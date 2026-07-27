import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class SubclassSpellSlotsResponseDto {
  @ApiProperty({ example: 3 })
  classLevel!: number;

  @ApiProperty({ example: 'third' })
  patternSlug!: string;

  @ApiProperty({ example: 'Conjurador de um terço' })
  patternName!: string;

  @ApiProperty({ example: 2 })
  proficiencyBonus!: number;

  @ApiProperty({ example: 2, nullable: true })
  cantrips!: number | null;

  @ApiProperty({ example: 3, nullable: true })
  preparedSpells!: number | null;

  @ApiProperty({
    example: 'wizard',
    description: 'Classe cuja lista de magias a subclasse usa',
  })
  spellListClassSlug!: string;

  @ApiProperty({
    example: { '1': 2 },
    description: 'Spell slots by circle (key = circle, value = count)',
  })
  spellSlots!: Record<string, number>;
}

export class SubclassSpellcastingResponseDto {
  @ApiProperty({ example: 'spellslinger' })
  subclassSlug!: string;

  @ApiProperty({ example: 'third' })
  castingType!: string;

  @ApiPropertyOptional({ example: 'inteligencia' })
  abilitySlug!: string | null;

  @ApiPropertyOptional({ example: 'Arcane Focus or a Ranged weapon' })
  focusLabel!: string | null;

  @ApiProperty({ example: 'wizard' })
  spellListClassSlug!: string;

  @ApiProperty({ example: 'third' })
  spellSlotPatternSlug!: string;

  @ApiProperty({ example: false })
  ritual!: boolean;

  @ApiProperty({
    example: 'prepared',
    description: 'Modo de preparação na UI (prepared | known | wizard)',
  })
  spellcastingMode!: 'prepared' | 'known' | 'wizard';
}
