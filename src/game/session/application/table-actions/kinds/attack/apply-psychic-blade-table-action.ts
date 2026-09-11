import { rollD20Check, rollDamageParts } from '@game/dice/domain/dice';
import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from '../../primitives/table-action-guards';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { TableActionResponseDto } from '@game/session/dto/fighter/fighter-session.dto';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';

export async function applyPsychicBladeTableAction(input: {
  state: CharacterStateRepository;
  character: PlayerCharacter;
  getProficiencyBonus: (level: number) => Promise<number>;
  bonusAttack: boolean;
}): Promise<TableActionResponseDto> {
  const { character, bonusAttack } = input;
  assertCharacterSubclass(character, 'soulknife', 'Soulknife');
  assertCharacterLevel(character, 3, 'Rogue', 'Psychic Blades');
  const pb = await input.getProficiencyBonus(character.level);
  const dexterity = abilityModifier(character.abilityScores.destreza);
  const attack = rollD20Check(dexterity + pb);
  const damageDie = bonusAttack ? '1d4' : '1d6';
  const damage = rollDamageParts(damageDie, dexterity);
  const name = bonusAttack ? 'Lâmina Psíquica adicional' : 'Lâmina Psíquica';

  return {
    state: await input.state.buildResponse(character),
    actionName: name,
    expression: `${attack.expression}; ${damage.expression}`,
    roll: attack.d20.kept[0],
    total: attack.total,
    resourceSpent: false,
    note: `${name}: ataque ${attack.total}; dano ${damage.total} Psíquico (${damage.expression}). Alcance normal 18 m, sem longo alcance.`,
  };
}
