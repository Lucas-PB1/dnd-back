import { BadRequestException, Injectable } from '@nestjs/common';
import { isPaladinClass } from '../../combat/domain/paladin-features';
import { CharacterDomainService } from '../../sheet/domain/core/character-domain.service';
import { abilityModifier } from '../../sheet/domain/stats/ability-modifier';
import type { PlayerCharacter } from '../../shared/infrastructure/player-character.entity';
import {
  FighterTableActionResponseDto,
  UsePaladinTableActionDto,
} from '../dto/character-state.dto';
import { CharacterStateRepository } from '../infrastructure/character-state.repository';
import { PlayerCharacterAccessService } from '../../shared/player-character-access.service';
import { assertCharacterLevel } from './table-action-guards';

const LAY_ON_HANDS_SLUG = 'layOnHands';
const CHANNEL_DIVINITY_SLUG = 'channelDivinity';
const CURE_POISON_COST = 5;

@Injectable()
export class PaladinActionsHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
    private readonly domain: CharacterDomainService,
  ) {}

  async useTableAction(
    userId: string,
    characterId: string,
    dto: UsePaladinTableActionDto,
  ): Promise<FighterTableActionResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    if (!isPaladinClass(character.classSlug)) {
      throw new BadRequestException('Paladin action is not available');
    }

    switch (dto.actionSlug) {
      case 'lay-on-hands':
        return this.resolveLayOnHands(character, dto.amount);
      case 'cure-poison':
        return this.resolveCurePoison(character);
      case 'divine-sense':
        return this.resolveDivineSense(character);
      case 'abjure-enemies':
        return this.resolveAbjureEnemies(character);
      case 'oath-channel':
        return this.resolveOathChannel(character);
    }
  }

  private async resolveLayOnHands(
    character: PlayerCharacter,
    amount: number | undefined,
  ): Promise<FighterTableActionResponseDto> {
    const points = amount ?? 1;
    if (points < 1) {
      throw new BadRequestException('Lay on Hands requires at least 1 point');
    }
    const state = (
      await this.state.useClassResource(character, LAY_ON_HANDS_SLUG, points)
    ).state;
    return {
      state,
      actionName: 'Mãos Consagradas',
      total: points,
      resourceSpent: true,
      note: `Mãos Consagradas: cure ${points} PV (reserva de 5 × nível).`,
    };
  }

  private async resolveCurePoison(
    character: PlayerCharacter,
  ): Promise<FighterTableActionResponseDto> {
    const state = (
      await this.state.useClassResource(
        character,
        LAY_ON_HANDS_SLUG,
        CURE_POISON_COST,
      )
    ).state;
    return {
      state,
      actionName: 'Mãos Consagradas — Curar Veneno',
      total: CURE_POISON_COST,
      resourceSpent: true,
      note: 'Mãos Consagradas: gaste 5 PV da reserva para remover a condição Envenenado.',
    };
  }

  private async resolveDivineSense(
    character: PlayerCharacter,
  ): Promise<FighterTableActionResponseDto> {
    assertCharacterLevel(character, 3, 'Paladin', 'Sentido Divino');
    const state = (
      await this.state.useClassResource(character, CHANNEL_DIVINITY_SLUG, 1)
    ).state;
    return {
      state,
      actionName: 'Sentido Divino',
      resourceSpent: true,
      note: 'Sentido Divino: até o fim do próximo turno, saiba a posição de Celestiais, Corruptores e Mortos-vivos em 18 m (1 uso de Canalizar Divindade).',
    };
  }

  private async resolveAbjureEnemies(
    character: PlayerCharacter,
  ): Promise<FighterTableActionResponseDto> {
    assertCharacterLevel(character, 9, 'Paladin', 'Repudiar Inimigos');
    const saveDc = await this.paladinSaveDc(character);
    const state = (
      await this.state.useClassResource(character, CHANNEL_DIVINITY_SLUG, 1)
    ).state;
    return {
      state,
      actionName: 'Repudiar Inimigos',
      saveDc,
      resourceSpent: true,
      note: `Repudiar Inimigos: criaturas escolhidas fazem salvaguarda de Sabedoria CD ${saveDc}; na falha ficam Amedrontadas e com Deslocamento 0.`,
    };
  }

  private async resolveOathChannel(
    character: PlayerCharacter,
  ): Promise<FighterTableActionResponseDto> {
    assertCharacterLevel(character, 3, 'Paladin', 'Canalizar Divindade do Juramento');
    const saveDc = await this.paladinSaveDc(character);
    const state = (
      await this.state.useClassResource(character, CHANNEL_DIVINITY_SLUG, 1)
    ).state;
    return {
      state,
      actionName: this.oathChannelName(character.subclassSlug),
      saveDc,
      resourceSpent: true,
      note: `${this.oathChannelNote(character.subclassSlug)} (1 uso de Canalizar Divindade; CD ${saveDc} quando houver salvaguarda).`,
    };
  }

  private oathChannelName(subclassSlug: string | null): string {
    switch (subclassSlug) {
      case 'devotion':
        return 'Arma Sagrada';
      case 'glory':
        return 'Destruição Inspiradora';
      case 'ancients':
        return 'A Ira da Natureza';
      case 'vengeance':
        return 'Voto de Inimizade';
      case 'oath-of-revelry':
        return 'Conjurar Bebida';
      default:
        return 'Canalizar Divindade do Juramento';
    }
  }

  private oathChannelNote(subclassSlug: string | null): string {
    switch (subclassSlug) {
      case 'devotion':
        return 'Arma Sagrada: por 10 min, some o mod. de Carisma aos ataques da arma e ela emite luz Radiante';
      case 'glory':
        return 'Destruição Inspiradora: após acertar, cause dano Radiante extra e conceda PV temporários';
      case 'ancients':
        return 'A Ira da Natureza: vinhas espectrais Imobilizam criaturas próximas em uma falha de Força ou Destreza';
      case 'vengeance':
        return 'Voto de Inimizade: por 1 min, tenha Vantagem nos ataques contra o alvo escolhido';
      case 'oath-of-revelry':
        return 'Conjurar Bebida: crie bebida mágica que fortalece aliados na área';
      default:
        return 'Use uma opção de Canalizar Divindade do seu juramento';
    }
  }

  private async paladinSaveDc(character: PlayerCharacter): Promise<number> {
    const pb = await this.domain.getProficiencyBonus(character.level);
    return 8 + abilityModifier(character.abilityScores.carisma) + pb;
  }

}
