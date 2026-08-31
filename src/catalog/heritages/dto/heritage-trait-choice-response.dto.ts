import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class HeritageTraitChoiceResponseDto {
  @ApiProperty({ example: 'heritage_trait_1' })
  choiceKind!: string;

  @ApiProperty({ example: 'potent-breath' })
  traitSlug!: string;

  @ApiProperty({ example: 'Potent Breath' })
  traitName!: string;

  @ApiProperty({ example: '[Combate] Potent Breath' })
  label!: string;

  @ApiPropertyOptional()
  benefitBase!: string | null;

  @ApiPropertyOptional()
  benefitImproved!: string | null;

  @ApiProperty({ example: true })
  isTraditional!: boolean;

  @ApiProperty({ example: 1 })
  sortOrder!: number;
}
