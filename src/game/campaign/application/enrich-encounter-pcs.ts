import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, In, Repository } from 'typeorm';
import { ResolveEquippedArmorClass } from '@game/combat/application/resolve-equipped-armor-class';
import { PlayerCharacterState } from '@game/session/infrastructure/player-character-state.entity';
import { loadFeatSlugsByCharacterIds } from '@game/sheet/infrastructure/load-feat-slugs-by-character-ids';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { PcCombatantEnrichment } from '../domain/build-encounter-dto';

@Injectable()
export class EnrichEncounterPcs {
  constructor(
    private readonly dataSource: DataSource,
    private readonly armorClass: ResolveEquippedArmorClass,
    @InjectRepository(PlayerCharacterState)
    private readonly states: Repository<PlayerCharacterState>,
  ) {}

  async enrich(
    characters: PlayerCharacter[],
  ): Promise<Map<string, PcCombatantEnrichment>> {
    const result = new Map<string, PcCombatantEnrichment>();
    if (characters.length === 0) return result;

    const ids = characters.map((row) => row.id);
    const featsById = await loadFeatSlugsByCharacterIds(this.dataSource, ids);
    const states = await this.states.find({
      where: { characterId: In(ids) },
    });
    const stateById = new Map(states.map((row) => [row.characterId, row]));

    for (const character of characters) {
      const featSlugs = featsById.get(character.id) ?? [];
      const { armorClass } = await this.armorClass.resolve(
        character.id,
        character.abilityScores,
        {
          classSlug: character.classSlug,
          subclassSlug: character.subclassSlug,
          featSlugs,
        },
      );
      const state = stateById.get(character.id);
      result.set(character.id, {
        level: character.level,
        armorClass,
        hpCurrent: character.hitPointsCurrent,
        hpMax: character.hitPointsMax,
        featSlugs,
        conditions: state?.conditions ?? [],
        inspiration: state?.inspiration ?? false,
      });
    }
    return result;
  }
}
