import { BadRequestException, Injectable } from '@nestjs/common';
import {
  isFighterClass,
  listBattleMasterManeuvers,
} from '@game/combat/domain/fighter';
import { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import { LoadEffectCatalog } from '@game/effects';
import { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import type {
  UseFighterTableActionDto,
} from '@game/session/dto/table-actions/table-actions-martial.dto';
import type { TableActionResponseDto } from '@game/session/dto/fighter/fighter-session.dto';
import { applyDeclaredEconomyTableAction } from '../../table-actions/apply-declared-economy';

@Injectable()
export class FighterActionsHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
    private readonly domain: CharacterDomainService,
    private readonly sheet: CharacterSheetRepository,
    private readonly mechanicalCatalog: LoadCombatMechanicalCatalog,
    private readonly effectCatalog: LoadEffectCatalog,
  ) {}

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
    const catalog = await this.mechanicalCatalog.load();
    const maneuvers = listBattleMasterManeuvers(catalog.battleMasterManeuvers);
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

  async useTableAction(
    userId: string,
    characterId: string,
    dto: UseFighterTableActionDto,
  ): Promise<TableActionResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    if (!isFighterClass(character.classSlug)) {
      throw new BadRequestException('Fighter action is not available');
    }

    return applyDeclaredEconomyTableAction(
      {
        state: this.state,
        mechanicalCatalog: this.mechanicalCatalog,
        effectCatalog: this.effectCatalog,
        sheet: this.sheet,
        getProficiencyBonus: (level) => this.domain.getProficiencyBonus(level),
      },
      character,
      dto.actionSlug,
      {
        userId,
        checkTotal: dto.checkTotal,
        dc: dto.dc,
        usePsiDie: dto.usePsiDie,
        maneuverSlug: dto.maneuverSlug,
        useRelentless: dto.useRelentless,
        spellSlug: dto.spellSlug,
        optionSlug: dto.optionSlug,
        takeLowerBloodCost: dto.takeLowerBloodCost,
      },
    ) as Promise<TableActionResponseDto>;
  }
}
