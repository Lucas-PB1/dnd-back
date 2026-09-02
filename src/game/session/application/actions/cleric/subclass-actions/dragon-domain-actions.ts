import type {
  ClericActionDeps,
  ClericTableActionResult,
  PlayerCharacter,
} from '../cleric-action-deps';
import {
  assertSubclassFeature,
  spendChannelDivinity,
  spellSaveDc,
} from '../cleric-action-deps';

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
