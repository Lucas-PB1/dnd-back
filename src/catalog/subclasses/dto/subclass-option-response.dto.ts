import { ApiProperty } from '@nestjs/swagger';

export class SubclassOptionValueDto {
  @ApiProperty({ example: 'archery' })
  valueId!: string;

  @ApiProperty({ example: 'Arqueria' })
  label!: string;

  @ApiProperty({ example: 1 })
  sortOrder!: number;
}

export class SubclassOptionResponseDto {
  @ApiProperty({ example: 'additionalFightingStyle' })
  optionKey!: string;

  @ApiProperty({ example: 'Estilo de Luta Adicional' })
  label!: string;

  @ApiProperty({ example: 7 })
  unlockLevel!: number;

  @ApiProperty({ type: [SubclassOptionValueDto] })
  values!: SubclassOptionValueDto[];
}
