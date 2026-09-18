import type { CampaignRepository } from '../infrastructure/campaign.repository';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import type { ActorStateRepository } from '@game/actor/infrastructure/actor-state.repository';
import type { Repository } from 'typeorm';
import type { GameActor } from '@game/actor/infrastructure/game-actor.entity';
import type { CampaignEncounterCombatant } from '../infrastructure/campaign-encounter-combatant.entity';
import { applyCombatantHpDamage } from '@game/combat/application/apply-combatant-hp-damage';

export async function applyEncounterAttackDamage(input: {
  campaigns: CampaignRepository;
  characterState: CharacterStateRepository;
  actorState: ActorStateRepository;
  actors: Repository<GameActor>;
  target: CampaignEncounterCombatant;
  damage: number;
  damageTypeSlug?: string | null;
  dataSource?: import('typeorm').DataSource;
}): Promise<void> {
  await applyCombatantHpDamage({
    loadCharacter: async (characterId) => {
      const [character] = await input.campaigns.findCharactersByIds([
        characterId,
      ]);
      return character ?? null;
    },
    characterState: input.characterState,
    actorState: input.actorState,
    actors: input.actors,
    target: input.target,
    damage: input.damage,
    damageTypeSlug: input.damageTypeSlug,
    dataSource: input.dataSource,
  });
}
