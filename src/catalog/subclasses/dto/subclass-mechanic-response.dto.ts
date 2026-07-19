import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class SubclassMechanicResponseDto {
  @ApiProperty({ example: 'fighter' })
  classSlug!: string;

  @ApiProperty({ example: 3 })
  featureLevel!: number;

  @ApiProperty({ example: 'Crítico Aprimorado' })
  featureName!: string;

  @ApiProperty({
    example:
      'Seus ataques com armas e Desarmados podem marcar um sucesso crítico em um 19 ou 20 no d20.',
  })
  featureDescription!: string;

  @ApiPropertyOptional({ example: 'passive' })
  featureKind!: string | null;

  @ApiPropertyOptional({ example: 'wildRageAspect' })
  optionKey!: string | null;

  @ApiPropertyOptional({ example: 'rage' })
  resourceSlug!: string | null;

  @ApiPropertyOptional({ example: 'Fúria' })
  resourceName!: string | null;

  @ApiPropertyOptional({ example: 3 })
  resourceUnlockLevel!: number | null;

  @ApiPropertyOptional({ example: 'proficiency_bonus' })
  maxFormula!: string | null;

  @ApiPropertyOptional({ example: 2 })
  fixedMax!: number | null;
}
