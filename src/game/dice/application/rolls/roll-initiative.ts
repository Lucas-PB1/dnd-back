import type { DataSource } from 'typeorm';
import type { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import { initiativeBonus } from '@game/sheet/domain/stats/character-check-bonuses';
import { computeAbilityModifiers } from '@game/sheet/domain/stats/character-derived-stats';
import type { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import { resolveEffectiveAbilityScores } from '@game/sheet/infrastructure/load-class-ability-boosts';
import type { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { rollD20Check } from '@game/dice/domain/dice';
import type {
  CharacterRollResponseDto,
  RollInitiativeDto,
} from '@game/dice/dto/character-roll.dto';
import type { CharacterResourceSpender } from '@game/session/domain/character-resource-spender';
import { forceAdvantageIfNormal } from './advantage-mode';
import { loadAccessibleCharacter } from './roll-weapon-context';
import { applyStrokeOfLuckIfRequested } from './stroke-of-luck';
import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import { isRangerClass } from '@game/combat/domain/ranger';

export async function executeRollInitiative(input: {
  access: PlayerCharacterAccessService;
  sheet: CharacterSheetRepository;
  domain: CharacterDomainService;
  dataSource: DataSource;
  resourceSpender: CharacterResourceSpender;
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
  let bonus = initiativeBonus(mods.destreza, pb, sheet.characterFeats);
  const notes: string[] = [];
  if (
    isRangerClass(character.classSlug) &&
    character.subclassSlug === 'gloom-stalker' &&
    character.level >= 3
  ) {
    const wisdom = abilityModifier(scores.sabedoria);
    bonus += wisdom;
    notes.push(`Emboscador das Sombras: +${wisdom} (mod. de Sabedoria) na Iniciativa`);
  }
  let mode = input.dto.advantage ?? 'normal';
  if (character.subclassSlug === 'champion' && character.level >= 3) {
    mode = forceAdvantageIfNormal(mode);
  }
  if (character.subclassSlug === 'assassin' && character.level >= 3) {
    mode = forceAdvantageIfNormal(mode);
  }
  let result = rollD20Check(bonus, mode);
  result = await applyStrokeOfLuckIfRequested({
    requested: input.dto.strokeOfLuck,
    spender: input.resourceSpender,
    character,
    result,
    notes,
  });
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
