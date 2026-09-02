import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsIn, IsInt, IsOptional, IsString, Min } from 'class-validator';

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
  'context-switch',
  'harbinger-of-chaos',
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
