import type { DataSource } from 'typeorm';
import type { CharacterDomainService } from '../../../sheet/domain/core/character-domain.service';
import { initiativeBonus } from '../../../sheet/domain/stats/character-check-bonuses';
import { computeAbilityModifiers } from '../../../sheet/domain/stats/character-derived-stats';
import type { CharacterSheetRepository } from '../../../sheet/infrastructure/character-sheet.repository';
import { resolveEffectiveAbilityScores } from '../../../sheet/infrastructure/load-class-ability-boosts';
import type { PlayerCharacterAccessService } from '../../../shared/player-character-access.service';
import { rollD20Check } from '../../domain/dice';
import type {
  CharacterRollResponseDto,
  RollInitiativeDto,
} from '../../dto/character-roll.dto';
import { loadAccessibleCharacter } from './roll-weapon-context';
import {
  spendStrokeOfLuck,
  turnCheckIntoNaturalTwenty,
} from './stroke-of-luck';

export async function executeRollInitiative(input: {
  access: PlayerCharacterAccessService;
  sheet: CharacterSheetRepository;
  domain: CharacterDomainService;
  dataSource: DataSource;
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
  const bonus = initiativeBonus(mods.destreza, pb, sheet.characterFeats);
  let mode = input.dto.advantage ?? 'normal';
  if (
    character.subclassSlug === 'champion' &&
    character.level >= 3 &&
    mode === 'normal'
  ) {
    mode = 'advantage';
  }
  if (
    character.subclassSlug === 'assassin' &&
    character.level >= 3 &&
    mode === 'normal'
  ) {
    mode = 'advantage';
  }
  let result = rollD20Check(bonus, mode);
  const notes: string[] = [];
  if (input.dto.strokeOfLuck) {
    await spendStrokeOfLuck(input.dataSource, character);
    result = turnCheckIntoNaturalTwenty(result);
    notes.push('Golpe de Sorte: resultado do d20 transformado em 20');
  }
  if (mode === 'advantage' && character.subclassSlug === 'champion') {
    notes.push('Atleta Extraordinário: Vantagem na Iniciativa');
  }
  if (mode === 'advantage' && character.subclassSlug === 'assassin') {
    notes.push('Assassinar: Vantagem na Iniciativa');
  }
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
