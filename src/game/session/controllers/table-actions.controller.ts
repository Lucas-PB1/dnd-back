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
import { WithCasterTableActions } from './table-actions/caster.routes';
import { WithMartialTableActions } from './table-actions/martial.routes';

@ApiTags('game-characters')
@ApiBearerAuth()
@ApiUnauthorizedResponse({ description: 'Missing or invalid Bearer token' })
@UseGuards(SupabaseAuthGuard)
@Controller('characters')
export class TableActionsController extends WithMartialTableActions(
  WithCasterTableActions(class {}),
) {
  constructor(
    protected readonly rogue: RogueActionsHandler,
    protected readonly monk: MonkActionsHandler,
    protected readonly paladin: PaladinActionsHandler,
    protected readonly ranger: RangerActionsHandler,
    protected readonly cleric: ClericActionsHandler,
    protected readonly bard: BardActionsHandler,
    protected readonly barbarian: BarbarianActionsHandler,
    protected readonly sorcerer: SorcererActionsHandler,
    protected readonly warlock: WarlockActionsHandler,
    protected readonly druid: DruidActionsHandler,
    protected readonly wizard: WizardActionsHandler,
    protected readonly fighter: FighterActionsHandler,
    protected readonly gunslinger: GunslingerActionsHandler,
    protected readonly monsterHunter: MonsterHunterActionsHandler,
  ) {
    super();
  }
}
