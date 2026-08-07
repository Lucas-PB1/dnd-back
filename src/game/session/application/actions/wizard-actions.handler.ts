import { BadRequestException, Injectable } from '@nestjs/common';
import {
  abjurerArcaneWardHp,
  isWizardClass,
  portentDiceCount,
} from '../../../combat/domain/wizard-features';
import { rollDamageParts } from '../../../dice/domain/dice';
import { CharacterDomainService } from '../../../sheet/domain/core/character-domain.service';
import { abilityModifier } from '../../../sheet/domain/stats/ability-modifier';
import type { PlayerCharacter } from '../../../shared/infrastructure/player-character.entity';
import {
  TableActionResponseDto,
  UseWizardTableActionDto,
} from '../../dto/character-state.dto';
import { CharacterStateRepository } from '../../infrastructure/character-state.repository';
import { PlayerCharacterAccessService } from '../../../shared/player-character-access.service';
import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from '../core/table-action-guards';

@Injectable()
export class WizardActionsHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
    private readonly domain: CharacterDomainService,
  ) {}

  async useTableAction(
    userId: string,
    characterId: string,
    dto: UseWizardTableActionDto,
  ): Promise<TableActionResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    if (!isWizardClass(character.classSlug)) {
      throw new BadRequestException('Wizard action is not available');
    }

    switch (dto.actionSlug) {
      case 'arcane-recovery-1':
        return this.resolveArcaneRecovery(character, 1);
      case 'arcane-recovery-2':
        return this.resolveArcaneRecovery(character, 2);
      case 'arcane-recovery-3':
        return this.resolveArcaneRecovery(character, 3);
      case 'arcane-recovery-4':
        return this.resolveArcaneRecovery(character, 4);
      case 'arcane-recovery-5':
        return this.resolveArcaneRecovery(character, 5);

      case 'arcane-ward':
        return this.resolveArcaneWard(character);
      case 'portent':
        return this.resolvePortent(character);
      case 'sculpt-spells':
        return this.resolveSculptSpells(character);
      case 'improved-illusions':
        return this.resolveImprovedIllusions(character);
      case 'spell-mastery':
        return this.resolveSpellMastery(character);
      case 'arm-missile-shield':
        return this.resolveMissileFlag(character, 'shield', true);
      case 'disarm-missile-shield':
        return this.resolveMissileFlag(character, 'shield', false);
      case 'arm-giga-missile':
        return this.resolveMissileFlag(character, 'giga', true);
      case 'disarm-giga-missile':
        return this.resolveMissileFlag(character, 'giga', false);
    }
  }

  private async resolveArcaneRecovery(
    character: PlayerCharacter,
    slotLevel: number,
  ): Promise<TableActionResponseDto> {
    assertCharacterLevel(character, 1, 'Mago', 'Recuperação Arcana');
    await this.state.recoverSpellSlotLevel(character, slotLevel);
    const updatedState = await this.state.buildResponse(character);

    return {
      state: updatedState,
      actionName: `Recuperação Arcana (Slot ${slotLevel}º)`,
      resourceSpent: true,
      note: `Recuperação Arcana: recuperou 1 Slot de ${slotLevel}º círculo durante o descanso curto.`,
    };
  }

  private async resolveArcaneWard(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto> {
    assertCharacterSubclass(character, 'abjurer', 'Escola de Abjuração');
    assertCharacterLevel(character, 3, 'Mago', 'Proteção Arcana');
    const intMod = abilityModifier(character.abilityScores.inteligencia);
    const hp = abjurerArcaneWardHp(character.level, intMod);

    return {
      state: await this.state.buildResponse(character),
      actionName: 'Proteção Arcana',
      resourceSpent: false,
      total: hp,
      note: `Proteção Arcana: barreira mágica com ${hp} PV temporários ativa. Absorve dano sofrido e recarrega ao conjurar magias de Abjuração.`,
    };
  }

  private async resolvePortent(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto> {
    assertCharacterSubclass(character, 'diviner', 'Escola de Adivinhação');
    assertCharacterLevel(character, 3, 'Mago', 'Presságio');
    const count = portentDiceCount(character.level);
    const rolls = Array.from({ length: count }, () => Math.floor(Math.random() * 20) + 1);

    return {
      state: await this.state.buildResponse(character),
      actionName: 'Presságio',
      resourceSpent: false,
      note: `Presságio: rolagens de portento guardadas para hoje: [${rolls.join(', ')}]. Use para substituir qualquer d20 seu ou de uma criatura.`,
    };
  }

  private async resolveSculptSpells(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto> {
    assertCharacterSubclass(character, 'evoker', 'Escola de Evocação');
    assertCharacterLevel(character, 3, 'Mago', 'Esculpir Magias');

    return {
      state: await this.state.buildResponse(character),
      actionName: 'Esculpir Magias',
      resourceSpent: false,
      note: 'Esculpir Magias: escolha até 1 + Nível da Magia aliados no raio de evocação em área. Eles passam automaticamente na salvaguarda e não sofrem dano.',
    };
  }

  private async resolveImprovedIllusions(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto> {
    assertCharacterSubclass(character, 'illusionist', 'Escola de Ilusão');
    assertCharacterLevel(character, 3, 'Mago', 'Ilusão Aprimorada');

    return {
      state: await this.state.buildResponse(character),
      actionName: 'Ilusão Aprimorada',
      resourceSpent: false,
      note: 'Ilusão Aprimorada: conjure truques de Ilusão e Imagem Silenciosa como Ação Bônus sem componentes V e com o dobro do alcance.',
    };
  }

  private async resolveSpellMastery(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto> {
    assertCharacterLevel(character, 18, 'Mago', 'Dominância de Magias');

    return {
      state: await this.state.buildResponse(character),
      actionName: 'Dominância de Magias',
      resourceSpent: false,
      note: 'Dominância de Magias: 1 magia de 1º círculo e 1 de 2º círculo preparadas podem ser conjuradas sem consumir espaço de magia.',
    };
  }

  private async resolveMissileFlag(
    character: PlayerCharacter,
    kind: 'shield' | 'giga',
    armed: boolean,
  ): Promise<TableActionResponseDto> {
    assertCharacterSubclass(character, 'magic-missile-mage', 'Mago dos Mísseis');
    if (kind === 'shield') {
      assertCharacterLevel(character, 10, 'Mago', 'Escudo de Mísseis');
    } else {
      assertCharacterLevel(character, 14, 'Mago', 'Giga-Míssil');
    }

    const state = await this.state.setMissileMageArmedFlags(character, {
      missileShieldArmed: kind === 'shield' ? armed : undefined,
      gigaMissileArmed: kind === 'giga' ? armed : undefined,
    });

    const label = kind === 'shield' ? 'Escudo de Mísseis' : 'Giga-Míssil';
    return {
      state: await this.state.buildResponse(character, state),
      actionName: label,
      resourceSpent: false,
      note: armed
        ? `${label} armado: aplica no próximo Mísseis Mágicos (gasta o uso no cast).`
        : `${label} desarmado.`,
    };
  }
}
