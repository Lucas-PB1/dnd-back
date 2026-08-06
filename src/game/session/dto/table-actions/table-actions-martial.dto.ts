import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsBoolean, IsIn, IsInt, IsOptional, Max, Min } from 'class-validator';

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
