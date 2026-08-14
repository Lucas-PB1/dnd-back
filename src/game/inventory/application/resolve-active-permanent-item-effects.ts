import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { In, Repository } from 'typeorm';
import { PhbItem } from '@entities/phb-item.entity';
import { itemRequiresAttunement } from '../domain/attunement';
import {
  coverageBonusToEffects,
  parseItemCoverage,
} from '../domain/coverage/item-coverage';
import { mergeArtifactInstanceIntoCatalogProperties } from '../domain/artifact/merge-artifact-instance-effects';
import {
  resolveActivePermanentItemEffects,
  type InventoryItemForEffects,
  type ResolvedPermanentItemEffects,
} from '../domain/permanent-item-effects';
import { PlayerCharacterItem } from '../infrastructure/player-character-item.entity';

export type ActivePermanentItemEffects = ResolvedPermanentItemEffects;

@Injectable()
export class ResolveActivePermanentItemEffects {
  constructor(
    @InjectRepository(PlayerCharacterItem)
    private readonly inventoryItems: Repository<PlayerCharacterItem>,
    @InjectRepository(PhbItem)
    private readonly catalogItems: Repository<PhbItem>,
  ) {}

  async resolve(
    characterId: string,
    options?: {
      inventoryRows?: PlayerCharacterItem[];
      catalogItems?: Array<{
        slug: string;
        name: string;
        properties: Record<string, unknown> | null;
      }>;
    },
  ): Promise<ActivePermanentItemEffects> {
    const rows =
      options?.inventoryRows ??
      (await this.inventoryItems.find({ where: { characterId } }));
    if (rows.length === 0) {
      return resolveActivePermanentItemEffects([]);
    }

    const slugs = [
      ...new Set(
        rows.flatMap((row) =>
          [row.itemSlug, row.attachedCoverageSlug].filter(
            (slug): slug is string => Boolean(slug),
          ),
        ),
      ),
    ];
    const catalog =
      options?.catalogItems ??
      (await this.catalogItems.find({
        where: { slug: In(slugs) },
      }));
    const bySlug = new Map(catalog.map((item) => [item.slug, item]));

    const forEffects: InventoryItemForEffects[] = rows.map((row) => {
      const item = bySlug.get(row.itemSlug);
      return {
        location: row.location,
        attuned: row.attuned,
        itemName: item?.name ?? row.itemSlug,
        properties: mergeArtifactInstanceIntoCatalogProperties(
          (item?.properties ?? null) as Record<string, unknown> | null,
          row.instanceProperties,
        ),
      };
    });

    for (const row of rows) {
      const coverageSlug = row.attachedCoverageSlug;
      if (!coverageSlug || row.location !== 'equipped') continue;
      const coverageItem = bySlug.get(coverageSlug);
      if (!coverageItem) continue;
      const props = (coverageItem.properties ?? null) as Record<
        string,
        unknown
      > | null;
      const coverage = parseItemCoverage(props);
      if (!coverage) continue;
      // Bônus de arma/munição ficam por peça no resolve de ataques.
      if (coverage.appliesTo === 'weapon' || coverage.appliesTo === 'ammunition') {
        continue;
      }

      const requiresAttunement = itemRequiresAttunement(props);
      if (requiresAttunement && !row.attachedCoverageAttuned) continue;

      let properties = props;
      const bonus = row.attachedCoverageBonus;
      if (
        (bonus === 1 || bonus === 2 || bonus === 3) &&
        (coverage.appliesTo === 'armor' || coverage.appliesTo === 'shield')
      ) {
        const effects = coverageBonusToEffects(coverage.appliesTo, bonus);
        properties = {
          ...(props ?? {}),
          permanentEffects: effects,
          requiresAttunement,
        };
      }

      forEffects.push({
        location: 'equipped',
        attuned: requiresAttunement ? row.attachedCoverageAttuned : true,
        itemName: coverageItem.name,
        properties,
      });
    }

    return resolveActivePermanentItemEffects(forEffects);
  }
}
