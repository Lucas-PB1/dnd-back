import { BadRequestException, Injectable } from '@nestjs/common';
import {
  bardicInspirationDie,
  isBardClass,
} from '../../combat/domain/bard-features';
import {
  assertValidPersonaMasks,
  maxEquippedPersonaMasks,
} from '../../combat/domain/college-of-masks';
import { rollDamageParts } from '../../dice/domain/dice';
import { CharacterDomainService } from '../../sheet/domain/core/character-domain.service';
import { abilityModifier } from '../../sheet/domain/stats/ability-modifier';
import type { PlayerCharacter } from '../../shared/infrastructure/player-character.entity';
import {
  TableActionResponseDto,
  UseBardTableActionDto,
} from '../dto/character-state.dto';
import { CharacterStateRepository } from '../infrastructure/character-state.repository';
import { PlayerCharacterAccessService } from '../../shared/player-character-access.service';
import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from './table-action-guards';

const BARDIC_INSPIRATION_SLUG = 'bardicInspiration';

@Injectable()
export class BardActionsHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
    private readonly domain: CharacterDomainService,
  ) {}

  async useTableAction(
    userId: string,
    characterId: string,
    dto: UseBardTableActionDto,
  ): Promise<TableActionResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    if (!isBardClass(character.classSlug)) {
      throw new BadRequestException('Bard action is not available');
    }

    switch (dto.actionSlug) {
      case 'grant-inspiration':
        return this.resolveGrantInspiration(character);
      case 'cutting-words':
        return this.resolveCuttingWords(character);
      case 'enthralling-performance':
        return this.resolveEnthrallingPerformance(character);
      case 'agile-response':
        return this.resolveAgileResponse(character);
      case 'unarmed-dance':
        return this.resolveUnarmedDance(character);
      case 'combat-inspiration':
        return this.resolveCombatInspiration(character);
      case 'superior-inspiration':
        return this.resolveSuperiorInspiration(character);
      case 'set-persona-masks':
        return this.resolveSetPersonaMasks(character, dto.masks ?? []);
    }
  }

  private async resolveSetPersonaMasks(
    character: PlayerCharacter,
    masks: string[],
  ): Promise<TableActionResponseDto> {
    assertCharacterSubclass(
      character,
      'college-of-masks',
      'Colégio das Máscaras',
    );
    assertCharacterLevel(character, 3, 'Bardo', 'Máscaras de Persona');
    try {
      assertValidPersonaMasks(masks, character.level);
    } catch (error) {
      throw new BadRequestException(
        error instanceof Error ? error.message : 'Invalid persona masks',
      );
    }

    const max = maxEquippedPersonaMasks(character.level);
    const state = await this.state.setPersonaMasks(character, masks);
    const label = masks.length === 0 ? 'nenhuma máscara' : masks.join(', ');

    return {
      state,
      actionName: 'Vestir Máscaras de Persona',
      resourceSpent: false,
      note: `Máscaras de Persona (${masks.length}/${max}): ${label}.`,
    };
  }

  private async resolveGrantInspiration(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto> {
    assertCharacterLevel(character, 1, 'Bardo', 'Inspiração Bárdica');
    const die = bardicInspirationDie(character.level);
    const state = await this.spendInspiration(character);

    return {
      state,
      actionName: 'Inspiração Bárdica',
      expression: `1${die}`,
      resourceSpent: true,
      note: `Inspiração Bárdica (1${die}): concedida como Ação Bônus a uma criatura voluntária a até 18 m por 1 hora. Ela pode adicionar o dado a um teste de habilidade, ataque ou salvaguarda.`,
    };
  }

  private async resolveCuttingWords(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto> {
    assertCharacterSubclass(character, 'lore', 'Colégio do Conhecimento');
    assertCharacterLevel(character, 3, 'Bardo', 'Palavras Cortantes');
    const die = bardicInspirationDie(character.level);
    const result = rollDamageParts(`1${die}`, 0);
    const state = await this.spendInspiration(character);

    return {
      state,
      actionName: 'Palavras Cortantes',
      expression: result.expression,
      total: result.total,
      resourceSpent: true,
      note: `Palavras Cortantes: Reação gasta 1 Inspiração para subtrair ${result.total} (1${die}) de uma jogada de ataque, teste de habilidade ou dano de um inimigo visível a até 18 m.`,
    };
  }

  private async resolveEnthrallingPerformance(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto> {
    assertCharacterSubclass(character, 'glamour', 'Colégio do Glamour');
    assertCharacterLevel(character, 3, 'Bardo', 'Desempenho Cativante');
    const die = bardicInspirationDie(character.level);
    const result = rollDamageParts(`2${die}`, 0);
    const charisma = abilityModifier(character.abilityScores.carisma);
    const alliesCount = Math.max(1, charisma);
    const state = await this.spendInspiration(character);

    return {
      state,
      actionName: 'Desempenho Cativante',
      expression: result.expression,
      total: result.total,
      resourceSpent: true,
      note: `Desempenho Cativante: gaste 1 Inspiração para conceder ${result.total} PV temporários (${result.expression}) a até ${alliesCount} aliados a 18 m. Cada um pode usar a Reação para mover-se seu Deslocamento sem provocar ataques de oportunidade.`,
    };
  }

  private async resolveAgileResponse(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto> {
    assertCharacterSubclass(character, 'dance', 'Colégio da Dança');
    assertCharacterLevel(character, 6, 'Bardo', 'Resposta Ágil');
    const die = bardicInspirationDie(character.level);
    const result = rollDamageParts(`1${die}`, 0);
    const state = await this.spendInspiration(character);

    return {
      state,
      actionName: 'Resposta Ágil',
      expression: result.expression,
      total: result.total,
      resourceSpent: true,
      note: `Resposta Ágil: Reação gasta 1 Inspiração para conceder +${result.total} (1${die}) na CA a você ou aliado a 18 m atacado. Se o ataque errar, o alvo pode mover metade do Deslocamento sem provocar Opport. Attacks.`,
    };
  }

  private async resolveUnarmedDance(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto> {
    assertCharacterSubclass(character, 'dance', 'Colégio da Dança');
    assertCharacterLevel(character, 3, 'Bardo', 'Dança Virtuosa (Ataque Desarmado)');
    const die = bardicInspirationDie(character.level);
    const charisma = abilityModifier(character.abilityScores.carisma);
    const result = rollDamageParts(`1${die}`, charisma);

    return {
      state: await this.state.buildResponse(character),
      actionName: 'Dança Virtuosa (Ataque Desarmado)',
      expression: result.expression,
      total: result.total,
      resourceSpent: false,
      note: `Ataque Desarmado Dançante: usa Carisma no ataque/dano e causa ${result.total} de dano Contundente (${result.expression}). Ao usar Ação Bônus, pode mover-se sem provocar ataques de oportunidade.`,
    };
  }

  private async resolveCombatInspiration(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto> {
    assertCharacterSubclass(character, 'valor', 'Colégio da Bravura');
    assertCharacterLevel(character, 3, 'Bardo', 'Inspiração de Combate');
    const die = bardicInspirationDie(character.level);
    const state = await this.spendInspiration(character);

    return {
      state,
      actionName: 'Inspiração de Combate',
      expression: `1${die}`,
      resourceSpent: true,
      note: `Inspiração de Combate (1${die}): a criatura com Inspiração Bárdica pode rolar o dado e somar à rolagem de dano da arma ou usar a Reação para somar o dado à sua CA contra um ataque.`,
    };
  }

  private async resolveSuperiorInspiration(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto> {
    assertCharacterLevel(character, 18, 'Bardo', 'Inspiração Superior');
    const state = await this.state.recoverClassResource(
      character,
      BARDIC_INSPIRATION_SLUG,
      1,
    );

    return {
      state,
      actionName: 'Inspiração Superior',
      resourceSpent: false,
      note: 'Inspiração Superior: ao rolar iniciativa sem usos de Inspiração Bárdica restantes, recupere 1 uso.',
    };
  }

  private async spendInspiration(
    character: PlayerCharacter,
  ): Promise<TableActionResponseDto['state']> {
    try {
      const result = await this.state.useClassResource(
        character,
        BARDIC_INSPIRATION_SLUG,
        1,
      );
      return result.state;
    } catch {
      // Fallback para slug alternativo com hífen caso o catálogo registre com hífen
      const result = await this.state.useClassResource(
        character,
        'bardic-inspiration',
        1,
      );
      return result.state;
    }
  }
}
