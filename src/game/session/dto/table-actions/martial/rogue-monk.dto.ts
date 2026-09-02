import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsBoolean, IsIn, IsInt, IsOptional, Min } from 'class-validator';

const ROGUE_TABLE_ACTION_SLUGS = [
  'psychic-blade-main',
  'psychic-blade-bonus',
  'psi-bolstered-knack',
  'guided-strike',
  'psychic-whispers',
  'psychic-teleport',
  'psychic-veil',
  'rend-mind',
  'spell-thief',
  'arachnoid-web',
  'magic-device-charge',
  'armor-of-the-faithful',
  'rend-the-blasphemous',
  'chains-of-judgement',
  'divine-retaliation',
  'erupting-blades',
  'final-judgement-spirits',
] as const;

export class UseRogueTableActionDto {
  @ApiProperty({ enum: ROGUE_TABLE_ACTION_SLUGS })
  @IsIn([...ROGUE_TABLE_ACTION_SLUGS])
  actionSlug!: (typeof ROGUE_TABLE_ACTION_SLUGS)[number];

  @ApiPropertyOptional({ description: 'Total atual do teste ou ataque' })
  @IsOptional()
  @IsInt()
  checkTotal?: number;

  @ApiPropertyOptional({ description: 'CD do teste ou CA do alvo' })
  @IsOptional()
  @IsInt()
  @Min(1)
  dc?: number;

  @ApiPropertyOptional({
    default: false,
    description: 'Gasta Dados de Energia Psiônica em vez do uso gratuito',
  })
  @IsOptional()
  @IsBoolean()
  usePsiDie?: boolean;
}

export class UseMonkTableActionDto {
  @ApiProperty({
    enum: [
      'flurry-of-blows',
      'patient-defense',
      'step-of-the-wind',
      'stunning-strike',
      'open-hand-technique',
      'wholeness-of-body',
      'vibrating-palm',
      'elemental-attunement',
      'elemental-blast',
      'hand-of-healing',
      'hand-of-harm',
      'flurry-of-healing-and-harm',
      'hand-of-ultimate-mercy',
      'shadow-arts',
      'shadow-step',
      'improved-shadow-step',
      'cloak-of-shadows',
      'street-combo',
      'energy-burst',
      'guard-breaker',
      'uppercut',
      'air-dash',
      'knockout',
      'recover-knockout',
    ],
  })
  @IsIn([
    'flurry-of-blows',
    'patient-defense',
    'step-of-the-wind',
    'stunning-strike',
    'open-hand-technique',
    'wholeness-of-body',
    'vibrating-palm',
    'elemental-attunement',
    'elemental-blast',
    'hand-of-healing',
    'hand-of-harm',
    'flurry-of-healing-and-harm',
    'hand-of-ultimate-mercy',
    'shadow-arts',
    'shadow-step',
    'improved-shadow-step',
    'cloak-of-shadows',
    'street-combo',
    'energy-burst',
    'guard-breaker',
    'uppercut',
    'air-dash',
    'knockout',
    'recover-knockout',
  ])
  actionSlug!:
    | 'flurry-of-blows'
    | 'patient-defense'
    | 'step-of-the-wind'
    | 'stunning-strike'
    | 'open-hand-technique'
    | 'wholeness-of-body'
    | 'vibrating-palm'
    | 'elemental-attunement'
    | 'elemental-blast'
    | 'hand-of-healing'
    | 'hand-of-harm'
    | 'flurry-of-healing-and-harm'
    | 'hand-of-ultimate-mercy'
    | 'shadow-arts'
    | 'shadow-step'
    | 'improved-shadow-step'
    | 'cloak-of-shadows'
    | 'street-combo'
    | 'energy-burst'
    | 'guard-breaker'
    | 'uppercut'
    | 'air-dash'
    | 'knockout'
    | 'recover-knockout';
}
