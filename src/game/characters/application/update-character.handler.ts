import { Injectable } from '@nestjs/common';
import { CatalogLookupService } from '../../../catalog/catalog-lookup.service';
import { CharacterFactory } from '../domain/character.factory';
import { CharacterRepository } from '../infrastructure/character.repository';
import { CharacterMapper } from '../infrastructure/character.mapper';
import { UpdateCharacterDto } from '../dto/update-character.dto';
import { CharacterResponseDto } from '../dto/character-response.dto';

@Injectable()
export class UpdateCharacterHandler {
  constructor(
    private readonly catalogLookup: CatalogLookupService,
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

    CharacterFactory.applyUpdate(row, dto);
    const saved = await this.repository.save(row);
    return this.mapper.toDto(saved);
  }
}
