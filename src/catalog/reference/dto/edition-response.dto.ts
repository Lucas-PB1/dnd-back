import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class EditionResponseDto {
  @ApiProperty({ example: 'phb-2024-pt' })
  slug!: string;

  @ApiProperty({ example: 'PHB 2024 PT-BR' })
  label!: string;

  @ApiProperty({ example: 'Livro do Jogador 2024' })
  book!: string;

  @ApiProperty({ example: 'pt-BR' })
  language!: string;

  @ApiPropertyOptional({ nullable: true })
  notes!: string | null;
}
