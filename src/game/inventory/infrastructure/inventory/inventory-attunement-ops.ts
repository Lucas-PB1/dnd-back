import { BadRequestException } from '@nestjs/common';
import { Repository } from 'typeorm';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { PlayerCharacterItem } from '../player-character-item.entity';
import {
  itemRequiresAttunement,
  MAX_ATTUNED_ITEMS,
} from '@game/inventory/domain/attunement';
import { mayEndCursedAttunement } from '@game/inventory/domain/cursed-item';
import { assertCharacterMayAttune } from '@game/inventory/domain/attunement-restriction';
import type { ArtifactRandomTableRow } from '@game/inventory/domain/artifact/artifact-instance.types';
import {
  buildArtifactInstanceProperties,
  needsArtifactInstanceRoll,
} from '@game/inventory/domain/artifact/roll-artifact-instance';

export type AttunementCharacterContext = {
  classSlug: string;
  speciesSlug: string | null;
};

export type ArtifactAttunementRollDeps = {
  loadArtifactRandomRows: () => Promise<ArtifactRandomTableRow[]>;
  pickSpellByLevel?: (level: number, rng: () => number) => string | null;
  rng?: () => number;
  nowIso?: () => string;
};

export async function applyInventoryAttunement(input: {
  items: Repository<PlayerCharacterItem>;
  catalogLookup: CatalogLookupService;
  characterId: string;
  character: AttunementCharacterContext;
  row: PlayerCharacterItem;
  attuned: boolean;
  artifactRoll?: ArtifactAttunementRollDeps;
}): Promise<void> {
  const {
    items,
    catalogLookup,
    characterId,
    character,
    row,
    attuned,
    artifactRoll,
  } = input;
  if (row.attuned === attuned) return;

  if (!attuned) {
    const catalog = await catalogLookup.assertItemInCatalog(row.itemSlug);
    const props =
      catalog.properties != null &&
      typeof catalog.properties === 'object' &&
      !Array.isArray(catalog.properties)
        ? (catalog.properties as Record<string, unknown>)
        : null;
    if (
      !mayEndCursedAttunement({
        properties: props,
        instanceProperties: row.instanceProperties,
      })
    ) {
      throw new BadRequestException(
        `Item '${row.itemSlug}' is cursed — cast Remover Maldição (or set instance curseBroken) before ending attunement`,
      );
    }
    row.attuned = false;
    return;
  }

  const catalog = await catalogLookup.assertItemInCatalog(row.itemSlug);
  if (!itemRequiresAttunement(catalog.properties)) {
    throw new BadRequestException(
      `Item '${row.itemSlug}' does not require attunement`,
    );
  }

  try {
    assertCharacterMayAttune({
      itemLabel: row.itemSlug,
      classSlug: character.classSlug,
      speciesSlug: character.speciesSlug,
      properties: catalog.properties,
    });
  } catch (error) {
    throw new BadRequestException(
      error instanceof Error ? error.message : 'Attunement not allowed',
    );
  }

  const attunedCount = await items.count({
    where: { characterId, attuned: true },
  });
  const coverageAttunedCount = await items.count({
    where: { characterId, attachedCoverageAttuned: true },
  });
  if (attunedCount + coverageAttunedCount >= MAX_ATTUNED_ITEMS) {
    throw new BadRequestException(
      `Maximum of ${MAX_ATTUNED_ITEMS} attuned items reached`,
    );
  }

  row.attuned = true;

  const catalogProps =
    catalog.properties != null &&
    typeof catalog.properties === 'object' &&
    !Array.isArray(catalog.properties)
      ? (catalog.properties as Record<string, unknown>)
      : null;

  if (
    artifactRoll &&
    needsArtifactInstanceRoll(catalogProps, row.instanceProperties)
  ) {
    const tableRows = await artifactRoll.loadArtifactRandomRows();
    row.instanceProperties = buildArtifactInstanceProperties({
      catalogProperties: catalogProps,
      existingInstance: row.instanceProperties,
      tableRows,
      rng: artifactRoll.rng ?? Math.random,
      nowIso: artifactRoll.nowIso?.() ?? new Date().toISOString(),
      pickSpellByLevel: artifactRoll.pickSpellByLevel,
    });
  }
}

export async function applyAttachedCoverageAttunement(input: {
  items: Repository<PlayerCharacterItem>;
  catalogLookup: CatalogLookupService;
  characterId: string;
  character: AttunementCharacterContext;
  row: PlayerCharacterItem;
  attuned: boolean;
}): Promise<void> {
  const { items, catalogLookup, characterId, character, row, attuned } = input;
  if (row.attachedCoverageAttuned === attuned) return;

  if (!attuned) {
    row.attachedCoverageAttuned = false;
    return;
  }

  const coverageSlug = row.attachedCoverageSlug;
  if (!coverageSlug) {
    throw new BadRequestException(
      `Item '${row.itemSlug}' has no attached coverage to attune`,
    );
  }

  const catalog = await catalogLookup.assertItemInCatalog(coverageSlug);
  if (!itemRequiresAttunement(catalog.properties)) {
    throw new BadRequestException(
      `Coverage '${coverageSlug}' does not require attunement`,
    );
  }

  try {
    assertCharacterMayAttune({
      itemLabel: coverageSlug,
      classSlug: character.classSlug,
      speciesSlug: character.speciesSlug,
      properties: catalog.properties,
    });
  } catch (error) {
    throw new BadRequestException(
      error instanceof Error ? error.message : 'Attunement not allowed',
    );
  }

  const attunedCount = await items.count({
    where: { characterId, attuned: true },
  });
  const coverageAttunedCount = await items.count({
    where: { characterId, attachedCoverageAttuned: true },
  });
  if (attunedCount + coverageAttunedCount >= MAX_ATTUNED_ITEMS) {
    throw new BadRequestException(
      `Maximum of ${MAX_ATTUNED_ITEMS} attuned items reached`,
    );
  }

  row.attachedCoverageAttuned = true;
}
