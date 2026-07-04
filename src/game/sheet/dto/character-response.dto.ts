import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import { IsInt, IsOptional, Max, Min, ValidateNested } from 'class-validator';
import {
  CharacterEquipmentDto,
  CharacterSpellDto,
  SpeciesChoiceDto,
  SubclassOptionDto,
} from './character-sheet.dto';

export class AbilityScoresDto {
  @ApiProperty({ example: 15 })
  @IsInt()
  @Min(1)
  @Max(30)
  forca!: number;

  @ApiProperty({ example: 14 })
  @IsInt()
  @Min(1)
  @Max(30)
  destreza!: number;

  @ApiProperty({ example: 13 })
  @IsInt()
  @Min(1)
  @Max(30)
  constituicao!: number;

  @ApiProperty({ example: 10 })
  @IsInt()
  @Min(1)
  @Max(30)
  inteligencia!: number;

  @ApiProperty({ example: 12 })
  @IsInt()
  @Min(1)
  @Max(30)
  sabedoria!: number;

  @ApiProperty({ example: 8 })
  @IsInt()
  @Min(1)
  @Max(30)
  carisma!: number;
}

export class CharacterResponseDto {
  @ApiProperty({ format: 'uuid' })
  id!: string;

  @ApiProperty({ example: 'Thorin' })
  name!: string;

  @ApiProperty({ example: 1 })
  level!: number;

  @ApiProperty({ example: 'fighter' })
  classSlug!: string;

  @ApiProperty({ example: 'dwarf' })
  speciesSlug!: string;

  @ApiProperty({ example: 'acolyte' })
  backgroundSlug!: string;

  @ApiPropertyOptional({ example: 'champion' })
  subclassSlug!: string | null;

  @ApiPropertyOptional({ example: 'lawful-good' })
  alignmentSlug!: string | null;

  @ApiProperty({ type: AbilityScoresDto })
  abilityScores!: AbilityScoresDto;

  @ApiPropertyOptional()
  hitPointsMax!: number | null;

  @ApiPropertyOptional()
  hitPointsCurrent!: number | null;

  @ApiProperty({ example: 2, description: 'Proficiency bonus from PHB character level table' })
  proficiencyBonus!: number;

  @ApiProperty({
    example: ['athletics', 'perception'],
    description: 'Perícias escolhidas da pool da classe',
  })
  classSkillSlugs!: string[];

  @ApiProperty({ type: [SpeciesChoiceDto] })
  speciesChoices!: SpeciesChoiceDto[];

  @ApiProperty({ type: [SubclassOptionDto] })
  subclassOptions!: SubclassOptionDto[];

  @ApiProperty({ example: ['magic-initiate'] })
  featSlugs!: string[];

  @ApiProperty({ type: [CharacterSpellDto] })
  characterSpells!: CharacterSpellDto[];

  @ApiProperty({ type: [CharacterEquipmentDto] })
  equipment!: CharacterEquipmentDto[];

  @ApiProperty({ example: ['common'] })
  languageSlugs!: string[];

  @ApiPropertyOptional({ example: 'standard-array' })
  abilityGenerationMethodSlug!: string | null;

  @ApiProperty({
    example: ['insight', 'religion'],
    description: 'Perícias fixas do antecedente (derivado do catálogo)',
  })
  backgroundSkillSlugs!: string[];

  @ApiProperty()
  createdAt!: string;

  @ApiProperty()
  updatedAt!: string;

  @ApiProperty({
    example: { forca: 2, destreza: 1, constituicao: 0, inteligencia: 0, sabedoria: 1, carisma: -1 },
    description: 'Modificadores derivados dos abilityScores',
  })
  abilityModifiers!: AbilityScoresDto;

  @ApiProperty({
    example: 13,
    description: '10 + mod Sab + PB se proficiente em Percepção',
  })
  passivePerception!: number;

  @ApiProperty({
    example: 12,
    description: 'CA base sem armadura (10 + mod Des)',
  })
  armorClass!: number;
}
