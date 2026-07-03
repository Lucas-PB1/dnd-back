import { ApiProperty } from '@nestjs/swagger';

export class ClassSpellResponseDto {
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
}
