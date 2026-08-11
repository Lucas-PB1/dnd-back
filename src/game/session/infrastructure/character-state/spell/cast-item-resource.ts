import { BadRequestException } from '@nestjs/common';
import { DataSource } from 'typeorm';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { applyResourceSpend } from '@game/session/domain/class-resources';
import { assertItemCastEconomyAllows } from '@game/session/domain/assert-item-spell-cast';
import { assertItemFreeSpellCastAllows } from '@game/session/domain/assert-item-spell-cast';
import {
  ENSPELLED_ARMOR_COVERAGE_SLUG,
  ENSPELLED_STAFF_ITEM_SLUG,
  ENSPELLED_WEAPON_COVERAGE_SLUG,
} from '@game/inventory/domain/coverage/enspelled-weapon';
import { PlayerCharacterState } from '@game/session/infrastructure/player-character-state.entity';
import {
  loadActiveItemSlugs,
  resolveClassResources,
} from '../resources/class-resources';

export async function assertFreeItemCast(input: {
  character: PlayerCharacter;
  dataSource: DataSource;
  itemSlug: string;
  spellSlug: string;
}): Promise<{ itemSlug: string }> {
  const { character, dataSource, itemSlug, spellSlug } = input;
  const activeItemSlugs = await loadActiveItemSlugs(dataSource, character.id);
  if (!activeItemSlugs.includes(itemSlug)) {
    throw new BadRequestException(
      `Item '${itemSlug}' is not active for free item cast`,
    );
  }

  const economyRows = await dataSource.query<
    {
      action_id: string;
      item_slug: string;
      spell_slug: string | null;
      resource_slug: string | null;
      spend_amount: number | null;
    }[]
  >(
    `SELECT
       a.action_id,
       i.slug AS item_slug,
       a.spell_slug,
       a.resource_slug,
       a.spend_amount
     FROM rpg.phb_class_economy_action a
     JOIN rpg.phb_item i ON i.id = a.item_id
     WHERE i.slug = $1
       AND a.spell_slug = $2
       AND a.resource_slug IS NULL
       AND a.table_action = 'cast-item-free'`,
    [itemSlug, spellSlug],
  );

  const match = assertItemFreeSpellCastAllows({
    matches: economyRows.map((row) => ({
      actionId: row.action_id,
      itemSlug: row.item_slug,
      spellSlug: row.spell_slug,
      resourceSlug: row.resource_slug,
      spendAmount:
        row.spend_amount == null ? null : Number(row.spend_amount),
    })),
    spellSlug,
    itemSlug,
  });

  return { itemSlug: match.itemSlug };
}

export async function spendItemCastResource(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  dataSource: DataSource;
  resourceSlug: string;
  spendAmount: number;
  spellSlug: string;
}): Promise<{ itemSlug: string }> {
  const {
    character,
    state,
    dataSource,
    resourceSlug,
    spendAmount,
    spellSlug,
  } = input;

  const activeItemSlugs = await loadActiveItemSlugs(dataSource, character.id);
  if (activeItemSlugs.length === 0) {
    throw new BadRequestException(
      'No active magic items available for item cast',
    );
  }

  const economyRows = await dataSource.query<
    {
      action_id: string;
      item_slug: string;
      spell_slug: string | null;
      resource_slug: string;
      spend_amount: number;
    }[]
  >(
    `SELECT
       a.action_id,
       i.slug AS item_slug,
       a.spell_slug,
       a.resource_slug,
       a.spend_amount
     FROM rpg.phb_class_economy_action a
     JOIN rpg.phb_item i ON i.id = a.item_id
     WHERE a.resource_slug = $1
       AND a.spend_amount = $2
       AND i.slug = ANY($3::text[])
       AND a.table_action = 'spend-resource'`,
    [resourceSlug, spendAmount, activeItemSlugs],
  );

  const boundRows = await dataSource.query<{ bound_spell_slug: string }[]>(
    `SELECT bound_spell_slug FROM (
       SELECT pci.attached_coverage_spell_slug AS bound_spell_slug
       FROM rpg.player_character_item pci
       JOIN rpg.phb_item cov ON cov.slug = pci.attached_coverage_slug
       WHERE pci.character_id = $1
         AND pci.location = 'equipped'
         AND pci.attached_coverage_slug = ANY($2::text[])
         AND pci.attached_coverage_spell_slug = $3
         AND (
           COALESCE((cov.properties->>'requiresAttunement')::boolean, false) = false
           OR pci.attached_coverage_attuned = true
         )
       UNION ALL
       SELECT pci.bound_spell_slug
       FROM rpg.player_character_item pci
       JOIN rpg.phb_item i ON i.slug = pci.item_slug
       WHERE pci.character_id = $1
         AND pci.location = 'equipped'
         AND pci.item_slug = ANY($4::text[])
         AND pci.bound_spell_slug = $3
         AND (
           COALESCE((i.properties->>'requiresAttunement')::boolean, false) = false
           OR pci.attuned = true
         )
     ) bound
     LIMIT 1`,
    [
      character.id,
      [ENSPELLED_WEAPON_COVERAGE_SLUG, ENSPELLED_ARMOR_COVERAGE_SLUG],
      spellSlug,
      [ENSPELLED_STAFF_ITEM_SLUG],
    ],
  );

  const match = assertItemCastEconomyAllows({
    matches: economyRows.map((row) => ({
      actionId: row.action_id,
      itemSlug: row.item_slug,
      spellSlug: row.spell_slug,
      resourceSlug: row.resource_slug,
      spendAmount: Number(row.spend_amount),
    })),
    spellSlug,
    resourceSlug,
    spendAmount,
    boundSpellSlug: boundRows[0]?.bound_spell_slug ?? null,
  });

  const resources = await resolveClassResources(dataSource, character);
  const resource = resources.find((item) => item.slug === resourceSlug);
  if (!resource) {
    throw new BadRequestException(
      `Resource '${resourceSlug}' is not available for this character`,
    );
  }
  try {
    state.resourcesUsed = applyResourceSpend(
      state.resourcesUsed ?? {},
      resourceSlug,
      resource.max,
      spendAmount,
    );
  } catch (error) {
    throw new BadRequestException(
      error instanceof Error ? error.message : 'Cannot spend item cast resource',
    );
  }

  return { itemSlug: match.itemSlug };
}
