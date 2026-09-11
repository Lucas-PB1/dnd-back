import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsIn, IsOptional } from 'class-validator';
import { TableActionOptionsDto } from '../table-action-options.dto';

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
  'giants-fury',
  'crushing-steps',
  'titanic-strikes',
  'titans-fury',
  'primal-companion',
  'primal-companion-summon',
  'primal-companion-restore',
  'shape-of-the-wild',
  'shape-of-the-wild-action',
  'shape-of-the-wild-rage-recover',
] as const;

export class UseBarbarianTableActionDto extends TableActionOptionsDto {
  @ApiProperty({ enum: BARBARIAN_TABLE_ACTION_SLUGS })
  @IsIn([...BARBARIAN_TABLE_ACTION_SLUGS])
  actionSlug!: (typeof BARBARIAN_TABLE_ACTION_SLUGS)[number];

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
