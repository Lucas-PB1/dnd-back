import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class SpeciesTraitChoiceResponseDto {
  @ApiProperty({ example: 'Herança Dracônica' })
  traitName!: string;

  @ApiProperty({ example: 'dragon_ancestry' })
  choiceKind!: string;

  @ApiProperty({ example: 'black-dragon' })
  choiceSlug!: string;

  @ApiProperty({ example: 'Dragão Negro' })
  choiceName!: string;

  @ApiPropertyOptional()
  level1Benefit!: string | null;

  @ApiPropertyOptional()
  spellLevel3Slug!: string | null;

  @ApiPropertyOptional()
  spellLevel5Slug!: string | null;

  @ApiPropertyOptional()
  damageType!: string | null;
}
