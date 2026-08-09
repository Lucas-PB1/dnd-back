import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import {
  isMeleeWeaponFromPropertyIds,
  propertyIdsFromItemProperties,
} from '@game/combat/domain/warlock/pact-blade';
import { isWarlockClass } from '@game/combat/domain/warlock-features';
import { PlayerCharacterOption } from '@game/sheet/infrastructure/player-sheet.entities';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';

export const PACT_OF_THE_BLADE_SLUG = 'pact-of-the-blade';
export const ELDRITCH_INVOCATION_OPTION_KEY = 'eldritch-invocation';

@Injectable()
export class AssertCanBindPactWeaponService {
  constructor(
    private readonly catalogLookup: CatalogLookupService,
    @InjectRepository(PlayerCharacterOption)
    private readonly options: Repository<PlayerCharacterOption>,
  ) {}

  async hasPactOfTheBlade(characterId: string): Promise<boolean> {
    const count = await this.options.count({
      where: {
        characterId,
        scope: 'class',
        optionKey: ELDRITCH_INVOCATION_OPTION_KEY,
        valueId: PACT_OF_THE_BLADE_SLUG,
      },
    });
    return count > 0;
  }

  async assertCharacterCanUsePactBlade(
    character: PlayerCharacter,
  ): Promise<void> {
    if (!isWarlockClass(character.classSlug)) {
      throw new BadRequestException(
        'Arma de Pacto só está disponível para Bruxos',
      );
    }
    if (!(await this.hasPactOfTheBlade(character.id))) {
      throw new BadRequestException(
        'Requer a invocação Pacto da Lâmina',
      );
    }
  }

  async assertItemIsMeleeWeapon(itemSlug: string): Promise<void> {
    const catalog = await this.catalogLookup.assertItemInCatalog(itemSlug);
    if (catalog.itemType !== 'weapon') {
      throw new BadRequestException(
        `Item '${itemSlug}' não é uma arma`,
      );
    }
    const propertyIds = propertyIdsFromItemProperties(
      catalog.properties as Record<string, unknown> | null,
    );
    if (!isMeleeWeaponFromPropertyIds(propertyIds)) {
      throw new BadRequestException(
        `Item '${itemSlug}' não é uma arma corpo a corpo elegível ao Pacto da Lâmina`,
      );
    }
  }

  async assert(character: PlayerCharacter, itemSlug: string): Promise<void> {
    await this.assertCharacterCanUsePactBlade(character);
    await this.assertItemIsMeleeWeapon(itemSlug);
  }
}
