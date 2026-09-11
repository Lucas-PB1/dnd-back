import { BadRequestException } from '@nestjs/common';
import {
  assertValidPersonaMasks,
  bardicInspirationDie,
  maxEquippedPersonaMasks,
} from '@game/combat/domain/bard';
import { featureSchedulesFromCatalog } from '@game/combat/domain/feature-schedule';
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

const MASKS_SUBCLASS = 'college-of-masks' as const;
const MASKS_LABEL = 'Colégio das Máscaras';

async function bardBands(deps: BardActionDeps, character: PlayerCharacter) {
  const catalog = await deps.mechanicalCatalog.load();
  return featureSchedulesFromCatalog(
    catalog,
    character.classSlug,
    character.subclassSlug,
  );
}

async function bardSpellSaveDc(
  deps: BardActionDeps,
  character: PlayerCharacter,
): Promise<number> {
  const proficiency = await deps.domain.getProficiencyBonus(character.level);
  return 8 + proficiency + abilityModifier(character.abilityScores.carisma);
}

async function requireEquippedMask(
  deps: BardActionDeps,
  character: PlayerCharacter,
  maskSlug: string,
  maskName: string,
): Promise<void> {
  assertCharacterSubclass(character, MASKS_SUBCLASS, MASKS_LABEL);
  assertCharacterLevel(character, 3, 'Bardo', `Máscara ${maskName}`);
  const state = await deps.state.buildResponse(character);
  if (!(state.personaMasks ?? []).includes(maskSlug)) {
    throw new BadRequestException(
      `Vista a máscara ${maskName} antes de usar este efeito`,
    );
  }
}

export async function resolveVirtuosoSkill(
  deps: BardActionDeps,
  character: PlayerCharacter,
): Promise<BardTableActionResult> {
  assertCharacterSubclass(character, MASKS_SUBCLASS, MASKS_LABEL);
  assertCharacterLevel(character, 6, 'Bardo', 'Habilidade de Virtuoso');
  const state = (
    await deps.state.useClassResource(character, 'virtuoso-skill', 1)
  ).state;
  return {
    state,
    actionName: 'Habilidade de Virtuoso',
    resourceSpent: true,
    note: 'Habilidade de Virtuoso: 1×/turno, ao fazer um Teste d20, faça-o com Carisma se ainda não usar esse atributo.',
  };
}

export async function resolvePersonaAngel(
  deps: BardActionDeps,
  character: PlayerCharacter,
): Promise<BardTableActionResult> {
  await requireEquippedMask(deps, character, 'persona-mask-angel', 'Anjo');
  const die = bardicInspirationDie(
    character.level,
    await bardBands(deps, character),
  );
  const result = rollDamageParts(`1${die}`, 0);
  const state = await spendInspiration(deps, character);
  return {
    state,
    actionName: 'Máscara — Anjo',
    expression: result.expression,
    total: result.total,
    resourceSpent: true,
    note: `Anjo: +${result.total} Radiante (${result.expression}) no dano (1×/turno; 1 Inspiração).`,
  };
}

export async function resolvePersonaDevil(
  deps: BardActionDeps,
  character: PlayerCharacter,
): Promise<BardTableActionResult> {
  await requireEquippedMask(deps, character, 'persona-mask-devil', 'Diabo');
  const die = bardicInspirationDie(
    character.level,
    await bardBands(deps, character),
  );
  const result = rollDamageParts(`2${die}`, 0);
  await spendInspiration(deps, character);
  const state = await applyTemporaryHitPoints(
    deps.state,
    character,
    result.total,
  );
  return {
    state,
    actionName: 'Máscara — Diabo',
    expression: result.expression,
    total: result.total,
    resourceSpent: true,
    note: `Diabo: Reação — ${result.total} Fogo (${result.expression}) ao agressor a 9 m; ${result.total} PV temp. aplicados na ficha.`,
  };
}

export async function resolvePersonaDragon(
  deps: BardActionDeps,
  character: PlayerCharacter,
): Promise<BardTableActionResult> {
  await requireEquippedMask(deps, character, 'persona-mask-dragon', 'Dragão');
  const die = bardicInspirationDie(
    character.level,
    await bardBands(deps, character),
  );
  const result = rollDamageParts(`2${die}`, 0);
  const saveDc = await bardSpellSaveDc(deps, character);
  const state = await spendInspiration(deps, character);
  return {
    state,
    actionName: 'Máscara — Dragão',
    expression: result.expression,
    total: result.total,
    saveDc,
    resourceSpent: true,
    note: `Dragão: cone 4,5 m — CD ${saveDc} de DES; ${result.total} Fogo (${result.expression}) ou metade no sucesso.`,
  };
}

export async function resolvePersonaGladiator(
  deps: BardActionDeps,
  character: PlayerCharacter,
): Promise<BardTableActionResult> {
  await requireEquippedMask(
    deps,
    character,
    'persona-mask-gladiator',
    'Gladiador',
  );
  const state = await spendInspiration(deps, character);
  return {
    state,
    actionName: 'Máscara — Gladiador',
    resourceSpent: true,
    note: 'Gladiador: Ação Bônus — ataque com arma ou Ataque Desarmado (1 Inspiração).',
  };
}

export async function resolvePersonaJester(
  deps: BardActionDeps,
  character: PlayerCharacter,
): Promise<BardTableActionResult> {
  await requireEquippedMask(deps, character, 'persona-mask-jester', 'Bobão');
  const state = await spendInspiration(deps, character);
  return {
    state,
    actionName: 'Máscara — Bobão',
    resourceSpent: true,
    note: 'Bobão: Ação Bônus — mova metade do Deslocamento sem OA e conjure Escárnio Vicioso (1 Inspiração).',
  };
}

export async function resolveSetPersonaMasks(
  deps: BardActionDeps,
  character: PlayerCharacter,
  masks: string[],
): Promise<BardTableActionResult> {
  assertCharacterSubclass(character, MASKS_SUBCLASS, MASKS_LABEL);
  assertCharacterLevel(character, 3, 'Bardo', 'Máscaras de Persona');
  try {
    const catalog = await deps.mechanicalCatalog.load();
    assertValidPersonaMasks(catalog.personaMaskSlugs, masks, character.level);
  } catch (error) {
    throw new BadRequestException(
      error instanceof Error ? error.message : 'Invalid persona masks',
    );
  }

  const max = maxEquippedPersonaMasks(character.level);
  const state = await deps.state.martial.setPersonaMasks(character, masks);
  const label = masks.length === 0 ? 'nenhuma máscara' : masks.join(', ');

  return {
    state,
    actionName: 'Vestir Máscaras de Persona',
    resourceSpent: false,
    note: `Máscaras de Persona (${masks.length}/${max}): ${label}.`,
  };
}
