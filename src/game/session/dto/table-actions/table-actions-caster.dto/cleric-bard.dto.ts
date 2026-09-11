import { ApiProperty } from '@nestjs/swagger';
import { IsIn } from 'class-validator';
import { TableActionOptionsDto } from '../table-action-options.dto';

const CLERIC_TABLE_ACTION_SLUGS = [
  'divine-spark-heal',
  'divine-spark-damage',
  'turn-undead',
  'divine-intervention',
  'preserve-life',
  'radiance-of-dawn',
  'warding-flare',
  'crown-of-light',
  'tricksters-blessing',
  'invoke-duplicity',
  'guided-strike',
  'war-priest',
  'war-gods-blessing',
  'dragon-majesty',
  'serpent-blessing',
  'chromatic-affinity',
  'legendary-aspect-rend',
  'legendary-aspect-tail',
  'legendary-aspect-wings',
  'adjust-the-skein',
  'pluck-the-threads',
  'intertwined-fate',
] as const;

export class UseClericTableActionDto extends TableActionOptionsDto {
  @ApiProperty({ enum: CLERIC_TABLE_ACTION_SLUGS })
  @IsIn(CLERIC_TABLE_ACTION_SLUGS)
  actionSlug!: (typeof CLERIC_TABLE_ACTION_SLUGS)[number];
}

const BARD_TABLE_ACTION_SLUGS = [
  'grant-inspiration',
  'cutting-words',
  'peerless-skill',
  'mantle-of-inspiration',
  'mantle-of-majesty',
  'unbreakable-majesty',
  'agile-response',
  'coordinated-movement',
  'unarmed-dance',
  'combat-inspiration',
  'superior-inspiration',
  'virtuoso-skill',
  'persona-angel',
  'persona-devil',
  'persona-dragon',
  'persona-gladiator',
  'persona-jester',
  'set-persona-masks',
  'bragi-rune',
  'battle-sagas',
] as const;

export class UseBardTableActionDto extends TableActionOptionsDto {
  @ApiProperty({ enum: BARD_TABLE_ACTION_SLUGS })
  @IsIn(BARD_TABLE_ACTION_SLUGS)
  actionSlug!: (typeof BARD_TABLE_ACTION_SLUGS)[number];
}
