import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class SkillResponseDto {
  @ApiProperty({ example: 'athletics' })
  slug!: string;

  @ApiProperty({ example: 'Atletismo' })
  name!: string;

  @ApiProperty({ example: 'forca' })
  abilitySlug!: string;

  @ApiProperty({ example: 'Força' })
  abilityName!: string;

  @ApiPropertyOptional()
  description!: string | null;
}
