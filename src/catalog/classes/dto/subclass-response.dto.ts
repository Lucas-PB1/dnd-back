import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class SubclassResponseDto {
  @ApiProperty({ example: 'champion' })
  slug!: string;

  @ApiProperty({ example: 'Campeão' })
  name!: string;

  @ApiProperty({ example: 'fighter' })
  classSlug!: string;

  @ApiProperty({ example: 'Guerreiro' })
  className!: string;

  @ApiPropertyOptional({ example: 'Busque o auge da proeza no combate' })
  tagline!: string | null;

  @ApiPropertyOptional()
  summary!: string | null;

  @ApiPropertyOptional()
  sourceChapter!: number | null;

  @ApiPropertyOptional()
  editionSlug!: string | null;

  @ApiPropertyOptional()
  spellSourceSlug!: string | null;

  @ApiPropertyOptional()
  spellSourceLabel!: string | null;
}
