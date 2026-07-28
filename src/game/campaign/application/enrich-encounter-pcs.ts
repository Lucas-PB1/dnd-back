import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { In, Repository } from 'typeorm';
import { ResolveEquippedArmorClass } from '../../combat/application/resolve-equipped-armor-class';
import { PlayerCharacterState } from '../../session/infrastructure/player-character-state.entity';
import { CharacterSheetRepository } from '../../sheet/infrastructure/character-sheet.repository';
import type { PlayerCharacter } from '../../shared/infrastructure/player-character.entity';
import type { PcCombatantEnrichment } from '../domain/build-encounter-dto';

@Injectable()
export class EnrichEncounterPcs {
  constructor(
    private readonly sheets: CharacterSheetRepository,
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
    const backgroundById = new Map(
      characters.map((row) => [row.id, row.backgroundSlug]),
    );
    const sheets = await this.sheets.loadMany(ids, backgroundById);
    const states = await this.states.find({
      where: { characterId: In(ids) },
    });
    const stateById = new Map(states.map((row) => [row.characterId, row]));

    for (const character of characters) {
      const sheet = sheets.get(character.id);
      const featSlugs = (sheet?.characterFeats ?? []).map(
        (feat) => feat.featSlug,
      );
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
