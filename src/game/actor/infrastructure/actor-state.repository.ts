import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { GameActor } from './game-actor.entity';
import { GameActorState } from './game-actor-state.entity';
import { PhbCondition } from '@game/session/infrastructure/phb-condition.entity';
import { assertValidConditions } from '@game/session/infrastructure/character-state/core/conditions';
import type { PatchActorStateDto } from '../dto/actor-state.dto';
import type { ActorStateResponseDto } from '../dto/actor-state.dto';
import { computeAbilityModifiers } from '@game/shared/domain/ability-scores';
import { clampHitPointsCurrent } from '@game/shared/domain/combat-vitals';

@Injectable()
export class ActorStateRepository {
  constructor(
    @InjectRepository(GameActorState)
    private readonly stateRepo: Repository<GameActorState>,
    @InjectRepository(PhbCondition)
    private readonly conditions: Repository<PhbCondition>,
    private readonly catalogLookup: CatalogLookupService,
  ) {}

  async ensureState(actorId: string): Promise<GameActorState> {
    let state = await this.stateRepo.findOne({ where: { actorId } });
    if (!state) {
      state = this.stateRepo.create({ actorId });
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
    };
  }

  async patch(
    actor: GameActor,
    dto: PatchActorStateDto,
    actorRepo: Repository<GameActor>,
  ): Promise<ActorStateResponseDto> {
    const state = await this.ensureState(actor.id);

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

    return this.buildResponse(actor, state);
  }
}
