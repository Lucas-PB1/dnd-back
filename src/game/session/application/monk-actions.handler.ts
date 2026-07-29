import { BadRequestException, Injectable } from '@nestjs/common';
import {
  isMonkClass,
  martialArtsDie,
  monkFocusSaveDc,
} from '../../combat/domain/monk-features';
import { rollDamageParts } from '../../dice/domain/dice';
import { CharacterDomainService } from '../../sheet/domain/core/character-domain.service';
import { abilityModifier } from '../../sheet/domain/stats/ability-modifier';
import type { PlayerCharacter } from '../../shared/infrastructure/player-character.entity';
import {
  FighterTableActionResponseDto,
  UseMonkTableActionDto,
} from '../dto/character-state.dto';
import { CharacterStateRepository } from '../infrastructure/character-state.repository';
import { PlayerCharacterAccessService } from '../../shared/player-character-access.service';

const FOCUS_RESOURCE_SLUG = 'focusPoints';

@Injectable()
export class MonkActionsHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
    private readonly domain: CharacterDomainService,
  ) {}

  async useTableAction(
    userId: string,
    characterId: string,
    dto: UseMonkTableActionDto,
  ): Promise<FighterTableActionResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    if (!isMonkClass(character.classSlug)) {
      throw new BadRequestException('Monk action is not available');
    }

    switch (dto.actionSlug) {
      case 'flurry-of-blows':
        return this.resolveFlurryOfBlows(character);
      case 'patient-defense':
        return this.resolvePatientDefense(character);
      case 'step-of-the-wind':
        return this.resolveStepOfTheWind(character);
      case 'stunning-strike':
        return this.resolveStunningStrike(character);
      case 'open-hand-technique':
        return this.resolveOpenHandTechnique(character);
      case 'elemental-blast':
        return this.resolveElementalBlast(character);
      case 'hand-of-healing':
        return this.resolveHandOfHealing(character);
      case 'hand-of-harm':
        return this.resolveHandOfHarm(character);
      case 'shadow-step':
        return this.resolveShadowStep(character);
    }
  }

  private async resolveFlurryOfBlows(
    character: PlayerCharacter,
  ): Promise<FighterTableActionResponseDto> {
    this.assertLevel(character, 2, 'Torrente de Golpes');
    const strikes = character.level >= 10 ? 3 : 2;
    const state = await this.spendFocus(character, 1);
    return {
      state,
      actionName: 'Torrente de Golpes',
      resourceSpent: true,
      note: `Torrente de Golpes: gaste 1 Foco para fazer ${strikes} Ataques Desarmados como Ação Bônus (${martialArtsDie(
        character.level,
      )} cada).`,
    };
  }

  private async resolvePatientDefense(
    character: PlayerCharacter,
  ): Promise<FighterTableActionResponseDto> {
    this.assertLevel(character, 2, 'Defesa Paciente');
    const state = await this.spendFocus(character, 1);
    return {
      state,
      actionName: 'Defesa Paciente',
      resourceSpent: true,
      note: 'Defesa Paciente: gaste 1 Foco para usar Esquivar e Desengajar como Ação Bônus (Desengajar é gratuito sem gastar Foco).',
    };
  }

  private async resolveStepOfTheWind(
    character: PlayerCharacter,
  ): Promise<FighterTableActionResponseDto> {
    this.assertLevel(character, 2, 'Passo do Vento');
    const state = await this.spendFocus(character, 1);
    return {
      state,
      actionName: 'Passo do Vento',
      resourceSpent: true,
      note: 'Passo do Vento: gaste 1 Foco para usar Disparar e Desengajar como Ação Bônus; distância de salto dobra neste turno.',
    };
  }

  private async resolveStunningStrike(
    character: PlayerCharacter,
  ): Promise<FighterTableActionResponseDto> {
    this.assertLevel(character, 5, 'Golpe Atordoante');
    const saveDc = await this.focusDc(character);
    const state = await this.spendFocus(character, 1);
    return {
      state,
      actionName: 'Golpe Atordoante',
      saveDc,
      resourceSpent: true,
      note: `Golpe Atordoante: no acerto, gaste 1 Foco; o alvo faz salvaguarda de Constituição CD ${saveDc}. Falha = Atordoado até o fim do seu próximo turno; sucesso = metade do Deslocamento e Vantagem no seu próximo ataque contra ele.`,
    };
  }

  private async resolveOpenHandTechnique(
    character: PlayerCharacter,
  ): Promise<FighterTableActionResponseDto> {
    this.assertSubclass(character, 'open-hand', 'Mão Espalmada');
    this.assertLevel(character, 3, 'Técnica da Mão Espalmada');
    const saveDc = await this.focusDc(character);
    return {
      state: await this.state.buildResponse(character),
      actionName: 'Técnica da Mão Espalmada',
      saveDc,
      resourceSpent: false,
      note: `Técnica da Mão Espalmada: ao acertar com a Torrente de Golpes, cada ataque pode impor Caído (salvaguarda de Destreza CD ${saveDc}), empurrar 4,5 m (salvaguarda de Força CD ${saveDc}) ou impedir Reações até seu próximo turno.`,
    };
  }

  private async resolveElementalBlast(
    character: PlayerCharacter,
  ): Promise<FighterTableActionResponseDto> {
    this.assertSubclass(character, 'elements', 'Combatente dos Elementos');
    this.assertLevel(character, 3, 'Explosão Elemental');
    const dexterity = abilityModifier(character.abilityScores.destreza);
    const damage = rollDamageParts(martialArtsDie(character.level), dexterity);
    const state = await this.spendFocus(character, 1);
    return {
      state,
      actionName: 'Explosão Elemental',
      expression: damage.expression,
      roll: damage.dice[0]?.rolls[0],
      total: damage.total,
      resourceSpent: true,
      note: `Explosão Elemental: gaste 1 Foco para atacar à distância (18 m) com alcance elemental; dano ${damage.total} do tipo elemental escolhido (${damage.expression}).`,
    };
  }

  private async resolveHandOfHealing(
    character: PlayerCharacter,
  ): Promise<FighterTableActionResponseDto> {
    this.assertSubclass(character, 'mercy', 'Combatente da Misericórdia');
    this.assertLevel(character, 3, 'Mão de Cura');
    const wisdom = abilityModifier(character.abilityScores.sabedoria);
    const heal = rollDamageParts(martialArtsDie(character.level), wisdom);
    const state = await this.spendFocus(character, 1);
    return {
      state,
      actionName: 'Mão de Cura',
      expression: heal.expression,
      roll: heal.dice[0]?.rolls[0],
      total: heal.total,
      resourceSpent: true,
      note: `Mão de Cura: gaste 1 Foco para curar ${heal.total} PV (${heal.expression}) em uma criatura ao alcance.`,
    };
  }

  private async resolveHandOfHarm(
    character: PlayerCharacter,
  ): Promise<FighterTableActionResponseDto> {
    this.assertSubclass(character, 'mercy', 'Combatente da Misericórdia');
    this.assertLevel(character, 3, 'Mão de Dolo');
    const wisdom = abilityModifier(character.abilityScores.sabedoria);
    const damage = rollDamageParts(martialArtsDie(character.level), wisdom);
    const state = await this.spendFocus(character, 1);
    return {
      state,
      actionName: 'Mão de Dolo',
      expression: damage.expression,
      roll: damage.dice[0]?.rolls[0],
      total: damage.total,
      resourceSpent: true,
      note: `Mão de Dolo: ao acertar um Ataque Desarmado, gaste 1 Foco (1×/turno) para +${damage.total} de dano Necrótico (${damage.expression}).`,
    };
  }

  private async resolveShadowStep(
    character: PlayerCharacter,
  ): Promise<FighterTableActionResponseDto> {
    this.assertSubclass(character, 'shadow', 'Combatente das Sombras');
    this.assertLevel(character, 6, 'Passo da Sombra');
    return {
      state: await this.state.buildResponse(character),
      actionName: 'Passo da Sombra',
      resourceSpent: false,
      note: 'Passo da Sombra: na penumbra ou escuridão, teleporte-se até 9 m para outra área de penumbra/escuridão; seu próximo ataque corpo a corpo neste turno tem Vantagem.',
    };
  }

  private async spendFocus(
    character: PlayerCharacter,
    amount: number,
  ): Promise<FighterTableActionResponseDto['state']> {
    const result = await this.state.useClassResource(
      character,
      FOCUS_RESOURCE_SLUG,
      amount,
    );
    return result.state;
  }

  private async focusDc(character: PlayerCharacter): Promise<number> {
    const pb = await this.domain.getProficiencyBonus(character.level);
    return monkFocusSaveDc({
      wisdomModifier: abilityModifier(character.abilityScores.sabedoria),
      proficiencyBonus: pb,
    });
  }

  private assertLevel(
    character: PlayerCharacter,
    minimumLevel: number,
    actionName: string,
  ): void {
    if (character.level < minimumLevel) {
      throw new BadRequestException(
        `${actionName} requires Monk level ${minimumLevel}`,
      );
    }
  }

  private assertSubclass(
    character: PlayerCharacter,
    subclassSlug: string,
    subclassName: string,
  ): void {
    if (character.subclassSlug !== subclassSlug) {
      throw new BadRequestException(`${subclassName} action is not available`);
    }
  }
}
