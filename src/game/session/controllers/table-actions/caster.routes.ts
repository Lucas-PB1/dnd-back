import { Body, Param, ParseUUIDPipe } from '@nestjs/common';
import { CurrentUser } from '@identity/decorators/current-user.decorator';
import { AuthUser } from '@identity/auth-user';
import { BardActionsHandler } from '../../application/actions/bard/bard-actions.handler';
import { ClericActionsHandler } from '../../application/actions/cleric/cleric-actions.handler';
import { DruidActionsHandler } from '../../application/actions/druid/druid-actions.handler';
import { SorcererActionsHandler } from '../../application/actions/sorcerer/sorcerer-actions.handler';
import { WarlockActionsHandler } from '../../application/actions/warlock/warlock-actions.handler';
import { WizardActionsHandler } from '../../application/actions/wizard/wizard-actions.handler';
import { TableActionResponseDto } from '../../dto/fighter/fighter-session.dto';
import {
  UseBardTableActionDto,
  UseClericTableActionDto,
  UseDruidTableActionDto,
  UseSorcererTableActionDto,
  UseWarlockTableActionDto,
  UseWizardTableActionDto,
} from '../../dto/table-actions/table-actions-caster.dto';
import { TableActionEndpoint } from './route-decorators';

export abstract class CasterTableActionsHost {
  abstract readonly cleric: ClericActionsHandler;
  abstract readonly bard: BardActionsHandler;
  abstract readonly sorcerer: SorcererActionsHandler;
  abstract readonly warlock: WarlockActionsHandler;
  abstract readonly druid: DruidActionsHandler;
  abstract readonly wizard: WizardActionsHandler;

  @TableActionEndpoint(
    'cleric',
    'Resolve a Cleric or Cleric-subclass tabletop action',
  )
  useClericTableAction(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UseClericTableActionDto,
  ): Promise<TableActionResponseDto> {
    return this.cleric.useTableAction(user.id, id, dto);
  }

  @TableActionEndpoint(
    'bard',
    'Resolve a Bard or Bard-subclass tabletop action',
  )
  useBardTableAction(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UseBardTableActionDto,
  ): Promise<TableActionResponseDto> {
    return this.bard.useTableAction(user.id, id, dto);
  }

  @TableActionEndpoint(
    'sorcerer',
    'Resolve a Sorcerer or Sorcerer-subclass tabletop action',
  )
  useSorcererTableAction(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UseSorcererTableActionDto,
  ): Promise<TableActionResponseDto> {
    return this.sorcerer.useTableAction(user.id, id, dto);
  }

  @TableActionEndpoint(
    'warlock',
    'Resolve a Warlock or Warlock-subclass tabletop action',
  )
  useWarlockTableAction(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UseWarlockTableActionDto,
  ): Promise<TableActionResponseDto> {
    return this.warlock.useTableAction(user.id, id, dto);
  }

  @TableActionEndpoint(
    'druid',
    'Resolve a Druid or Druid-subclass tabletop action',
  )
  useDruidTableAction(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UseDruidTableActionDto,
  ): Promise<TableActionResponseDto> {
    return this.druid.useTableAction(user.id, id, dto);
  }

  @TableActionEndpoint(
    'wizard',
    'Resolve a Wizard or Wizard-subclass tabletop action',
  )
  useWizardTableAction(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UseWizardTableActionDto,
  ): Promise<TableActionResponseDto> {
    return this.wizard.useTableAction(user.id, id, dto);
  }
}
