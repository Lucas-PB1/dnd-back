import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class FeatOptionValueDto {
  @ApiProperty({ example: 'cleric' })
  valueId!: string;

  @ApiProperty({ example: 'Clérigo' })
  label!: string;

  @ApiProperty({ example: 1 })
  sortOrder!: number;
}

export class FeatOptionResponseDto {
  @ApiProperty({ example: 'spellList' })
  optionKey!: string;

  @ApiProperty({ example: 'Lista de magias' })
  label!: string;

  @ApiProperty({ example: 'catalog' })
  valueType!: string;

  @ApiProperty({ example: 1 })
  sortOrder!: number;

  @ApiPropertyOptional({ example: 'spellList' })
  dependsOnOptionKey!: string | null;

  @ApiPropertyOptional({ example: 0, description: 'Nível máximo da magia para valueType spell' })
  spellMaxLevel!: number | null;

  @ApiPropertyOptional({
    example: ['divination', 'enchantment'],
    description: 'Escolas permitidas quando valueType spell sem lista de classe',
  })
  spellSchoolSlugs!: string[] | null;

  @ApiPropertyOptional({ type: [FeatOptionValueDto] })
  values!: FeatOptionValueDto[];
}
