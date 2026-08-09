import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import {
  IsBoolean,
  IsIn,
  IsInt,
  IsOptional,
  IsString,
  Max,
  Min,
} from 'class-validator';

export class UseRogueTableActionDto {
  @ApiProperty({
    enum: [
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
    ],
  })
  @IsIn([
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
  ])
  actionSlug!:
    | 'psychic-blade-main'
    | 'psychic-blade-bonus'
    | 'psi-bolstered-knack'
    | 'guided-strike'
    | 'psychic-whispers'
    | 'psychic-teleport'
    | 'psychic-veil'
    | 'rend-mind'
    | 'spell-thief'
    | 'arachnoid-web'
    | 'magic-device-charge';

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
      'elemental-blast',
      'hand-of-healing',
      'hand-of-harm',
      'shadow-step',
    ],
  })
  @IsIn([
    'flurry-of-blows',
    'patient-defense',
    'step-of-the-wind',
    'stunning-strike',
    'open-hand-technique',
    'elemental-blast',
    'hand-of-healing',
    'hand-of-harm',
    'shadow-step',
  ])
  actionSlug!:
    | 'flurry-of-blows'
    | 'patient-defense'
    | 'step-of-the-wind'
    | 'stunning-strike'
    | 'open-hand-technique'
    | 'elemental-blast'
    | 'hand-of-healing'
    | 'hand-of-harm'
    | 'shadow-step';
}

export class UsePaladinTableActionDto {
  @ApiProperty({
    enum: [
      'lay-on-hands',
      'cure-poison',
      'divine-sense',
      'abjure-enemies',
      'oath-channel',
    ],
  })
  @IsIn([
    'lay-on-hands',
    'cure-poison',
    'divine-sense',
    'abjure-enemies',
    'oath-channel',
  ])
  actionSlug!:
    | 'lay-on-hands'
    | 'cure-poison'
    | 'divine-sense'
    | 'abjure-enemies'
    | 'oath-channel';

  @ApiPropertyOptional({
    minimum: 1,
    description: 'Pontos de Mãos Consagradas a gastar (cura)',
  })
  @IsOptional()
  @IsInt()
  @Min(1)
  amount?: number;
}

export class UseRangerTableActionDto {
  @ApiProperty({
    enum: [
      'hunters-mark-free',
      'tireless',
      'natures-veil',
      'fey-reinforcements',
      'misty-wanderer',
      'primal-companion',
      'set-bestial-aspect',
      'feral-howl',
    ],
  })
  @IsIn([
    'hunters-mark-free',
    'tireless',
    'natures-veil',
    'fey-reinforcements',
    'misty-wanderer',
    'primal-companion',
    'set-bestial-aspect',
    'feral-howl',
  ])
  actionSlug!:
    | 'hunters-mark-free'
    | 'tireless'
    | 'natures-veil'
    | 'fey-reinforcements'
    | 'misty-wanderer'
    | 'primal-companion'
    | 'set-bestial-aspect'
    | 'feral-howl';

  @ApiPropertyOptional({
    minimum: 0,
    maximum: 5,
    description: 'Nível de Aspecto Bestial (set-bestial-aspect)',
  })
  @IsOptional()
  @IsInt()
  @Min(0)
  @Max(5)
  level?: number;
}

const FIGHTER_TABLE_ACTION_SLUGS = [
  'second-wind',
  'action-surge',
  'tactical-mind',
  'use-maneuver',
  'dungeon-precaution',
  'psi:protective-field',
  'psi:telekinetic-movement',
  'psi:psychic-leap',
  'psi:mental-guard',
  'psi:energy-bulwark',
  'psi:telekinetic-master',
] as const;

export class UseFighterTableActionDto {
  @ApiProperty({ enum: FIGHTER_TABLE_ACTION_SLUGS })
  @IsIn([...FIGHTER_TABLE_ACTION_SLUGS])
  actionSlug!: (typeof FIGHTER_TABLE_ACTION_SLUGS)[number];

  @ApiPropertyOptional({
    example: 'trip-attack',
    description: 'Slug da manobra (use-maneuver)',
  })
  @IsOptional()
  @IsString()
  maneuverSlug?: string;

  @ApiPropertyOptional({
    description: 'Implacável: 1d8 sem gastar Superioridade (use-maneuver)',
  })
  @IsOptional()
  @IsBoolean()
  useRelentless?: boolean;

  @ApiPropertyOptional({
    example: 'detectar-magia',
    description: 'Magia de Precaução (dungeon-precaution)',
  })
  @IsOptional()
  @IsString()
  spellSlug?: string;

  @ApiPropertyOptional({
    description: 'Gasta Energia Psiônica em vez do uso gratuito (psi:*)',
  })
  @IsOptional()
  @IsBoolean()
  usePsiDie?: boolean;

  @ApiPropertyOptional({
    description: 'Mente Tática: total atual do teste (opcional)',
  })
  @IsOptional()
  @IsInt()
  @Min(1)
  checkTotal?: number;

  @ApiPropertyOptional({
    description: 'Mente Tática: CD do teste (opcional; exige checkTotal)',
  })
  @IsOptional()
  @IsInt()
  @Min(1)
  dc?: number;
}
