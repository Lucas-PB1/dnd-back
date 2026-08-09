import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsArray, IsIn, IsOptional, IsString } from 'class-validator';

const CLERIC_TABLE_ACTION_SLUGS = [
  'divine-spark-heal',
  'divine-spark-damage',
  'turn-undead',
  'divine-intervention',
  'preserve-life',
  'radiance-of-dawn',
  'warding-flare',
  'crown-of-light',
  'tricksters-blessing',
  'invoke-duplicity',
  'guided-strike',
  'war-priest',
  'war-gods-blessing',
] as const;

export class UseClericTableActionDto {
  @ApiProperty({ enum: CLERIC_TABLE_ACTION_SLUGS })
  @IsIn(CLERIC_TABLE_ACTION_SLUGS)
  actionSlug!: (typeof CLERIC_TABLE_ACTION_SLUGS)[number];
}

const BARD_TABLE_ACTION_SLUGS = [
  'grant-inspiration',
  'cutting-words',
  'enthralling-performance',
  'agile-response',
  'unarmed-dance',
  'combat-inspiration',
  'superior-inspiration',
  'set-persona-masks',
] as const;

export class UseBardTableActionDto {
  @ApiProperty({ enum: BARD_TABLE_ACTION_SLUGS })
  @IsIn(BARD_TABLE_ACTION_SLUGS)
  actionSlug!: (typeof BARD_TABLE_ACTION_SLUGS)[number];

  @ApiPropertyOptional({
    type: [String],
    description: 'Máscaras a vestir (set-persona-masks)',
    example: ['persona-mask-angel'],
  })
  @IsOptional()
  @IsArray()
  @IsString({ each: true })
  masks?: string[];
}

const SORCERER_TABLE_ACTION_SLUGS = [
  'convert-slot-1-to-points',
  'convert-slot-2-to-points',
  'convert-slot-3-to-points',
  'convert-slot-4-to-points',
  'convert-slot-5-to-points',
  'convert-points-to-slot-1',
  'convert-points-to-slot-2',
  'convert-points-to-slot-3',
  'convert-points-to-slot-4',
  'convert-points-to-slot-5',
  'use-metamagic-1',
  'use-metamagic-2',
  'use-metamagic-3',
  'innate-sorcery',
  'sorcerous-restoration',
  'tides-of-chaos',
  'bastion-of-law',
] as const;

export class UseSorcererTableActionDto {
  @ApiProperty({ enum: SORCERER_TABLE_ACTION_SLUGS })
  @IsIn(SORCERER_TABLE_ACTION_SLUGS)
  actionSlug!: (typeof SORCERER_TABLE_ACTION_SLUGS)[number];
}

const WARLOCK_TABLE_ACTION_SLUGS = [
  'magical-cunning',
  'healing-light',
  'dark-ones-luck',
  'fey-step-effect',
  'awakened-mind',
  'fiendish-resilience',
] as const;

export class UseWarlockTableActionDto {
  @ApiProperty({ enum: WARLOCK_TABLE_ACTION_SLUGS })
  @IsIn(WARLOCK_TABLE_ACTION_SLUGS)
  actionSlug!: (typeof WARLOCK_TABLE_ACTION_SLUGS)[number];
}

const DRUID_TABLE_ACTION_SLUGS = [
  'wild-shape',
  'wild-resurgence-slot',
  'wild-resurgence-shape',
  'starry-form-archer',
  'starry-form-chalice',
  'starry-form-dragon',
  'wrath-of-the-sea',
  'moon-combat-wild-shape',
] as const;

export class UseDruidTableActionDto {
  @ApiProperty({ enum: DRUID_TABLE_ACTION_SLUGS })
  @IsIn(DRUID_TABLE_ACTION_SLUGS)
  actionSlug!: (typeof DRUID_TABLE_ACTION_SLUGS)[number];
}

const WIZARD_TABLE_ACTION_SLUGS = [
  'arcane-recovery-1',
  'arcane-recovery-2',
  'arcane-recovery-3',
  'arcane-recovery-4',
  'arcane-recovery-5',
  'arcane-ward',
  'arcane-ward-recharge',
  'projected-ward',
  'spell-breaker',
  'portent',
  'third-eye',
  'sculpt-spells',
  'overchannel',
  'improved-illusions',
  'spectral-summon',
  'illusory-self',
  'illusory-reality',
  'spell-mastery',
  'arm-missile-shield',
  'disarm-missile-shield',
  'arm-giga-missile',
  'disarm-giga-missile',
] as const;

export class UseWizardTableActionDto {
  @ApiProperty({ enum: WIZARD_TABLE_ACTION_SLUGS })
  @IsIn(WIZARD_TABLE_ACTION_SLUGS)
  actionSlug!: (typeof WIZARD_TABLE_ACTION_SLUGS)[number];
}
