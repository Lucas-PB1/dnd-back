import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import {
  CharacterEquipmentDto,
  CharacterFeatDto,
  CharacterSpellDto,
  CharacterTransformationDto,
  ClassOptionDto,
  FeatOptionDto,
  SpeciesChoiceDto,
  SubclassOptionDto,
} from '../character-sheet.dto';
import { AbilityScoresDto } from '../ability-scores.dto';
import { AggregatedHeritageTraitDto } from './heritage-trait.dto';

/** Identidade, opções de ficha e antecedentes — base de CharacterResponseDto. */
export class CharacterIdentityResponseDto {
  @ApiProperty({ format: 'uuid' })
  id!: string;

  @ApiProperty({ example: 'Thorin' })
  name!: string;

  @ApiProperty({ example: 1 })
  level!: number;

  @ApiProperty({ example: 'fighter' })
  classSlug!: string;

  @ApiPropertyOptional({ example: 'dwarf', nullable: true })
  speciesSlug!: string | null;

  @ApiPropertyOptional({ example: 'gh-dwarf', nullable: true })
  heritageSlug!: string | null;

  @ApiProperty({ example: 'acolyte' })
  backgroundSlug!: string;

  @ApiPropertyOptional({ example: 'champion' })
  subclassSlug!: string | null;

  @ApiPropertyOptional({ example: 'lawful-good' })
  alignmentSlug!: string | null;

  @ApiProperty({ type: AbilityScoresDto })
  abilityScores!: AbilityScoresDto;

  @ApiProperty({
    type: AbilityScoresDto,
    description:
      'Atributos após aumentos permanentes de classe (ex.: nível 20). Iguais a abilityScores quando não há aumento.',
  })
  effectiveAbilityScores!: AbilityScoresDto;

  @ApiPropertyOptional()
  hitPointsMax!: number | null;

  @ApiPropertyOptional()
  hitPointsCurrent!: number | null;

  @ApiPropertyOptional({
    nullable: true,
    description: 'URL pública do retrato do personagem (Supabase storage)',
  })
  portraitUrl!: string | null;

  @ApiProperty({ example: 2, description: 'Proficiency bonus from PHB character level table' })
  proficiencyBonus!: number;

  @ApiProperty({
    example: ['athletics', 'perception'],
    description: 'Perícias escolhidas da pool da classe',
  })
  classSkillSlugs!: string[];

  @ApiProperty({ type: [SpeciesChoiceDto] })
  speciesChoices!: SpeciesChoiceDto[];

  @ApiProperty({ type: [SpeciesChoiceDto] })
  heritageChoices!: SpeciesChoiceDto[];

  @ApiPropertyOptional({
    type: CharacterTransformationDto,
    nullable: true,
    description: 'Transformação GH Cap. 6 ativa; null se ausente',
  })
  transformation!: CharacterTransformationDto | null;

  @ApiPropertyOptional({ type: [AggregatedHeritageTraitDto] })
  aggregatedHeritageTraits?: AggregatedHeritageTraitDto[];

  @ApiProperty({ type: [SubclassOptionDto] })
  subclassOptions!: SubclassOptionDto[];

  @ApiProperty({ type: [ClassOptionDto] })
  classOptions!: ClassOptionDto[];

  @ApiProperty({ type: [CharacterFeatDto] })
  characterFeats!: CharacterFeatDto[];

  @ApiProperty({ type: [FeatOptionDto] })
  featOptions!: FeatOptionDto[];

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

  @ApiPropertyOptional({
    enum: ['plus2plus1', 'plus1x3'],
    example: 'plus2plus1',
  })
  backgroundAbilityBoostMode!: 'plus2plus1' | 'plus1x3';

  @ApiPropertyOptional({ example: 'sabedoria' })
  backgroundAbilityBoostPlus2Slug!: string | null;

  @ApiPropertyOptional({ example: 'carisma' })
  backgroundAbilityBoostPlus1Slug!: string | null;

  @ApiPropertyOptional({
    example: ['sabedoria', 'carisma', 'inteligencia'],
    description: 'Preenchido quando mode = plus1x3',
  })
  backgroundAbilityBoostPlus1Slugs!: string[] | null;

  @ApiPropertyOptional({
    example: 'ferramentas-de-cartografo',
    description: 'Ferramenta do antecedente (fixa ou escolhida)',
  })
  backgroundToolItemSlug!: string | null;

  @ApiProperty()
  createdAt!: string;

  @ApiProperty()
  updatedAt!: string;
}
