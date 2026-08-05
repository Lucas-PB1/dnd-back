import { BadRequestException, Injectable } from '@nestjs/common';
import {
  isWarlockClass,
  warlockPactSlotLevel,
} from '../../combat/domain/warlock-features';
import { rollDamageParts } from '../../dice/domain/dice';
import { CharacterDomainService } from '../../sheet/domain/core/character-domain.service';
import { abilityModifier } from '../../sheet/domain/stats/ability-modifier';
import type { PlayerCharacter } from '../../shared/infrastructure/player-character.entity';
import {
  TableActionResponseDto,
  UseWarlockTableActionDto,
} from '../dto/character-state.dto';
import { CharacterStateRepository } from '../infrastructure/character-state.repository';
import { PlayerCharacterAccessService } from '../../shared/player-character-access.service';
import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from './table-action-guards';

@Injectable()
export class WarlockActionsHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
    private readonly domain: CharacterDomainService,
  ) {}

  async useTableAction(
    userId: string,
    characterId: string,
    dto: UseWarlockTableActionDto,
  ): Promise<TableActionResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    if (!isWarlockClass(character.classSlug)) {
      throw new BadRequestException('Warlock action is not available');
    }

    switch (dto.actionSlug) {
      case 'magical-cunning':
        return this.resolveMagicalCunning(character);
      case 'healing-light':
        return this.resolveHealingLight(character);
      case 'dark-ones-own-luck':
        return this.resolveDarkOnesOwnLuck(character);
      case 'fey-step-effect':
        return this.resolveFeyStepEffect(character);
      case 'awakened-mind':
        return this.resolveAwakenedMind(character);
      case 'fiendish-resilience':
        return this.resolveFiendishResilience(character);
    }
  }

  private async resolveMagicalCunning(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto> {
    assertCharacterLevel(character, 5, 'Bruxo', 'Contato Arcano');
    const slotLvl = warlockPactSlotLevel(character.level);
    await this.state.recoverSpellSlotLevel(character, slotLvl);
    const updatedState = await this.state.buildResponse(character);

    return {
      state: updatedState,
      actionName: 'Contato Arcano',
      resourceSpent: true,
      note: `Contato Arcano: Ação Bônus recuperou 1 Slot de Pacto de ${slotLvl}º círculo (1×/Descanso Longo).`,
    };
  }

  private async resolveHealingLight(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto> {
    assertCharacterSubclass(character, 'celestial', 'Patrono Celestial');
    assertCharacterLevel(character, 3, 'Bruxo', 'Luz Curativa');
    const charisma = abilityModifier(character.abilityScores.carisma);
    const diceCount = Math.max(1, charisma);
    const result = rollDamageParts(`${diceCount}d6`, 0);

    let state;
    try {
      state = (
        await this.state.useClassResource(
          character,
          'healing-light',
          diceCount,
        )
      ).state;
    } catch {
      state = await this.state.buildResponse(character);
    }

    return {
      state,
      actionName: 'Luz Curativa',
      expression: result.expression,
      total: result.total,
      resourceSpent: true,
      note: `Luz Curativa: Ação Bônus gasta ${diceCount}d6 da reserva e restaura ${result.total} PV (${result.expression}) a uma criatura visível a até 18 m.`,
    };
  }

  private async resolveDarkOnesOwnLuck(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto> {
    assertCharacterSubclass(character, 'fiend', 'Patrono Ínfero');
    assertCharacterLevel(character, 3, 'Bruxo', 'Sorte do Próprio Inferno');
    const result = rollDamageParts('1d10', 0);

    let state;
    try {
      state = (
        await this.state.useClassResource(
          character,
          'dark-ones-own-luck',
          1,
        )
      ).state;
    } catch {
      state = await this.state.buildResponse(character);
    }

    return {
      state,
      actionName: 'Sorte do Próprio Inferno',
      expression: result.expression,
      total: result.total,
      resourceSpent: true,
      note: `Sorte do Próprio Inferno: some +${result.total} (1d10) ao teste de habilidade ou salvaguarda que você acabou de rolar.`,
    };
  }

  private async resolveFeyStepEffect(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto> {
    assertCharacterSubclass(character, 'archfey', 'Patrono Arquifada');
    assertCharacterLevel(character, 3, 'Bruxo', 'Passo de Bruma Aprimorado');

    return {
      state: await this.state.buildResponse(character),
      actionName: 'Passo de Bruma Aprimorado',
      resourceSpent: false,
      note: 'Passo de Bruma Aprimorado: ao teletransportar-se com Passo de Bruma, aplique um efeito de Passo Feérico (Provocar, Desorientar, Invisibilidade ou Refrancar).',
    };
  }

  private async resolveAwakenedMind(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto> {
    assertCharacterSubclass(character, 'great-old-one', 'Patrono Grande Antigo');
    assertCharacterLevel(character, 3, 'Bruxo', 'Mente Desperta');

    return {
      state: await this.state.buildResponse(character),
      actionName: 'Mente Desperta',
      resourceSpent: false,
      note: 'Mente Desperta: estabeleça elo telepático a 9 m. Suas magias do Hex/Maldição causam dano Psíquico e impõem Desvantagem.',
    };
  }

  private async resolveFiendishResilience(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto> {
    assertCharacterSubclass(character, 'fiend', 'Patrono Ínfero');
    assertCharacterLevel(character, 10, 'Bruxo', 'Resiliência Ínfera');

    return {
      state: await this.state.buildResponse(character),
      actionName: 'Resiliência Ínfera',
      resourceSpent: false,
      note: 'Resiliência Ínfera: escolha um tipo de dano após um descanso curto ou longo para ganhar Resistência a ele (armas mágicas ou de prata ignoram a resistência).',
    };
  }
}
