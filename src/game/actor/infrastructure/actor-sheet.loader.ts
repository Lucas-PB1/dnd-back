import { Injectable } from '@nestjs/common';
import { InjectDataSource } from '@nestjs/typeorm';
import { DataSource } from 'typeorm';
import {
  ActorSheetData,
  EMPTY_ACTOR_SHEET,
} from '../domain/actor-sheet.types';

@Injectable()
export class ActorSheetLoader {
  constructor(
    @InjectDataSource()
    private readonly dataSource: DataSource,
  ) {}

  async load(actorId: string): Promise<ActorSheetData> {
    const rows = await this.dataSource.query<
      { get_game_actor_bundle: ActorSheetData | null }[]
    >('SELECT rpg.get_game_actor_bundle($1) AS get_game_actor_bundle', [
      actorId,
    ]);
    const bundle = rows[0]?.get_game_actor_bundle;
    if (!bundle || typeof bundle !== 'object') {
      return EMPTY_ACTOR_SHEET;
    }
    return {
      speeds: bundle.speeds ?? [],
      actions: bundle.actions ?? [],
      spells: bundle.spells ?? [],
      state: bundle.state ?? null,
    };
  }
}
