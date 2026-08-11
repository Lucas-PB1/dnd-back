import { Injectable, BadRequestException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbItem } from '@entities/phb-item.entity';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { parseItemCoverage } from '../domain/coverage/item-coverage';
import { assertCoverageNotEquippable } from '../domain/assert-can-equip-item';

/** Gate de equip: só bloqueia cobertura; proficiência é soft (compliance/ataques). */
@Injectable()
export class AssertCanEquipItemService {
  constructor(
    @InjectRepository(PhbItem)
    private readonly catalogItems: Repository<PhbItem>,
  ) {}

  async assert(_character: PlayerCharacter, itemSlug: string): Promise<void> {
    const catalog = await this.catalogItems.findOne({ where: { slug: itemSlug } });
    if (
      catalog &&
      parseItemCoverage(
        (catalog.properties ?? null) as Record<string, unknown> | null,
      )
    ) {
      assertCoverageNotEquippable(itemSlug);
    }
  }
}
