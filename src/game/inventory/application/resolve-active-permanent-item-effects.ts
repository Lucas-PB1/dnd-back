import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { In, Repository } from 'typeorm';
import { PhbItem } from '../../../entities/phb-item.entity';
import {
  resolveActivePermanentItemEffects,
  type PermanentItemEffects,
} from '../domain/permanent-item-effects';
import { PlayerCharacterItem } from '../infrastructure/player-character-item.entity';

export type ActivePermanentItemEffects = PermanentItemEffects & {
  sourceNames: string[];
};

@Injectable()
export class ResolveActivePermanentItemEffects {
  constructor(
    @InjectRepository(PlayerCharacterItem)
    private readonly inventoryItems: Repository<PlayerCharacterItem>,
    @InjectRepository(PhbItem)
    private readonly catalogItems: Repository<PhbItem>,
  ) {}

  async resolve(characterId: string): Promise<ActivePermanentItemEffects> {
    const rows = await this.inventoryItems.find({ where: { characterId } });
    if (rows.length === 0) {
      return resolveActivePermanentItemEffects([]);
    }

    const catalog = await this.catalogItems.find({
      where: { slug: In(rows.map((row) => row.itemSlug)) },
    });
    const bySlug = new Map(catalog.map((item) => [item.slug, item]));

    return resolveActivePermanentItemEffects(
      rows.map((row) => {
        const item = bySlug.get(row.itemSlug);
        return {
          location: row.location,
          attuned: row.attuned,
          itemName: item?.name ?? row.itemSlug,
          properties: item?.properties ?? null,
        };
      }),
    );
  }
}
