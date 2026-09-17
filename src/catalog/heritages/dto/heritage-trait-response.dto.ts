import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class HeritageTraitOptionValueDto {
  @ApiProperty({ example: 'fire' })
  valueId!: string;

  @ApiProperty({ example: 'Fogo' })
  label!: string;

  @ApiProperty({ example: 1 })
  sortOrder!: number;
}

export class HeritageTraitOptionGroupDto {
  @ApiProperty({ example: 'damageType' })
  optionKey!: string;

  @ApiProperty({ example: 'Tipo de dano' })
  label!: string;

  @ApiProperty({ example: 'catalog' })
  valueType!: string;

  @ApiProperty({ type: [HeritageTraitOptionValueDto] })
  values!: HeritageTraitOptionValueDto[];
}

export class HeritageTraitResponseDto {
  @ApiProperty({ example: 'battlefield-dominance' })
  slug!: string;

  @ApiProperty({ example: 'Domínio do Campo de Batalha' })
  name!: string;

  @ApiProperty({ enum: ['combat', 'exploration', 'roleplaying'], example: 'combat' })
  category!: string;

  @ApiProperty()
  description!: string;

  @ApiPropertyOptional()
  benefitBase!: string | null;

  @ApiPropertyOptional()
  benefitImproved!: string | null;

  @ApiPropertyOptional({ type: [HeritageTraitOptionGroupDto] })
  options?: HeritageTraitOptionGroupDto[];
}
