import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class EffectSummaryResponseDto {
  @ApiProperty({ example: '1' })
  id!: string;

  @ApiProperty({ example: 'damage_die_floor' })
  kind!: string;

  @ApiProperty({ example: 'passive' })
  trigger!: string;

  @ApiPropertyOptional({ example: 'Piso elemental', nullable: true })
  label!: string | null;

  @ApiPropertyOptional({
    example: 'Faces 1 viram 2 nos dados de dano do tipo escolhido.',
    nullable: true,
  })
  note!: string | null;

  @ApiProperty({ example: 1 })
  unlockLevel!: number;

  @ApiProperty({ example: 1 })
  sortOrder!: number;
}
