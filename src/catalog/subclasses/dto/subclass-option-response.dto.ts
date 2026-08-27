import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class SubclassOptionValueDto {
  @ApiProperty({ example: 'archery' })
  valueId!: string;

  @ApiProperty({ example: 'Arqueria' })
  label!: string;

  @ApiProperty({ example: 1 })
  sortOrder!: number;

  @ApiPropertyOptional({
    nullable: true,
    example: 'Você ganha +2 em jogadas de ataque à distância.',
  })
  benefit!: string | null;
}

export class SubclassOptionResponseDto {
  @ApiProperty({ example: 'additionalFightingStyle' })
  optionKey!: string;

  @ApiProperty({ example: 'Estilo de Luta Adicional' })
  label!: string;

  @ApiProperty({ example: 7 })
  unlockLevel!: number;

  @ApiProperty({ example: 'fighting_style' })
  valueType!: string;

  @ApiProperty({ type: [SubclassOptionValueDto] })
  values!: SubclassOptionValueDto[];

  @ApiPropertyOptional({ example: 2 })
  spellMaxLevel?: number | null;

  @ApiPropertyOptional({ type: [String] })
  spellSchoolSlugs?: string[] | null;
}
