import { BadRequestException } from '@nestjs/common';
import type { DataSource } from 'typeorm';
import {
  METAMAGIC_OPTION_KEY,
  type MetamagicCatalogRow,
} from '@game/combat/domain/sorcerer';
import { assertCharacterLevel } from './table-action-guards';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { TableActionResponseDto } from '@game/session/dto/fighter/fighter-session.dto';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';

const SORCERY_POINTS_SLUG = 'sorceryPoints';

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

async function loadMetamagicOption(
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

export async function applyCatalogMetamagicTableAction(input: {
  state: CharacterStateRepository;
  dataSource: DataSource;
  character: PlayerCharacter;
  metamagicSlug: string;
}): Promise<TableActionResponseDto> {
  assertCharacterLevel(input.character, 2, 'Feiticeiro', 'Metamagia');
  if (!input.metamagicSlug?.trim()) {
    throw new BadRequestException('metamagicSlug é obrigatório');
  }
  const option = await loadMetamagicOption(
    input.dataSource,
    input.metamagicSlug.trim(),
  );
  if (!option) {
    throw new BadRequestException(
      `Metamagia desconhecida: '${input.metamagicSlug}'`,
    );
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

  const state = (
    await input.state.useClassResource(
      input.character,
      SORCERY_POINTS_SLUG,
      option.cost,
    )
  ).state;

  return {
    state,
    actionName: option.name,
    resourceSpent: true,
    total: option.cost,
    note: `Metamagia — ${option.name} (${option.cost} pt): ${option.description}`,
  };
}
