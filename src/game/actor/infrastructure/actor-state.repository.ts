import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { GameActor } from './game-actor.entity';
import { GameActorState } from './game-actor-state.entity';
import { PhbCondition } from '@game/session/infrastructure/phb-condition.entity';
import { PlayerCharacterState } from '@game/session/infrastructure/player-character-state.entity';
import { assertValidConditions } from '@game/session/infrastructure/character-state/core/conditions';
import type { PatchActorStateDto } from '../dto/actor-state.dto';
import type { ActorStateResponseDto } from '../dto/actor-state.dto';
import { computeAbilityModifiers } from '@game/shared/domain/ability-scores';
import { clampHitPointsCurrent } from '@game/shared/domain/combat-vitals';
import { clearBoardedIfActor } from '../application/clear-boarded-actor';
import { isPhantomSteedTemplate } from '../domain/mount-sheet';
import { clampVehicleMetric } from '../domain/vehicle-sheet';

@Injectable()
export class ActorStateRepository {
  constructor(
    @InjectRepository(GameActorState)
    private readonly stateRepo: Repository<GameActorState>,
    @InjectRepository(PhbCondition)
    private readonly conditions: Repository<PhbCondition>,
    @InjectRepository(PlayerCharacterState)
    private readonly pcStates: Repository<PlayerCharacterState>,
    private readonly catalogLookup: CatalogLookupService,
  ) {}

  async ensureState(actorId: string): Promise<GameActorState> {
    let state = await this.stateRepo.findOne({ where: { actorId } });
    if (!state) {
      state = this.stateRepo.create({
        actorId,
        crewCurrent: 0,
        passengerCurrent: 0,
        cargoCurrentLb: 0,
      });
      state = await this.stateRepo.save(state);
    }
    return state;
  }

  buildResponse(actor: GameActor, state: GameActorState): ActorStateResponseDto {
    return {
      actorId: actor.id,
      hitPointsCurrent: actor.hitPointsCurrent,
      hitPointsMax: actor.hitPointsMax,
      armorClass: actor.armorClass,
      abilityModifiers: computeAbilityModifiers(actor.abilityScores),
      conditions: state.conditions,
      tempHp: state.tempHp,
      concentratingOn: state.concentratingOn,
      innateSpellUses: state.innateSpellUses ?? {},
      damageThreshold: actor.damageThreshold ?? null,
      crewCapacity: actor.crewCapacity ?? null,
      passengerCapacity: actor.passengerCapacity ?? null,
      cargoCapacityLb: actor.cargoCapacityLb ?? null,
      crewCurrent: state.crewCurrent ?? 0,
      passengerCurrent: state.passengerCurrent ?? 0,
      cargoCurrentLb: state.cargoCurrentLb ?? 0,
    };
  }

  async patch(
    actor: GameActor,
    dto: PatchActorStateDto,
    actorRepo: Repository<GameActor>,
  ): Promise<ActorStateResponseDto> {
    const state = await this.ensureState(actor.id);
    const previousHp = actor.hitPointsCurrent;

    if (dto.conditions !== undefined) {
      await assertValidConditions(this.conditions, dto.conditions);
      state.conditions = dto.conditions;
    }
    if (dto.tempHp !== undefined) {
      state.tempHp = dto.tempHp;
    }
    if (dto.concentratingOn !== undefined) {
      if (dto.concentratingOn !== null) {
        const spell = await this.catalogLookup.assertSpellInCatalog(
          dto.concentratingOn,
        );
        if (!spell.concentration) {
          throw new BadRequestException(
            `Spell '${dto.concentratingOn}' is not a concentration spell`,
          );
        }
      }
      state.concentratingOn = dto.concentratingOn;
    }
    if (dto.innateSpellUses !== undefined) {
      state.innateSpellUses = dto.innateSpellUses;
    }
    if (dto.crewCurrent !== undefined) {
      state.crewCurrent = clampVehicleMetric(
        dto.crewCurrent,
        actor.crewCapacity,
      );
    }
    if (dto.passengerCurrent !== undefined) {
      state.passengerCurrent = clampVehicleMetric(
        dto.passengerCurrent,
        actor.passengerCapacity,
      );
    }
    if (dto.cargoCurrentLb !== undefined) {
      state.cargoCurrentLb = clampVehicleMetric(
        dto.cargoCurrentLb,
        actor.cargoCapacityLb,
      );
    }
    if (dto.hitPointsCurrent !== undefined) {
      actor.hitPointsCurrent = dto.hitPointsCurrent;
    }
    if (dto.hitPointsMax !== undefined) {
      actor.hitPointsMax = dto.hitPointsMax;
    }
    if (dto.armorClass !== undefined) {
      actor.armorClass = dto.armorClass;
    }
    actor.hitPointsCurrent = clampHitPointsCurrent(
      actor.hitPointsCurrent,
      actor.hitPointsMax,
    ) as number | null;

    await this.stateRepo.save(state);
    if (
      dto.hitPointsCurrent !== undefined ||
      dto.hitPointsMax !== undefined ||
      dto.armorClass !== undefined
    ) {
      await actorRepo.save(actor);
    }

    const damaged =
      dto.hitPointsCurrent !== undefined &&
      previousHp != null &&
      actor.hitPointsCurrent != null &&
      actor.hitPointsCurrent < previousHp;

    if (isPhantomSteedTemplate(actor.templateSlug) && damaged) {
      await clearBoardedIfActor(
        this.pcStates,
        actor.parentCharacterId,
        actor.id,
      );
      await actorRepo.remove(actor);
      return this.buildResponse(actor, state);
    }

    if (actor.hitPointsCurrent === 0) {
      await clearBoardedIfActor(
        this.pcStates,
        actor.parentCharacterId,
        actor.id,
      );
    }

    return this.buildResponse(actor, state);
  }
}
