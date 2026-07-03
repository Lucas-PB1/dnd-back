import { ApiProperty } from '@nestjs/swagger';

export class ClassSpellSlotsResponseDto {
  @ApiProperty({ example: 5 })
  classLevel!: number;

  @ApiProperty({ example: 'full-caster' })
  patternSlug!: string;

  @ApiProperty({ example: 'Conjurador completo' })
  patternName!: string;

  @ApiProperty({
    example: { '1': 4, '2': 3, '3': 2 },
    description: 'Spell slots by circle (key = circle, value = count)',
  })
  spellSlots!: Record<string, number>;
}
