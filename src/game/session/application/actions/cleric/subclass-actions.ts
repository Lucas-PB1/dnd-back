import { rollDamageParts } from '@game/dice/domain/dice';
import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import { applyTemporaryHitPoints } from '@game/session/application/core/apply-temporary-hit-points';
import type {
  ClericActionDeps,
  ClericTableActionResult,
  PlayerCharacter,
} from './cleric-action-deps';
import {
  assertSubclassFeature,
  spendChannelDivinity,
  spellSaveDc,
} from './cleric-action-deps';

export async function resolveRadianceOfDawn(
  deps: ClericActionDeps,
  character: PlayerCharacter,
): Promise<ClericTableActionResult> {
  assertSubclassFeature(
    character,
    'light',
    'Domínio da Luz',
    'Brilho do Amanhecer',
  );
  const result = rollDamageParts('2d10', character.level);
  const state = await spendChannelDivinity(deps, character);
  const saveDc = await spellSaveDc(deps, character);
  return {
    state,
    actionName: 'Brilho do Amanhecer',
    expression: result.expression,
    total: result.total,
    saveDc,
    resourceSpent: true,
    note: `Brilho do Amanhecer: dissipa Escuridão mágica; CD ${saveDc} de CON, ${result.total} Radiante (${result.expression}) ou metade.`,
  };
}

export async function resolveWardingFlare(
  deps: ClericActionDeps,
  character: PlayerCharacter,
): Promise<ClericTableActionResult> {
  assertSubclassFeature(
    character,
    'light',
    'Domínio da Luz',
    'Labareda Protetora',
  );
  const spent = await deps.state.useClassResource(
    character,
    'warding-flare',
    1,
  );

  if (character.level < 6) {
    return {
      state: spent.state,
      actionName: 'Labareda Protetora',
      resourceSpent: true,
      note: 'Labareda Protetora: Reação para impor Desvantagem ao ataque de uma criatura visível a até 9 m.',
    };
  }

  const result = rollDamageParts(
    '2d6',
    abilityModifier(character.abilityScores.sabedoria),
  );
  const state = await applyTemporaryHitPoints(
    deps.state,
    character,
    result.total,
  );
  return {
    state,
    actionName: 'Labareda Protetora Aprimorada',
    expression: result.expression,
    total: result.total,
    resourceSpent: true,
    note: `Labareda Protetora: imponha Desvantagem e conceda ${result.total} PV temporários (${result.expression}) ao alvo do ataque. Aplicado na ficha — ajuste o contador se o alvo for um aliado.`,
  };
}

export async function resolveCrownOfLight(
  deps: ClericActionDeps,
  character: PlayerCharacter,
): Promise<ClericTableActionResult> {
  assertSubclassFeature(
    character,
    'light',
    'Domínio da Luz',
    'Coroa de Luz',
    17,
  );
  const state = (
    await deps.state.useClassResource(character, 'corona-of-light', 1)
  ).state;
  return {
    state,
    actionName: 'Coroa de Luz',
    resourceSpent: true,
    note: 'Coroa de Luz: aura de luz solar por 1 minuto; inimigos na Luz Plena têm Desvantagem em salvaguardas contra seu dano Ígneo ou Radiante.',
  };
}

export async function resolveTrickstersBlessing(
  deps: ClericActionDeps,
  character: PlayerCharacter,
): Promise<ClericTableActionResult> {
  assertSubclassFeature(
    character,
    'trickery',
    'Domínio da Trapaça',
    'Bênção do Trapaceiro',
  );
  const state = (
    await deps.state.useClassResource(character, 'tricksters-blessing', 1)
  ).state;
  return {
    state,
    actionName: 'Bênção do Trapaceiro',
    resourceSpent: true,
    note: 'Bênção do Trapaceiro: você ou uma criatura voluntária a 9 m recebe Vantagem em Furtividade até o Descanso Longo ou uma nova bênção.',
  };
}

export async function resolveInvokeDuplicity(
  deps: ClericActionDeps,
  character: PlayerCharacter,
): Promise<ClericTableActionResult> {
  assertSubclassFeature(
    character,
    'trickery',
    'Domínio da Trapaça',
    'Invocar Duplicidade',
  );
  const state = await spendChannelDivinity(deps, character);
  return {
    state,
    actionName: 'Invocar Duplicidade',
    resourceSpent: true,
    note: 'Invocar Duplicidade: Ação Bônus cria a ilusão por 1 minuto. Conjure a partir dela e obtenha Vantagem contra criaturas distraídas.',
  };
}

export async function resolveGuidedStrike(
  deps: ClericActionDeps,
  character: PlayerCharacter,
): Promise<ClericTableActionResult> {
  assertSubclassFeature(
    character,
    'war',
    'Domínio da Guerra',
    'Ataque Direcionado',
  );
  const state = await spendChannelDivinity(deps, character);
  /** PHB: Ataque Direcionado concede +10 à jogada. */
  const GUIDED_STRIKE_ATTACK_BONUS = 10;
  return {
    state,
    actionName: 'Ataque Direcionado',
    total: GUIDED_STRIKE_ATTACK_BONUS,
    resourceSpent: true,
    note: 'Ataque Direcionado: some +10 à jogada de ataque que errou, potencialmente transformando-a em acerto.',
  };
}

