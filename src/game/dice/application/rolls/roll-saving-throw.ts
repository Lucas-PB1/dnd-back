import { BadRequestException } from '@nestjs/common';
import { DataSource } from 'typeorm';
import { isFighterClass } from '../../../combat/domain/fighter-features';
import type { CharacterDomainService } from '../../../sheet/domain/core/character-domain.service';
import { collectSaveProficiencyAbilities } from '../../../sheet/domain/stats/character-check-bonuses';
import { computeAbilityModifiers } from '../../../sheet/domain/stats/character-derived-stats';
import type { CharacterSheetRepository } from '../../../sheet/infrastructure/character-sheet.repository';
import type { PlayerCharacterAccessService } from '../../../shared/player-character-access.service';
import type { AbilityKey } from '../../../build/domain/ability-generation';
import { rollD20Check } from '../../domain/dice';
import type {
  CharacterRollResponseDto,
  RollSavingThrowDto,
} from '../../dto/character-roll.dto';
import { loadAccessibleCharacter } from './roll-weapon-context';
import type { ResolveActivePermanentItemEffects } from '../../../inventory/application/resolve-active-permanent-item-effects';
import { applyItemAbilityBonuses } from '../../../inventory/domain/permanent-item-effects';
import { resolveEffectiveAbilityScores } from '../../../sheet/infrastructure/load-class-ability-boosts';
import { applyResourceSpend } from '../../../session/domain/class-resources';
import { resolveClassResources } from '../../../session/infrastructure/character-state/class-resources';

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
     FROM rpg.phb_class_saving_throw cst
     JOIN rpg.phb_class c ON c.id = cst.class_id
     JOIN rpg.phb_ability a ON a.id = cst.ability_id
     WHERE c.slug = $1`,
    [character.classSlug],
  );
  const sheet = await input.sheet.load(character.id, character.backgroundSlug);
  const saveProficiencies = new Set(
    collectSaveProficiencyAbilities(
      stRows.map((row) => row.slug),
      sheet.featOptions,
    ),
  );
  const proficient = saveProficiencies.has(ability);
  const pb = await input.domain.getProficiencyBonus(character.level);
  const itemEffects = await input.permanentItemEffects.resolve(character.id);
  const classScores = await resolveEffectiveAbilityScores(
    input.dataSource,
    character.classSlug,
    character.level,
    character.abilityScores,
  );
  const scores = applyItemAbilityBonuses(
    classScores,
    itemEffects.abilityBonuses,
    itemEffects.abilityScoreCaps,
  );
  const mods = computeAbilityModifiers(scores);
  const itemSaveBonus = itemEffects.savingThrowBonuses[ability] ?? 0;
  let bonus = mods[ability] + (proficient ? pb : 0) + itemSaveBonus;
  const notes: string[] = [];

  if (input.dto.indomitable) {
    if (!isFighterClass(character.classSlug) || character.level < 9) {
      throw new BadRequestException('Indomitable requires Fighter level 9+');
    }
    const resources = await resolveClassResources(
      input.dataSource,
      character,
    );
    const indomitable = resources.find((item) => item.slug === 'indomitable');
    if (!indomitable) {
      throw new BadRequestException('Indomitable is not available');
    }
    const stateRows = await input.dataSource.query<
      { resources_used: Record<string, number> }[]
    >(
      `SELECT resources_used FROM rpg.player_character_state WHERE character_id = $1`,
      [character.id],
    );
    const used = stateRows[0]?.resources_used ?? {};
    let nextUsed: Record<string, number>;
    try {
      nextUsed = applyResourceSpend(used, 'indomitable', indomitable.max, 1);
    } catch (error) {
      throw new BadRequestException(
        error instanceof Error ? error.message : 'Cannot spend Indomitable',
      );
    }
    await input.dataSource.query(
      `UPDATE rpg.player_character_state
       SET resources_used = $2::jsonb
       WHERE character_id = $1`,
      [character.id, JSON.stringify(nextUsed)],
    );
    bonus += character.level;
    notes.push(`Indomável: +${character.level} (rerrolagem)`);
  }

  const result = rollD20Check(bonus, input.dto.advantage ?? 'normal');
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
