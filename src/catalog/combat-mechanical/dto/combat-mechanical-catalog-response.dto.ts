import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class CunningStrikeEffectDto {
  @ApiProperty({ example: 'poison' })
  slug!: string;

  @ApiProperty({ example: 'Envenenar' })
  name!: string;

  @ApiProperty({ example: 1 })
  cost!: number;

  @ApiProperty({ example: 5 })
  unlockLevel!: number;

  @ApiPropertyOptional({ example: 'constitution' })
  saveAbility?: string;

  @ApiPropertyOptional({ example: 'thief' })
  subclassSlug?: string;

  @ApiProperty({ example: 'Requer Kit de Veneno…' })
  note!: string;
}

export class PersonaMaskDto {
  @ApiProperty({ example: 'persona-mask-jester' })
  slug!: string;

  @ApiProperty({ example: 'Bobão' })
  name!: string;
}

export class PrecautionSpellDto {
  @ApiProperty({ example: 'alarme' })
  slug!: string;

  @ApiProperty({ example: 'Alarme' })
  name!: string;
}

export class GunslingerManeuverDto {
  @ApiProperty()
  slug!: string;

  @ApiProperty()
  name!: string;

  @ApiProperty()
  description!: string;

  @ApiProperty()
  effectKind!: string;

  @ApiProperty()
  riskCost!: number;

  @ApiProperty()
  fromLevel!: number;

  @ApiPropertyOptional()
  subclassSlug?: string;
}

export class BattleMasterManeuverDto {
  @ApiProperty()
  slug!: string;

  @ApiProperty()
  name!: string;

  @ApiProperty()
  description!: string;

  @ApiProperty()
  timing!: string;

  @ApiProperty()
  addsToDamage!: boolean;

  @ApiProperty()
  addsToAttack!: boolean;
}

export class SubclassTableActionDto {
  @ApiProperty()
  subclassSlug!: string;

  @ApiProperty()
  slug!: string;

  @ApiProperty()
  name!: string;

  @ApiProperty()
  unlockLevel!: number;

  @ApiPropertyOptional()
  freeResourceSlug?: string;

  @ApiProperty()
  alwaysSpendsPool!: boolean;

  @ApiProperty()
  rollsPoolDie!: boolean;

  @ApiProperty()
  spendsOnlyOnSuccess!: boolean;

  @ApiPropertyOptional()
  alwaysPoolCost?: number;

  @ApiPropertyOptional()
  repeatPoolCost?: number;
}

export class BeastborneAspectBenefitDto {
  @ApiProperty()
  level!: number;

  @ApiProperty()
  note!: string;
}

export class ClassEconomyActionDto {
  @ApiProperty({ example: 'fighter-second-wind' })
  id!: string;

  @ApiProperty({ example: 'Recuperar Fôlego' })
  name!: string;

  @ApiProperty({ example: 'bonus' })
  economy!: string;

  @ApiPropertyOptional({ example: 'fighter', nullable: true })
  classSlug?: string | null;

  @ApiProperty({ example: 1 })
  minLevel!: number;

  @ApiPropertyOptional({ example: 'psi-warrior' })
  subclassSlug?: string;

  @ApiPropertyOptional({ example: 'dwarf', nullable: true })
  speciesSlug?: string | null;

  @ApiPropertyOptional({ example: 'lucky', nullable: true })
  featSlug?: string | null;

  @ApiPropertyOptional({ example: 'ring-of-barrels', nullable: true })
  itemSlug?: string | null;

  @ApiPropertyOptional({ example: 'giantAncestryId' })
  requiresOptionKey?: string;

  @ApiPropertyOptional({ example: 'cloud' })
  requiresOptionValue?: string;

  @ApiPropertyOptional({ example: 'secondWind' })
  resourceSlug?: string;

  @ApiPropertyOptional()
  freeResourceSlug?: string;

  @ApiPropertyOptional()
  alwaysSpendsResource?: boolean;

  @ApiPropertyOptional()
  summary?: string;

  @ApiPropertyOptional()
  description?: string;

  @ApiPropertyOptional({ example: 'second-wind' })
  tableAction?: string;

  @ApiPropertyOptional()
  spendAmount?: number;
}

export class ClassPanelActionDto {
  @ApiProperty({ example: 'bard|grant-inspiration' })
  panelKey!: string;

  @ApiProperty({ example: 'bard' })
  classSlug!: string;

  @ApiPropertyOptional({ example: 'lore' })
  subclassSlug?: string;

  @ApiProperty({ example: 'grant-inspiration' })
  slug!: string;

  @ApiProperty({ example: 'Conceder Inspiração' })
  name!: string;

  @ApiPropertyOptional()
  title?: string;

  @ApiProperty({ example: 1 })
  minLevel!: number;

  @ApiPropertyOptional({ example: 'bardicInspiration' })
  resourceSlug?: string;

  @ApiProperty({ example: 'base' })
  section!: string;

  @ApiProperty()
  spendsFocus!: boolean;

  @ApiProperty()
  sortOrder!: number;
}

/** Resposta pública do catálogo mecânico de combate (SSOT no schema `rpg`). */
export class CombatMechanicalCatalogResponseDto {
  @ApiProperty({ type: [GunslingerManeuverDto] })
  gunslingerManeuvers!: GunslingerManeuverDto[];

  @ApiProperty({ type: [BattleMasterManeuverDto] })
  battleMasterManeuvers!: BattleMasterManeuverDto[];

  @ApiProperty({ type: [CunningStrikeEffectDto] })
  cunningStrikeEffects!: CunningStrikeEffectDto[];

  @ApiProperty({ type: [SubclassTableActionDto] })
  tableActions!: SubclassTableActionDto[];

  @ApiProperty({ type: [PersonaMaskDto] })
  personaMasks!: PersonaMaskDto[];

  @ApiProperty({ type: [BeastborneAspectBenefitDto] })
  beastborneAspectBenefits!: BeastborneAspectBenefitDto[];

  @ApiProperty({ type: [String], example: ['Aberração', 'Besta'] })
  dungeoneerSlayerLabels!: string[];

  @ApiProperty({ type: [PrecautionSpellDto] })
  precautionSpells!: PrecautionSpellDto[];

  @ApiProperty({ type: [ClassEconomyActionDto] })
  economyActions!: ClassEconomyActionDto[];

  @ApiProperty({ type: [ClassPanelActionDto] })
  panelActions!: ClassPanelActionDto[];
}
