import { bardicInspirationDie } from '@game/combat/domain/bard';
import { rollDamageParts } from '@game/dice/domain/dice';
import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import { applyTemporaryHitPoints } from '@game/session/application/core/apply-temporary-hit-points';
import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from '@game/session/application/core/table-action-guards';
import type {
  BardActionDeps,
  BardTableActionResult,
  PlayerCharacter,
} from '../bard-action-deps';
import { spendInspiration } from '../bard-action-deps';

async function bardSpellSaveDc(
  deps: BardActionDeps,
  character: PlayerCharacter,
): Promise<number> {
  const proficiency = await deps.domain.getProficiencyBonus(character.level);
  return (
    8 + proficiency + abilityModifier(character.abilityScores.carisma)
  );
}

/** PHB 2024 — Manto de Inspiração (substitui legado “Desempenho Cativante”). */
export async function resolveMantleOfInspiration(
  deps: BardActionDeps,
  character: PlayerCharacter,
): Promise<BardTableActionResult> {
  assertCharacterSubclass(character, 'glamour', 'Colégio do Glamour');
  assertCharacterLevel(character, 3, 'Bardo', 'Manto de Inspiração');
  const die = bardicInspirationDie(character.level);
  const result = rollDamageParts(`2${die}`, 0);
  const charisma = abilityModifier(character.abilityScores.carisma);
  const alliesCount = Math.max(1, charisma);
  await spendInspiration(deps, character);
  const state = await applyTemporaryHitPoints(
    deps.state,
    character,
    result.total,
  );

  return {
    state,
    actionName: 'Manto de Inspiração',
    expression: result.expression,
    total: result.total,
    resourceSpent: true,
    note: `Manto de Inspiração: gaste 1 Inspiração para conceder ${result.total} PV temporários (${result.expression}) a até ${alliesCount} criaturas a 18 m. Cada uma pode usar a Reação para mover-se seu Deslocamento sem provocar OA. Total aplicado na ficha — ajuste se distribuir.`,
  };
}

export async function resolveMantleOfMajesty(
  deps: BardActionDeps,
  character: PlayerCharacter,
): Promise<BardTableActionResult> {
  assertCharacterSubclass(character, 'glamour', 'Colégio do Glamour');
  assertCharacterLevel(character, 6, 'Bardo', 'Manto de Majestade');
  const state = (
    await deps.state.useClassResource(character, 'mantle-of-majesty', 1)
  ).state;
  return {
    state,
    actionName: 'Manto de Majestade',
    resourceSpent: true,
    note: 'Manto de Majestade: Ação Bônus — conjure Comando sem espaço e assuma aparência sobrenatural por 1 minuto (Concentração). Enquanto durar, Comando como Ação Bônus sem espaço; Enfeitiçados por você falham automaticamente no save. Restaurar uso: espaço 3+ (mesa).',
  };
}

export async function resolveUnbreakableMajesty(
  deps: BardActionDeps,
  character: PlayerCharacter,
): Promise<BardTableActionResult> {
  assertCharacterSubclass(character, 'glamour', 'Colégio do Glamour');
  assertCharacterLevel(character, 14, 'Bardo', 'Majestade Inquebrável');
  const saveDc = await bardSpellSaveDc(deps, character);
  const state = (
    await deps.state.useClassResource(character, 'unbreakable-majesty', 1)
  ).state;
  return {
    state,
    actionName: 'Majestade Inquebrável',
    saveDc,
    resourceSpent: true,
    note: `Majestade Inquebrável: Ação Bônus — presença 1 minuto. Quando uma criatura o acerta pela 1ª vez no turno dela, CD ${saveDc} de CAR ou o ataque falha. Recupera em Descanso Curto ou Longo.`,
  };
}
