import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class HeritageTraitResponseDto {
  @ApiProperty({ example: 'battlefield-dominance' })
  slug!: string;

  @ApiProperty({ example: 'Domínio do Campo de Batalha' })
  name!: string;

  @ApiProperty({ enum: ['combat', 'exploration', 'roleplaying'], example: 'combat' })
  category!: string;

  @ApiProperty()
  description!: string;

  @ApiPropertyOptional()
  benefitBase!: string | null;

  @ApiPropertyOptional()
  benefitImproved!: string | null;
}
