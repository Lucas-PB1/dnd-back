import {
  ForbiddenException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CatalogLookupService } from '../../catalog/catalog-lookup.service';
import {
  DEFAULT_ABILITY_SCORES,
  PlayerCharacter,
} from './player-character.entity';
import { CreateCharacterDto } from './dto/create-character.dto';
import { UpdateCharacterDto } from './dto/update-character.dto';
import { CharacterResponseDto } from './dto/character-response.dto';

@Injectable()
export class CharactersService {
  constructor(
    @InjectRepository(PlayerCharacter)
    private readonly charactersRepo: Repository<PlayerCharacter>,
    private readonly catalogLookup: CatalogLookupService,
  ) {}

  async findAllForUser(userId: string): Promise<CharacterResponseDto[]> {
    const rows = await this.charactersRepo.find({
      where: { userId },
      order: { updatedAt: 'DESC' },
    });
    return rows.map((row) => this.toDto(row));
  }

  async findOneForUser(userId: string, id: string): Promise<CharacterResponseDto> {
    const row = await this.findOwnedOrFail(userId, id);
    return this.toDto(row);
  }

  async create(userId: string, dto: CreateCharacterDto): Promise<CharacterResponseDto> {
    await this.catalogLookup.validateCharacterCatalogRefs({
      classSlug: dto.classSlug,
      speciesSlug: dto.speciesSlug,
      backgroundSlug: dto.backgroundSlug,
      subclassSlug: dto.subclassSlug,
      alignmentSlug: dto.alignmentSlug,
    });

    const entity = this.charactersRepo.create({
      userId,
      name: dto.name,
      level: 1,
      classSlug: dto.classSlug,
      speciesSlug: dto.speciesSlug,
      backgroundSlug: dto.backgroundSlug,
      subclassSlug: dto.subclassSlug ?? null,
      alignmentSlug: dto.alignmentSlug ?? null,
      abilityScores: dto.abilityScores ?? DEFAULT_ABILITY_SCORES,
      hitPointsMax: dto.hitPointsMax ?? null,
      hitPointsCurrent: dto.hitPointsCurrent ?? dto.hitPointsMax ?? null,
    });

    const saved = await this.charactersRepo.save(entity);
    return this.toDto(saved);
  }

  async update(
    userId: string,
    id: string,
    dto: UpdateCharacterDto,
  ): Promise<CharacterResponseDto> {
    const row = await this.findOwnedOrFail(userId, id);

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

    if (dto.name !== undefined) row.name = dto.name;
    if (dto.level !== undefined) row.level = dto.level;
    if (dto.classSlug !== undefined) row.classSlug = dto.classSlug;
    if (dto.speciesSlug !== undefined) row.speciesSlug = dto.speciesSlug;
    if (dto.backgroundSlug !== undefined) row.backgroundSlug = dto.backgroundSlug;
    if (dto.subclassSlug !== undefined) row.subclassSlug = dto.subclassSlug ?? null;
    if (dto.alignmentSlug !== undefined) row.alignmentSlug = dto.alignmentSlug ?? null;
    if (dto.abilityScores !== undefined) row.abilityScores = dto.abilityScores;
    if (dto.hitPointsMax !== undefined) row.hitPointsMax = dto.hitPointsMax;
    if (dto.hitPointsCurrent !== undefined) row.hitPointsCurrent = dto.hitPointsCurrent;

    const saved = await this.charactersRepo.save(row);
    return this.toDto(saved);
  }

  async remove(userId: string, id: string): Promise<void> {
    const row = await this.findOwnedOrFail(userId, id);
    await this.charactersRepo.remove(row);
  }

  private async findOwnedOrFail(userId: string, id: string): Promise<PlayerCharacter> {
    const row = await this.charactersRepo.findOne({ where: { id } });
    if (!row) {
      throw new NotFoundException(`Character '${id}' not found`);
    }
    if (row.userId !== userId) {
      throw new ForbiddenException('You do not have access to this character');
    }
    return row;
  }

  private toDto(row: PlayerCharacter): CharacterResponseDto {
    return {
      id: row.id,
      name: row.name,
      level: row.level,
      classSlug: row.classSlug,
      speciesSlug: row.speciesSlug,
      backgroundSlug: row.backgroundSlug,
      subclassSlug: row.subclassSlug,
      alignmentSlug: row.alignmentSlug,
      abilityScores: row.abilityScores,
      hitPointsMax: row.hitPointsMax,
      hitPointsCurrent: row.hitPointsCurrent,
      createdAt: row.createdAt.toISOString(),
      updatedAt: row.updatedAt.toISOString(),
    };
  }
}
