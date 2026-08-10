import {
  isBarbarianClass,
  rageDamageBonus,
} from '@game/combat/domain/barbarian';
import { applyTemporaryHitPoints } from '@game/session/application/core/apply-temporary-hit-points';
import { assertCharacterLevel } from '@game/session/application/core/table-action-guards';
import { BadRequestException } from '@nestjs/common';
import type {
  BarbarianActionDeps,
  BarbarianTableActionResult,
  PlayerCharacter,
} from './barbarian-action-deps';
import { RAGE_RESOURCE } from './barbarian-action-deps';

export async function resolveToggleRage(
  deps: BarbarianActionDeps,
  character: PlayerCharacter,
): Promise<BarbarianTableActionResult> {
  if (!isBarbarianClass(character.classSlug)) {
    throw new BadRequestException('Rage requires the Barbarian class');
  }
  const before = await deps.state.buildResponse(character);
  const entering = !before.rageActive;
  const state = await deps.state.martial.toggleRage(character, entering);

  if (!entering) {
    return {
      state,
      actionName: 'Encerrar Fúria',
      resourceSpent: false,
      note: 'Fúria encerrada.',
    };
  }

  const bonus = rageDamageBonus(character.level);
  let note = `Fúria ativa (+${bonus} dano FOR; Resistência Contundente/Cortante/Perfurante). Gasta 1 uso.`;
  let nextState = state;

  if (character.subclassSlug === 'world-tree' && character.level >= 3) {
    nextState = await applyTemporaryHitPoints(
      deps.state,
      character,
      character.level,
    );
    note += ` Árvore do Mundo — Surto de Vitalidade: ${character.level} PV temporários aplicados na ficha.`;
  }

  if (character.subclassSlug === 'wild-heart' && character.level >= 3) {
    note +=
      ' Coração Selvagem: escolha Águia, Lobo ou Urso nesta ativação (mesa).';
  }
  if (character.subclassSlug === 'wild-heart' && character.level >= 14) {
    note += ' Também escolha Carneiro, Falcão ou Leão.';
  }
  if (character.level >= 7) {
    note += ' Bote Instintivo: mova até metade do Deslocamento.';
  }

  return {
    state: nextState,
    actionName: 'Entrar em Fúria',
    resourceSpent: true,
    note,
  };
}

export async function resolveToggleReckless(
  deps: BarbarianActionDeps,
  character: PlayerCharacter,
): Promise<BarbarianTableActionResult> {
  assertCharacterLevel(character, 2, 'Bárbaro', 'Ataque Imprudente');
  const before = await deps.state.buildResponse(character);
  const next = !before.recklessActive;
  const state = await deps.state.martial.toggleReckless(character, next);
  return {
    state,
    actionName: next ? 'Ataque Imprudente' : 'Encerrar Imprudente',
    resourceSpent: false,
    note: next
      ? 'Ataque Imprudente ativo: Vantagem em ataques com Força; ataques contra você têm Vantagem.'
      : 'Ataque Imprudente encerrado.',
  };
}

export async function resolveRecoverAllRage(
  deps: BarbarianActionDeps,
  character: PlayerCharacter,
): Promise<BarbarianTableActionResult> {
  assertCharacterLevel(character, 15, 'Bárbaro', 'Fúria Persistente');
  const state = await deps.state.martial.recoverAllRage(character);
  return {
    state,
    actionName: 'Fúria Persistente',
    resourceSpent: false,
    note: `Fúria Persistente: recuperou todos os usos de ${RAGE_RESOURCE} (marque 1×/Descanso Longo na mesa).`,
  };
}
