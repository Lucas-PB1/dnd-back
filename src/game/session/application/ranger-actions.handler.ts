import { BadRequestException, Injectable } from '@nestjs/common';
import {
  HUNTERS_MARK_SPELL_SLUG,
  isRangerClass,
} from '../../combat/domain/ranger-features';
import { rollDamageParts } from '../../dice/domain/dice';
import { abilityModifier } from '../../sheet/domain/stats/ability-modifier';
import type { PlayerCharacter } from '../../shared/infrastructure/player-character.entity';
import {
  FighterTableActionResponseDto,
  UseRangerTableActionDto,
} from '../dto/character-state.dto';
import { CharacterStateRepository } from '../infrastructure/character-state.repository';
import { PlayerCharacterAccessService } from '../../shared/player-character-access.service';
import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from './table-action-guards';

const FAVORED_ENEMY_SLUG = 'favoredEnemy';
const TIRELESS_SLUG = 'tireless';
const NATURES_VEIL_SLUG = 'naturesVeil';
const FEY_REINFORCEMENTS_SLUG = 'fey-reinforcements';
const MISTY_WANDERER_SLUG = 'misty-wanderer';

@Injectable()
export class RangerActionsHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
  ) {}

  async useTableAction(
    userId: string,
    characterId: string,
    dto: UseRangerTableActionDto,
  ): Promise<FighterTableActionResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    if (!isRangerClass(character.classSlug)) {
      throw new BadRequestException('Ranger action is not available');
    }

    switch (dto.actionSlug) {
      case 'hunters-mark-free':
        return this.resolveHuntersMarkFree(character);
      case 'tireless':
        return this.resolveTireless(character);
      case 'natures-veil':
        return this.resolveNaturesVeil(character);
      case 'fey-reinforcements':
        return this.resolveFeyReinforcements(character);
      case 'misty-wanderer':
        return this.resolveMistyWanderer(character);
      case 'primal-companion':
        return this.resolvePrimalCompanion(character);
    }
  }

  private async resolveHuntersMarkFree(
    character: PlayerCharacter,
  ): Promise<FighterTableActionResponseDto> {
    await this.state.useClassResource(character, FAVORED_ENEMY_SLUG, 1);
    const state = await this.state.patch(character, {
      concentratingOn: HUNTERS_MARK_SPELL_SLUG,
    });
    return {
      state,
      actionName: 'Marca do Predador (gratuita)',
      resourceSpent: true,
      note: 'Inimigo Favorito: Marca do Predador conjurada sem espaço; concentração iniciada. Cause o dado extra no acerto pela ficha.',
    };
  }

  private async resolveTireless(
    character: PlayerCharacter,
  ): Promise<FighterTableActionResponseDto> {
    assertCharacterLevel(character, 10, 'Ranger', 'Incansável');
    const wisdom = Math.max(1, abilityModifier(character.abilityScores.sabedoria));
    const heal = rollDamageParts('1d8', wisdom);
    const state = (
      await this.state.useClassResource(character, TIRELESS_SLUG, 1)
    ).state;
    return {
      state,
      actionName: 'Incansável',
      expression: heal.expression,
      roll: heal.dice[0]?.rolls[0],
      total: heal.total,
      resourceSpent: true,
      note: `Incansável: você ganha ${heal.total} PV temporários (${heal.expression}). Descanso Curto reduz Exaustão em 1.`,
    };
  }

  private async resolveNaturesVeil(
    character: PlayerCharacter,
  ): Promise<FighterTableActionResponseDto> {
    assertCharacterLevel(character, 14, 'Ranger', 'Véu da Natureza');
    const state = (
      await this.state.useClassResource(character, NATURES_VEIL_SLUG, 1)
    ).state;
    return {
      state,
      actionName: 'Véu da Natureza',
      resourceSpent: true,
      note: 'Véu da Natureza: Ação Bônus — você fica Invisível até o fim do seu próximo turno.',
    };
  }

  private async resolveFeyReinforcements(
    character: PlayerCharacter,
  ): Promise<FighterTableActionResponseDto> {
    assertCharacterSubclass(character, 'fey-wanderer', 'Andarilho Feérico');
    assertCharacterLevel(character, 11, 'Ranger', 'Reforços Feéricos');
    const state = (
      await this.state.useClassResource(character, FEY_REINFORCEMENTS_SLUG, 1)
    ).state;
    return {
      state,
      actionName: 'Reforços Feéricos',
      resourceSpent: true,
      note: 'Reforços Feéricos: Convocar Feérico sem espaço e sem Concentração (duração 1 minuto nesta conjuração).',
    };
  }

  private async resolveMistyWanderer(
    character: PlayerCharacter,
  ): Promise<FighterTableActionResponseDto> {
    assertCharacterSubclass(character, 'fey-wanderer', 'Andarilho Feérico');
    assertCharacterLevel(character, 15, 'Ranger', 'Andarilho Nebuloso');
    const state = (
      await this.state.useClassResource(character, MISTY_WANDERER_SLUG, 1)
    ).state;
    return {
      state,
      actionName: 'Andarilho Nebuloso',
      resourceSpent: true,
      note: 'Andarilho Nebuloso: Passo Nebuloso sem espaço; pode levar uma criatura voluntária a 1,5 m.',
    };
  }

  private async resolvePrimalCompanion(
    character: PlayerCharacter,
  ): Promise<FighterTableActionResponseDto> {
    assertCharacterSubclass(character, 'beast-master', 'Senhor das Feras');
    assertCharacterLevel(character, 3, 'Ranger', 'Companheiro Primal');
    return {
      state: await this.state.buildResponse(character),
      actionName: 'Companheiro Primal',
      resourceSpent: false,
      note: 'Companheiro Primal: Ação Bônus para comandar a fera; na ação Atacar você pode sacrificar um ataque para o Golpe da Fera.',
    };
  }


}
