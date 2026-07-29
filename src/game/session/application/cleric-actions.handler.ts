import { BadRequestException, Injectable } from '@nestjs/common';
import {
  destroyUndeadDice,
  divineSparkDice,
  isClericClass,
} from '../../combat/domain/cleric-features';
import { rollDamageParts } from '../../dice/domain/dice';
import { CharacterDomainService } from '../../sheet/domain/core/character-domain.service';
import { abilityModifier } from '../../sheet/domain/stats/ability-modifier';
import type { PlayerCharacter } from '../../shared/infrastructure/player-character.entity';
import {
  TableActionResponseDto,
  UseClericTableActionDto,
} from '../dto/character-state.dto';
import { CharacterStateRepository } from '../infrastructure/character-state.repository';
import { PlayerCharacterAccessService } from '../../shared/player-character-access.service';
import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from './table-action-guards';

const CHANNEL_DIVINITY_SLUG = 'channelDivinity';

@Injectable()
export class ClericActionsHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
    private readonly domain: CharacterDomainService,
  ) {}

  async useTableAction(
    userId: string,
    characterId: string,
    dto: UseClericTableActionDto,
  ): Promise<TableActionResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    if (!isClericClass(character.classSlug)) {
      throw new BadRequestException('Cleric action is not available');
    }

    switch (dto.actionSlug) {
      case 'divine-spark-heal':
        return this.resolveDivineSpark(character, 'heal');
      case 'divine-spark-damage':
        return this.resolveDivineSpark(character, 'damage');
      case 'turn-undead':
        return this.resolveTurnUndead(character);
      case 'divine-intervention':
        return this.resolveDivineIntervention(character);
      case 'preserve-life':
        return this.resolvePreserveLife(character);
      case 'radiance-of-dawn':
        return this.resolveRadianceOfDawn(character);
      case 'warding-flare':
        return this.resolveWardingFlare(character);
      case 'crown-of-light':
        return this.resolveCrownOfLight(character);
      case 'tricksters-blessing':
        return this.resolveTrickstersBlessing(character);
      case 'invoke-duplicity':
        return this.resolveInvokeDuplicity(character);
      case 'guided-strike':
        return this.resolveGuidedStrike(character);
      case 'war-priest':
        return this.resolveWarPriest(character);
      case 'war-gods-blessing':
        return this.resolveWarGodsBlessing(character);
    }
  }

  private async resolveDivineSpark(
    character: PlayerCharacter,
    mode: 'heal' | 'damage',
  ): Promise<TableActionResponseDto> {
    assertCharacterLevel(character, 2, 'Clérigo', 'Centelha Divina');
    const dice = divineSparkDice(character.level);
    const wisdom = abilityModifier(character.abilityScores.sabedoria);
    const result = rollDamageParts(dice, wisdom);
    const state = await this.spendChannelDivinity(character);
    const saveDc =
      mode === 'damage' ? await this.spellSaveDc(character) : undefined;

    return {
      state,
      actionName: mode === 'heal' ? 'Centelha Divina — Cura' : 'Centelha Divina — Dano',
      expression: result.expression,
      total: result.total,
      resourceSpent: true,
      ...(saveDc != null ? { saveDc } : {}),
      note:
        mode === 'heal'
          ? `Centelha Divina: restaure ${result.total} PV (${result.expression}).`
          : `Centelha Divina: CD ${saveDc} de CON; ${result.total} Necrótico ou Radiante (${result.expression}), metade no sucesso.`,
    };
  }

  private async resolveTurnUndead(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto> {
    assertCharacterLevel(character, 2, 'Clérigo', 'Expulsar Mortos-Vivos');
    const saveDc = await this.spellSaveDc(character);
    const state = await this.spendChannelDivinity(character);

    if (character.level < 5) {
      return {
        state,
        actionName: 'Expulsar Mortos-Vivos',
        saveDc,
        resourceSpent: true,
        note: `Expulsar Mortos-Vivos: CD ${saveDc} de SAB; falha deixa Mortos-Vivos Amedrontados e Incapacitados por 1 minuto (encerra ao sofrer dano).`,
      };
    }

    const dice = destroyUndeadDice(character.abilityScores.sabedoria);
    const result = rollDamageParts(dice, 0);
    return {
      state,
      actionName: 'Expulsar e Fulminar Mortos-Vivos',
      expression: result.expression,
      total: result.total,
      saveDc,
      resourceSpent: true,
      note: `Expulsar Mortos-Vivos + Fulminar: CD ${saveDc} de SAB; na falha, sofre ${result.total} Radiante (${dice}) e fica Amedrontado/Incapacitado.`,
    };
  }

  private async resolveDivineIntervention(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto> {
    assertCharacterLevel(character, 10, 'Clérigo', 'Intervenção Divina');
    const state = (
      await this.state.useClassResource(
        character,
        'divineIntervention',
        1,
      )
    ).state;
    return {
      state,
      actionName: 'Intervenção Divina',
      resourceSpent: true,
      note:
        character.level >= 20
          ? 'Intervenção Divina Maior: conjure uma magia de Clérigo de até 5º círculo ou Desejo sem espaço/material. Desejo bloqueia a característica por 2d4 Descansos Longos.'
          : 'Intervenção Divina: conjure uma magia de Clérigo de até 5º círculo, sem Reação, espaço ou componente Material.',
    };
  }

  private async resolvePreserveLife(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto> {
    this.assertSubclassFeature(character, 'life', 'Domínio da Vida', 'Preservar a Vida');
    const state = await this.spendChannelDivinity(character);
    const total = 5 * character.level;
    return {
      state,
      actionName: 'Preservar a Vida',
      total,
      resourceSpent: true,
      note: `Preservar a Vida: distribua até ${total} PV entre criaturas Sangrando a 9 m; nenhuma passa da metade dos PV máximos.`,
    };
  }

  private async resolveRadianceOfDawn(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto> {
    this.assertSubclassFeature(character, 'light', 'Domínio da Luz', 'Brilho do Amanhecer');
    const result = rollDamageParts('2d10', character.level);
    const state = await this.spendChannelDivinity(character);
    const saveDc = await this.spellSaveDc(character);
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

  private async resolveWardingFlare(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto> {
    this.assertSubclassFeature(character, 'light', 'Domínio da Luz', 'Labareda Protetora');
    const state = (
      await this.state.useClassResource(character, 'warding-flare', 1)
    ).state;

    if (character.level < 6) {
      return {
        state,
        actionName: 'Labareda Protetora',
        resourceSpent: true,
        note: 'Labareda Protetora: Reação para impor Desvantagem ao ataque de uma criatura visível a até 9 m.',
      };
    }

    const result = rollDamageParts(
      '2d6',
      abilityModifier(character.abilityScores.sabedoria),
    );
    return {
      state,
      actionName: 'Labareda Protetora Aprimorada',
      expression: result.expression,
      total: result.total,
      resourceSpent: true,
      note: `Labareda Protetora: imponha Desvantagem e conceda ${result.total} PV temporários (${result.expression}) ao alvo do ataque.`,
    };
  }

  private async resolveCrownOfLight(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto> {
    this.assertSubclassFeature(character, 'light', 'Domínio da Luz', 'Coroa de Luz', 17);
    const state = (
      await this.state.useClassResource(character, 'corona-of-light', 1)
    ).state;
    return {
      state,
      actionName: 'Coroa de Luz',
      resourceSpent: true,
      note: 'Coroa de Luz: aura de luz solar por 1 minuto; inimigos na Luz Plena têm Desvantagem em salvaguardas contra seu dano Ígneo ou Radiante.',
    };
  }

  private async resolveTrickstersBlessing(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto> {
    this.assertSubclassFeature(character, 'trickery', 'Domínio da Trapaça', 'Bênção do Trapaceiro');
    return {
      state: await this.state.buildResponse(character),
      actionName: 'Bênção do Trapaceiro',
      resourceSpent: false,
      note: 'Bênção do Trapaceiro: você ou uma criatura voluntária a 9 m recebe Vantagem em Furtividade até o Descanso Longo ou uma nova bênção.',
    };
  }

  private async resolveInvokeDuplicity(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto> {
    this.assertSubclassFeature(character, 'trickery', 'Domínio da Trapaça', 'Invocar Duplicidade');
    const state = await this.spendChannelDivinity(character);
    return {
      state,
      actionName: 'Invocar Duplicidade',
      resourceSpent: true,
      note: 'Invocar Duplicidade: Ação Bônus cria a ilusão por 1 minuto. Conjure a partir dela e obtenha Vantagem contra criaturas distraídas.',
    };
  }

  private async resolveGuidedStrike(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto> {
    this.assertSubclassFeature(character, 'war', 'Domínio da Guerra', 'Ataque Direcionado');
    const state = await this.spendChannelDivinity(character);
    return {
      state,
      actionName: 'Ataque Direcionado',
      total: 10,
      resourceSpent: true,
      note: 'Ataque Direcionado: some +10 à jogada de ataque que errou, potencialmente transformando-a em acerto.',
    };
  }

  private async resolveWarPriest(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto> {
    this.assertSubclassFeature(character, 'war', 'Domínio da Guerra', 'Sacerdote da Guerra');
    const state = (
      await this.state.useClassResource(character, 'war-priest', 1)
    ).state;
    return {
      state,
      actionName: 'Sacerdote da Guerra',
      resourceSpent: true,
      note: 'Sacerdote da Guerra: use uma Ação Bônus para realizar um ataque com arma ou Ataque Desarmado.',
    };
  }

  private async resolveWarGodsBlessing(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto> {
    this.assertSubclassFeature(
      character,
      'war',
      'Domínio da Guerra',
      'Bênção do Deus da Guerra',
      6,
    );
    const state = await this.spendChannelDivinity(character);
    return {
      state,
      actionName: 'Bênção do Deus da Guerra',
      resourceSpent: true,
      note: 'Bênção do Deus da Guerra: conjure Arma Espiritual ou Escudo da Fé sem espaço; não requer Concentração e dura até 1 minuto.',
    };
  }

  private assertSubclassFeature(
    character: PlayerCharacter,
    subclassSlug: string,
    subclassName: string,
    featureName: string,
    minLevel = 3,
  ): void {
    assertCharacterSubclass(character, subclassSlug, subclassName);
    assertCharacterLevel(character, minLevel, 'Clérigo', featureName);
  }

  private async spendChannelDivinity(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto['state']> {
    return (
      await this.state.useClassResource(character, CHANNEL_DIVINITY_SLUG, 1)
    ).state;
  }

  private async spellSaveDc(character: PlayerCharacter): Promise<number> {
    const proficiency = await this.domain.getProficiencyBonus(character.level);
    return (
      8 +
      proficiency +
      abilityModifier(character.abilityScores.sabedoria)
    );
  }
}
