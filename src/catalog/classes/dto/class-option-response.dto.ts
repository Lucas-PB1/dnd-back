import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class ClassOptionValueDto {
  @ApiProperty({ example: 'protector' })
  valueId!: string;

  @ApiProperty({ example: 'Protetor' })
  label!: string;

  @ApiProperty({ example: 1 })
  sortOrder!: number;

  @ApiPropertyOptional({
    example: 'Proficiência com armas Marciais e Armadura Pesada.',
    nullable: true,
  })
  benefit!: string | null;
}

export class ClassOptionResponseDto {
  @ApiProperty({ example: 'divineOrder' })
  optionKey!: string;

  @ApiProperty({ example: 'Ordem Divina' })
  label!: string;

  @ApiProperty({ example: 1 })
  unlockLevel!: number;

  @ApiProperty({ example: 'catalog' })
  valueType!: string;

  @ApiProperty({ type: [ClassOptionValueDto] })
  values!: ClassOptionValueDto[];
}
