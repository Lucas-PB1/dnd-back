import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsArray, IsIn, IsInt, IsOptional, IsString, Min } from 'class-validator';

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
  'dragon-majesty',
  'serpent-blessing',
  'chromatic-affinity',
  'legendary-aspect-rend',
  'legendary-aspect-tail',
  'legendary-aspect-wings',
] as const;

export class UseClericTableActionDto {
  @ApiProperty({ enum: CLERIC_TABLE_ACTION_SLUGS })
  @IsIn(CLERIC_TABLE_ACTION_SLUGS)
  actionSlug!: (typeof CLERIC_TABLE_ACTION_SLUGS)[number];
}

const BARD_TABLE_ACTION_SLUGS = [
  'grant-inspiration',
  'cutting-words',
  'peerless-skill',
  'mantle-of-inspiration',
  'mantle-of-majesty',
  'unbreakable-majesty',
  'agile-response',
  'coordinated-movement',
  'unarmed-dance',
  'combat-inspiration',
  'superior-inspiration',
  'virtuoso-skill',
  'persona-angel',
  'persona-devil',
  'persona-dragon',
  'persona-gladiator',
  'persona-jester',
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
  'use-metamagic',
  'innate-sorcery',
  'sorcerous-restoration',
  'tides-of-chaos',
  'bastion-of-law',
  'restore-balance',
  'dragon-wings',
  'bend-luck',
  'heroic-soul',
  'mystical-maneuver',
  'warp-implosion',
] as const;

export class UseSorcererTableActionDto {
  @ApiProperty({ enum: SORCERER_TABLE_ACTION_SLUGS })
  @IsIn(SORCERER_TABLE_ACTION_SLUGS)
  actionSlug!: (typeof SORCERER_TABLE_ACTION_SLUGS)[number];

  @ApiPropertyOptional({
    example: 'subtle-spell',
    description: 'Slug da opção de Metamagia (use-metamagic)',
  })
  @IsOptional()
  @IsString()
  metamagicSlug?: string;

  @ApiPropertyOptional({
    example: 3,
    description: 'Pontos de Feitiçaria gastos (bastion-of-law: 1–5)',
  })
  @IsOptional()
  @IsInt()
  @Min(1)
  pointsSpent?: number;
}

const WARLOCK_TABLE_ACTION_SLUGS = [
  'magical-cunning',
  'healing-light',
  'dark-ones-luck',
  'fey-step-effect',
  'awakened-mind',
  'fiendish-resilience',
  'invoke-pact-weapon',
  'hurl-through-hell',
  'searing-vengeance',
  'beguiling-defenses',
  'clairvoyant-combatant',
] as const;

export class UseWarlockTableActionDto {
  @ApiProperty({ enum: WARLOCK_TABLE_ACTION_SLUGS })
  @IsIn(WARLOCK_TABLE_ACTION_SLUGS)
  actionSlug!: (typeof WARLOCK_TABLE_ACTION_SLUGS)[number];

  @ApiPropertyOptional({
    example: 'longsword',
    description:
      'Slug da arma do inventário (invoke-pact-weapon). Se omitido, usa a já marcada.',
  })
  @IsOptional()
  @IsString()
  itemSlug?: string;

  @ApiPropertyOptional({
    example: 2,
    description: 'Quantidade de d6 da Luz Medicinal (1–mod. Carisma).',
  })
  @IsOptional()
  @IsInt()
  @Min(1)
  diceCount?: number;
}

const DRUID_TABLE_ACTION_SLUGS = [
  'wild-shape',
  'wild-resurgence-slot',
  'wild-resurgence-shape',
  'starry-form-archer',
  'starry-form-chalice',
  'starry-form-dragon',
  'stellar-guidance',
  'cosmic-omen',
  'wrath-of-the-sea',
  'ocean-manifestation',
  'moon-combat-wild-shape',
  'lunar-step',
  'restore-lunar-step',
  'land-aid',
  'nature-sanctuary',
  'natural-recovery-1',
  'natural-recovery-2',
  'natural-recovery-3',
  'natural-recovery-4',
  'natural-recovery-5',
  'city-shape',
  'wall-warp',
] as const;

export class UseDruidTableActionDto {
  @ApiProperty({ enum: DRUID_TABLE_ACTION_SLUGS })
  @IsIn(DRUID_TABLE_ACTION_SLUGS)
  actionSlug!: (typeof DRUID_TABLE_ACTION_SLUGS)[number];

  @ApiPropertyOptional({
    example: 2,
    description: 'Círculo do espaço gasto (ex.: restaurar Passo Lunar, mín. 2).',
  })
  @IsOptional()
  @IsInt()
  @Min(1)
  slotLevel?: number;
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
