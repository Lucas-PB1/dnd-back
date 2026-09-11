import {
  BadRequestException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { PhbCreatureTemplate } from '@entities/template/phb-creature-template.entity';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import {
  resolveCompanionConfig,
} from '@game/companion/domain/companion-profiles';
import {
  loadCompanionProfileBySubclass,
  loadCompanionTemplateMaps,
} from '@game/companion/infrastructure/companion-profile.queries';
import { loadCharacterSheet } from '@game/sheet/infrastructure/character-sheet/load-character-sheet';
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
    @InjectRepository(GameActor)
    private readonly actors: Repository<GameActor>,
    @InjectRepository(PhbCreatureTemplate)
    private readonly creatureTemplates: Repository<PhbCreatureTemplate>,
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

    const template = await this.creatureTemplates.findOne({
      where: { slug: config.templateSlug },
    });
    if (!template) {
      throw new NotFoundException(
        `Template de companheiro '${config.templateSlug}' não encontrado`,
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
      if (dto.restoreHp && sameTemplate.hitPointsMax != null) {
        sameTemplate.hitPointsCurrent = sameTemplate.hitPointsMax;
        await this.actors.save(sameTemplate);
      }
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
    if (dto.restoreHp && actor.hitPointsMax != null) {
      actor.hitPointsCurrent = actor.hitPointsMax;
      await this.actors.save(actor);
    }

    return {
      ...(await this.mapper.toDto(actor)),
      reused: false,
      templateSlug: config.templateSlug,
      variantLabel: config.variantLabel,
      profileId: config.profile.profileId,
    };
  }
}
