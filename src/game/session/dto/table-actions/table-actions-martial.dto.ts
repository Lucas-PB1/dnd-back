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

const PALADIN_TABLE_ACTION_SLUGS = [
  'lay-on-hands',
  'cure-poison',
  'divine-sense',
  'abjure-enemies',
  'oath-channel',
  'inspiring-smite',
  'peerless-athlete',
  'glorious-defense',
  'undying-sentinel',
  'reveler',
  'hunt-the-prey',
  'perfect-hunter',
] as const;

export class UsePaladinTableActionDto {
  @ApiProperty({ enum: PALADIN_TABLE_ACTION_SLUGS })
  @IsIn([...PALADIN_TABLE_ACTION_SLUGS])
  actionSlug!: (typeof PALADIN_TABLE_ACTION_SLUGS)[number];

  @ApiPropertyOptional({
    minimum: 1,
    description: 'Pontos de Mãos Consagradas a gastar (cura)',
  })
  @IsOptional()
  @IsInt()
  @Min(1)
  amount?: number;
}

const RANGER_TABLE_ACTION_SLUGS = [
  'hunters-mark-free',
  'tireless',
  'natures-veil',
  'fey-reinforcements',
  'misty-wanderer',
  'primal-companion',
  'hunter-defense',
  'gloom-stalker-dodge',
  'set-bestial-aspect',
  'feral-howl',
  'torturer-technique',
  'veil-of-pain',
  'mental-agony',
] as const;

export class UseRangerTableActionDto {
  @ApiProperty({ enum: RANGER_TABLE_ACTION_SLUGS })
  @IsIn([...RANGER_TABLE_ACTION_SLUGS])
  actionSlug!: (typeof RANGER_TABLE_ACTION_SLUGS)[number];

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
  'blood-strike',
  'blood-explosion',
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

  @ApiPropertyOptional({
    example: 'hunting-strike',
    description: 'Opção de Golpe de Sangue (blood-strike)',
  })
  @IsOptional()
  @IsString()
  optionSlug?: string;

  @ApiPropertyOptional({
    description:
      'Sangue da Criação (L10+): rerrola o Custo de Sangue e fica com o menor',
  })
  @IsOptional()
  @IsBoolean()
  takeLowerBloodCost?: boolean;
}

const GUNSLINGER_TABLE_ACTION_SLUGS = [
  'use-maneuver',
  'recover-risk',
  'reload-firearm',
  'fire-chamber',
] as const;

export class UseGunslingerTableActionDto {
  @ApiProperty({ enum: GUNSLINGER_TABLE_ACTION_SLUGS })
  @IsIn([...GUNSLINGER_TABLE_ACTION_SLUGS])
  actionSlug!: (typeof GUNSLINGER_TABLE_ACTION_SLUGS)[number];

  @ApiPropertyOptional({
    example: 'bite-the-bullet',
    description: 'Slug da manobra (use-maneuver)',
  })
  @IsOptional()
  @IsString()
  maneuverSlug?: string;

  @ApiPropertyOptional({
    example: 'revolver',
    description: 'Arma de fogo (reload-firearm / fire-chamber)',
  })
  @IsOptional()
  @IsString()
  itemSlug?: string;

  @ApiPropertyOptional({
    example: 1,
    description: 'Tiros a gastar (fire-chamber; Automática = 2)',
  })
  @IsOptional()
  @IsInt()
  @Min(1)
  shots?: number;
}

const BARBARIAN_TABLE_ACTION_SLUGS = [
  'toggle-rage',
  'toggle-reckless',
  'recover-all-rage',
  'frenzy',
  'wild-heart-eagle',
  'fanatical-focus',
  'retaliation',
  'intimidating-presence',
  'restore-intimidating-presence',
  'champion-of-the-gods',
  'zealous-presence',
  'restore-zealous-presence',
  'rage-of-the-gods',
  'revitalizing-strength',
  'branches-of-the-tree',
  'traverse-the-tree',
  'undeniable-magic-rage',
  'cantrip-mage-hand',
  'cantrip-shocking-grasp',
  'cantrip-sure-strike',
  'burning-hands-slap',
  'magic-missile-throws',
  'shield-block',
  'i-cast-fist',
  'electrified-chains',
  'fulgurant-strike',
  'lightning-step',
  'roaring-crash',
] as const;

export class UseBarbarianTableActionDto {
  @ApiProperty({ enum: BARBARIAN_TABLE_ACTION_SLUGS })
  @IsIn([...BARBARIAN_TABLE_ACTION_SLUGS])
  actionSlug!: (typeof BARBARIAN_TABLE_ACTION_SLUGS)[number];

  @ApiPropertyOptional({
    minimum: 1,
    description: 'Dados d12 de Campeão dos Deuses a gastar',
  })
  @IsOptional()
  @IsInt()
  @Min(1)
  diceCount?: number;
}
