import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PlayerCharacterSpell } from '../infrastructure/player-sheet.entities';

@Injectable()
export class CharacterSpellLookup {
  constructor(
    @InjectRepository(PlayerCharacterSpell)
    private readonly spells: Repository<PlayerCharacterSpell>,
  ) {}

  async hasSpell(characterId: string, spellSlug: string): Promise<boolean> {
    const row = await this.spells.findOne({ where: { characterId, spellSlug } });
    return row !== null;
  }
}
