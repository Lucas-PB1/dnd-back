import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class ClassProgressionResponseDto {
  @ApiProperty({ example: 5 })
  level!: number;

  @ApiProperty({ example: 3 })
  proficiencyBonus!: number;

  @ApiPropertyOptional({ example: 3, nullable: true })
  cantrips!: number | null;

  @ApiPropertyOptional({
    example: 6,
    nullable: true,
    description: 'Cota de truques/conhecidas ou preparadas conforme a classe',
  })
  preparedSpells!: number | null;

  @ApiPropertyOptional({ example: 2, nullable: true })
  channelDivinity!: number | null;
}
