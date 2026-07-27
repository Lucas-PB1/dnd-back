import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class SpellResponseDto {
  @ApiProperty({ example: 'alarme' })
  slug!: string;

  @ApiProperty({ example: 'Alarme' })
  name!: string;

  @ApiProperty({ example: 1 })
  level!: number;

  @ApiProperty({ example: '1º Círculo' })
  levelLabel!: string;

  @ApiProperty({ example: 'abjuracao' })
  schoolSlug!: string;

  @ApiProperty({ example: 'Abjuração' })
  schoolName!: string;

  @ApiProperty()
  castingTime!: string;

  @ApiProperty()
  range!: string;

  @ApiProperty()
  hasVerbal!: boolean;

  @ApiProperty()
  hasSomatic!: boolean;

  @ApiProperty()
  hasMaterial!: boolean;

  @ApiPropertyOptional()
  materialDescription!: string | null;

  @ApiPropertyOptional()
  componentsLabel!: string | null;

  @ApiProperty()
  duration!: string;

  @ApiProperty()
  concentration!: boolean;

  @ApiProperty()
  ritual!: boolean;

  @ApiProperty()
  description!: string;

  @ApiPropertyOptional()
  higherLevels!: string | null;

  @ApiPropertyOptional()
  sourceChapter!: number | null;

  @ApiPropertyOptional()
  editionSlug!: string | null;

  @ApiPropertyOptional({
    description: 'Atributo da salvaguarda principal, se a magia pedir teste',
    example: 'sabedoria',
  })
  saveAbilitySlug!: string | null;

  @ApiProperty({
    description: 'True se a magia pede jogada de ataque mágico',
  })
  requiresAttackRoll!: boolean;
}
