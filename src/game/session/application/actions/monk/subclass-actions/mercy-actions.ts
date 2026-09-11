import { martialArtsDie } from '@game/combat/domain/monk';
import { featureSchedulesFromCatalog } from '@game/combat/domain/feature-schedule';
import { rollDamageParts } from '@game/dice/domain/dice';
import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import { applyHealHitPoints } from '@game/session/application/core/apply-heal-hit-points';
import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from '@game/session/application/core/table-action-guards';
import type {
  MonkActionDeps,
  MonkTableActionResult,
  PlayerCharacter,
} from '../monk-action-deps';
import { spendFocus, spendResource } from '../monk-action-deps';

async function monkBands(deps: MonkActionDeps, character: PlayerCharacter) {
  const catalog = await deps.mechanicalCatalog.load();
  return featureSchedulesFromCatalog(
    catalog,
    character.classSlug,
    character.subclassSlug,
  );
}

const FLURRY_HEAL_HARM_SLUG = 'hand-of-harm-flurry';
const ULTIMATE_MERCY_SLUG = 'hand-of-ultimate-mercy';

export async function resolveHandOfHealing(
  deps: MonkActionDeps,
  character: PlayerCharacter,
): Promise<MonkTableActionResult> {
  assertCharacterSubclass(character, 'mercy', 'Combatente da Misericórdia');
  assertCharacterLevel(character, 3, 'Monk', 'Mão de Cura');
  const wisdom = abilityModifier(character.abilityScores.sabedoria);
  const bands = await monkBands(deps, character);
  const heal = rollDamageParts(martialArtsDie(character.level, bands), wisdom);
  await spendFocus(deps, character, 1);
  const { state, healed } = await applyHealHitPoints(
    deps.state,
    character,
    heal.total,
  );
  const touch =
    character.level >= 6
      ? ' Também pode encerrar Atordoado, Cego, Envenenado, Paralisado ou Surdo no alvo (Toque de Médico).'
      : '';
  return {
    state,
    actionName: 'Mão de Cura',
    expression: heal.expression,
    roll: heal.dice[0]?.rolls[0],
    total: heal.total,
    resourceSpent: true,
    note: `Mão de Cura: Usar Magia, gaste 1 Foco — cure ${heal.total} PV (${heal.expression}; +${healed} na ficha — ajuste se for aliado). Na Torrente, pode substituir 1 ataque desarmado por esta cura sem gastar Foco da cura.${touch}`,
  };
}

export async function resolveHandOfHarm(
  deps: MonkActionDeps,
  character: PlayerCharacter,
): Promise<MonkTableActionResult> {
  assertCharacterSubclass(character, 'mercy', 'Combatente da Misericórdia');
  assertCharacterLevel(character, 3, 'Monk', 'Mão de Dolo');
  const wisdom = abilityModifier(character.abilityScores.sabedoria);
  const bands = await monkBands(deps, character);
  const damage = rollDamageParts(martialArtsDie(character.level, bands), wisdom);
  const state = await spendFocus(deps, character, 1);
  const poison =
    character.level >= 6
      ? ' Também pode impor Envenenado até o fim do seu próximo turno (Toque de Médico).'
      : '';
  return {
    state,
    actionName: 'Mão de Dolo',
    expression: damage.expression,
    roll: damage.dice[0]?.rolls[0],
    total: damage.total,
    resourceSpent: true,
    note: `Mão de Dolo: 1×/turno no acerto desarmado, gaste 1 Foco para +${damage.total} Necrótico (${damage.expression}).${poison}`,
  };
}

export async function resolveFlurryOfHealingAndHarm(
  deps: MonkActionDeps,
  character: PlayerCharacter,
): Promise<MonkTableActionResult> {
  assertCharacterSubclass(character, 'mercy', 'Combatente da Misericórdia');
  assertCharacterLevel(character, 11, 'Monk', 'Torrente de Cura e Dolo');
  const state = await spendResource(
    deps,
    character,
    FLURRY_HEAL_HARM_SLUG,
    1,
  );
  return {
    state,
    actionName: 'Torrente de Cura e Dolo',
    resourceSpent: true,
    note: 'Torrente de Cura e Dolo: nesta Torrente, cada ataque desarmado pode ser substituído por Mão de Cura sem gastar Foco da cura; e 1×/turno Mão de Dolo sem gastar Foco do dolo. Usos = mod. de Sabedoria (mín. 1)/DL.',
  };
}

export async function resolveHandOfUltimateMercy(
  deps: MonkActionDeps,
  character: PlayerCharacter,
): Promise<MonkTableActionResult> {
  assertCharacterSubclass(character, 'mercy', 'Combatente da Misericórdia');
  assertCharacterLevel(character, 17, 'Monk', 'Mão da Misericórdia Final');
  const wisdom = abilityModifier(character.abilityScores.sabedoria);
  const heal = rollDamageParts('4d10', wisdom);
  await spendFocus(deps, character, 5);
  const state = await spendResource(
    deps,
    character,
    ULTIMATE_MERCY_SLUG,
    1,
  );
  return {
    state,
    actionName: 'Mão da Misericórdia Final',
    expression: heal.expression,
    roll: heal.dice[0]?.rolls[0],
    total: heal.total,
    resourceSpent: true,
    note: `Mão da Misericórdia Final: Usar Magia, toque cadáver (≤24 h), gaste 5 Foco + 1 uso. Revive com ${heal.total} PV (${heal.expression}); remove Atordoado/Cego/Envenenado/Paralisado/Surdo. 1×/DL.`,
  };
}
