import { BadRequestException, Injectable } from '@nestjs/common';
import {
  abjurerArcaneWardHp,
  ILLUSORY_SELF_RESOURCE,
  isWizardClass,
  portentDiceCount,
  SCULPT_SPELLS_UNLOCK_LEVEL,
  SPECTRAL_SUMMON_RESOURCE,
  THIRD_EYE_RESOURCE,
} from '@game/combat/domain/wizard-features';
import { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import {
  TableActionResponseDto,
  UseWizardTableActionDto,
} from '@game/session/dto/character-state.dto';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
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
      case 'arcane-ward-recharge':
        return this.resolveArcaneWardRecharge(character);
      case 'projected-ward':
        return this.resolveProjectedWard(character);
      case 'spell-breaker':
        return this.resolveSpellBreaker(character);

      case 'portent':
        return this.resolvePortent(character);
      case 'third-eye':
        return this.resolveThirdEye(character);

      case 'sculpt-spells':
        return this.resolveSculptSpells(character);
      case 'overchannel':
        return this.resolveOverchannel(character);

      case 'improved-illusions':
        return this.resolveImprovedIllusions(character);
      case 'spectral-summon':
        return this.resolveSpectralSummon(character);
      case 'illusory-self':
        return this.resolveIllusorySelf(character);
      case 'illusory-reality':
        return this.resolveIllusoryReality(character);

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

  private async resolveArcaneWardRecharge(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto> {
    assertCharacterSubclass(character, 'abjurer', 'Escola de Abjuração');
    assertCharacterLevel(character, 3, 'Mago', 'Proteção Arcana');

    return {
      state: await this.state.buildResponse(character),
      actionName: 'Recarregar Proteção Arcana',
      resourceSpent: false,
      note: 'Recarregar Proteção: Ação Bônus — gaste 1 espaço de magia; a Proteção recupera PV iguais ao dobro do círculo do espaço.',
    };
  }

  private async resolveProjectedWard(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto> {
    assertCharacterSubclass(character, 'abjurer', 'Escola de Abjuração');
    assertCharacterLevel(character, 6, 'Mago', 'Proteção Projetada');

    return {
      state: await this.state.buildResponse(character),
      actionName: 'Proteção Projetada',
      resourceSpent: false,
      note: 'Proteção Projetada: Reação — quando uma criatura à sua vista a até 9 m sofrer dano, sua Proteção Arcana pode absorvê-lo no lugar dela.',
    };
  }

  private async resolveSpellBreaker(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto> {
    assertCharacterSubclass(character, 'abjurer', 'Escola de Abjuração');
    assertCharacterLevel(character, 10, 'Mago', 'Rompe-Magia');
    const pb = await this.domain.getProficiencyBonus(character.level);

    return {
      state: await this.state.buildResponse(character),
      actionName: 'Rompe-Magia',
      resourceSpent: false,
      note: `Rompe-Magia: Dissipar Magia como Ação Bônus; some +${pb} (PB) ao teste. Contramagia e Dissipar sempre preparadas; se falharem ao interromper, o espaço não é gasto.`,
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

  private async resolveThirdEye(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto> {
    assertCharacterSubclass(character, 'diviner', 'Escola de Adivinhação');
    assertCharacterLevel(character, 10, 'Mago', 'O Terceiro Olho');
    const state = (
      await this.state.useClassResource(character, THIRD_EYE_RESOURCE, 1)
    ).state;

    return {
      state,
      actionName: 'O Terceiro Olho',
      resourceSpent: true,
      note: 'O Terceiro Olho: Ação Bônus — escolha Compreensão Superior, Ver o Invisível (sem espaço) ou Visão no Escuro 36 m até o próximo descanso. 1× por Descanso Curto ou Longo.',
    };
  }

  private async resolveSculptSpells(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto> {
    assertCharacterSubclass(character, 'evoker', 'Escola de Evocação');
    assertCharacterLevel(
      character,
      SCULPT_SPELLS_UNLOCK_LEVEL,
      'Mago',
      'Esculpir Magias',
    );

    return {
      state: await this.state.buildResponse(character),
      actionName: 'Esculpir Magias',
      resourceSpent: false,
      note: 'Esculpir Magias: escolha até 1 + nível da magia aliados na área de Evocação. Eles passam automaticamente na salvaguarda e não sofrem dano.',
    };
  }

  private async resolveOverchannel(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto> {
    assertCharacterSubclass(character, 'evoker', 'Escola de Evocação');
    assertCharacterLevel(character, 14, 'Mago', 'Sobrecarga');

    return {
      state: await this.state.buildResponse(character),
      actionName: 'Sobrecarga',
      resourceSpent: false,
      note: 'Sobrecarga: ao conjurar magia de Mago com dano (espaço 1º–5º), pode causar dano máximo. 1ª vez no dia sem custo; usos seguintes antes do Descanso Longo causam 2d12 Necrótico por círculo (+1d12 por uso extra), ignorando Resistência/Imunidade.',
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

  private async resolveSpectralSummon(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto> {
    assertCharacterSubclass(character, 'illusionist', 'Escola de Ilusão');
    assertCharacterLevel(character, 6, 'Mago', 'Criaturas Espectrais');
    const state = (
      await this.state.useClassResource(character, SPECTRAL_SUMMON_RESOURCE, 1)
    ).state;

    return {
      state,
      actionName: 'Criaturas Espectrais',
      resourceSpent: true,
      note: 'Criaturas Espectrais: Ação — Convocar Feérico ou Invocar Fera (versão Ilusão) sem espaço; PV da criatura pela metade. Recupera no Descanso Longo.',
    };
  }

  private async resolveIllusorySelf(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto> {
    assertCharacterSubclass(character, 'illusionist', 'Escola de Ilusão');
    assertCharacterLevel(character, 10, 'Mago', 'Autoimagem Ilusória');
    const state = (
      await this.state.useClassResource(character, ILLUSORY_SELF_RESOURCE, 1)
    ).state;

    return {
      state,
      actionName: 'Autoimagem Ilusória',
      resourceSpent: true,
      note: 'Autoimagem Ilusória: Reação ao ser atingido — o ataque erra. Restaure no Descanso Curto/Longo ou gastando um espaço de 2º+ (sem ação).',
    };
  }

  private async resolveIllusoryReality(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto> {
    assertCharacterSubclass(character, 'illusionist', 'Escola de Ilusão');
    assertCharacterLevel(character, 14, 'Mago', 'Realidade Ilusória');

    return {
      state: await this.state.buildResponse(character),
      actionName: 'Realidade Ilusória',
      resourceSpent: false,
      note: 'Realidade Ilusória: Ação Bônus — enquanto uma Ilusão conjurada com espaço estiver ativa, torne real 1 objeto inanimado não mágico dela por 1 minuto (não causa dano nem condições).',
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
