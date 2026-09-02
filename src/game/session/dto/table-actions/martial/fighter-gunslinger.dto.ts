import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import {
  IsBoolean,
  IsIn,
  IsInt,
  IsOptional,
  IsString,
  Min,
} from 'class-validator';

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
  'marauders-reprisal',
  'unstoppable-assault',
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
