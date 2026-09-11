import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsIn, IsInt, IsOptional, Max, Min } from 'class-validator';
import { TableActionOptionsDto } from '../table-action-options.dto';

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
  'encouraging-smite',
  'guardian-of-the-dead',
  'spirit-of-the-valkyrie',
] as const;

export class UsePaladinTableActionDto extends TableActionOptionsDto {
  @ApiProperty({ enum: PALADIN_TABLE_ACTION_SLUGS })
  @IsIn([...PALADIN_TABLE_ACTION_SLUGS])
  actionSlug!: (typeof PALADIN_TABLE_ACTION_SLUGS)[number];
}

const RANGER_TABLE_ACTION_SLUGS = [
  'hunters-mark-free',
  'tireless',
  'natures-veil',
  'fey-reinforcements',
  'misty-wanderer',
  'primal-companion',
  'primal-companion-summon',
  'primal-companion-restore',
  'hunter-defense',
  'gloom-stalker-dodge',
  'set-bestial-aspect',
  'feral-howl',
  'torturer-technique',
  'veil-of-pain',
  'mental-agony',
] as const;

export class UseRangerTableActionDto extends TableActionOptionsDto {
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
  declare level?: number;

  @ApiPropertyOptional({
    enum: ['strike', 'help', 'dash', 'disengage', 'dodge'],
    description: 'Comando do companheiro primal (primal-companion)',
  })
  @IsOptional()
  @IsIn(['strike', 'help', 'dash', 'disengage', 'dodge'])
  declare companionCommand?:
    | 'strike'
    | 'help'
    | 'dash'
    | 'disengage'
    | 'dodge';
}
