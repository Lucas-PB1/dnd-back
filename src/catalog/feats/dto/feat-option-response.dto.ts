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

  @ApiPropertyOptional({ example: 0, description: 'Para valueType spell — nível máximo da magia' })
  spellMaxLevel!: number | null;

  @ApiPropertyOptional({ type: [FeatOptionValueDto] })
  values!: FeatOptionValueDto[];
}
