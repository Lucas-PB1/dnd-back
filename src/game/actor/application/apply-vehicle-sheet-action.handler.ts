import {
  BadRequestException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { PlayerCharacterState } from '@game/session/infrastructure/player-character-state.entity';
import { GameActor } from '../infrastructure/game-actor.entity';
import { ActorStateRepository } from '../infrastructure/actor-state.repository';
import { BoardCharacterVehicleHandler } from './character-vehicle.handlers';
import { formatVehicleMetricsNote } from '../domain/vehicle-sheet';
import {
  VehicleSheetActionDto,
  VehicleSheetActionResponseDto,
} from '../dto/character-vehicle.dto';

@Injectable()
export class ApplyVehicleSheetActionHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly board: BoardCharacterVehicleHandler,
    private readonly actorState: ActorStateRepository,
    @InjectRepository(GameActor)
    private readonly actors: Repository<GameActor>,
    @InjectRepository(PlayerCharacterState)
    private readonly pcStates: Repository<PlayerCharacterState>,
  ) {}

  async execute(
    userId: string,
    characterId: string,
    dto: VehicleSheetActionDto,
  ): Promise<VehicleSheetActionResponseDto> {
    await this.access.findAccessibleOrFail(userId, characterId, 'write');

    if (dto.action === 'board') {
      if (!dto.actorId) {
        throw new BadRequestException('Embarcar exige actorId');
      }
      const boarded = await this.board.execute(userId, characterId, {
        actorId: dto.actorId,
      });
      return {
        boardedActorId: boarded.boardedActorId,
        actionName: 'Embarcar',
        note: 'Embarcado no veículo.',
        resourceSpent: false,
      };
    }

    if (dto.action === 'dismount') {
      await this.board.execute(userId, characterId, { actorId: null });
      return {
        boardedActorId: null,
        actionName: 'Desembarcar',
        note: 'Desembarcou.',
        resourceSpent: false,
      };
    }

    const actor = await this.resolveVehicleActor(characterId, dto.actorId);
    const pcState = await this.pcStates.findOne({ where: { characterId } });
    const boardedActorId = pcState?.boardedActorId ?? null;

    if (dto.action === 'helm') {
      if (boardedActorId !== actor.id) {
        throw new BadRequestException(
          'Leme exige estar embarcado neste veículo',
        );
      }
      return {
        boardedActorId,
        actionName: 'Leme',
        note: 'No leme: você controla o veículo neste turno (declare o rumo na mesa). Combate/colisão fica fora.',
        resourceSpent: false,
      };
    }

    if (
      dto.crewCurrent == null &&
      dto.passengerCurrent == null &&
      dto.cargoCurrentLb == null
    ) {
      throw new BadRequestException(
        'set-metrics exige crewCurrent, passengerCurrent ou cargoCurrentLb',
      );
    }

    const actorState = await this.actorState.patch(
      actor,
      {
        crewCurrent: dto.crewCurrent,
        passengerCurrent: dto.passengerCurrent,
        cargoCurrentLb: dto.cargoCurrentLb,
      },
      this.actors,
    );
    return {
      boardedActorId,
      actionName: 'Métricas',
      note: formatVehicleMetricsNote({
        crewCurrent: actorState.crewCurrent,
        crewCapacity: actorState.crewCapacity,
        passengerCurrent: actorState.passengerCurrent,
        passengerCapacity: actorState.passengerCapacity,
        cargoCurrentLb: actorState.cargoCurrentLb,
        cargoCapacityLb: actorState.cargoCapacityLb,
      }),
      resourceSpent: false,
      actorState,
    };
  }

  private async resolveVehicleActor(
    characterId: string,
    actorId: string | null | undefined,
  ): Promise<GameActor> {
    const pcState = await this.pcStates.findOne({ where: { characterId } });
    const id = actorId ?? pcState?.boardedActorId ?? null;
    if (!id) {
      throw new BadRequestException(
        'Informe actorId ou embarque num veículo antes',
      );
    }
    const actor = await this.actors.findOne({ where: { id } });
    if (!actor) {
      throw new NotFoundException(`Actor '${id}' not found`);
    }
    if (actor.parentCharacterId !== characterId) {
      throw new BadRequestException('Actor is not linked to this character');
    }
    if (actor.actorKind !== 'vehicle') {
      throw new BadRequestException(
        'Only vehicle actors accept vehicle sheet actions',
      );
    }
    return actor;
  }
}
