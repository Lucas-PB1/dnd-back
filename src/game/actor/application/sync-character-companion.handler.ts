import {
  BadRequestException,
  Injectable,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { CatalogLookupService } from '@catalog/game-port';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import {
  resolveCompanionConfig,
} from '@game/companion/domain/companion-profiles';
import { scaleCompanionCombatStats } from '@game/companion/domain/scale-companion-stats';
import {
  loadCompanionProfileBySubclass,
  loadCompanionTemplateMaps,
} from '@game/companion/infrastructure/companion-profile.queries';
import { loadCharacterSheet } from '@game/sheet/infrastructure/character-sheet/load-character-sheet';
import { loadScaleByLevel } from '../infrastructure/creature-scale.queries';
import { ActorMapper } from '../infrastructure/actor.mapper';
import { ActorPersistenceService } from '../infrastructure/actor-persistence.service';
import { GameActor } from '../infrastructure/game-actor.entity';
import {
  CharacterCompanionSyncResponseDto,
  SyncCharacterCompanionDto,
} from '../dto/character-companion.dto';

@Injectable()
export class SyncCharacterCompanionHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly persistence: ActorPersistenceService,
    private readonly mapper: ActorMapper,
    private readonly dataSource: DataSource,
    private readonly catalogLookup: CatalogLookupService,
    @InjectRepository(GameActor)
    private readonly actors: Repository<GameActor>,
  ) {}

  async execute(
    userId: string,
    characterId: string,
    dto: SyncCharacterCompanionDto = {},
  ): Promise<CharacterCompanionSyncResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    const profile = await loadCompanionProfileBySubclass(
      this.dataSource,
      character.subclassSlug,
    );
    if (!profile) {
      throw new BadRequestException(
        'Esta subclasse não possui companheiro vinculado à ficha',
      );
    }
    if (character.level < profile.minLevel) {
      throw new BadRequestException(
        `Companheiro disponível a partir do nível ${profile.minLevel}`,
      );
    }

    const sheet = await loadCharacterSheet(
      { dataSource: this.dataSource },
      characterId,
      character.backgroundSlug,
    );
    const maps = await loadCompanionTemplateMaps(
      this.dataSource,
      profile.profileId,
    );
    const config = resolveCompanionConfig(
      profile,
      maps,
      sheet.subclassOptions,
    );
    if (!config) {
      throw new BadRequestException(
        'Complete as escolhas do companheiro na ficha antes de invocar',
      );
    }

    const template = await this.catalogLookup.findCreatureTemplateOrFail(
      config.templateSlug,
    );
    const scale = await loadScaleByLevel(this.dataSource, config.templateSlug);
    if (!scale) {
      throw new BadRequestException(
        `Template '${config.templateSlug}' sem phb_creature_scale_by_level`,
      );
    }

    const existing = await this.actors.find({
      where: {
        parentCharacterId: characterId,
        actorKind: 'companion',
      },
      order: { createdAt: 'ASC' },
    });

    const sameTemplate = existing.find(
      (actor) => actor.templateSlug === config.templateSlug,
    );
    if (sameTemplate) {
      await this.applyScaledStats(
        sameTemplate,
        template.armorClass,
        scale,
        character,
        dto.restoreHp,
      );
      return {
        ...(await this.mapper.toDto(sameTemplate)),
        reused: true,
        templateSlug: config.templateSlug,
        variantLabel: config.variantLabel,
        profileId: config.profile.profileId,
      };
    }

    for (const actor of existing) {
      await this.actors.remove(actor);
    }

    const actorId = await this.persistence.spawnFromTemplate({
      templateSlug: config.templateSlug,
      ownerUserId: userId,
      actorKind: 'companion',
      parentCharacterId: characterId,
    });
    const actor = await this.actors.findOneOrFail({ where: { id: actorId } });
    await this.applyScaledStats(
      actor,
      template.armorClass,
      scale,
      character,
      dto.restoreHp ?? true,
    );

    return {
      ...(await this.mapper.toDto(actor)),
      reused: false,
      templateSlug: config.templateSlug,
      variantLabel: config.variantLabel,
      profileId: config.profile.profileId,
    };
  }

  private async applyScaledStats(
    actor: GameActor,
    templateArmorClass: number | null,
    scale: {
      hpBase: number;
      hpPerLevel: number;
      acAbilitySlug: string | null;
    },
    character: { level: number; abilityScores: GameActor['abilityScores'] },
    restoreHp?: boolean,
  ): Promise<void> {
    const scaled = scaleCompanionCombatStats(
      {
        armorClass: templateArmorClass,
        hpBase: scale.hpBase,
        hpPerLevel: scale.hpPerLevel,
        acAbilitySlug: scale.acAbilitySlug,
      },
      character.level,
      character.abilityScores,
    );
    let dirty = false;
    if (scaled.hitPointsMax != null) {
      const prevMax = actor.hitPointsMax;
      actor.hitPointsMax = scaled.hitPointsMax;
      if (restoreHp || actor.hitPointsCurrent == null) {
        actor.hitPointsCurrent = scaled.hitPointsMax;
      } else if (prevMax != null && actor.hitPointsCurrent > scaled.hitPointsMax) {
        actor.hitPointsCurrent = scaled.hitPointsMax;
      }
      dirty = true;
    } else if (restoreHp && actor.hitPointsMax != null) {
      actor.hitPointsCurrent = actor.hitPointsMax;
      dirty = true;
    }
    if (scaled.armorClass != null) {
      actor.armorClass = scaled.armorClass;
      dirty = true;
    }
    if (dirty) {
      await this.actors.save(actor);
    }
  }
}
