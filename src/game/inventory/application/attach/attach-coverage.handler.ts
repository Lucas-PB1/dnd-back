import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { PhbItem } from '@entities/equipment/phb-item.entity';
import { PhbWeapon } from '@entities/equipment/phb-weapon.entity';
import { VPhbArmor } from '@entities/views/v-phb-armor.entity';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import {
  AttachCoverageDto,
  DetachCoverageDto,
  InventoryItemResponseDto,
} from '../../dto/inventory.dto';
import { PlayerCharacterItem } from '../../infrastructure/player-character-item.entity';
import {
  runAttachCoverage,
  runDetachCoverage,
} from './coverage/attach-coverage-flow';

@Injectable()
export class AttachCoverageHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    @InjectRepository(PlayerCharacterItem)
    private readonly items: Repository<PlayerCharacterItem>,
    @InjectRepository(PhbItem)
    private readonly catalogItems: Repository<PhbItem>,
    @InjectRepository(PhbWeapon)
    private readonly weapons: Repository<PhbWeapon>,
    @InjectRepository(VPhbArmor)
    private readonly armorCatalog: Repository<VPhbArmor>,
    private readonly catalogLookup: CatalogLookupService,
  ) {}

  async attach(
    userId: string,
    characterId: string,
    dto: AttachCoverageDto,
  ): Promise<InventoryItemResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    return runAttachCoverage(
      this.flowDeps(),
      characterId,
      {
        classSlug: character.classSlug,
        speciesSlug: character.speciesSlug ?? null,
      },
      dto.baseItemSlug,
      dto.coverageSlug,
      dto.bonus,
      dto.spellSlug,
    );
  }

  async detach(
    userId: string,
    characterId: string,
    dto: DetachCoverageDto,
  ): Promise<InventoryItemResponseDto> {
    await this.access.findAccessibleOrFail(userId, characterId, 'write');
    return runDetachCoverage(
      this.flowDeps(),
      characterId,
      dto.baseItemSlug,
    );
  }

  private flowDeps() {
    return {
      items: this.items,
      catalogItems: this.catalogItems,
      weapons: this.weapons,
      armorCatalog: this.armorCatalog,
      catalogLookup: this.catalogLookup,
    };
  }
}
