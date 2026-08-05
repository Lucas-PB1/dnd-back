import { BadRequestException, Injectable } from '@nestjs/common';
import {
  isDruidClass,
  moonWildShapeTempHp,
} from '../../combat/domain/druid-features';
import { rollDamageParts } from '../../dice/domain/dice';
import { CharacterDomainService } from '../../sheet/domain/core/character-domain.service';
import { abilityModifier } from '../../sheet/domain/stats/ability-modifier';
import type { PlayerCharacter } from '../../shared/infrastructure/player-character.entity';
import {
  TableActionResponseDto,
  UseDruidTableActionDto,
} from '../dto/character-state.dto';
import { CharacterStateRepository } from '../infrastructure/character-state.repository';
import { PlayerCharacterAccessService } from '../../shared/player-character-access.service';
import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from './table-action-guards';

const WILD_SHAPE_SLUG = 'wildShape';

@Injectable()
export class DruidActionsHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
    private readonly domain: CharacterDomainService,
  ) {}

  async useTableAction(
    userId: string,
    characterId: string,
    dto: UseDruidTableActionDto,
  ): Promise<TableActionResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    if (!isDruidClass(character.classSlug)) {
      throw new BadRequestException('Druid action is not available');
    }

    switch (dto.actionSlug) {
      case 'wild-shape':
        return this.resolveWildShape(character);
      case 'wild-resurgence-slot':
        return this.resolveWildResurgenceSlot(character);
      case 'wild-resurgence-shape':
        return this.resolveWildResurgenceShape(character);
      case 'starry-form-archer':
        return this.resolveStarryFormArcher(character);
      case 'starry-form-chalice':
        return this.resolveStarryFormChalice(character);
      case 'starry-form-dragon':
        return this.resolveStarryFormDragon(character);
      case 'wrath-of-the-sea':
        return this.resolveWrathOfTheSea(character);
      case 'moon-combat-wild-shape':
        return this.resolveMoonCombatWildShape(character);
    }
  }

  private async resolveWildShape(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto> {
    assertCharacterLevel(character, 2, 'Druida', 'Forma Selvagem');
    const state = await this.spendWildShape(character);

    return {
      state,
      actionName: 'Forma Selvagem',
      resourceSpent: true,
      total: 1,
      note: 'Forma Selvagem: gastou 1 uso para assumir a forma de uma besta ou ativar Companheiro Selvagem.',
    };
  }

  private async resolveWildResurgenceSlot(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto> {
    assertCharacterLevel(character, 5, 'Druida', 'Ressurgimento Selvagem');
    await this.spendWildShape(character);
    await this.state.recoverSpellSlotLevel(character, 1);
    const updatedState = await this.state.buildResponse(character);

    return {
      state: updatedState,
      actionName: 'Ressurgimento Selvagem (Slot)',
      resourceSpent: true,
      note: 'Ressurgimento Selvagem: gastou 1 uso de Forma Selvagem para recuperar 1 Slot de 1º círculo.',
    };
  }

  private async resolveWildResurgenceShape(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto> {
    assertCharacterLevel(character, 5, 'Druida', 'Ressurgimento Selvagem');
    await this.state.consumeSpellSlotLevel(character, 1);
    const updatedState = await this.recoverWildShape(character);

    return {
      state: updatedState,
      actionName: 'Ressurgimento Selvagem (Forma)',
      resourceSpent: true,
      note: 'Ressurgimento Selvagem: consumiu 1 Slot de 1º círculo para recuperar 1 uso de Forma Selvagem.',
    };
  }

  private async resolveStarryFormArcher(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto> {
    assertCharacterSubclass(character, 'stars', 'Círculo das Estrelas');
    assertCharacterLevel(character, 3, 'Druida', 'Forma Estelar (Arquiro)');
    const wisdom = abilityModifier(character.abilityScores.sabedoria);
    const result = rollDamageParts('1d8', wisdom);
    const state = await this.spendWildShape(character);

    return {
      state,
      actionName: 'Forma Estelar: Arquiro',
      expression: result.expression,
      total: result.total,
      resourceSpent: true,
      note: `Forma Estelar (Arquiro): Ação Bônus desfere um ataque à distância radiante causando ${result.total} de dano radiante (${result.expression}).`,
    };
  }

  private async resolveStarryFormChalice(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto> {
    assertCharacterSubclass(character, 'stars', 'Círculo das Estrelas');
    assertCharacterLevel(character, 3, 'Druida', 'Forma Estelar (Cálice)');
    const wisdom = abilityModifier(character.abilityScores.sabedoria);
    const result = rollDamageParts('1d8', wisdom);
    const state = await this.spendWildShape(character);

    return {
      state,
      actionName: 'Forma Estelar: Cálice',
      expression: result.expression,
      total: result.total,
      resourceSpent: true,
      note: `Forma Estelar (Cálice): ao conjurar uma magia de cura, você ou uma criatura a até 9 m recupera ${result.total} PV adicionais (${result.expression}).`,
    };
  }

  private async resolveStarryFormDragon(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto> {
    assertCharacterSubclass(character, 'stars', 'Círculo das Estrelas');
    assertCharacterLevel(character, 3, 'Druida', 'Forma Estelar (Dragão)');
    const state = await this.spendWildShape(character);

    return {
      state,
      actionName: 'Forma Estelar: Dragão',
      resourceSpent: true,
      note: 'Forma Estelar (Dragão): em testes de Inteligência, Sabedoria ou salvaguardas de Concentração, qualquer resultado menor que 10 no d20 torna-se 10.',
    };
  }

  private async resolveWrathOfTheSea(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto> {
    assertCharacterSubclass(character, 'sea', 'Círculo do Mar');
    assertCharacterLevel(character, 3, 'Druida', 'Ira do Mar');
    const wisdom = abilityModifier(character.abilityScores.sabedoria);
    const diceCount = Math.max(1, wisdom);
    const result = rollDamageParts(`${diceCount}d6`, 0);
    const state = await this.spendWildShape(character);

    return {
      state,
      actionName: 'Ira do Mar',
      expression: result.expression,
      total: result.total,
      resourceSpent: true,
      note: `Ira do Mar: Ação Bônus emana aura de tempestade a 3 m. Causa ${result.total} de dano elétrico/concussão (${result.expression}) e empurra a criatura atingida em 4,5 m.`,
    };
  }

  private async resolveMoonCombatWildShape(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto> {
    assertCharacterSubclass(character, 'moon', 'Círculo da Lua');
    assertCharacterLevel(character, 3, 'Druida', 'Forma Selvagem de Combate');
    const tempHp = moonWildShapeTempHp(character.level);
    const state = await this.spendWildShape(character);

    return {
      state,
      actionName: 'Forma Selvagem de Combate',
      resourceSpent: true,
      total: tempHp,
      note: `Forma Selvagem de Combate: ganha ${tempHp} PV temporários, CA = 13 + Mod. Sabedoria e pode gastar slots de magia para se curar com Ação Bônus.`,
    };
  }

  private async spendWildShape(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto['state']> {
    try {
      const result = await this.state.useClassResource(
        character,
        WILD_SHAPE_SLUG,
        1,
      );
      return result.state;
    } catch {
      const result = await this.state.useClassResource(
        character,
        'wild-shape',
        1,
      );
      return result.state;
    }
  }

  private async recoverWildShape(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto['state']> {
    try {
      return await this.state.recoverClassResource(
        character,
        WILD_SHAPE_SLUG,
        1,
      );
    } catch {
      return await this.state.recoverClassResource(
        character,
        'wild-shape',
        1,
      );
    }
  }
}
