import { Entity, Column, PrimaryColumn } from 'typeorm';

@Entity({ schema: 'rpg', name: 'player_character_skill' })
export class PlayerCharacterSkill {
  @PrimaryColumn({ name: 'character_id', type: 'uuid' })
  characterId!: string;

  @PrimaryColumn({ name: 'skill_slug' })
  skillSlug!: string;
}
