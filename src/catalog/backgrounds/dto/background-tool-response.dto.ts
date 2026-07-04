import { ApiProperty } from '@nestjs/swagger';

export class BackgroundToolResponseDto {
  @ApiProperty({ example: 'ferramentas-de-carpinteiro' })
  itemSlug!: string;

  @ApiProperty({ example: 'Ferramentas de Carpinteiro' })
  itemName!: string;

  @ApiProperty({ example: 'artisan' })
  categorySlug!: string;

  @ApiProperty({ example: 'Ferramentas de Artesão' })
  categoryName!: string;
}
