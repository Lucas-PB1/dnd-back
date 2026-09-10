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

export class StrikeOptionDto {
  @ApiProperty({ example: 'hunting-strike' })
  slug!: string;

  @ApiProperty({ example: 'Golpe da Caça' })
  name!: string;

  @ApiPropertyOptional({ example: 'blood-hound' })
  subclassSlug?: string;

  @ApiPropertyOptional({ example: 'blood-strike' })
  resourceSlug?: string | null;

  @ApiPropertyOptional({ example: 'blood-strike' })
  tableAction?: string | null;

  @ApiPropertyOptional({ example: '1d4' })
  costDice?: string | null;

  @ApiProperty({ example: '1d6' })
  extraDice!: string;

  @ApiProperty({ example: '3d6' })
  extraDiceL18!: string;

  @ApiPropertyOptional({ example: 'slashing' })
  damageType?: string | null;

  @ApiPropertyOptional({ example: 'constituicao' })
  saveAbility?: string | null;

  @ApiPropertyOptional()
  onFailCondition?: string | null;

  @ApiPropertyOptional()
  onFailPendingKind?: string | null;

  @ApiPropertyOptional()
  onHitPendingKind?: string | null;

  @ApiProperty()
  replacesAttackWithSave!: boolean;

  @ApiPropertyOptional()
  secondaryDice?: string | null;

  @ApiPropertyOptional()
  secondaryDiceL18?: string | null;

  @ApiProperty()
  ignoreTargetArmor!: boolean;

  @ApiProperty()
  ignoreDamageResistance!: boolean;

  @ApiProperty()
  addsArenaEffect!: boolean;

  @ApiPropertyOptional()
  arenaEffectSlug?: string | null;

  @ApiProperty()
  noteOnly!: boolean;
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
