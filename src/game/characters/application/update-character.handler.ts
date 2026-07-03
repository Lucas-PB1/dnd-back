import { Injectable } from '@nestjs/common';
import { CatalogLookupService } from '../../../catalog/catalog-lookup.service';
import { CharacterFactory } from '../domain/character.factory';
import { CharacterDomainService } from '../domain/character-domain.service';
import { CharacterRepository } from '../infrastructure/character.repository';
import { CharacterMapper } from '../infrastructure/character.mapper';
import { UpdateCharacterDto } from '../dto/update-character.dto';
import { CharacterResponseDto } from '../dto/character-response.dto';

@Injectable()
export class UpdateCharacterHandler {
  constructor(
    private readonly catalogLookup: CatalogLookupService,
    private readonly domain: CharacterDomainService,
    private readonly repository: CharacterRepository,
    private readonly mapper: CharacterMapper,
  ) {}

  async execute(
    userId: string,
    id: string,
    dto: UpdateCharacterDto,
  ): Promise<CharacterResponseDto> {
    const row = await this.repository.findOwnedOrFail(userId, id);

    if (
      dto.classSlug !== undefined ||
      dto.speciesSlug !== undefined ||
      dto.backgroundSlug !== undefined ||
      dto.subclassSlug !== undefined ||
      dto.alignmentSlug !== undefined
    ) {
      await this.catalogLookup.validateCharacterCatalogRefs({
        classSlug: dto.classSlug ?? row.classSlug,
        speciesSlug: dto.speciesSlug ?? row.speciesSlug,
        backgroundSlug: dto.backgroundSlug ?? row.backgroundSlug,
        subclassSlug: dto.subclassSlug !== undefined ? dto.subclassSlug : row.subclassSlug,
        alignmentSlug: dto.alignmentSlug !== undefined ? dto.alignmentSlug : row.alignmentSlug,
      });
    }

    const before = {
      level: row.level,
      classSlug: row.classSlug,
      abilityScores: row.abilityScores,
    };

    CharacterFactory.applyUpdate(row, dto);

    await this.domain.refreshHitPointsAfterChange(row, dto, {
      level: dto.level !== undefined && dto.level !== before.level,
      classSlug: dto.classSlug !== undefined && dto.classSlug !== before.classSlug,
      abilityScores:
        dto.abilityScores !== undefined &&
        JSON.stringify(dto.abilityScores) !== JSON.stringify(before.abilityScores),
    });

    const saved = await this.repository.save(row);
    return this.mapper.toDto(saved);
  }
}
