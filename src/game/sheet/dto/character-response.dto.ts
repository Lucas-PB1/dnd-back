import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import { IsOptional, ValidateNested } from 'class-validator';
import {
  CharacterEquipmentDto,
  CharacterFeatDto,
  CharacterSpellDto,
  ClassOptionDto,
  FeatOptionDto,
  SpeciesChoiceDto,
  SubclassOptionDto,
} from './character-sheet.dto';
import { AbilityScoresDto } from './ability-scores.dto';
import { CharacterCampaignRefDto } from './character-campaign-ref.dto';
import { CoinPurseDto } from './coin-purse.dto';
import {
  EquipmentWarningResponseDto,
  WeaponAttackResponseDto,
} from './character-combat-response.dto';
import { CharacterThreadBundleDto } from './character-thread.dto';

export { AbilityScoresDto } from './ability-scores.dto';
export { CharacterCampaignRefDto } from './character-campaign-ref.dto';
export { CoinPurseDto } from './coin-purse.dto';
export {
  EquipmentWarningResponseDto,
  WeaponAttackResponseDto,
} from './character-combat-response.dto';

export class AggregatedHeritageTraitDto {
  @ApiProperty({ example: 'improved-darkvision' })
  traitSlug!: string;

  @ApiProperty({ example: 'Visão no Escuro Aprimorada' })
  traitName!: string;

  @ApiProperty({ example: 2 })
  takeCount!: number;

  @ApiProperty({ example: [1, 4] })
  slotIndexes!: number[];

  @ApiProperty({ type: [String] })
  activeBenefits!: string[];
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
    description: 'CA considerando armadura e escudo equipados no inventário',
  })
  armorClass!: number;

  @ApiProperty({
    example: 'Armadura de Couro + Escudo',
    description: 'Descrição legível da composição da CA',
  })
  armorClassNote!: string;

  @ApiProperty({ type: [WeaponAttackResponseDto] })
  weaponAttacks!: WeaponAttackResponseDto[];

  @ApiPropertyOptional({
    example: 'sabedoria',
    description: 'Atributo de conjuração da classe (phb_class_spellcasting)',
  })
  spellcastingAbilitySlug!: string | null;

  @ApiPropertyOptional({
    example: 14,
    description: 'CD de magia: 8 + PB + mod do atributo de conjuração',
  })
  spellSaveDc!: number | null;

  @ApiPropertyOptional({
    example: 6,
    description: 'Bônus de ataque mágico: PB + mod do atributo de conjuração',
  })
  spellAttackBonus!: number | null;

  @ApiProperty({ type: [EquipmentWarningResponseDto] })
  equipmentWarnings!: EquipmentWarningResponseDto[];

  @ApiProperty({
    example: false,
    description: 'True se armadura/escudo sem treino impede conjuração',
  })
  cannotCastSpellsInArmor!: boolean;

  @ApiProperty({
    example: 0,
    description: 'Penalidade de deslocamento em metros (Força < strength_req)',
    enum: [0, 3],
  })
  speedPenaltyMeters!: 0 | 3;

  @ApiProperty({
    example: 0,
    description:
      'Bônus de deslocamento em metros (itens + Movimento Rápido do Bárbaro)',
  })
  itemSpeedBonusMeters!: number;

  @ApiProperty({
    type: [String],
    example: ['Sentido de Perigo: Vantagem em salvaguardas de Destreza'],
    description: 'Notas de combate de classe (Bárbaro, Guerreiro etc.)',
  })
  classCombatNotes!: string[];

  @ApiProperty({
    example: 2,
    description: 'Ataques por Ação Atacar (Ataque Extra do Guerreiro)',
  })
  attacksPerAction!: number;

  @ApiProperty({
    example: 3,
    description:
      'Bônus de salvaguarda de auras/features de classe (ex.: Aura de Proteção). 0 se não houver. Front não recalcula.',
  })
  savingThrowAuraBonus!: number;

  @ApiProperty({ type: [CharacterCampaignRefDto] })
  campaigns!: CharacterCampaignRefDto[];

  @ApiProperty({ type: CoinPurseDto, description: 'Saldo das 5 moedas D&D' })
  coins!: CoinPurseDto;

  @ApiPropertyOptional({
    type: CharacterThreadBundleDto,
    description: 'Character Thread ativo + histórico (Northlands)',
  })
  thread!: CharacterThreadBundleDto | null;
}

/** Resumo para GET /characters — sem sheet/combat/magias. */
export class CharacterSummaryResponseDto {
  @ApiProperty({ format: 'uuid' })
  id!: string;

  @ApiProperty({ example: 'Thorin' })
  name!: string;

  @ApiProperty({ example: 1 })
  level!: number;

  @ApiProperty({ example: 'fighter' })
  classSlug!: string;

  @ApiProperty({ example: 'Guerreiro' })
  className!: string;

  @ApiPropertyOptional({ example: 'dwarf', nullable: true })
  speciesSlug!: string | null;

  @ApiPropertyOptional({ example: 'gh-dwarf', nullable: true })
  heritageSlug!: string | null;

  @ApiProperty({ example: 'Anão' })
  speciesName!: string;

  @ApiProperty({ example: 'acolyte' })
  backgroundSlug!: string;

  @ApiPropertyOptional({ example: 'champion' })
  subclassSlug!: string | null;

  @ApiPropertyOptional({ example: 'Campeão', nullable: true })
  subclassName!: string | null;

  @ApiProperty()
  createdAt!: string;

  @ApiProperty()
  updatedAt!: string;

  @ApiProperty({ type: [CharacterCampaignRefDto] })
  campaigns!: CharacterCampaignRefDto[];
}
