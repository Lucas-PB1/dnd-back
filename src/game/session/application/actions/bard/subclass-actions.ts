import { BadRequestException } from '@nestjs/common';
import { bardicInspirationDie } from '@game/combat/domain/bard';
import {
  assertValidPersonaMasks,
  maxEquippedPersonaMasks,
} from '@game/combat/domain/bard';
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
} from './bard-action-deps';
import { spendInspiration } from './bard-action-deps';

async function bardSpellSaveDc(
  deps: BardActionDeps,
  character: PlayerCharacter,
): Promise<number> {
  const proficiency = await deps.domain.getProficiencyBonus(character.level);
  return (
    8 + proficiency + abilityModifier(character.abilityScores.carisma)
  );
}

async function requireEquippedMask(
  deps: BardActionDeps,
  character: PlayerCharacter,
  maskSlug: string,
  maskName: string,
): Promise<void> {
  assertCharacterSubclass(
    character,
    'college-of-masks',
    'Colégio das Máscaras',
  );
  assertCharacterLevel(character, 3, 'Bardo', `Máscara ${maskName}`);
  const state = await deps.state.buildResponse(character);
  const equipped = state.personaMasks ?? [];
  if (!equipped.includes(maskSlug)) {
    throw new BadRequestException(
      `Vista a máscara ${maskName} antes de usar este efeito`,
    );
  }
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

export async function resolveAgileResponse(
  deps: BardActionDeps,
  character: PlayerCharacter,
): Promise<BardTableActionResult> {
  assertCharacterSubclass(character, 'dance', 'Colégio da Dança');
  assertCharacterLevel(character, 6, 'Bardo', 'Movimento Inspirador');
  const state = await spendInspiration(deps, character);

  return {
    state,
    actionName: 'Movimento Inspirador',
    resourceSpent: true,
    note: 'Movimento Inspirador: Reação quando um inimigo à sua vista encerra o turno a até 1,5 m. Gaste 1 Inspiração de Bardo para se mover até metade do Deslocamento; um aliado a até 9 m também pode (própria Reação). Nenhum movimento provoca Ataques de Oportunidade.',
  };
}

export async function resolveCoordinatedMovement(
  deps: BardActionDeps,
  character: PlayerCharacter,
): Promise<BardTableActionResult> {
  assertCharacterSubclass(character, 'dance', 'Colégio da Dança');
  assertCharacterLevel(character, 6, 'Bardo', 'Movimento Coordenado');
  const die = bardicInspirationDie(character.level);
  const result = rollDamageParts(`1${die}`, 0);
  const state = await spendInspiration(deps, character);
  return {
    state,
    actionName: 'Movimento Coordenado',
    expression: result.expression,
    total: result.total,
    resourceSpent: true,
    note: `Movimento Coordenado: na iniciativa, gaste 1 Inspiração — você e aliados a 9 m que possam ver/ouvir você somam +${result.total} (${result.expression}) à iniciativa.`,
  };
}

export async function resolveUnarmedDance(
  deps: BardActionDeps,
  character: PlayerCharacter,
): Promise<BardTableActionResult> {
  assertCharacterSubclass(character, 'dance', 'Colégio da Dança');
  assertCharacterLevel(character, 3, 'Bardo', 'Dança Virtuosa (Ataque Desarmado)');
  const die = bardicInspirationDie(character.level);
  const dexterity = abilityModifier(character.abilityScores.destreza);
  const result = rollDamageParts(`1${die}`, dexterity);

  return {
    state: await deps.state.buildResponse(character),
    actionName: 'Dança Virtuosa (Ataque Desarmado)',
    expression: result.expression,
    total: result.total,
    resourceSpent: false,
    note: `Ataque Desarmado (Dança): usa Destreza no ataque; dano Contundente ${result.total} (${result.expression} = dado de Inspiração + DES, sem gastar uso).`,
  };
}

export async function resolvePeerlessSkill(
  deps: BardActionDeps,
  character: PlayerCharacter,
): Promise<BardTableActionResult> {
  assertCharacterSubclass(character, 'lore', 'Colégio do Conhecimento');
  assertCharacterLevel(character, 14, 'Bardo', 'Perícia Inigualável');
  const die = bardicInspirationDie(character.level);
  const result = rollDamageParts(`1${die}`, 0);
  const state = await spendInspiration(deps, character);
  return {
    state,
    actionName: 'Perícia Inigualável',
    expression: result.expression,
    total: result.total,
    resourceSpent: true,
    note: `Perícia Inigualável: após falhar teste ou ataque, some +${result.total} (${result.expression}) ao d20. Se ainda falhar, devolva o uso de Inspiração (± na Economia).`,
  };
}

export async function resolveVirtuosoSkill(
  deps: BardActionDeps,
  character: PlayerCharacter,
): Promise<BardTableActionResult> {
  assertCharacterSubclass(
    character,
    'college-of-masks',
    'Colégio das Máscaras',
  );
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
  await requireEquippedMask(
    deps,
    character,
    'persona-mask-angel',
    'Anjo',
  );
  const die = bardicInspirationDie(character.level);
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
  await requireEquippedMask(
    deps,
    character,
    'persona-mask-devil',
    'Diabo',
  );
  const die = bardicInspirationDie(character.level);
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
  await requireEquippedMask(
    deps,
    character,
    'persona-mask-dragon',
    'Dragão',
  );
  const die = bardicInspirationDie(character.level);
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
  await requireEquippedMask(
    deps,
    character,
    'persona-mask-jester',
    'Bobão',
  );
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
  assertCharacterSubclass(
    character,
    'college-of-masks',
    'Colégio das Máscaras',
  );
  assertCharacterLevel(character, 3, 'Bardo', 'Máscaras de Persona');
  try {
    const catalog = await deps.mechanicalCatalog.load();
    assertValidPersonaMasks(
      catalog.personaMaskSlugs,
      masks,
      character.level,
    );
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
