import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class SpeciesTraitResponseDto {
  @ApiProperty({ example: 'Visão no Escuro' })
  name!: string;

  @ApiProperty()
  description!: string;

  @ApiPropertyOptional({ example: 'dragon_ancestry' })
  choiceKind!: string | null;
}
