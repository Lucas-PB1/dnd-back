import { ApiProperty } from '@nestjs/swagger';

/** Listagem leve (`fields=summary`) — labels sem description/higherLevels. */
export class SpellSummaryResponseDto {
  @ApiProperty({ example: 'alarme' })
  slug!: string;

  @ApiProperty({ example: 'Alarme' })
  name!: string;

  @ApiProperty({ example: 1 })
  level!: number;

  @ApiProperty({ example: 'abjuracao' })
  schoolSlug!: string;

  @ApiProperty({ example: 'Abjuração' })
  schoolName!: string;

  @ApiProperty()
  ritual!: boolean;
}
