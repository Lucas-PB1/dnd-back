import { DataSource } from 'typeorm';
import type { PlayerCharacterItem } from '@game/inventory/infrastructure/player-character-item.entity';
import type { AbilityScores } from '@game/shared/infrastructure/player-character.entity';
import type { UnarmoredDefenseRow } from '../domain/equipment';

export type CombatBundleArmorRow = {
  itemSlug: string;
  itemName: string;
  categorySlug: string;
  acBase: number;
  strengthReq: number | null;
  stealthDisadvantage: boolean;
};

export type CombatBundleItemRow = {
  slug: string;
  name: string;
  properties: Record<string, unknown> | null;
};

export type CharacterCombatBundle = {
  inventory: PlayerCharacterItem[];
  activeItemSlugs: string[];
  items: CombatBundleItemRow[];
  armor: CombatBundleArmorRow[];
  unarmoredDefenses: UnarmoredDefenseRow[];
};

type CombatBundleJson = {
  inventory?: Array<Record<string, unknown>> | null;
  activeItemSlugs?: string[] | null;
  items?: Array<{
    slug: string;
    name: string;
    properties?: Record<string, unknown> | null;
  }> | null;
  armor?: Array<{
    itemSlug: string;
    itemName: string;
    categorySlug: string;
    acBase: number;
    strengthReq?: number | null;
    stealthDisadvantage?: boolean;
  }> | null;
  unarmoredDefenses?: Array<{
    label: string;
    secondAbilitySlug: string;
    allowsShield: boolean;
  }> | null;
};

export async function loadCharacterCombatBundle(
  dataSource: DataSource,
  characterId: string,
  classSlug: string,
  subclassSlug: string | null,
): Promise<CharacterCombatBundle> {
  const rows = await dataSource.query<{ bundle: CombatBundleJson }[]>(
    `SELECT rpg.get_character_combat_bundle($1::uuid, $2::text, $3::text) AS bundle`,
    [characterId, classSlug, subclassSlug],
  );
  return mapCombatBundle(rows[0]?.bundle);
}

function mapCombatBundle(
  bundle: CombatBundleJson | null | undefined,
): CharacterCombatBundle {
  if (!bundle) {
    return {
      inventory: [],
      activeItemSlugs: [],
      items: [],
      armor: [],
      unarmoredDefenses: [],
    };
  }

  return {
    inventory: (bundle.inventory ?? []).map(mapInventoryRow),
    activeItemSlugs: bundle.activeItemSlugs ?? [],
    items: (bundle.items ?? []).map((row) => ({
      slug: row.slug,
      name: row.name,
      properties: row.properties ?? null,
    })),
    armor: (bundle.armor ?? []).map((row) => ({
      itemSlug: row.itemSlug,
      itemName: row.itemName,
      categorySlug: row.categorySlug,
      acBase: Number(row.acBase),
      strengthReq: row.strengthReq == null ? null : Number(row.strengthReq),
      stealthDisadvantage: Boolean(row.stealthDisadvantage),
    })),
    unarmoredDefenses: (bundle.unarmoredDefenses ?? []).map((row) => ({
      label: row.label,
      secondAbility: row.secondAbilitySlug as keyof AbilityScores,
      allowsShield: Boolean(row.allowsShield),
    })),
  };
}

function mapInventoryRow(row: Record<string, unknown>): PlayerCharacterItem {
  return {
    characterId: String(row.characterId),
    itemSlug: String(row.itemSlug),
    quantity: Number(row.quantity ?? 1),
    location: row.location as PlayerCharacterItem['location'],
    equipmentSlot: (row.equipmentSlot ?? null) as PlayerCharacterItem['equipmentSlot'],
    attuned: Boolean(row.attuned),
    isPactWeapon: Boolean(row.isPactWeapon),
    attachedCharmSlug: (row.attachedCharmSlug as string | null) ?? null,
    attachedCoverageSlug: (row.attachedCoverageSlug as string | null) ?? null,
    attachedCoverageBonus:
      row.attachedCoverageBonus == null
        ? null
        : Number(row.attachedCoverageBonus),
    attachedCoverageAttuned: Boolean(row.attachedCoverageAttuned),
    attachedCoverageSpellSlug:
      (row.attachedCoverageSpellSlug as string | null) ?? null,
    boundSpellSlug: (row.boundSpellSlug as string | null) ?? null,
    instanceProperties:
      (row.instanceProperties as Record<string, unknown> | null) ?? null,
    containedInItemSlug: (row.containedInItemSlug as string | null) ?? null,
  };
}
