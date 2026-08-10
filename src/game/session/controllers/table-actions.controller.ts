import {
  Body,
  Controller,
  HttpCode,
  HttpStatus,
  Param,
  ParseUUIDPipe,
  Post,
  UseGuards,
} from '@nestjs/common';
import {
  ApiBearerAuth,
  ApiOkResponse,
  ApiOperation,
  ApiTags,
  ApiUnauthorizedResponse,
} from '@nestjs/swagger';
import { SupabaseAuthGuard } from '@identity/guards/supabase-auth.guard';
import { CurrentUser } from '@identity/decorators/current-user.decorator';
import { AuthUser } from '@identity/auth-user';
import { RogueActionsHandler } from '../application/actions/rogue-actions.handler';
import { MonkActionsHandler } from '../application/actions/monk-actions.handler';
import { PaladinActionsHandler } from '../application/actions/paladin-actions.handler';
import { RangerActionsHandler } from '../application/actions/ranger-actions.handler';
import { ClericActionsHandler } from '../application/actions/cleric-actions.handler';
import { BardActionsHandler } from '../application/actions/bard-actions.handler';
import { BarbarianActionsHandler } from '../application/actions/barbarian-actions.handler';
import { SorcererActionsHandler } from '../application/actions/sorcerer-actions.handler';
import { WarlockActionsHandler } from '../application/actions/warlock-actions.handler';
import { DruidActionsHandler } from '../application/actions/druid-actions.handler';
import { WizardActionsHandler } from '../application/actions/wizard-actions.handler';
import { FighterActionsHandler } from '../application/actions/fighter-actions.handler';
import { GunslingerActionsHandler } from '../application/actions/gunslinger-actions.handler';
import {
  TableActionResponseDto,
  UseBarbarianTableActionDto,
  UseBardTableActionDto,
  UseClericTableActionDto,
  UseDruidTableActionDto,
  UseFighterTableActionDto,
  UseGunslingerTableActionDto,
  UseMonkTableActionDto,
  UsePaladinTableActionDto,
  UseRangerTableActionDto,
  UseRogueTableActionDto,
  UseSorcererTableActionDto,
  UseWarlockTableActionDto,
  UseWizardTableActionDto,
  UseManeuverResponseDto,
} from '../dto';

@ApiTags('game-characters')
@ApiBearerAuth()
@ApiUnauthorizedResponse({ description: 'Missing or invalid Bearer token' })
@UseGuards(SupabaseAuthGuard)
@Controller('characters')
export class TableActionsController {
  constructor(
    private readonly rogue: RogueActionsHandler,
    private readonly monk: MonkActionsHandler,
    private readonly paladin: PaladinActionsHandler,
    private readonly ranger: RangerActionsHandler,
    private readonly cleric: ClericActionsHandler,
    private readonly bard: BardActionsHandler,
    private readonly barbarian: BarbarianActionsHandler,
    private readonly sorcerer: SorcererActionsHandler,
    private readonly warlock: WarlockActionsHandler,
    private readonly druid: DruidActionsHandler,
    private readonly wizard: WizardActionsHandler,
    private readonly fighter: FighterActionsHandler,
    private readonly gunslinger: GunslingerActionsHandler,
  ) {}

  @Post(':id/fighter/table-action')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({
    summary: 'Resolve a Fighter or Fighter-subclass tabletop action',
  })
  @ApiOkResponse({ type: TableActionResponseDto })
  useFighterTableAction(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UseFighterTableActionDto,
  ): Promise<TableActionResponseDto> {
    return this.fighter.useTableAction(user.id, id, dto);
  }

  @Post(':id/gunslinger/table-action')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({
    summary: 'Resolve a Gunslinger tabletop action (maneuver / recover-risk)',
  })
  @ApiOkResponse({ type: TableActionResponseDto })
  useGunslingerTableAction(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UseGunslingerTableActionDto,
  ): Promise<UseManeuverResponseDto | TableActionResponseDto> {
    return this.gunslinger.useTableAction(user.id, id, dto);
  }

