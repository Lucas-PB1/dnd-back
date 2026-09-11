import type { DataSource } from 'typeorm';
import type { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import { computeAbilityModifiers } from '@game/sheet/domain/stats/character-derived-stats';
import {
  applyFocusedInitiativeFloor,
  resolveInitiativeAdvantageContributions,
  resolveInitiativeBonus,
} from '@game/sheet/domain/stats/character-check-bonuses';
import type { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import { resolveEffectiveAbilityScores } from '@game/sheet/infrastructure/load-class-ability-boosts';
import type { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { rollDie, rollD20Check } from '@game/dice/domain/dice';
import type {
  CharacterRollResponseDto,
  RollInitiativeDto,
} from '@game/dice/dto/character-roll.dto';
import type { CharacterResourceSpender } from '@game/session/domain/character-resource-spender';
import type { LoadEffectCatalog } from '@game/effects';
import { loadInitiativeRules } from '@game/sheet/infrastructure/initiative-rule.queries';
import { loadAccessibleCharacter } from './roll-weapon-context';
import { applyStrokeOfLuckIfRequested } from './stroke-of-luck';

export async function executeRollInitiative(input: {
  access: PlayerCharacterAccessService;
  sheet: CharacterSheetRepository;
  domain: CharacterDomainService;
  dataSource: DataSource;
  resourceSpender: CharacterResourceSpender;
  effectCatalog: LoadEffectCatalog;
  userId: string;
  characterId: string;
  dto: RollInitiativeDto;
}): Promise<CharacterRollResponseDto> {
  const character = await loadAccessibleCharacter(
    input.access,
    input.userId,
    input.characterId,
  );
  const sheet = await input.sheet.load(character.id);
  const pb = await input.domain.getProficiencyBonus(character.level);
  const scores = await resolveEffectiveAbilityScores(
    input.dataSource,
    character.classSlug,
    character.level,
    character.abilityScores,
  );
  const mods = computeAbilityModifiers(scores);
  const featSlugs = sheet.characterFeats.map((feat) => feat.featSlug);
  const featEffects = await input.effectCatalog.load({
    ownerKind: 'feat',
    ownerSlugs: featSlugs,
    kinds: ['initiative_pb'],
  });
  const initiativeRules = await loadInitiativeRules(
    input.dataSource,
    character.classSlug,
    character.subclassSlug,
  );
  const rollContext = {
    dexterityModifier: mods.destreza,
    wisdomModifier: mods.sabedoria,
    intelligenceModifier: mods.inteligencia,
    proficiencyBonus: pb,
    classSlug: character.classSlug,
    subclassSlug: character.subclassSlug,
    level: character.level,
    characterFeats: sheet.characterFeats,
    featEffects,
    heritageChoices: sheet.heritageChoices,
    speciesChoices: sheet.speciesChoices,
    initiativeRules,
  };

  const { total: modifier, notes: bonusNotes } =
    resolveInitiativeBonus(rollContext);
  const { mode, notes: advantageNotes } = resolveInitiativeAdvantageContributions(
    rollContext,
    input.dto,
  );
  const notes = [...bonusNotes, ...advantageNotes];

  let result = rollD20Check(modifier, mode);
  const floor = applyFocusedInitiativeFloor(
    result.d20.kept,
    sheet.heritageChoices,
  );
  if (floor.note) notes.push(floor.note);
  if (floor.kept.some((face, index) => face !== result.d20.kept[index])) {
    const keptFace = floor.kept[0] ?? 0;
    result = {
      ...result,
      d20: { ...result.d20, kept: floor.kept },
      total: keptFace + modifier,
      expression: `1d20${modifier >= 0 ? `+${modifier}` : modifier}`,
    };
  }

  if (input.dto.kasInitiativeBoost) {
    const kasRoll = rollDie(10);
    result.total += kasRoll;
    notes.push(`Espada de Kas: +${kasRoll} (1d10) na Iniciativa`);
  }

  result = await applyStrokeOfLuckIfRequested({
    requested: input.dto.strokeOfLuck,
    spender: input.resourceSpender,
    character,
    result,
    notes,
  });

  return {
    kind: 'initiative',
    label: 'Iniciativa',
    expression: result.expression,
    total: result.total,
    modifier: result.modifier,
    mode: result.mode,
    rolls: result.d20.rolls,
    kept: result.d20.kept,
    note: notes.length > 0 ? notes.join(' · ') : undefined,
  };
}
