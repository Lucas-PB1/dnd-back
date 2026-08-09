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
import { SorcererActionsHandler } from '../application/actions/sorcerer-actions.handler';
import { WarlockActionsHandler } from '../application/actions/warlock-actions.handler';
import { DruidActionsHandler } from '../application/actions/druid-actions.handler';
import { WizardActionsHandler } from '../application/actions/wizard-actions.handler';
import {
  FighterTableActionResponseDto,
  UseBardTableActionDto,
  UseClericTableActionDto,
  UseDruidTableActionDto,
  UseMonkTableActionDto,
  UsePaladinTableActionDto,
  UseRangerTableActionDto,
  UseRogueTableActionDto,
  UseSorcererTableActionDto,
  UseWarlockTableActionDto,
  UseWizardTableActionDto,
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
    private readonly sorcerer: SorcererActionsHandler,
    private readonly warlock: WarlockActionsHandler,
    private readonly druid: DruidActionsHandler,
    private readonly wizard: WizardActionsHandler,
  ) {}

  @Post(':id/rogue/table-action')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({
    summary: 'Resolve a Rogue or Rogue-subclass tabletop action',
  })
  @ApiOkResponse({ type: FighterTableActionResponseDto })
  useRogueTableAction(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UseRogueTableActionDto,
  ): Promise<FighterTableActionResponseDto> {
    return this.rogue.useTableAction(user.id, id, dto);
  }

  @Post(':id/monk/table-action')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({
    summary: 'Resolve a Monk or Monk-subclass tabletop action',
  })
  @ApiOkResponse({ type: FighterTableActionResponseDto })
  useMonkTableAction(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UseMonkTableActionDto,
  ): Promise<FighterTableActionResponseDto> {
    return this.monk.useTableAction(user.id, id, dto);
  }

  @Post(':id/paladin/table-action')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({
    summary: 'Resolve a Paladin or Paladin-subclass tabletop action',
  })
  @ApiOkResponse({ type: FighterTableActionResponseDto })
  usePaladinTableAction(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UsePaladinTableActionDto,
  ): Promise<FighterTableActionResponseDto> {
    return this.paladin.useTableAction(user.id, id, dto);
  }

  @Post(':id/ranger/table-action')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({
    summary: 'Resolve a Ranger or Ranger-subclass tabletop action',
  })
  @ApiOkResponse({ type: FighterTableActionResponseDto })
  useRangerTableAction(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UseRangerTableActionDto,
  ): Promise<FighterTableActionResponseDto> {
    return this.ranger.useTableAction(user.id, id, dto);
  }

  @Post(':id/cleric/table-action')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({
    summary: 'Resolve a Cleric or Cleric-subclass tabletop action',
  })
  @ApiOkResponse({ type: FighterTableActionResponseDto })
  useClericTableAction(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UseClericTableActionDto,
  ): Promise<FighterTableActionResponseDto> {
    return this.cleric.useTableAction(user.id, id, dto);
  }

  @Post(':id/bard/table-action')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({
    summary: 'Resolve a Bard or Bard-subclass tabletop action',
  })
  @ApiOkResponse({ type: FighterTableActionResponseDto })
  useBardTableAction(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UseBardTableActionDto,
  ): Promise<FighterTableActionResponseDto> {
    return this.bard.useTableAction(user.id, id, dto);
  }

  @Post(':id/sorcerer/table-action')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({
    summary: 'Resolve a Sorcerer or Sorcerer-subclass tabletop action',
  })
  @ApiOkResponse({ type: FighterTableActionResponseDto })
  useSorcererTableAction(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UseSorcererTableActionDto,
  ): Promise<FighterTableActionResponseDto> {
    return this.sorcerer.useTableAction(user.id, id, dto);
  }

  @Post(':id/warlock/table-action')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({
    summary: 'Resolve a Warlock or Warlock-subclass tabletop action',
  })
  @ApiOkResponse({ type: FighterTableActionResponseDto })
  useWarlockTableAction(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UseWarlockTableActionDto,
  ): Promise<FighterTableActionResponseDto> {
    return this.warlock.useTableAction(user.id, id, dto);
  }

  @Post(':id/druid/table-action')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({
    summary: 'Resolve a Druid or Druid-subclass tabletop action',
  })
  @ApiOkResponse({ type: FighterTableActionResponseDto })
  useDruidTableAction(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UseDruidTableActionDto,
  ): Promise<FighterTableActionResponseDto> {
    return this.druid.useTableAction(user.id, id, dto);
  }

  @Post(':id/wizard/table-action')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({
    summary: 'Resolve a Wizard or Wizard-subclass tabletop action',
  })
  @ApiOkResponse({ type: FighterTableActionResponseDto })
  useWizardTableAction(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UseWizardTableActionDto,
  ): Promise<FighterTableActionResponseDto> {
    return this.wizard.useTableAction(user.id, id, dto);
  }
}