  @Post(':id/rogue/table-action')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({
    summary: 'Resolve a Rogue or Rogue-subclass tabletop action',
  })
  @ApiOkResponse({ type: TableActionResponseDto })
  useRogueTableAction(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UseRogueTableActionDto,
  ): Promise<TableActionResponseDto> {
    return this.rogue.useTableAction(user.id, id, dto);
  }

  @Post(':id/monk/table-action')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({
    summary: 'Resolve a Monk or Monk-subclass tabletop action',
  })
  @ApiOkResponse({ type: TableActionResponseDto })
  useMonkTableAction(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UseMonkTableActionDto,
  ): Promise<TableActionResponseDto> {
    return this.monk.useTableAction(user.id, id, dto);
  }

  @Post(':id/paladin/table-action')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({
    summary: 'Resolve a Paladin or Paladin-subclass tabletop action',
  })
  @ApiOkResponse({ type: TableActionResponseDto })
  usePaladinTableAction(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UsePaladinTableActionDto,
  ): Promise<TableActionResponseDto> {
    return this.paladin.useTableAction(user.id, id, dto);
  }

  @Post(':id/ranger/table-action')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({
    summary: 'Resolve a Ranger or Ranger-subclass tabletop action',
  })
  @ApiOkResponse({ type: TableActionResponseDto })
  useRangerTableAction(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UseRangerTableActionDto,
  ): Promise<TableActionResponseDto> {
    return this.ranger.useTableAction(user.id, id, dto);
  }

  @Post(':id/cleric/table-action')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({
    summary: 'Resolve a Cleric or Cleric-subclass tabletop action',
  })
  @ApiOkResponse({ type: TableActionResponseDto })
  useClericTableAction(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UseClericTableActionDto,
  ): Promise<TableActionResponseDto> {
    return this.cleric.useTableAction(user.id, id, dto);
  }

  @Post(':id/bard/table-action')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({
    summary: 'Resolve a Bard or Bard-subclass tabletop action',
  })
  @ApiOkResponse({ type: TableActionResponseDto })
  useBardTableAction(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UseBardTableActionDto,
  ): Promise<TableActionResponseDto> {
    return this.bard.useTableAction(user.id, id, dto);
  }

  @Post(':id/barbarian/table-action')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({
    summary: 'Resolve a Barbarian or Barbarian-subclass tabletop action',
  })
  @ApiOkResponse({ type: TableActionResponseDto })
  useBarbarianTableAction(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UseBarbarianTableActionDto,
  ): Promise<TableActionResponseDto> {
    return this.barbarian.useTableAction(user.id, id, dto);
  }

  @Post(':id/sorcerer/table-action')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({
    summary: 'Resolve a Sorcerer or Sorcerer-subclass tabletop action',
  })
  @ApiOkResponse({ type: TableActionResponseDto })
  useSorcererTableAction(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UseSorcererTableActionDto,
  ): Promise<TableActionResponseDto> {
    return this.sorcerer.useTableAction(user.id, id, dto);
  }

  @Post(':id/warlock/table-action')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({
    summary: 'Resolve a Warlock or Warlock-subclass tabletop action',
  })
  @ApiOkResponse({ type: TableActionResponseDto })
  useWarlockTableAction(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UseWarlockTableActionDto,
  ): Promise<TableActionResponseDto> {
    return this.warlock.useTableAction(user.id, id, dto);
  }

  @Post(':id/druid/table-action')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({
    summary: 'Resolve a Druid or Druid-subclass tabletop action',
  })
  @ApiOkResponse({ type: TableActionResponseDto })
  useDruidTableAction(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UseDruidTableActionDto,
  ): Promise<TableActionResponseDto> {
    return this.druid.useTableAction(user.id, id, dto);
  }

  @Post(':id/wizard/table-action')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({
    summary: 'Resolve a Wizard or Wizard-subclass tabletop action',
  })
  @ApiOkResponse({ type: TableActionResponseDto })
  useWizardTableAction(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UseWizardTableActionDto,
  ): Promise<TableActionResponseDto> {
    return this.wizard.useTableAction(user.id, id, dto);
  }
}
