import { BadRequestException } from '@nestjs/common';
import { DataSource } from 'typeorm';
import {
  hasIndomitable,
  isFighterClass,
} from '@game/combat/domain/fighter';
import {
  hasDiamondSoul,
  hasEvasion as hasMonkEvasion,
  isMonkClass,
} from '@game/combat/domain/monk';
import { paladinSavingThrowAuraBonus } from '@game/combat/domain/paladin';
import {
  hasEvasion as hasRogueEvasion,
  hasSlipperyMind,
  isRogueClass,
} from '@game/combat/domain/rogue';
import type { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import { collectSaveProficiencyAbilities } from '@game/sheet/domain/stats/character-check-bonuses';
import { computeAbilityModifiers } from '@game/sheet/domain/stats/character-derived-stats';
import type { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import type { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import type { AbilityKey } from '@game/build/domain/ability-generation';
import { rollD20Check } from '@game/dice/domain/dice';
import type {
  CharacterRollResponseDto,
  RollSavingThrowDto,
} from '@game/dice/dto/character-roll.dto';
import { loadAccessibleCharacter } from './roll-weapon-context';
import type { ResolveActivePermanentItemEffects } from '@game/inventory/application/effects/resolve-active-permanent-item-effects';
import { applyItemAbilityBonuses } from '@game/inventory/domain/permanent-item-effects';
import {
  applyAbilityPenalties,
  collectAbilityPenaltiesFromInventory,
} from '@game/inventory/domain/artifact/artifact-instance-ops';
import { PlayerCharacterItem } from '@game/inventory/infrastructure/player-character-item.entity';
import { resolveEffectiveAbilityScores } from '@game/sheet/infrastructure/load-class-ability-boosts';
import type { CharacterResourceSpender } from '@game/session/domain/character-resource-spender';
import { applyStrokeOfLuckIfRequested } from './stroke-of-luck';
import { applyCursemarkedBracketIfTriggered } from './apply-cursemarked-bracket';
import { applyInspirationSpend } from './apply-inspiration-spend';
import type { LoadEffectCatalog } from '@game/effects';

async function loadAbilityPenalties(dataSource: DataSource, characterId: string) {
  if (typeof dataSource?.getRepository !== 'function') {
    return collectAbilityPenaltiesFromInventory([]);
  }
  const rows = await dataSource.getRepository(PlayerCharacterItem).find({
    where: { characterId },
  });
  return collectAbilityPenaltiesFromInventory(rows);
}

const ABILITY_LABELS: Record<AbilityKey, string> = {
  forca: 'Força',
  destreza: 'Destreza',
  constituicao: 'Constituição',
  inteligencia: 'Inteligência',
  sabedoria: 'Sabedoria',
  carisma: 'Carisma',
};

export async function executeRollSavingThrow(input: {
  access: PlayerCharacterAccessService;
  sheet: CharacterSheetRepository;
  domain: CharacterDomainService;
  dataSource: DataSource;
  permanentItemEffects: ResolveActivePermanentItemEffects;
  resourceSpender: CharacterResourceSpender;
  effectCatalog: LoadEffectCatalog;
  userId: string;
  characterId: string;
  dto: RollSavingThrowDto;
}): Promise<CharacterRollResponseDto> {
  const character = await loadAccessibleCharacter(
    input.access,
    input.userId,
    input.characterId,
  );
  const ability = input.dto.abilitySlug as AbilityKey;
  const stRows = await input.dataSource.query<{ slug: string }[]>(
    `SELECT a.slug
     FROM rpg.phb_class_proficiency cp
     JOIN rpg.phb_class c ON c.id = cp.class_id
     JOIN rpg.phb_ability a ON a.id = cp.ref_id
     WHERE c.slug = $1 AND cp.kind = 'saving_throw'::rpg.class_proficiency_kind`,
    [character.classSlug],
  );
  const sheet = await input.sheet.load(character.id, character.backgroundSlug);
  const saveProficiencies = new Set(
    collectSaveProficiencyAbilities(
      stRows.map((row) => row.slug),
      sheet.featOptions,
    ),
  );
  if (
    isRogueClass(character.classSlug) &&
    hasSlipperyMind(character.level)
  ) {
    saveProficiencies.add('sabedoria');
    saveProficiencies.add('carisma');
  }
  if (isMonkClass(character.classSlug) && hasDiamondSoul(character.level)) {
    for (const slug of Object.keys(ABILITY_LABELS) as AbilityKey[]) {
      saveProficiencies.add(slug);
    }
  }
  const proficient = saveProficiencies.has(ability);
  const pb = await input.domain.getProficiencyBonus(character.level);
  const itemEffects = await input.permanentItemEffects.resolve(character.id);
  const classScores = await resolveEffectiveAbilityScores(
    input.dataSource,
    character.classSlug,
    character.level,
    character.abilityScores,
  );
  const scores = applyAbilityPenalties(
    applyItemAbilityBonuses(
      classScores,
      itemEffects.abilityBonuses,
      itemEffects.abilityScoreCaps,
    ),
    await loadAbilityPenalties(input.dataSource, character.id),
  );
  const mods = computeAbilityModifiers(scores);
  const itemSaveBonus = itemEffects.savingThrowBonuses[ability] ?? 0;
  let bonus = mods[ability] + (proficient ? pb : 0) + itemSaveBonus;
  const notes: string[] = [];

  const auraBonus = paladinSavingThrowAuraBonus({
    classSlug: character.classSlug,
    level: character.level,
    charismaModifier: mods.carisma,
  });
  if (auraBonus > 0) {
    bonus += auraBonus;
    notes.push(
      `Aura de Proteção: +${auraBonus} (mod. de Carisma; aliados no alcance também)`,
    );
  }

  if (input.dto.indomitable && input.dto.strokeOfLuck) {
    throw new BadRequestException(
      'Choose either Indomitable or Stroke of Luck for this roll',
    );
  }

  if (input.dto.indomitable) {
    if (
      !isFighterClass(character.classSlug) ||
      !hasIndomitable(character.level)
    ) {
      throw new BadRequestException('Indomitable requires Fighter level 9+');
    }
    await input.resourceSpender.spendClassResource(
      character,
      'indomitable',
      1,
    );
    bonus += character.level;
    notes.push(`Indomável: +${character.level} (rerrolagem)`);
  }

  let result = rollD20Check(bonus, input.dto.advantage ?? 'normal');
  result = await applyStrokeOfLuckIfRequested({
    requested: input.dto.strokeOfLuck,
    spender: input.resourceSpender,
    character,
    result,
    notes,
  });
  if (
    ((isRogueClass(character.classSlug) &&
      hasRogueEvasion(character.level)) ||
      (isMonkClass(character.classSlug) &&
        hasMonkEvasion(character.level))) &&
    ability === 'destreza'
  ) {
    notes.push(
      'Evasão: sucesso = nenhum dano; falha = metade (quando a salvaguarda normalmente reduz à metade)',
    );
  }
  await applyCursemarkedBracketIfTriggered({
    dataSource: input.dataSource,
    character,
    resourceSpender: input.resourceSpender,
    kind: 'save',
    kept: result.d20.kept[0] ?? 0,
    notes,
  });
  const failed =
    input.dto.dc != null ? result.total < input.dto.dc : null;
  await applyInspirationSpend({
    resourceSpender: input.resourceSpender,
    sheet: input.sheet,
    effectCatalog: input.effectCatalog,
    character,
    spentInspiration: Boolean(input.dto.spentInspiration),
    failed,
    notes,
  });
  return {
    kind: 'saving_throw',
    label: `Salvaguarda — ${ABILITY_LABELS[ability]}`,
    expression: result.expression,
    total: result.total,
    modifier: result.modifier,
    mode: result.mode,
    rolls: result.d20.rolls,
    kept: result.d20.kept,
    note: notes.length > 0 ? notes.join(' · ') : undefined,
  };
}
