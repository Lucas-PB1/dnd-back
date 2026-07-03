import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class CharacterLevelResponseDto {
  @ApiProperty({ example: 1 })
  level!: number;

  @ApiProperty({ example: 2 })
  proficiencyBonus!: number;

  @ApiPropertyOptional({ example: 0 })
  xpThreshold!: number | null;
}
