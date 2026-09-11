import { BadRequestException } from '@nestjs/common';
import { Repository } from 'typeorm';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { PhbWeapon } from '@entities/equipment/phb-weapon.entity';
import { VPhbArmor } from '@entities/views/v-phb-armor.entity';
import {
  itemRequiresAttunement,
  MAX_ATTUNED_ITEMS,
} from '../../../domain/attunement';
import { assertCharacterMayAttune } from '../../../domain/attunement-restriction';
import { type CoverageBaseContext } from '../../../domain/coverage/item-coverage';
import { PlayerCharacterItem } from '../../../infrastructure/player-character-item.entity';

export async function resolveCoverageBaseContext(
  catalogLookup: CatalogLookupService,
  weapons: Repository<PhbWeapon>,
  armorCatalog: Repository<VPhbArmor>,
  itemSlug: string,
): Promise<CoverageBaseContext> {
  const catalog = await catalogLookup.assertItemInCatalog(itemSlug);
  const props = (catalog.properties ?? null) as Record<string, unknown> | null;
  const subtypeLabel =
    (typeof props?.weaponSubtype === 'string' && props.weaponSubtype) ||
    (typeof props?.armorSubtype === 'string' && props.armorSubtype) ||
    (typeof props?.category === 'string' && props.category) ||
    null;

  const weapon = await weapons.findOne({
    where: { item: { slug: itemSlug } },
    relations: ['item'],
  });
  const armor = await armorCatalog.findOne({
    where: { itemSlug },
  });

  return {
    itemSlug,
    itemName: catalog.name,
    itemType: catalog.itemType,
    weaponCategory: weapon?.category ?? null,
    armorCategorySlug: armor?.categorySlug ?? null,
    subtypeLabel,
  };
}

export async function hasCoverageAttunementSlot(
  items: Repository<PlayerCharacterItem>,
  characterId: string,
): Promise<boolean> {
  const attunedCount = await items.count({
    where: { characterId, attuned: true },
  });
  const coverageAttunedCount = await items.count({
    where: { characterId, attachedCoverageAttuned: true },
  });
  return attunedCount + coverageAttunedCount < MAX_ATTUNED_ITEMS;
}

export async function resolveCoverageShouldAttune(
  items: Repository<PlayerCharacterItem>,
  characterId: string,
  character: { classSlug: string; speciesSlug: string | null },
  coverageSlug: string,
  coverageProps: Record<string, unknown> | null,
): Promise<boolean> {
  if (!itemRequiresAttunement(coverageProps)) return false;
  if (!(await hasCoverageAttunementSlot(items, characterId))) return false;
  try {
    assertCharacterMayAttune({
      itemLabel: coverageSlug,
      classSlug: character.classSlug,
      speciesSlug: character.speciesSlug,
      properties: coverageProps,
    });
    return true;
  } catch {
    return false;
  }
}

export async function consumeCoverageFromBackpack(
  items: Repository<PlayerCharacterItem>,
  row: PlayerCharacterItem,
): Promise<void> {
  if (row.quantity <= 1) {
    await items.remove(row);
    return;
  }
  row.quantity -= 1;
  await items.save(row);
}

export async function returnCoverageToBackpack(
  items: Repository<PlayerCharacterItem>,
  catalogLookup: CatalogLookupService,
  characterId: string,
  coverageSlug: string,
): Promise<void> {
  const existing = await items.findOne({
    where: { characterId, itemSlug: coverageSlug },
  });
  if (existing) {
    if (existing.location === 'equipped') {
      throw new BadRequestException(
        `Cannot return coverage '${coverageSlug}': another copy is equipped`,
      );
    }
    existing.quantity += 1;
    await items.save(existing);
    return;
  }

  await catalogLookup.assertItemInCatalog(coverageSlug);
  await items.save(
    items.create({
      characterId,
      itemSlug: coverageSlug,
      quantity: 1,
      location: 'backpack',
      equipmentSlot: null,
      attuned: false,
      attachedCharmSlug: null,
      attachedCoverageSlug: null,
      attachedCoverageBonus: null,
      attachedCoverageSpellSlug: null,
      attachedCoverageAttuned: false,
    }),
  );
}
