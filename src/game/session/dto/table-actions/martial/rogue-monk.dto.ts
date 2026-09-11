import { ApiProperty } from '@nestjs/swagger';
import { IsIn } from 'class-validator';
import { TableActionOptionsDto } from '../table-action-options.dto';

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

export class UseRogueTableActionDto extends TableActionOptionsDto {
  @ApiProperty({ enum: ROGUE_TABLE_ACTION_SLUGS })
  @IsIn([...ROGUE_TABLE_ACTION_SLUGS])
  actionSlug!: (typeof ROGUE_TABLE_ACTION_SLUGS)[number];
}

const MONK_TABLE_ACTION_SLUGS = [
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
] as const;

export class UseMonkTableActionDto extends TableActionOptionsDto {
  @ApiProperty({ enum: MONK_TABLE_ACTION_SLUGS })
  @IsIn([...MONK_TABLE_ACTION_SLUGS])
  actionSlug!: (typeof MONK_TABLE_ACTION_SLUGS)[number];
}
