import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

/** Listagem leve (`fields=summary`) — labels sem description/higherLevels. */
export class SpellSummaryResponseDto {
  @ApiProperty({ example: 'alarme' })
  slug!: string;

  @ApiProperty({ example: 'Alarme' })
  name!: string;

  @ApiProperty({ example: 1 })
  level!: number;

  @ApiPropertyOptional({ example: '1º Círculo' })
  levelLabel!: string | null;

  @ApiProperty({ example: 'abjuracao' })
  schoolSlug!: string;

  @ApiProperty({ example: 'Abjuração' })
  schoolName!: string;

  @ApiPropertyOptional({ example: '1 minuto' })
  castingTime!: string | null;

  @ApiPropertyOptional({ example: '9 m' })
  range!: string | null;

  @ApiProperty()
  ritual!: boolean;

  @ApiProperty()
  concentration!: boolean;

  @ApiPropertyOptional()
  editionSlug!: string | null;

  @ApiPropertyOptional()
  saveAbilitySlug!: string | null;

  @ApiProperty()
  requiresAttackRoll!: boolean;
}
