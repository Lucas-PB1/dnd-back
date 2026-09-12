import { BadRequestException } from '@nestjs/common';
import type { DataSource, Repository } from 'typeorm';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { PlayerCharacterItem } from '@game/inventory/infrastructure/player-character-item.entity';
import type { TableActionResponseDto } from '@game/session/dto/fighter/fighter-session.dto';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import {
  ARTISAN_CRAFT_ACTION_SLUG,
  ARTISAN_FEAT_SLUG,
  isArtisanQuickCraftItem,
  readArtisanCraftedQty,
  toolSlugForCraftItem,
  withArtisanCraftedQty,
} from '@game/session/domain/artisan-craft';

export type ArtisanCraftDeps = {
  state: CharacterStateRepository;
  items: Repository<PlayerCharacterItem>;
  dataSource: DataSource;
};

export async function applyArtisanCraftTableAction(input: {
  deps: ArtisanCraftDeps;
  character: PlayerCharacter;
  actionName: string;
  itemSlug: string | undefined;
}): Promise<TableActionResponseDto> {
  const itemSlug = input.itemSlug?.trim();
  if (!itemSlug) {
    throw new BadRequestException(
      'artisan-craft exige itemSlug (tabela Fabricação Rápida)',
    );
  }
  if (!isArtisanQuickCraftItem(itemSlug)) {
    throw new BadRequestException(
      `Item '${itemSlug}' não está na tabela Fabricação Rápida`,
    );
  }
  const toolSlug = toolSlugForCraftItem(itemSlug)!;
  const proficient = await characterHasArtisanToolProficiency(
    input.deps.dataSource,
    input.character.id,
    toolSlug,
  );
  if (!proficient) {
    throw new BadRequestException(
      `Sem proficiência com ${toolSlug} para fabricar '${itemSlug}'`,
    );
  }

  await dissolvePriorCraftedThenAdd(input.deps.items, input.character.id, itemSlug);

  const state = await input.deps.state.buildResponse(input.character);
  return {
    state,
    actionName: input.actionName,
    resourceSpent: false,
    note: `Fabricação Rápida: ${itemSlug} adicionado (dura até o próximo Descanso Longo). Ferramenta: ${toolSlug}.`,
  };
}

export function isArtisanCraftAction(
  featSlug: string,
  actionSlug: string,
): boolean {
  return (
    featSlug === ARTISAN_FEAT_SLUG && actionSlug === ARTISAN_CRAFT_ACTION_SLUG
  );
}

async function characterHasArtisanToolProficiency(
  dataSource: DataSource,
  characterId: string,
  toolSlug: string,
): Promise<boolean> {
  const rows = await dataSource.query<{ ok: number }[]>(
    `SELECT 1 AS ok
     FROM rpg.player_character_option
     WHERE character_id = $1
       AND scope = 'feat'
       AND owner_slug = $2
       AND option_key IN ('artisanTool1', 'artisanTool2', 'artisanTool3')
       AND value_id = $3
     LIMIT 1`,
    [characterId, ARTISAN_FEAT_SLUG, toolSlug],
  );
  return rows.length > 0;
}

async function dissolvePriorCraftedThenAdd(
  items: Repository<PlayerCharacterItem>,
  characterId: string,
  itemSlug: string,
): Promise<void> {
  const all = await items.find({ where: { characterId } });
  for (const row of all) {
    const crafted = readArtisanCraftedQty(row.instanceProperties);
    if (crafted <= 0) continue;
    const removeQty = Math.min(crafted, row.quantity);
    row.quantity -= removeQty;
    row.instanceProperties = withArtisanCraftedQty(row.instanceProperties, 0);
    if (row.quantity <= 0) await items.remove(row);
    else await items.save(row);
  }

  const existing = await items.findOne({ where: { characterId, itemSlug } });
  if (existing) {
    existing.quantity += 1;
    const prev = readArtisanCraftedQty(existing.instanceProperties);
    existing.instanceProperties = withArtisanCraftedQty(
      existing.instanceProperties,
      prev + 1,
    );
    await items.save(existing);
    return;
  }

  await items.save(
    items.create({
      characterId,
      itemSlug,
      quantity: 1,
      location: 'backpack',
      equipmentSlot: null,
      attuned: false,
      isPactWeapon: false,
      instanceProperties: withArtisanCraftedQty(null, 1),
    }),
  );
}
