import { BadRequestException } from '@nestjs/common';
import type { DataSource } from 'typeorm';
import {
  isCombatMetamagicSlug,
  METAMAGIC_OPTION_KEY,
  type MetamagicCatalogRow,
} from '@game/combat/domain/sorcerer';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';

const SORCERY_POINTS_SLUG = 'sorceryPoints';

export async function loadMetamagicCatalogRow(
  dataSource: DataSource,
  slug: string,
): Promise<MetamagicCatalogRow | null> {
  const rows = await dataSource.query<
    {
      slug: string;
      name: string;
      description: string;
      cost: number;
      stacks_with_other: boolean;
    }[]
  >(
    `SELECT slug, name, description, cost, stacks_with_other
     FROM rpg.phb_metamagic
     WHERE slug = $1
     LIMIT 1`,
    [slug],
  );
  const row = rows[0];
  if (!row) return null;
  return {
    slug: row.slug,
    name: row.name,
    description: row.description,
    cost: Number(row.cost),
    stacksWithOther: row.stacks_with_other,
  };
}

async function loadKnownMetamagicSlugs(
  dataSource: DataSource,
  characterId: string,
): Promise<string[]> {
  const rows = await dataSource.query<{ value_id: string }[]>(
    `SELECT value_id
     FROM rpg.player_character_option
     WHERE character_id = $1
       AND scope = 'class'
       AND option_key = $2
     ORDER BY instance_index ASC`,
    [characterId, METAMAGIC_OPTION_KEY],
  );
  return rows.map((row) => row.value_id);
}

export type SpendCombatMetamagicResult = {
  slug: string;
  name: string;
  cost: number;
  note: string;
};

/**
 * Gasta Pontos de Feitiçaria e valida metamagia tipada de combate (PVE-6a).
 */
export async function spendCombatMetamagic(input: {
  dataSource: DataSource;
  useClassResource: (
    character: PlayerCharacter,
    resourceSlug: string,
    amount: number,
  ) => Promise<unknown>;
  character: PlayerCharacter;
  metamagicSlug: string;
}): Promise<SpendCombatMetamagicResult> {
  const slug = input.metamagicSlug.trim();
  if (!isCombatMetamagicSlug(slug)) {
    throw new BadRequestException(
      `Metamagia '${slug}' ainda não tipada em combate (use heightened-spell, seeking-spell, empowered-spell ou careful-spell)`,
    );
  }
  const option = await loadMetamagicCatalogRow(input.dataSource, slug);
  if (!option) {
    throw new BadRequestException(`Metamagia desconhecida: '${slug}'`);
  }
  const known = await loadKnownMetamagicSlugs(
    input.dataSource,
    input.character.id,
  );
  if (known.length > 0 && !known.includes(option.slug)) {
    throw new BadRequestException(
      `Você não conhece a Metamagia '${option.name}'`,
    );
  }
  await input.useClassResource(
    input.character,
    SORCERY_POINTS_SLUG,
    option.cost,
  );
  return {
    slug: option.slug,
    name: option.name,
    cost: option.cost,
    note: `Metamagia — ${option.name} (${option.cost} pt)`,
  };
}
