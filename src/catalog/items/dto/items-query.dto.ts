import { ApiPropertyOptional, IntersectionType } from '@nestjs/swagger';
import { IsIn, IsOptional, IsString } from 'class-validator';
import { CatalogFieldsQueryDto } from '@common/dto/catalog-fields.dto';
import { SearchQueryDto } from '@common/dto/pagination.dto';

export class ItemsQueryDto extends IntersectionType(
  SearchQueryDto,
  CatalogFieldsQueryDto,
) {
  @ApiPropertyOptional({
    example: 'weapon',
    description:
      'Filter by item_type. Comma-separated for multiple (e.g. gear,tool,focus,other)',
  })
  @IsOptional()
  @IsString()
  itemType?: string;

  @ApiPropertyOptional({
    description:
      'When true, only items with properties.magic = true (itens mágicos)',
    enum: ['true', 'false'],
    example: 'true',
  })
  @IsOptional()
  @IsIn(['true', 'false'])
  magic?: 'true' | 'false';

  @ApiPropertyOptional({
    description:
      'Filter by properties.rarity (common|uncommon|rare|very-rare|legendary|artifact|varies)',
    example: 'rare',
  })
  @IsOptional()
  @IsString()
  rarity?: string;

  @ApiPropertyOptional({
    description:
      'When true, only items with a parseable catalog cost; false = no cost / Varia',
    enum: ['true', 'false'],
  })
  @IsOptional()
  @IsIn(['true', 'false'])
  hasCost?: 'true' | 'false';

  @ApiPropertyOptional({
    description:
      'Filter by properties.kind (service|mount|coverage|…). Comma-separated.',
    example: 'service',
  })
  @IsOptional()
  @IsString()
  kind?: string;

  @ApiPropertyOptional({
    description: 'When true, only properties.consumable = true',
    enum: ['true', 'false'],
  })
  @IsOptional()
  @IsIn(['true', 'false'])
  consumable?: 'true' | 'false';

  @ApiPropertyOptional({
    description: 'Exclude properties.kind = coverage (base pieces for overlays)',
    enum: ['true', 'false'],
  })
  @IsOptional()
  @IsIn(['true', 'false'])
  excludeCoverage?: 'true' | 'false';

  @ApiPropertyOptional({
    description:
      'When true, only properties.requiresAttunement = true; false = sem exigência explícita',
    enum: ['true', 'false'],
  })
  @IsOptional()
  @IsIn(['true', 'false'])
  requiresAttunement?: 'true' | 'false';

  @ApiPropertyOptional({
    description: 'Ordenação: name | name_desc | cost_asc | cost_desc',
    enum: ['name', 'name_desc', 'cost_asc', 'cost_desc'],
  })
  @IsOptional()
  @IsIn(['name', 'name_desc', 'cost_asc', 'cost_desc'])
  sort?: 'name' | 'name_desc' | 'cost_asc' | 'cost_desc';
}
