import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { clearArtifactRandomForReroll } from '../domain/artifact/artifact-reroll';
import { resolveSentientConflict } from '../domain/artifact/sentient-conflict';
import {
  buildArtifactInstanceProperties,
  parseArtifactRandomQuota,
} from '../domain/artifact/roll-artifact-instance';
import type { ArtifactRandomTableRow } from '../domain/artifact/artifact-instance.types';
import { PlayerCharacterItem } from '../infrastructure/player-character-item.entity';
import { DmgArtifactRandomProperty } from '../infrastructure/dmg-artifact-random-property.entity';
import { inventoryItemToDto } from '../infrastructure/inventory/inventory-item-mappers';
import { PhbItem } from '@entities/phb-item.entity';
import type { InventoryItemResponseDto } from '../dto/inventory.dto';
import { loadArtifactRandomRows } from '../infrastructure/inventory/load-artifact-attunement-deps';

export type SentientConflictResult = {
  itemSlug: string;
  saveDc: number;
  itemCharisma: number;
  itemCharismaMod: number;
  note: string;
};

@Injectable()
export class ApplyArtifactPolishHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    @InjectRepository(PlayerCharacterItem)
    private readonly items: Repository<PlayerCharacterItem>,
    @InjectRepository(DmgArtifactRandomProperty)
    private readonly artifactRandomProperties: Repository<DmgArtifactRandomProperty>,
    @InjectRepository(PhbItem)
    private readonly catalogItems: Repository<PhbItem>,
    private readonly catalogLookup: CatalogLookupService,
  ) {}

  async conflict(
    userId: string,
    characterId: string,
    itemSlug: string,
  ): Promise<SentientConflictResult> {
    await this.access.findAccessibleOrFail(userId, characterId, 'write');
    const row = await this.requireRow(characterId, itemSlug);
    try {
      return resolveSentientConflict({
        itemSlug,
        instanceProperties: row.instanceProperties,
      });
    } catch (error) {
      throw new BadRequestException(
        error instanceof Error ? error.message : 'Conflict not available',
      );
    }
  }

  async reroll(
    userId: string,
    characterId: string,
    itemSlug: string,
  ): Promise<InventoryItemResponseDto> {
    await this.access.findAccessibleOrFail(userId, characterId, 'write');
    const row = await this.requireRow(characterId, itemSlug);
    const catalog = await this.catalogLookup.assertItemInCatalog(itemSlug);
    const props =
      catalog.properties != null &&
      typeof catalog.properties === 'object' &&
      !Array.isArray(catalog.properties)
        ? (catalog.properties as Record<string, unknown>)
        : null;
    if (!parseArtifactRandomQuota(props)) {
      throw new BadRequestException(
        `Item '${itemSlug}' has no artifactRandomQuota to reroll`,
      );
    }

    const cleared = clearArtifactRandomForReroll(row.instanceProperties);
    const tableRows: ArtifactRandomTableRow[] =
      await loadArtifactRandomRows(this.artifactRandomProperties);
    row.instanceProperties = buildArtifactInstanceProperties({
      catalogProperties: props,
      existingInstance: cleared,
      tableRows,
      rng: Math.random,
      nowIso: new Date().toISOString(),
    });
    await this.items.save(row);
    return inventoryItemToDto(this.catalogItems, row);
  }

  private async requireRow(characterId: string, itemSlug: string) {
    const row = await this.items.findOne({
      where: { characterId, itemSlug },
    });
    if (!row) {
      throw new BadRequestException(`Item '${itemSlug}' not in inventory`);
    }
    return row;
  }
}
