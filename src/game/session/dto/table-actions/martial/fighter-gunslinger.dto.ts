import { ApiProperty } from '@nestjs/swagger';
import { IsIn } from 'class-validator';
import { TableActionOptionsDto } from '../table-action-options.dto';

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

export class UseFighterTableActionDto extends TableActionOptionsDto {
  @ApiProperty({ enum: FIGHTER_TABLE_ACTION_SLUGS })
  @IsIn([...FIGHTER_TABLE_ACTION_SLUGS])
  actionSlug!: (typeof FIGHTER_TABLE_ACTION_SLUGS)[number];
}

const GUNSLINGER_TABLE_ACTION_SLUGS = [
  'use-maneuver',
  'recover-risk',
  'reload-firearm',
  'fire-chamber',
] as const;

export class UseGunslingerTableActionDto extends TableActionOptionsDto {
  @ApiProperty({ enum: GUNSLINGER_TABLE_ACTION_SLUGS })
  @IsIn([...GUNSLINGER_TABLE_ACTION_SLUGS])
  actionSlug!: (typeof GUNSLINGER_TABLE_ACTION_SLUGS)[number];
}
