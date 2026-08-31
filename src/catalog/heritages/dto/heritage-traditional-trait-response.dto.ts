import { ApiProperty } from '@nestjs/swagger';

export class HeritageTraditionalTraitResponseDto {
  @ApiProperty({ example: 'potent-breath' })
  traitSlug!: string;

  @ApiProperty({ example: 'Sopro Potente' })
  traitName!: string;

  @ApiProperty({ example: 'combat' })
  category!: string;

  @ApiProperty({ example: 'combat' })
  categoryHint!: string;

  @ApiProperty({ example: 1 })
  sortOrder!: number;
}
