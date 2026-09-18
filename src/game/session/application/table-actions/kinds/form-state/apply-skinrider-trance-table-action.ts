import { BadRequestException } from '@nestjs/common';
import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from '../../primitives/table-action-guards';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { TableActionResponseDto } from '@game/session/dto/fighter/fighter-session.dto';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';

const SKINRIDER_RESOURCE = 'skinrider-trance';
const PRIMAL_SPIRIT_SUBCLASS = 'pathofthe-primal-spirit';

export async function applySkinriderTranceTableAction(input: {
  state: CharacterStateRepository;
  character: PlayerCharacter;
  actionSlug: string;
}): Promise<TableActionResponseDto> {
  assertCharacterSubclass(
    input.character,
    PRIMAL_SPIRIT_SUBCLASS,
    'Caminho do Espírito Primordial',
  );
  assertCharacterLevel(
    input.character,
    10,
    'Bárbaro',
    'Transe do Cavaleiro da Pele',
  );

  if (input.actionSlug === 'skinrider-s-trance-end') {
    const before = await input.state.buildResponse(input.character);
    if (!before.skinriderTranceActive) {
      return {
        state: before,
        actionName: 'Encerrar Transe',
        resourceSpent: false,
        note: 'Transe do Cavaleiro da Pele já estava inativo.',
      };
    }
    const state = await input.state.setSkinriderTrance(input.character, {
      active: false,
      actorId: null,
    });
    return {
      state,
      actionName: 'Encerrar Transe',
      resourceSpent: false,
      note: 'Transe do Cavaleiro da Pele encerrado. Corpo deixa o estado catatônico.',
    };
  }

  if (input.actionSlug !== 'skinrider-s-trance') {
    throw new BadRequestException(
      `Transe do Cavaleiro da Pele desconhecido: ${input.actionSlug}`,
    );
  }

  const before = await input.state.buildResponse(input.character);
  if (before.skinriderTranceActive) {
    throw new BadRequestException(
      'Transe do Cavaleiro da Pele já está ativo — encerre antes de entrar de novo',
    );
  }

  const companion = (before.companions ?? []).find(
    (entry) => entry.actorId && !entry.defeated,
  );
  if (!companion?.actorId) {
    throw new BadRequestException(
      'Transe exige companheiro primal ativo na ficha (Amizade Animal: declare actor na mesa)',
    );
  }

  await input.state.useClassResource(input.character, SKINRIDER_RESOURCE, 1);
  const state = await input.state.setSkinriderTrance(input.character, {
    active: true,
    actorId: companion.actorId,
  });

  const hours =
    Math.floor(input.character.level / 2) +
    Math.floor(((input.character.abilityScores?.constituicao ?? 10) - 10) / 2);

  return {
    state,
    actionName: 'Transe do Cavaleiro da Pele',
    resourceSpent: true,
    note: `Transe ativo · posse de ${companion.name} (actor ${companion.actorId}). Corpo catatônico. Duração máx. ~${Math.max(1, hours)} h. Declare Amizade Animal na mesa se for outra Fera.`,
  };
}
