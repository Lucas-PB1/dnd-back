import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class SubclassMechanicResponseDto {
  @ApiProperty({ example: 'fighter' })
  classSlug!: string;

  @ApiProperty({ example: 3 })
  featureLevel!: number;

  @ApiProperty({ example: 'Atleta Extraordinário' })
  featureName!: string;

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
