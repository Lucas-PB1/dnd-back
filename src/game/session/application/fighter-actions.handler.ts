import { BadRequestException, Injectable } from '@nestjs/common';
import { listBattleMasterManeuvers } from '../../combat/domain/battle-master-maneuvers';
import {
  findDungeoneerPrecautionSpell,
  resolveBattleMasterTableRoll,
  resolvePsiWarriorTableAction,
} from '../../combat/domain/fighter-table-actions';
import {
  psiEnergyDieFaces,
  superiorityDieFaces,
} from '../../combat/domain/fighter-features';
import { rollDie } from '../../dice/domain/dice';
import { CharacterDomainService } from '../../sheet/domain/core/character-domain.service';
import { abilityModifier } from '../../sheet/domain/stats/ability-modifier';
import { CharacterSheetRepository } from '../../sheet/infrastructure/character-sheet.repository';
import { PlayerCharacterAccessService } from '../../shared/player-character-access.service';
import { CharacterStateRepository } from '../infrastructure/character-state.repository';
import {
  ActionSurgeResponseDto,
  FighterTableActionResponseDto,
  SecondWindResponseDto,
  TacticalMindDto,
  TacticalMindResponseDto,
  UseBattleMasterManeuverDto,
  UseDungeonPrecautionDto,
  UsePsiWarriorActionDto,
} from '../dto/character-state.dto';

@Injectable()
export class FighterActionsHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
    private readonly domain: CharacterDomainService,
    private readonly sheet: CharacterSheetRepository,
  ) {}

  async useSecondWind(
    userId: string,
    characterId: string,
  ): Promise<SecondWindResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    return this.state.useSecondWind(character);
  }

  async useTacticalMind(
    userId: string,
    characterId: string,
    dto: TacticalMindDto,
  ): Promise<TacticalMindResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    return this.state.useTacticalMind(character, dto.checkTotal, dto.dc);
  }

  async useActionSurge(
    userId: string,
    characterId: string,
  ): Promise<ActionSurgeResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    return this.state.useActionSurge(character);
  }

  async listBattleMasterManeuvers(userId: string, characterId: string) {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'read',
    );
    if (
      character.classSlug !== 'fighter' ||
      character.subclassSlug !== 'battle-master' ||
      character.level < 3
    ) {
      return [];
    }
    const maneuvers = listBattleMasterManeuvers();
    const sheet = await this.sheet.load(
      character.id,
      character.backgroundSlug,
    );
    const selected = new Set(
      sheet.subclassOptions
        .filter((option) => option.optionKey.startsWith('maneuver'))
        .map((option) => option.valueId),
    );
    return selected.size === 0
      ? maneuvers
      : maneuvers.filter((maneuver) => selected.has(maneuver.slug));
  }

  async useBattleMasterManeuver(
    userId: string,
    characterId: string,
    dto: UseBattleMasterManeuverDto,
  ): Promise<FighterTableActionResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    if (
      character.classSlug !== 'fighter' ||
      character.subclassSlug !== 'battle-master'
    ) {
      throw new BadRequestException('Battle Master maneuver is not available');
    }

    const available = await this.listBattleMasterManeuvers(userId, characterId);
    if (!available.some((maneuver) => maneuver.slug === dto.maneuverSlug)) {
      throw new BadRequestException(
        `Maneuver '${dto.maneuverSlug}' is not selected by this character`,
      );
    }

    const dieFaces = dto.useRelentless
      ? 8
      : superiorityDieFaces(character.level);
    if (dieFaces == null) {
      throw new BadRequestException('Superiority Die is not available');
    }
    const dieRoll = rollDie(dieFaces);
    const proficiencyBonus = await this.domain.getProficiencyBonus(
      character.level,
    );

    let state = await this.state.buildResponse(character);
    if (!dto.useRelentless) {
      state = (
        await this.state.useClassResource(
          character,
          'superiority-dice',
          1,
        )
      ).state;
    }

    try {
      const result = resolveBattleMasterTableRoll({
        maneuverSlug: dto.maneuverSlug,
        level: character.level,
        proficiencyBonus,
        strengthModifier: abilityModifier(character.abilityScores.forca),
        dexterityModifier: abilityModifier(character.abilityScores.destreza),
        charismaModifier: abilityModifier(character.abilityScores.carisma),
        dieRoll,
        useRelentless: dto.useRelentless,
      });
      return {
        state,
        actionName: result.maneuver.name,
        expression: result.expression,
        roll: result.roll,
        total: result.effectValue,
        saveDc: result.saveDc,
        resourceSpent: result.resourceSpent,
        note: result.note,
      };
    } catch (error) {
      throw new BadRequestException(
        error instanceof Error ? error.message : 'Cannot use maneuver',
      );
    }
  }

  async usePsiWarriorAction(
    userId: string,
    characterId: string,
    dto: UsePsiWarriorActionDto,
  ): Promise<FighterTableActionResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    if (
      character.classSlug !== 'fighter' ||
      character.subclassSlug !== 'psi-warrior'
    ) {
      throw new BadRequestException('Psi Warrior action is not available');
    }

    const dieFaces = psiEnergyDieFaces(character.level);
    const dieRoll =
      dto.actionSlug === 'protective-field' && dieFaces != null
        ? rollDie(dieFaces)
        : undefined;
    try {
      const result = resolvePsiWarriorTableAction({
        actionSlug: dto.actionSlug,
        level: character.level,
        intelligenceModifier: abilityModifier(
          character.abilityScores.inteligencia,
        ),
        dieRoll,
        usePsiDie: dto.usePsiDie,
      });
      if (!result.resourceSlug) {
        throw new Error(`${result.actionName} has no resource configured`);
      }
      const spent = await this.state.useClassResource(
        character,
        result.resourceSlug,
        1,
      );
      return {
        state: spent.state,
        actionName: result.actionName,
        expression: result.expression,
        roll: result.roll,
        total: result.total,
        saveDc: result.saveDc,
        resourceSpent: true,
        note: result.note,
      };
    } catch (error) {
      throw new BadRequestException(
        error instanceof Error ? error.message : 'Cannot use Psi Warrior action',
      );
    }
  }

  async useDungeonPrecaution(
    userId: string,
    characterId: string,
    dto: UseDungeonPrecautionDto,
  ): Promise<FighterTableActionResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    const spell = findDungeoneerPrecautionSpell(dto.spellSlug);
    if (
      character.classSlug !== 'fighter' ||
      character.subclassSlug !== 'dungeoneer' ||
      character.level < 7 ||
      !spell
    ) {
      throw new BadRequestException('Dungeon Precaution is not available');
    }
    const spent = await this.state.useClassResource(
      character,
      'dungeon-precautions',
      1,
    );
    return {
      state: spent.state,
      actionName: spell.name,
      resourceSpent: true,
      note: `Precauções na Masmorra: conjure ${spell.name} sem gastar espaço de magia; escolha INT, SAB ou CAR como atributo de conjuração.`,
    };
  }
}
