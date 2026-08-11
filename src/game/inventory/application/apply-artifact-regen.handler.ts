import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { findArtifactRegenOnInstance } from '../domain/artifact/artifact-instance-ops';
import { PlayerCharacterItem } from '../infrastructure/player-character-item.entity';
import { itemEffectsActive } from '../domain/item-effects-active';
import { itemRequiresAttunement } from '../domain/attunement';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';

export type ArtifactRegenResult = {
  itemSlug: string;
  dice: string;
  roll: number;
  hitPointsHealed: number;
  hitPointsCurrent: number;
  note: string;
};

@Injectable()
export class ApplyArtifactRegenHandler {
  constructor(
    @InjectRepository(PlayerCharacterItem)
    private readonly items: Repository<PlayerCharacterItem>,
    @InjectRepository(PlayerCharacter)
    private readonly characters: Repository<PlayerCharacter>,
    private readonly catalogLookup: CatalogLookupService,
  ) {}

  async execute(
    characterId: string,
    itemSlug: string,
  ): Promise<ArtifactRegenResult> {
    const character = await this.characters.findOne({
      where: { id: characterId },
    });
    if (!character) {
      throw new BadRequestException('Character not found');
    }
    if (
      character.hitPointsCurrent == null ||
      character.hitPointsMax == null
    ) {
      throw new BadRequestException('Character hit points are not set');
    }
    if (character.hitPointsCurrent <= 0) {
      throw new BadRequestException(
        'Regen requires at least 1 hit point (RAW)',
      );
    }

    const row = await this.items.findOne({
      where: { characterId, itemSlug },
    });
    if (!row) {
      throw new BadRequestException(`Inventory item '${itemSlug}' not found`);
    }

    const catalog = await this.catalogLookup.assertItemInCatalog(itemSlug);
    const requiresAttunement = itemRequiresAttunement(catalog.properties);
    if (
      !itemEffectsActive({
        location: row.location,
        attuned: row.attuned,
        requiresAttunement,
      })
    ) {
      throw new BadRequestException(
        `Item '${itemSlug}' effects are not active`,
      );
    }

    const regen = findArtifactRegenOnInstance(row.instanceProperties);
    if (!regen) {
      throw new BadRequestException(
        `Item '${itemSlug}' has no artifact regen property`,
      );
    }

    const faces = Number(regen.dice.replace(/^1d/i, '')) || 6;
    const roll = Math.floor(Math.random() * faces) + 1;
    const before = character.hitPointsCurrent;
    const next = Math.min(character.hitPointsMax, before + roll);
    const healed = next - before;
    character.hitPointsCurrent = next;
    await this.characters.save(character);

    return {
      itemSlug,
      dice: regen.dice,
      roll,
      hitPointsHealed: healed,
      hitPointsCurrent: next,
      note: `Regeneração do artefato: ${regen.dice} → ${roll} (curou ${healed} PV)`,
    };
  }
}
