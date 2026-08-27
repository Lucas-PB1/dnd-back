import {
  BadRequestException,
  Injectable,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { DEFAULT_ABILITY_SCORES } from '@game/shared/domain/ability-scores';
import { GameActor } from './game-actor.entity';
import { GameActorSpeed } from './game-actor-speed.entity';
import { GameActorAction } from './game-actor-action.entity';
import { GameActorSpell } from './game-actor-spell.entity';
import { GameActorState } from './game-actor-state.entity';
import type { CreateActorDto } from '../dto/actor.dto';

@Injectable()
export class ActorPersistenceService {
  constructor(
    @InjectRepository(GameActorSpeed)
    private readonly speeds: Repository<GameActorSpeed>,
    @InjectRepository(GameActorAction)
    private readonly actions: Repository<GameActorAction>,
    @InjectRepository(GameActorSpell)
    private readonly spells: Repository<GameActorSpell>,
    @InjectRepository(GameActorState)
    private readonly states: Repository<GameActorState>,
    private readonly dataSource: DataSource,
  ) {}

  async createWithChildren(
    actor: GameActor,
    dto: CreateActorDto,
  ): Promise<GameActor> {
    if (actor.actorKind === 'companion' && !actor.parentCharacterId) {
      throw new BadRequestException(
        'Companion actors require parentCharacterId',
      );
    }

    actor.abilityScores = actor.abilityScores ?? DEFAULT_ABILITY_SCORES;
    if (actor.hitPointsCurrent == null && actor.hitPointsMax != null) {
      actor.hitPointsCurrent = actor.hitPointsMax;
    }

    return this.dataSource.transaction(async (manager) => {
      const saved = await manager.save(GameActor, actor);
      await manager.save(
        GameActorState,
        manager.create(GameActorState, { actorId: saved.id }),
      );

      if (dto.speeds?.length) {
        await manager.save(
          GameActorSpeed,
          dto.speeds.map((speed) =>
            manager.create(GameActorSpeed, {
              actorId: saved.id,
              movementKind: speed.movementKind,
              speedFt: speed.speedFt,
            }),
          ),
        );
      }

      if (dto.actions?.length) {
        await manager.save(
          GameActorAction,
          dto.actions.map((action, index) =>
            manager.create(GameActorAction, {
              actorId: saved.id,
              name: action.name,
              actionBucket: action.actionBucket ?? 'action',
              attackBonus: action.attackBonus ?? null,
              damageExpression: action.damageExpression ?? null,
              reachFt: action.reachFt ?? null,
              sortOrder: action.sortOrder ?? index,
            }),
          ),
        );
      }

      if (dto.spells?.length) {
        await manager.save(
          GameActorSpell,
          dto.spells.map((spell, index) =>
            manager.create(GameActorSpell, {
              actorId: saved.id,
              spellSlug: spell.spellSlug,
              usageKind: spell.usageKind,
              usesPerDay: spell.usesPerDay ?? null,
              slotLevel: spell.slotLevel ?? null,
              rechargeDice: spell.rechargeDice ?? null,
              sortOrder: spell.sortOrder ?? index,
            }),
          ),
        );
      }

      return saved;
    });
  }

  async spawnFromTemplate(input: {
    templateSlug: string;
    ownerUserId: string;
    actorKind: GameActor['actorKind'];
    campaignId?: string | null;
    parentCharacterId?: string | null;
    nameOverride?: string | null;
  }): Promise<string> {
    const rows = await this.dataSource.query<{ spawn_game_actor_from_template: string }[]>(
      `SELECT rpg.spawn_game_actor_from_template($1, $2, $3::rpg.actor_kind, $4, $5, $6) AS spawn_game_actor_from_template`,
      [
        input.templateSlug,
        input.ownerUserId,
        input.actorKind,
        input.campaignId ?? null,
        input.parentCharacterId ?? null,
        input.nameOverride ?? null,
      ],
    );
    return rows[0].spawn_game_actor_from_template;
  }
}
