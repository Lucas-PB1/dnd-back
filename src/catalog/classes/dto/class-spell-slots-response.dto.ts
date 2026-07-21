import { ApiProperty } from '@nestjs/swagger';

export class ClassSpellSlotsResponseDto {
  @ApiProperty({ example: 5 })
  classLevel!: number;

  @ApiProperty({ example: 'full-caster' })
  patternSlug!: string;

  @ApiProperty({ example: 'Conjurador completo' })
  patternName!: string;

  @ApiProperty({ example: 2 })
  proficiencyBonus!: number;

  @ApiProperty({ example: 4, nullable: true })
  cantrips!: number | null;

  @ApiProperty({
    example: 2,
    nullable: true,
    description: 'Truques ou magias conhecidas/preparadas conforme a classe',
  })
  preparedSpells!: number | null;

  @ApiProperty({ example: null, nullable: true })
  channelDivinity!: number | null;

  @ApiProperty({
    example: { '1': 4, '2': 3, '3': 2 },
    description: 'Spell slots by circle (key = circle, value = count)',
  })
  spellSlots!: Record<string, number>;
}
