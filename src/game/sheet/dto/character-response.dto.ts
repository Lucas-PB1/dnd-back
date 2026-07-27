import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import { IsInt, IsOptional, Max, Min, ValidateNested } from 'class-validator';
import {
  CharacterEquipmentDto,
  CharacterFeatDto,
  CharacterSpellDto,
  ClassOptionDto,
  FeatOptionDto,
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

export class CharacterCampaignRefDto {
  @ApiProperty({ format: 'uuid' })
  id!: string;

  @ApiProperty({ example: 'Ruínas de Shadowdale' })
  name!: string;
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

  @ApiProperty({
    type: 'array',
    description: 'Ataques passivos das armas equipadas (main_hand / off_hand)',
    example: [
      {
        itemSlug: 'longsword',
        itemName: 'Espada Longa',
        mode: 'melee',
        attackBonus: 5,
        abilitySlug: 'forca',
        proficient: true,
        damageDice: '1d10',
        damageBonus: 3,
        damageType: 'Cortante',
        attackNote: 'corpo a corpo: FOR + PB · versátil (2 mãos)',
        damageNote: '1d10 +3 (FOR)',
        role: 'main',
        attackDisadvantage: false,
        omitsAbilityDamage: false,
        greatWeaponFighting: false,
        masteryActive: true,
        masterySlug: 'sap',
        masteryName: 'Drenar',
        nickUsesAttackAction: false,
        grazeOnMissDamage: null,
      },
    ],
  })
  weaponAttacks!: Array<{
    itemSlug: string;
    itemName: string;
    mode: 'melee' | 'ranged';
    attackBonus: number;
    abilitySlug: 'forca' | 'destreza';
    proficient: boolean;
    damageDice: string;
    damageBonus: number;
    damageType: string | null;
    attackNote: string;
    damageNote: string;
    role: 'main' | 'light_bonus' | 'dual_bonus';
    attackDisadvantage: boolean;
    omitsAbilityDamage: boolean;
    greatWeaponFighting: boolean;
    masteryActive: boolean;
    masterySlug: string | null;
    masteryName: string | null;
    nickUsesAttackAction: boolean;
    grazeOnMissDamage: number | null;
  }>;

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

  @ApiProperty({
    type: 'array',
    description: 'Avisos de conformidade de equipamento (treino, Força, dual wield, etc.)',
    example: [
      {
        code: 'lacks_armor_training',
        message: 'Sem treino com Cota de Malha…',
        itemSlug: 'chain-mail',
      },
    ],
  })
  equipmentWarnings!: Array<{
    code: string;
    message: string;
    itemSlug?: string;
  }>;

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
    type: [CharacterCampaignRefDto],
    description: 'Campanhas em que o personagem está vinculado',
  })
  campaigns!: CharacterCampaignRefDto[];
}
