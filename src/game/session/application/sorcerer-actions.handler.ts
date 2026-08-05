import { BadRequestException, Injectable } from '@nestjs/common';
import {
  isSorcererClass,
  sorceryPointCostToCreateSlot,
} from '../../combat/domain/sorcerer-features';
import { CharacterDomainService } from '../../sheet/domain/core/character-domain.service';
import type { PlayerCharacter } from '../../shared/infrastructure/player-character.entity';
import {
  TableActionResponseDto,
  UseSorcererTableActionDto,
} from '../dto/character-state.dto';
import { CharacterStateRepository } from '../infrastructure/character-state.repository';
import { PlayerCharacterAccessService } from '../../shared/player-character-access.service';
import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from './table-action-guards';

const SORCERY_POINTS_SLUG = 'sorceryPoints';

@Injectable()
export class SorcererActionsHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
    private readonly domain: CharacterDomainService,
  ) {}

  async useTableAction(
    userId: string,
    characterId: string,
    dto: UseSorcererTableActionDto,
  ): Promise<TableActionResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    if (!isSorcererClass(character.classSlug)) {
      throw new BadRequestException('Sorcerer action is not available');
    }

    switch (dto.actionSlug) {
      case 'convert-slot-1-to-points':
        return this.convertSlotToPoints(character, 1);
      case 'convert-slot-2-to-points':
        return this.convertSlotToPoints(character, 2);
      case 'convert-slot-3-to-points':
        return this.convertSlotToPoints(character, 3);
      case 'convert-slot-4-to-points':
        return this.convertSlotToPoints(character, 4);
      case 'convert-slot-5-to-points':
        return this.convertSlotToPoints(character, 5);

      case 'convert-points-to-slot-1':
        return this.convertPointsToSlot(character, 1);
      case 'convert-points-to-slot-2':
        return this.convertPointsToSlot(character, 2);
      case 'convert-points-to-slot-3':
        return this.convertPointsToSlot(character, 3);
      case 'convert-points-to-slot-4':
        return this.convertPointsToSlot(character, 4);
      case 'convert-points-to-slot-5':
        return this.convertPointsToSlot(character, 5);

      case 'use-metamagic-1':
        return this.useMetamagic(character, 1, 'Metamágica (1 ponto)');
      case 'use-metamagic-2':
        return this.useMetamagic(character, 2, 'Metamágica (2 pontos)');
      case 'use-metamagic-3':
        return this.useMetamagic(character, 3, 'Metamágica (3 pontos)');

      case 'innate-sorcery':
        return this.resolveInnateSorcery(character);
      case 'sorcerous-restoration':
        return this.resolveSorcerousRestoration(character);
      case 'tides-of-chaos':
        return this.resolveTidesOfChaos(character);
      case 'bastion-of-law':
        return this.resolveBastionOfLaw(character);
    }
  }

  private async convertSlotToPoints(
    character: PlayerCharacter,
    slotLevel: number,
  ): Promise<TableActionResponseDto> {
    assertCharacterLevel(character, 2, 'Feiticeiro', 'Fonte de Magia');
    await this.state.consumeSpellSlotLevel(character, slotLevel);
    const updatedState = await this.state.recoverClassResource(
      character,
      SORCERY_POINTS_SLUG,
      slotLevel,
    );

    return {
      state: updatedState,
      actionName: `Converter Slot de ${slotLevel}º Círculo`,
      resourceSpent: true,
      total: slotLevel,
      note: `Fonte de Magia: consumiu 1 Slot de ${slotLevel}º círculo para recuperar ${slotLevel} Pontos de Feitiçaria.`,
    };
  }

  private async convertPointsToSlot(
    character: PlayerCharacter,
    slotLevel: number,
  ): Promise<TableActionResponseDto> {
    assertCharacterLevel(character, 2, 'Feiticeiro', 'Fonte de Magia');
    const cost = sorceryPointCostToCreateSlot(slotLevel);
    await this.spendPoints(character, cost);
    await this.state.recoverSpellSlotLevel(character, slotLevel);
    const updatedState = await this.state.buildResponse(character);

    return {
      state: updatedState,
      actionName: `Criar Slot de ${slotLevel}º Círculo`,
      resourceSpent: true,
      total: cost,
      note: `Fonte de Magia: gastou ${cost} Pontos de Feitiçaria para criar 1 Slot de ${slotLevel}º círculo.`,
    };
  }

  private async useMetamagic(
    character: PlayerCharacter,
    pointsCost: number,
    label: string,
  ): Promise<TableActionResponseDto> {
    assertCharacterLevel(character, 2, 'Feiticeiro', 'Metamágica');
    const state = await this.spendPoints(character, pointsCost);

    return {
      state,
      actionName: label,
      resourceSpent: true,
      total: pointsCost,
      note: `Metamágica: gastou ${pointsCost} Ponto(s) de Feitiçaria para modificar a conjuração da magia.`,
    };
  }

  private async resolveInnateSorcery(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto> {
    assertCharacterLevel(character, 1, 'Feiticeiro', 'Inato Feiticeiro');

    return {
      state: await this.state.buildResponse(character),
      actionName: 'Ira Feiticeira',
      resourceSpent: false,
      note: 'Inato Feiticeiro: Ação Bônus ativa Ira Feiticeira por 1 minuto (+1 na CD das suas magias e Vantagem nas jogadas de ataque com truques de Feiticeiro).',
    };
  }

  private async resolveSorcerousRestoration(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto> {
    assertCharacterLevel(character, 5, 'Feiticeiro', 'Restauração Feiticeira');
    const pointsToRecover = Math.floor(character.level / 2);
    const state = await this.state.recoverClassResource(
      character,
      SORCERY_POINTS_SLUG,
      pointsToRecover,
    );

    return {
      state,
      actionName: 'Restauração Feiticeira',
      resourceSpent: false,
      total: pointsToRecover,
      note: `Restauração Feiticeira: recuperou ${pointsToRecover} Pontos de Feitiçaria no Descanso Curto.`,
    };
  }

  private async resolveTidesOfChaos(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto> {
    assertCharacterSubclass(character, 'wild-magic', 'Magia Selvagem');
    assertCharacterLevel(character, 3, 'Feiticeiro', 'Maré de Caos');

    return {
      state: await this.state.buildResponse(character),
      actionName: 'Maré de Caos',
      resourceSpent: false,
      note: 'Maré de Caos: ganhe Vantagem em uma jogada de ataque, teste de habilidade ou salvaguarda. O Mestre pode disparar um Surto de Magia Selvagem a qualquer momento antes do próximo descanso longo para recarregar esta característica.',
    };
  }

  private async resolveBastionOfLaw(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto> {
    assertCharacterSubclass(character, 'clockwork', 'Mapeamento Mecânico');
    assertCharacterLevel(character, 6, 'Feiticeiro', 'Baluarte da Ordem');
    const state = await this.spendPoints(character, 2);

    return {
      state,
      actionName: 'Baluarte da Ordem',
      resourceSpent: true,
      total: 2,
      note: 'Baluarte da Ordem: gastou 2 Pontos de Feitiçaria para conceder 2d8 de dados de proteção a uma criatura a até 9 m. Ao sofrer dano, a criatura pode gastar os dados para reduzir o dano sofrido.',
    };
  }

  private async spendPoints(
    character: PlayerCharacter,
    amount: number,
  ): Promise<TableActionResponseDto['state']> {
    try {
      const result = await this.state.useClassResource(
        character,
        SORCERY_POINTS_SLUG,
        amount,
      );
      return result.state;
    } catch {
      const result = await this.state.useClassResource(
        character,
        'sorcery-points',
        amount,
      );
      return result.state;
    }
  }
}
