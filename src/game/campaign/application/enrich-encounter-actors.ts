import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { In, Repository } from 'typeorm';
import { GameActor } from '@game/actor/infrastructure/game-actor.entity';
import { GameActorState } from '@game/actor/infrastructure/game-actor-state.entity';

export type ActorCombatantEnrichment = {
  name: string;
  armorClass: number | null;
  hpCurrent: number | null;
  hpMax: number | null;
  conditions: string[];
};

@Injectable()
export class EnrichEncounterActors {
  constructor(
    @InjectRepository(GameActor)
    private readonly actors: Repository<GameActor>,
    @InjectRepository(GameActorState)
    private readonly states: Repository<GameActorState>,
  ) {}

  async enrich(actorIds: string[]): Promise<Map<string, ActorCombatantEnrichment>> {
    const map = new Map<string, ActorCombatantEnrichment>();
    if (actorIds.length === 0) return map;

    const rows = await this.actors.find({ where: { id: In(actorIds) } });
    const stateRows = await this.states.find({
      where: { actorId: In(actorIds) },
    });
    const stateByActor = new Map(stateRows.map((s) => [s.actorId, s]));

    for (const actor of rows) {
      const state = stateByActor.get(actor.id);
      map.set(actor.id, {
        name: actor.name,
        armorClass: actor.armorClass,
        hpCurrent: actor.hitPointsCurrent,
        hpMax: actor.hitPointsMax,
        conditions: state?.conditions ?? [],
      });
    }
    return map;
  }
}