export async function resolveWarPriest(
  deps: ClericActionDeps,
  character: PlayerCharacter,
): Promise<ClericTableActionResult> {
  assertSubclassFeature(
    character,
    'war',
    'Domínio da Guerra',
    'Sacerdote da Guerra',
  );
  const state = (
    await deps.state.useClassResource(character, 'war-priest', 1)
  ).state;
  return {
    state,
    actionName: 'Sacerdote da Guerra',
    resourceSpent: true,
    note: 'Sacerdote da Guerra: use uma Ação Bônus para realizar um ataque com arma ou Ataque Desarmado.',
  };
}

export async function resolveWarGodsBlessing(
  deps: ClericActionDeps,
  character: PlayerCharacter,
): Promise<ClericTableActionResult> {
  assertSubclassFeature(
    character,
    'war',
    'Domínio da Guerra',
    'Bênção do Deus da Guerra',
    6,
  );
  const state = await spendChannelDivinity(deps, character);
  return {
    state,
    actionName: 'Bênção do Deus da Guerra',
    resourceSpent: true,
    note: 'Bênção do Deus da Guerra: conjure Arma Espiritual ou Escudo da Fé sem espaço; não requer Concentração e dura até 1 minuto.',
  };
}

export async function resolveDragonMajesty(
  deps: ClericActionDeps,
  character: PlayerCharacter,
): Promise<ClericTableActionResult> {
  assertSubclassFeature(
    character,
    'dragon-domain',
    'Domínio do Dragão',
    'Majestade Dracônica',
  );
  const state = await spendChannelDivinity(deps, character);
  const saveDc = await spellSaveDc(deps, character);
  return {
    state,
    actionName: 'Majestade Dracônica',
    saveDc,
    resourceSpent: true,
    note: `Majestade Dracônica: Emanação 9 m — escolha Enfeitiçado ou Amedrontado. CD ${saveDc} de SAB; falha = condição por 1 minuto (repete no fim do turno).`,
  };
}

export async function resolveSerpentBlessing(
  deps: ClericActionDeps,
  character: PlayerCharacter,
): Promise<ClericTableActionResult> {
  assertSubclassFeature(
    character,
    'dragon-domain',
    'Domínio do Dragão',
    'Bênção da Serpe',
    6,
  );
  const state = await spendChannelDivinity(deps, character);
  return {
    state,
    actionName: 'Bênção da Serpe',
    resourceSpent: true,
    note: 'Bênção da Serpe: conjure Sopro do Dragão ou Proteção contra Energia em si mesmo sem espaço; a magia não exige Concentração.',
  };
}

export async function resolveChromaticAffinity(
  deps: ClericActionDeps,
  character: PlayerCharacter,
): Promise<ClericTableActionResult> {
  assertSubclassFeature(
    character,
    'dragon-domain',
    'Domínio do Dragão',
    'Afinidade Cromática',
  );
  const state = (
    await deps.state.useClassResource(character, 'chromatic-affinity', 1)
  ).state;
  return {
    state,
    actionName: 'Afinidade Cromática',
    total: character.level,
    resourceSpent: true,
    note: `Afinidade Cromática: ao causar dano do tipo escolhido no Descanso Longo, some +${character.level} daquele tipo (1×/turno).`,
  };
}

async function resolveLegendaryAspect(
  deps: ClericActionDeps,
  character: PlayerCharacter,
  kind: 'rend' | 'tail' | 'wings',
): Promise<ClericTableActionResult> {
  assertSubclassFeature(
    character,
    'dragon-domain',
    'Domínio do Dragão',
    'Aspecto Lendário',
    17,
  );
  const state = (
    await deps.state.useClassResource(character, 'legendary-aspect', 1)
  ).state;

  if (kind === 'rend') {
    return {
      state,
      actionName: 'Aspecto Lendário — Rasgar',
      resourceSpent: true,
      note: 'Rasgar: mova-se até seu Deslocamento e conjure um Truque de Clérigo (ação) ou faça um ataque corpo a corpo (ataque/dano usam Sabedoria). Não repita esta opção até o início do seu próximo turno.',
    };
  }
  if (kind === 'tail') {
    return {
      state,
      actionName: 'Aspecto Lendário — Golpe de Cauda',
      resourceSpent: true,
      note: 'Golpe de Cauda: cada criatura Grande ou menor à sua escolha a até 3 m fica Caída. Não repita esta opção até o início do seu próximo turno.',
    };
  }
  return {
    state,
    actionName: 'Aspecto Lendário — Bater de Asas',
    resourceSpent: true,
    note: 'Bater de Asas: mova-se imediatamente até seu Deslocamento com Deslocamento de Voo igual ao seu Deslocamento; não provoca Ataques de Oportunidade. Não repita esta opção até o início do seu próximo turno.',
  };
}

export function resolveLegendaryAspectRend(
  deps: ClericActionDeps,
  character: PlayerCharacter,
): Promise<ClericTableActionResult> {
  return resolveLegendaryAspect(deps, character, 'rend');
}

export function resolveLegendaryAspectTail(
  deps: ClericActionDeps,
  character: PlayerCharacter,
): Promise<ClericTableActionResult> {
  return resolveLegendaryAspect(deps, character, 'tail');
}

export function resolveLegendaryAspectWings(
  deps: ClericActionDeps,
  character: PlayerCharacter,
): Promise<ClericTableActionResult> {
  return resolveLegendaryAspect(deps, character, 'wings');
}
