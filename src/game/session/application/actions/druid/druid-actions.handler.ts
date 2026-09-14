import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectDataSource } from '@nestjs/typeorm';
import { DataSource } from 'typeorm';
import { SyncWildShapeActorHandler } from '@game/actor/application/sync-wild-shape-actor.handler';
import { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import { isDruidClass, maxWildShapeKnownForms } from '@game/combat/domain/druid';
import { LoadEffectCatalog } from '@game/effects';
import { SyncSpellSpiritHandler } from '@game/spirit/application/sync-spell-spirit.handler';
import { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import {
  TableActionResponseDto,
} from '@game/session/dto/fighter/fighter-session.dto';
import {
  UseDruidTableActionDto,
} from '@game/session/dto/table-actions/table-actions-caster.dto';
import type { WildShapeEligibleBeastDto } from '@game/session/dto/druid/wild-shape-eligible.dto';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { listEligibleWildShapeBeasts } from '@game/session/infrastructure/wild-shape/wild-shape.queries';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { applyDeclaredEconomyTableAction } from '../../table-actions/apply-declared-economy';

@Injectable()
export class DruidActionsHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
    private readonly domain: CharacterDomainService,
    private readonly mechanicalCatalog: LoadCombatMechanicalCatalog,
    private readonly effectCatalog: LoadEffectCatalog,
    private readonly syncWildShapeActor: SyncWildShapeActorHandler,
    private readonly syncSpellSpirit: SyncSpellSpiritHandler,
    @InjectDataSource()
    private readonly dataSource: DataSource,
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

    return applyDeclaredEconomyTableAction(
      {
        state: this.state,
        mechanicalCatalog: this.mechanicalCatalog,
        effectCatalog: this.effectCatalog,
        dataSource: this.dataSource,
        getProficiencyBonus: (level) => this.domain.getProficiencyBonus(level),
        syncWildShapeActor: this.syncWildShapeActor,
        syncSpellSpirit: this.syncSpellSpirit,
      },
      character,
      dto.actionSlug,
      {
        userId,
        slotLevel: dto.slotLevel,
        templateSlug: dto.templateSlug,
        templateSlugs: dto.templateSlugs,
        replaceSlug: dto.replaceSlug,
        spiritVariantKey: dto.spiritVariantKey,
      },
    ) as Promise<TableActionResponseDto>;
  }

  async listEligibleWildShapeBeasts(
    userId: string,
    characterId: string,
  ): Promise<{
    maxKnownForms: number;
    knownSlugs: string[];
    formSwapAvailable: boolean;
    beasts: WildShapeEligibleBeastDto[];
  }> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'read',
    );
    if (!isDruidClass(character.classSlug)) {
      throw new BadRequestException('Druid action is not available');
    }
    const moon = character.subclassSlug === 'moon';
    const [beasts, state] = await Promise.all([
      listEligibleWildShapeBeasts(this.dataSource, {
        level: character.level,
        moon,
      }),
      this.state.buildResponse(character),
    ]);
    return {
      maxKnownForms: maxWildShapeKnownForms(character.level),
      knownSlugs: state.wildShapeKnownSlugs ?? [],
      formSwapAvailable: state.wildShapeFormSwapAvailable ?? true,
      beasts: beasts.map((b) => ({
        slug: b.slug,
        name: b.name,
        challengeRating: b.challengeRating,
        armorClass: b.armorClass,
        hasFlySpeed: b.hasFlySpeed,
        known: (state.wildShapeKnownSlugs ?? []).includes(b.slug),
      })),
    };
  }
}
