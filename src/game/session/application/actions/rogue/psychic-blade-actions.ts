import { BadRequestException } from '@nestjs/common';
import { rollD20Check, rollDamageParts, rollDie } from '@game/dice/domain/dice';
import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from '@game/session/application/core/table-action-guards';
import type {
  PlayerCharacter,
  RogueActionDeps,
  RogueTableActionResult,
  UseRogueTableActionDto,
} from './rogue-action-deps';
import { psiDieFaces, resolveSoulknifeAction } from './soulknife-helpers';

export async function rollPsychicBlade(
  deps: RogueActionDeps,
  character: PlayerCharacter,
  bonusAttack: boolean,
): Promise<RogueTableActionResult> {
  assertCharacterLevel(character, 3, 'Rogue', 'Psychic Blades');
  const pb = await deps.domain.getProficiencyBonus(character.level);
  const dexterity = abilityModifier(character.abilityScores.destreza);
  const attack = rollD20Check(dexterity + pb);
  const damageDie = bonusAttack ? '1d4' : '1d6';
  const damage = rollDamageParts(damageDie, dexterity);
  const name = bonusAttack ? 'Lâmina Psíquica adicional' : 'Lâmina Psíquica';

  return {
    state: await deps.state.buildResponse(character),
    actionName: name,
    expression: `${attack.expression}; ${damage.expression}`,
    roll: attack.d20.kept[0],
    total: attack.total,
    resourceSpent: false,
    note: `${name}: ataque ${attack.total}; dano ${damage.total} Psíquico (${damage.expression}). Alcance normal 18 m, sem longo alcance.`,
  };
}

export async function resolveConditionalPsiBonus(
  deps: RogueActionDeps,
  character: PlayerCharacter,
  dto: UseRogueTableActionDto,
  attack: boolean,
): Promise<RogueTableActionResult> {
  const minimumLevel = attack ? 9 : 3;
  const actionName = attack ? 'Golpes Teleguiados' : 'Aptidão Reforçada';
  assertCharacterSubclass(character, 'soulknife', 'Soulknife');
  assertCharacterLevel(character, minimumLevel, 'Rogue', actionName);
  if (dto.checkTotal == null || dto.dc == null) {
    throw new BadRequestException(`${actionName} requires checkTotal and dc`);
  }

  const faces = psiDieFaces(character);
  const dieRoll = rollDie(faces);
  const newTotal = dto.checkTotal + dieRoll;
  const success = newTotal >= dto.dc;
  const tableAction = await resolveSoulknifeAction(
    deps,
    character,
    attack ? 'guided-strike' : 'psi-bolstered-knack',
    { dieRoll, succeededWithDie: success },
  );
  const state =
    tableAction.psiDiceCost > 0
      ? (
          await deps.state.useClassResource(
            character,
            'soulknife-psi-dice',
            tableAction.psiDiceCost,
          )
        ).state
      : await deps.state.buildResponse(character);

  return {
    state,
    actionName,
    expression: `1d${faces}`,
    roll: dieRoll,
    total: newTotal,
    resourceSpent: success,
    note: `${actionName}: ${dto.checkTotal} + ${dieRoll} = ${newTotal} vs ${dto.dc}; ${success ? 'sucesso, dado gasto' : 'ainda falhou, dado preservado'}.`,
  };
}
