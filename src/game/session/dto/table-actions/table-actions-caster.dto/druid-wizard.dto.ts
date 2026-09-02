import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsIn, IsInt, IsOptional, Min } from 'class-validator';

const DRUID_TABLE_ACTION_SLUGS = [
  'wild-shape',
  'wild-resurgence-slot',
  'wild-resurgence-shape',
  'starry-form-archer',
  'starry-form-chalice',
  'starry-form-dragon',
  'starry-form-end',
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
  'wickerbone-behemoth',
  'wolf-mantle',
  'defend-the-pack',
  'children-of-great-wolf',
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
  'brittle-bone-armor',
  'bone-puppetry',
] as const;

export class UseWizardTableActionDto {
  @ApiProperty({ enum: WIZARD_TABLE_ACTION_SLUGS })
  @IsIn(WIZARD_TABLE_ACTION_SLUGS)
  actionSlug!: (typeof WIZARD_TABLE_ACTION_SLUGS)[number];
}
