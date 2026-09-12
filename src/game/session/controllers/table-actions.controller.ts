import { Controller, UseGuards } from '@nestjs/common';
import {
  ApiBearerAuth,
  ApiTags,
  ApiUnauthorizedResponse,
} from '@nestjs/swagger';
import { SupabaseAuthGuard } from '@identity/guards/supabase-auth.guard';
import { RogueActionsHandler } from '../application/actions/rogue/rogue-actions.handler';
import { MonkActionsHandler } from '../application/actions/monk/monk-actions.handler';
import { PaladinActionsHandler } from '../application/actions/paladin/paladin-actions.handler';
import { RangerActionsHandler } from '../application/actions/ranger/ranger-actions.handler';
import { ClericActionsHandler } from '../application/actions/cleric/cleric-actions.handler';
import { BardActionsHandler } from '../application/actions/bard/bard-actions.handler';
import { BarbarianActionsHandler } from '../application/actions/barbarian/barbarian-actions.handler';
import { SorcererActionsHandler } from '../application/actions/sorcerer/sorcerer-actions.handler';
import { WarlockActionsHandler } from '../application/actions/warlock/warlock-actions.handler';
import { DruidActionsHandler } from '../application/actions/druid/druid-actions.handler';
import { WizardActionsHandler } from '../application/actions/wizard/wizard-actions.handler';
import { FighterActionsHandler } from '../application/actions/fighter/fighter-actions.handler';
import { GunslingerActionsHandler } from '../application/actions/gunslinger/gunslinger-actions.handler';
import { MonsterHunterActionsHandler } from '../application/actions/monster-hunter/monster-hunter-actions.handler';
import { TransformationActionsHandler } from '../application/actions/transformation/transformation-actions.handler';
import { FeatEconomyActionsHandler } from '../application/actions/feat/feat-economy-actions.handler';
import { TableActionsHost } from './table-actions/feat.routes';

@ApiTags('game-characters')
@ApiBearerAuth()
@ApiUnauthorizedResponse({ description: 'Missing or invalid Bearer token' })
@UseGuards(SupabaseAuthGuard)
@Controller('characters')
export class TableActionsController extends TableActionsHost {
  constructor(
    readonly rogue: RogueActionsHandler,
    readonly monk: MonkActionsHandler,
    readonly paladin: PaladinActionsHandler,
    readonly ranger: RangerActionsHandler,
    readonly cleric: ClericActionsHandler,
    readonly bard: BardActionsHandler,
    readonly barbarian: BarbarianActionsHandler,
    readonly sorcerer: SorcererActionsHandler,
    readonly warlock: WarlockActionsHandler,
    readonly druid: DruidActionsHandler,
    readonly wizard: WizardActionsHandler,
    readonly fighter: FighterActionsHandler,
    readonly gunslinger: GunslingerActionsHandler,
    readonly monsterHunter: MonsterHunterActionsHandler,
    readonly transformation: TransformationActionsHandler,
    readonly featEconomy: FeatEconomyActionsHandler,
  ) {
    super();
  }
}
