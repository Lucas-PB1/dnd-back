import { BadRequestException, Injectable } from '@nestjs/common';
import { psiEnergyDieFaces } from '../../combat/domain/fighter-features';
import {
  resolveSoulknifeTableAction,
  type SoulknifeActionSlug,
} from '../../combat/domain/rogue-table-actions';
import { rollD20Check, rollDamageParts, rollDie } from '../../dice/domain/dice';
import { CharacterDomainService } from '../../sheet/domain/core/character-domain.service';
import { abilityModifier } from '../../sheet/domain/stats/ability-modifier';
import type { PlayerCharacter } from '../../shared/infrastructure/player-character.entity';
import {
  FighterTableActionResponseDto,
  UseRogueTableActionDto,
} from '../dto/character-state.dto';
import { CharacterStateRepository } from '../infrastructure/character-state.repository';
import { PlayerCharacterAccessService } from '../../shared/player-character-access.service';
import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from './table-action-guards';

@Injectable()
export class RogueActionsHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
    private readonly domain: CharacterDomainService,
  ) {}

  async useTableAction(
    userId: string,
    characterId: string,
    dto: UseRogueTableActionDto,
  ): Promise<FighterTableActionResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    if (character.classSlug !== 'rogue') {
      throw new BadRequestException('Rogue action is not available');
    }

    if (dto.actionSlug.startsWith('psychic-')) {
      assertCharacterSubclass(character, 'soulknife', 'Soulknife');
    }

    switch (dto.actionSlug) {
      case 'psychic-blade-main':
        return this.rollPsychicBlade(character, false);
      case 'psychic-blade-bonus':
        return this.rollPsychicBlade(character, true);
      case 'psi-bolstered-knack':
        return this.resolveConditionalPsiBonus(character, dto, false);
      case 'guided-strike':
        return this.resolveConditionalPsiBonus(character, dto, true);
      case 'psychic-whispers':
        return this.resolvePsychicWhispers(character, dto.usePsiDie);
      case 'psychic-teleport':
        return this.resolvePsychicTeleport(character);
      case 'psychic-veil':
        return this.resolvePsychicVeil(character, dto.usePsiDie);
      case 'rend-mind':
        return this.resolveRendMind(character, dto.usePsiDie);
      case 'spell-thief':
        return this.resolveSpellThief(character);
      case 'arachnoid-web':
        return this.resolveArachnoidWeb(character);
      case 'magic-device-charge':
        return this.resolveMagicDeviceCharge(character);
    }
  }

  private async rollPsychicBlade(
    character: PlayerCharacter,
    bonusAttack: boolean,
  ): Promise<FighterTableActionResponseDto> {
    assertCharacterLevel(character, 3, 'Rogue', 'Psychic Blades');
    const pb = await this.domain.getProficiencyBonus(character.level);
    const dexterity = abilityModifier(character.abilityScores.destreza);
    const attack = rollD20Check(dexterity + pb);
    const damageDie = bonusAttack ? '1d4' : '1d6';
    const damage = rollDamageParts(damageDie, dexterity);
    const name = bonusAttack ? 'Lâmina Psíquica adicional' : 'Lâmina Psíquica';

    return {
      state: await this.state.buildResponse(character),
      actionName: name,
      expression: `${attack.expression}; ${damage.expression}`,
      roll: attack.d20.kept[0],
      total: attack.total,
      resourceSpent: false,
      note: `${name}: ataque ${attack.total}; dano ${damage.total} Psíquico (${damage.expression}). Alcance normal 18 m, sem longo alcance.`,
    };
  }

  private async resolveConditionalPsiBonus(
    character: PlayerCharacter,
    dto: UseRogueTableActionDto,
    attack: boolean,
  ): Promise<FighterTableActionResponseDto> {
    const minimumLevel = attack ? 9 : 3;
    const actionName = attack ? 'Golpes Teleguiados' : 'Aptidão Reforçada';
    assertCharacterSubclass(character, 'soulknife', 'Soulknife');
    assertCharacterLevel(character, minimumLevel, 'Rogue', actionName);
    if (dto.checkTotal == null || dto.dc == null) {
      throw new BadRequestException(`${actionName} requires checkTotal and dc`);
    }

    const faces = this.psiDieFaces(character);
    const dieRoll = rollDie(faces);
    const newTotal = dto.checkTotal + dieRoll;
    const success = newTotal >= dto.dc;
    const tableAction = await this.resolveSoulknifeAction(
      character,
      attack ? 'homing-strikes' : 'psi-bolstered-knack',
      { dieRoll, succeededWithDie: success },
    );
    const state = tableAction.psiDiceCost > 0
      ? (
          await this.state.useClassResource(
            character,
            'soulknife-psi-dice',
            tableAction.psiDiceCost,
          )
        ).state
      : await this.state.buildResponse(character);

    return {
      state,
      actionName,
      expression: `1d${faces}`,
      roll: dieRoll,
      total: newTotal,
      resourceSpent: success,
      note: `${actionName}: ${dto.checkTotal} + ${dieRoll} = ${newTotal} vs ${dto.dc}; ${success ? 'sucesso, dado gasto' : 'ainda falhou, dado preservado'}.`,
    };
  }

  private async resolvePsychicWhispers(
    character: PlayerCharacter,
    usePsiDie = false,
  ): Promise<FighterTableActionResponseDto> {
    assertCharacterLevel(character, 3, 'Rogue', 'Psychic Whispers');
    const faces = this.psiDieFaces(character);
    const dieRoll = rollDie(faces);
    const pb = await this.domain.getProficiencyBonus(character.level);
    const tableAction = await this.resolveSoulknifeAction(
      character,
      'psychic-whispers',
      { dieRoll, usePsiDice: usePsiDie },
    );
    const state = (
      await this.state.useClassResource(
        character,
        tableAction.resourceSlug ?? 'psychic-whispers',
        tableAction.psiDiceCost || 1,
      )
    ).state;

    return {
      state,
      actionName: 'Sussurros Psíquicos',
      expression: `1d${faces}`,
      roll: dieRoll,
      total: dieRoll,
      resourceSpent: true,
      note: `Sussurros Psíquicos: conecte até ${pb} criaturas por ${dieRoll} hora(s). ${usePsiDie ? 'Dado psi gasto.' : 'Uso gratuito gasto.'}`,
    };
  }

  private async resolvePsychicTeleport(
    character: PlayerCharacter,
  ): Promise<FighterTableActionResponseDto> {
    assertCharacterLevel(character, 9, 'Rogue', 'Psychic Teleportation');
    const faces = this.psiDieFaces(character);
    const dieRoll = rollDie(faces);
    const tableAction = await this.resolveSoulknifeAction(
      character,
      'psychic-teleportation',
      { dieRoll },
    );
    const state = (
      await this.state.useClassResource(
        character,
        tableAction.resourceSlug ?? 'soulknife-psi-dice',
        tableAction.psiDiceCost,
      )
    ).state;

    return {
      state,
      actionName: 'Teleporte Psíquico',
      expression: `1d${faces}`,
      roll: dieRoll,
      total: dieRoll * 3,
      resourceSpent: true,
      note: `Teleporte Psíquico: teleporte-se até ${dieRoll * 3} m para um espaço visível e desocupado.`,
    };
  }

  private async resolvePsychicVeil(
    character: PlayerCharacter,
    usePsiDie = false,
  ): Promise<FighterTableActionResponseDto> {
    assertCharacterLevel(character, 13, 'Rogue', 'Psychic Veil');
    const tableAction = await this.resolveSoulknifeAction(
      character,
      'psychic-veil',
      { usePsiDice: usePsiDie },
    );
    const state = (
      await this.state.useClassResource(
        character,
        tableAction.resourceSlug ?? 'psychic-veil',
        tableAction.psiDiceCost || 1,
      )
    ).state;
    return {
      state,
      actionName: 'Véu Psíquico',
      resourceSpent: true,
      note: `Véu Psíquico: Invisível por 1 hora, até causar dano/forçar salvaguarda ou encerrar. ${usePsiDie ? 'Dado psi gasto.' : 'Uso gratuito gasto.'}`,
    };
  }

  private async resolveRendMind(
    character: PlayerCharacter,
    usePsiDie = false,
  ): Promise<FighterTableActionResponseDto> {
    assertCharacterLevel(character, 17, 'Rogue', 'Rend Mind');
    const tableAction = await this.resolveSoulknifeAction(
      character,
      'rend-mind',
      { usePsiDice: usePsiDie },
    );
    const state = (
      await this.state.useClassResource(
        character,
        tableAction.resourceSlug ?? 'rend-mind',
        tableAction.psiDiceCost || 1,
      )
    ).state;
    const pb = await this.domain.getProficiencyBonus(character.level);
    const saveDc =
      8 + abilityModifier(character.abilityScores.destreza) + pb;
    return {
      state,
      actionName: 'Rasgar Mente',
      saveDc,
      resourceSpent: true,
      note: `Rasgar Mente: após Ataque Furtivo com Lâmina Psíquica, salvaguarda SAB CD ${saveDc}; falha = Atordoado. ${usePsiDie ? '3 dados psi gastos.' : 'Uso gratuito gasto.'}`,
    };
  }

  private async resolveSpellThief(
    character: PlayerCharacter,
  ): Promise<FighterTableActionResponseDto> {
    assertCharacterSubclass(character, 'arcane-trickster', 'Arcane Trickster');
    assertCharacterLevel(character, 17, 'Rogue', 'Spell Thief');
    const state = (
      await this.state.useClassResource(character, 'spell-thief', 1)
    ).state;
    const pb = await this.domain.getProficiencyBonus(character.level);
    const saveDc =
      8 + abilityModifier(character.abilityScores.inteligencia) + pb;
    return {
      state,
      actionName: 'Ladrão de Magias',
      saveDc,
      resourceSpent: true,
      note: `Ladrão de Magias: o conjurador faz salvaguarda INT CD ${saveDc}; falha nega a magia e permite prepará-la conforme a característica.`,
    };
  }

  private async resolveArachnoidWeb(
    character: PlayerCharacter,
  ): Promise<FighterTableActionResponseDto> {
    assertCharacterSubclass(
      character,
      'arachnoid-stalker',
      'Arachnid Stalker',
    );
    assertCharacterLevel(character, 3, 'Rogue', 'Webbing');
    const state = (
      await this.state.useClassResource(character, 'arachnoid-web', 1)
    ).state;
    const pb = await this.domain.getProficiencyBonus(character.level);
    const saveDc =
      8 + abilityModifier(character.abilityScores.destreza) + pb;
    return {
      state,
      actionName: 'Correia',
      saveDc,
      resourceSpent: true,
      note: `Correia: escolha puxar-se, balançar ou prender conforme a característica. CD ${saveDc} quando houver salvaguarda; aplique posição/teia na mesa.`,
    };
  }

  private async resolveMagicDeviceCharge(
    character: PlayerCharacter,
  ): Promise<FighterTableActionResponseDto> {
    assertCharacterSubclass(character, 'thief', 'Thief');
    assertCharacterLevel(character, 13, 'Rogue', 'Use Magic Device');
    const dieRoll = rollDie(6);
    return {
      state: await this.state.buildResponse(character),
      actionName: 'Usar Dispositivo Mágico — Cargas',
      expression: '1d6',
      roll: dieRoll,
      total: dieRoll,
      resourceSpent: false,
      note:
        dieRoll === 6
          ? 'Usar Dispositivo Mágico: resultado 6; a propriedade não gasta cargas.'
          : 'Usar Dispositivo Mágico: a propriedade gasta as cargas normalmente.',
    };
  }

  private psiDieFaces(character: PlayerCharacter): number {
    const faces = psiEnergyDieFaces(character.level);
    if (faces == null) {
      throw new BadRequestException('Soulknife Psi Energy Die is unavailable');
    }
    return faces;
  }

  private async resolveSoulknifeAction(
    character: PlayerCharacter,
    actionSlug: SoulknifeActionSlug,
    options: {
      dieRoll?: number;
      usePsiDice?: boolean;
      succeededWithDie?: boolean;
    },
  ) {
    const pb = await this.domain.getProficiencyBonus(character.level);
    return resolveSoulknifeTableAction({
      actionSlug,
      level: character.level,
      dexterityModifier: abilityModifier(character.abilityScores.destreza),
      proficiencyBonus: pb,
      ...options,
    });
  }


}
