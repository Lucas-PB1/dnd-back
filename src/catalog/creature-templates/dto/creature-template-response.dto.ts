import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class CreatureTemplateSummaryResponseDto {
  @ApiProperty({ example: 'goblin' })
  slug!: string;

  @ApiProperty({ example: 'Goblin' })
  name!: string;

  @ApiProperty({ example: 'phb-2024-pt' })
  editionSlug!: string;

  @ApiProperty({ example: 'Humanoid' })
  creatureType!: string;

  @ApiPropertyOptional({ example: 'small' })
  sizeSlug!: string | null;

  @ApiPropertyOptional({ example: '1/4' })
  challengeRating!: string | null;

  @ApiPropertyOptional({ example: 15 })
  armorClass!: number | null;

  @ApiPropertyOptional({ example: 7 })
  hitPointsAvg!: number | null;

  @ApiPropertyOptional({
    example: '/catalog/mounts/camelo.png',
    nullable: true,
    description: 'Caminho público da ilustração no front',
  })
  imageUrl!: string | null;
}

export class CreatureTemplateSpeedDto {
  @ApiProperty()
  movementKind!: string;

  @ApiProperty()
  speedFt!: number;
}

export class CreatureTemplateActionDto {
  @ApiProperty()
  id!: number;

  @ApiProperty()
  name!: string;

  @ApiProperty()
  actionBucket!: string;

  @ApiPropertyOptional({ nullable: true })
  attackBonus!: number | null;

  @ApiPropertyOptional({ nullable: true })
  damageExpression!: string | null;

  @ApiPropertyOptional({ nullable: true })
  reachFt!: number | null;

  @ApiPropertyOptional({ nullable: true })
  description!: string | null;

  @ApiProperty()
  sortOrder!: number;
}

export class CreatureTemplateSpellDto {
  @ApiProperty()
  spellSlug!: string;

  @ApiProperty()
  usageKind!: string;

  @ApiPropertyOptional({ nullable: true })
  usesPerDay!: number | null;

  @ApiPropertyOptional({ nullable: true })
  slotLevel!: number | null;

  @ApiPropertyOptional({ nullable: true })
  rechargeDice!: string | null;

  @ApiProperty()
  sortOrder!: number;
}

export class CreatureTemplateTraitDto {
  @ApiProperty()
  name!: string;

  @ApiProperty()
  description!: string;

  @ApiProperty()
  sortOrder!: number;
}

export class CreatureTemplateResponseDto extends CreatureTemplateSummaryResponseDto {
  @ApiPropertyOptional({ nullable: true })
  subtitle!: string | null;

  @ApiPropertyOptional({ nullable: true })
  alignment!: string | null;

  @ApiPropertyOptional({ nullable: true })
  initiativeModifier!: number | null;

  @ApiPropertyOptional({ nullable: true })
  abilityScores!: Record<string, number> | null;

  @ApiPropertyOptional({ nullable: true })
  creatureSubtype!: string | null;

  @ApiPropertyOptional({ nullable: true })
  proficiencyBonus!: number | null;

  @ApiPropertyOptional({ nullable: true })
  hitPointsFormula!: string | null;

  @ApiPropertyOptional({ nullable: true })
  spellcastingAbilitySlug!: string | null;

  @ApiPropertyOptional({ nullable: true })
  spellSaveDc!: number | null;

  @ApiPropertyOptional({ nullable: true })
  spellAttackBonus!: number | null;

  @ApiProperty({ type: [CreatureTemplateSpeedDto] })
  speeds!: CreatureTemplateSpeedDto[];

  @ApiProperty({ type: [CreatureTemplateActionDto] })
  actions!: CreatureTemplateActionDto[];

  @ApiProperty({ type: [CreatureTemplateSpellDto] })
  spells!: CreatureTemplateSpellDto[];

  @ApiProperty({ type: [CreatureTemplateTraitDto] })
  traits!: CreatureTemplateTraitDto[];
}
