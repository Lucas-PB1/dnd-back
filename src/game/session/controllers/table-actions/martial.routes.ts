import { Body, Param, ParseUUIDPipe } from '@nestjs/common';
import { CurrentUser } from '@identity/decorators/current-user.decorator';
import { AuthUser } from '@identity/auth-user';
import { BarbarianActionsHandler } from '../../application/actions/barbarian/barbarian-actions.handler';
import { FighterActionsHandler } from '../../application/actions/fighter/fighter-actions.handler';
import { GunslingerActionsHandler } from '../../application/actions/gunslinger/gunslinger-actions.handler';
import { MonkActionsHandler } from '../../application/actions/monk/monk-actions.handler';
import { MonsterHunterActionsHandler } from '../../application/actions/monster-hunter/monster-hunter-actions.handler';
import { PaladinActionsHandler } from '../../application/actions/paladin/paladin-actions.handler';
import { RangerActionsHandler } from '../../application/actions/ranger/ranger-actions.handler';
import { RogueActionsHandler } from '../../application/actions/rogue/rogue-actions.handler';
import { TableActionResponseDto } from '../../dto/fighter/fighter-session.dto';
import {
  UseBarbarianTableActionDto,
  UseFighterTableActionDto,
  UseGunslingerTableActionDto,
  UseMonkTableActionDto,
  UsePaladinTableActionDto,
  UseRangerTableActionDto,
  UseRogueTableActionDto,
} from '../../dto/table-actions/table-actions-martial.dto';
import { UseMonsterHunterTableActionDto } from '../../dto/table-actions/table-actions-monster-hunter.dto';
import { UseManeuverResponseDto } from '../../dto/core/session-commands.dto';
import { CasterTableActionsHost } from './caster.routes';
import { TableActionEndpoint } from './route-decorators';

export abstract class MartialTableActionsHost extends CasterTableActionsHost {
  abstract readonly fighter: FighterActionsHandler;
  abstract readonly gunslinger: GunslingerActionsHandler;
  abstract readonly rogue: RogueActionsHandler;
  abstract readonly monk: MonkActionsHandler;
  abstract readonly paladin: PaladinActionsHandler;
  abstract readonly ranger: RangerActionsHandler;
  abstract readonly barbarian: BarbarianActionsHandler;
  abstract readonly monsterHunter: MonsterHunterActionsHandler;

  @TableActionEndpoint(
    'fighter',
    'Resolve a Fighter or Fighter-subclass tabletop action',
  )
  useFighterTableAction(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UseFighterTableActionDto,
  ): Promise<TableActionResponseDto> {
    return this.fighter.useTableAction(user.id, id, dto);
  }

  @TableActionEndpoint(
    'gunslinger',
    'Resolve a Gunslinger tabletop action (maneuver / recover-risk)',
  )
  useGunslingerTableAction(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UseGunslingerTableActionDto,
  ): Promise<UseManeuverResponseDto | TableActionResponseDto> {
    return this.gunslinger.useTableAction(user.id, id, dto);
  }

  @TableActionEndpoint(
    'rogue',
    'Resolve a Rogue or Rogue-subclass tabletop action',
  )
  useRogueTableAction(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UseRogueTableActionDto,
  ): Promise<TableActionResponseDto> {
    return this.rogue.useTableAction(user.id, id, dto);
  }

  @TableActionEndpoint(
    'monk',
    'Resolve a Monk or Monk-subclass tabletop action',
  )
  useMonkTableAction(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UseMonkTableActionDto,
  ): Promise<TableActionResponseDto> {
    return this.monk.useTableAction(user.id, id, dto);
  }

  @TableActionEndpoint(
    'paladin',
    'Resolve a Paladin or Paladin-subclass tabletop action',
  )
  usePaladinTableAction(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UsePaladinTableActionDto,
  ): Promise<TableActionResponseDto> {
    return this.paladin.useTableAction(user.id, id, dto);
  }

  @TableActionEndpoint(
    'ranger',
    'Resolve a Ranger or Ranger-subclass tabletop action',
  )
  useRangerTableAction(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UseRangerTableActionDto,
  ): Promise<TableActionResponseDto> {
    return this.ranger.useTableAction(user.id, id, dto);
  }

  @TableActionEndpoint(
    'barbarian',
    'Resolve a Barbarian or Barbarian-subclass tabletop action',
  )
  useBarbarianTableAction(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UseBarbarianTableActionDto,
  ): Promise<TableActionResponseDto> {
    return this.barbarian.useTableAction(user.id, id, dto);
  }

  @TableActionEndpoint(
    'monster-hunter',
    'Resolve a Monster Hunter tabletop action',
  )
  useMonsterHunterTableAction(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UseMonsterHunterTableActionDto,
  ): Promise<TableActionResponseDto> {
    return this.monsterHunter.useTableAction(user.id, id, dto);
  }
}
