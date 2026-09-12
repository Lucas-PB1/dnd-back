import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsIn, IsInt, IsOptional, Min } from 'class-validator';
import { TableActionOptionsDto } from '../table-action-options.dto';

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
  'spirit-guidance',
  'spirit-aura',
  'spirit-secrets',
] as const;

export class UseSorcererTableActionDto extends TableActionOptionsDto {
  @ApiProperty({ enum: SORCERER_TABLE_ACTION_SLUGS })
  @IsIn(SORCERER_TABLE_ACTION_SLUGS)
  actionSlug!: (typeof SORCERER_TABLE_ACTION_SLUGS)[number];

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
  'context-switch',
  'harbinger-of-chaos',
] as const;

export class UseWarlockTableActionDto extends TableActionOptionsDto {
  @ApiProperty({ enum: WARLOCK_TABLE_ACTION_SLUGS })
  @IsIn(WARLOCK_TABLE_ACTION_SLUGS)
  actionSlug!: (typeof WARLOCK_TABLE_ACTION_SLUGS)[number];
}
