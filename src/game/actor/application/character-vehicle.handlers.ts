import {
  BadRequestException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { In, Repository } from 'typeorm';
import { PhbCreatureTemplate } from '@entities/phb-creature-template.entity';
import { PhbItem } from '@entities/phb-item.entity';
import { PhbVehicleTemplate } from '@entities/phb-vehicle-template.entity';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import {
  isBoardableTransportItemKind,
  itemPropertiesKind,
} from '@game/inventory/domain/item-kind';
import { PlayerCharacterItem } from '@game/inventory/infrastructure/player-character-item.entity';
import { PlayerCharacterState } from '@game/session/infrastructure/player-character-state.entity';
import { ActorMapper } from '../infrastructure/actor.mapper';
import { ActorPersistenceService } from '../infrastructure/actor-persistence.service';
import { GameActor } from '../infrastructure/game-actor.entity';
import {
  BoardCharacterVehicleDto,
  CharacterVehicleBoardResponseDto,
  CharacterVehicleLinkResponseDto,
  LinkCharacterVehicleDto,
} from '../dto/character-vehicle.dto';

type LinkableActorKind = 'vehicle' | 'mount';

@Injectable()
export class LinkCharacterVehicleHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly persistence: ActorPersistenceService,
    private readonly mapper: ActorMapper,
    @InjectRepository(GameActor)
    private readonly actors: Repository<GameActor>,
    @InjectRepository(PlayerCharacterItem)
    private readonly inventoryItems: Repository<PlayerCharacterItem>,
    @InjectRepository(PhbItem)
    private readonly catalogItems: Repository<PhbItem>,
    @InjectRepository(PhbVehicleTemplate)
    private readonly vehicleTemplates: Repository<PhbVehicleTemplate>,
    @InjectRepository(PhbCreatureTemplate)
    private readonly creatureTemplates: Repository<PhbCreatureTemplate>,
  ) {}

  async execute(
    userId: string,
    characterId: string,
    dto: LinkCharacterVehicleDto,
  ): Promise<CharacterVehicleLinkResponseDto> {
    await this.access.findAccessibleOrFail(userId, characterId, 'write');

    const templateSlug = await this.resolveTemplateSlug(characterId, dto);
    const actorKind = await this.resolveActorKind(templateSlug);

    const existing = await this.actors.findOne({
      where: {
        parentCharacterId: characterId,
        actorKind: In(['vehicle', 'mount']),
        templateSlug,
      },
      order: { createdAt: 'ASC' },
    });
    if (existing) {
      return { ...(await this.mapper.toDto(existing)), reused: true };
    }

    const actorId = await this.persistence.spawnFromTemplate({
      templateSlug,
      ownerUserId: userId,
      actorKind,
      parentCharacterId: characterId,
    });
    const actor = await this.actors.findOneOrFail({ where: { id: actorId } });
    return { ...(await this.mapper.toDto(actor)), reused: false };
  }

  private async resolveActorKind(
    templateSlug: string,
  ): Promise<LinkableActorKind> {
    const vehicle = await this.vehicleTemplates.findOne({
      where: { slug: templateSlug },
    });
    if (vehicle) return 'vehicle';

    const creature = await this.creatureTemplates.findOne({
      where: { slug: templateSlug },
    });
    if (creature) return 'mount';

    throw new NotFoundException(
      `Transport template '${templateSlug}' not found`,
    );
  }

  private async resolveTemplateSlug(
    characterId: string,
    dto: LinkCharacterVehicleDto,
  ): Promise<string> {
    const fromDto = dto.templateSlug?.trim() || dto.itemSlug?.trim();
    if (!fromDto) {
      throw new BadRequestException('itemSlug or templateSlug is required');
    }

    if (dto.itemSlug?.trim()) {
      const itemSlug = dto.itemSlug.trim();
      const owned = await this.inventoryItems.findOne({
        where: { characterId, itemSlug },
      });
      if (!owned) {
        throw new BadRequestException(
          `Item '${itemSlug}' not in character inventory`,
        );
      }
      const catalog = await this.catalogItems.findOne({
        where: { slug: itemSlug },
      });
      const kind = itemPropertiesKind(
        (catalog?.properties as Record<string, unknown> | null) ?? null,
      );
      if (!isBoardableTransportItemKind(kind)) {
        throw new BadRequestException(
          `Item '${itemSlug}' is not a boardable transport`,
        );
      }
      return itemSlug;
    }

    return fromDto;
  }
}

@Injectable()
export class BoardCharacterVehicleHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    @InjectRepository(GameActor)
    private readonly actors: Repository<GameActor>,
    @InjectRepository(PlayerCharacterState)
    private readonly states: Repository<PlayerCharacterState>,
  ) {}

  async execute(
    userId: string,
    characterId: string,
    dto: BoardCharacterVehicleDto,
  ): Promise<CharacterVehicleBoardResponseDto> {
    await this.access.findAccessibleOrFail(userId, characterId, 'write');

    let state = await this.states.findOne({ where: { characterId } });
    if (!state) {
      state = this.states.create({ characterId });
    }

    const actorId = dto.actorId ?? null;
    if (!actorId) {
      state.boardedActorId = null;
      await this.states.save(state);
      return { boardedActorId: null };
    }

    const actor = await this.actors.findOne({ where: { id: actorId } });
    if (!actor) {
      throw new NotFoundException(`Actor '${actorId}' not found`);
    }
    if (actor.parentCharacterId !== characterId) {
      throw new BadRequestException(
        'Actor is not linked to this character',
      );
    }
    if (actor.actorKind !== 'vehicle' && actor.actorKind !== 'mount') {
      throw new BadRequestException(
        'Only vehicle or mount actors can be boarded',
      );
    }

    state.boardedActorId = actorId;
    await this.states.save(state);
    return { boardedActorId: actorId };
  }
}
