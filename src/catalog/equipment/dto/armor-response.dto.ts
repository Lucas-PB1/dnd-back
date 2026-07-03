import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class ArmorResponseDto {
  @ApiProperty({ example: 'leather-armor' })
  slug!: string;

  @ApiProperty({ example: 'Armadura de Couro' })
  name!: string;

  @ApiProperty({ example: 'light' })
  categorySlug!: string;

  @ApiProperty({ example: 'Leve' })
  categoryName!: string;

  @ApiPropertyOptional()
  donDoff!: string | null;

  @ApiPropertyOptional({ example: 11 })
  acBase!: number | null;

  @ApiPropertyOptional()
  acFormula!: string | null;

  @ApiPropertyOptional()
  strengthReq!: number | null;

  @ApiProperty()
  stealthDisadvantage!: boolean;
}
