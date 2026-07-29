import {
  Body,
  Controller,
  Get,
  HttpCode,
  HttpStatus,
  Param,
  ParseUUIDPipe,
  Patch,
  Post,
  UseGuards,
} from '@nestjs/common';
import {
  ApiBearerAuth,
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
  ApiTags,
  ApiUnauthorizedResponse,
} from '@nestjs/swagger';
import { SupabaseAuthGuard } from '../../identity/guards/supabase-auth.guard';
import { CurrentUser } from '../../identity/decorators/current-user.decorator';
import { AuthUser } from '../../identity/auth-user';
import { GetCharacterStateQuery } from './application/get-character-state.query';
import { PatchCharacterStateHandler } from './application/patch-character-state.handler';
import { CastSpellHandler } from './application/cast-spell.handler';
import { RestHandler } from './application/rest.handler';
import { UseClassResourceHandler } from './application/use-class-resource.handler';
import { GunslingerActionsHandler } from './application/gunslinger-actions.handler';
import { BarbarianActionsHandler } from './application/barbarian-actions.handler';
import { FighterActionsHandler } from './application/fighter-actions.handler';
import { RogueActionsHandler } from './application/rogue-actions.handler';
import { MonkActionsHandler } from './application/monk-actions.handler';
import { PaladinActionsHandler } from './application/paladin-actions.handler';
import { RangerActionsHandler } from './application/ranger-actions.handler';
import {
  ActionSurgeResponseDto,
  CastSpellDto,
  CastSpellResponseDto,
  CharacterStateResponseDto,
  FighterTableActionResponseDto,
  FireChamberDto,
  PatchCharacterStateDto,
  ReloadFirearmDto,
  RestDto,
  RestResponseDto,
  SecondWindResponseDto,
  TacticalMindDto,
  TacticalMindResponseDto,
  ToggleRageDto,
  ToggleRecklessDto,
  UseClassResourceDto,
  UseClassResourceResponseDto,
  UseBattleMasterManeuverDto,
  UseDungeonPrecautionDto,
  UseManeuverDto,
  UseManeuverResponseDto,
  UsePsiWarriorActionDto,
  UseRogueTableActionDto,
  UseMonkTableActionDto,
  UsePaladinTableActionDto,
  UseRangerTableActionDto,
} from './dto/character-state.dto';

@ApiTags('game-characters')
@ApiBearerAuth()
@ApiUnauthorizedResponse({ description: 'Missing or invalid Bearer token' })
@UseGuards(SupabaseAuthGuard)
@Controller('characters')
export class CharacterSessionController {
  constructor(
    private readonly getState: GetCharacterStateQuery,
    private readonly patchState: PatchCharacterStateHandler,
    private readonly castSpell: CastSpellHandler,
    private readonly rest: RestHandler,
    private readonly useResource: UseClassResourceHandler,
    private readonly gunslinger: GunslingerActionsHandler,
    private readonly barbarian: BarbarianActionsHandler,
    private readonly fighter: FighterActionsHandler,
    private readonly rogue: RogueActionsHandler,
    private readonly monk: MonkActionsHandler,
    private readonly paladin: PaladinActionsHandler,
    private readonly ranger: RangerActionsHandler,
  ) {}

  @Get(':id/state')
  @ApiOperation({ summary: 'Get live table state (slots, concentration, conditions)' })
  @ApiOkResponse({ type: CharacterStateResponseDto })
  @ApiNotFoundResponse()
  getCharacterState(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<CharacterStateResponseDto> {
    return this.getState.execute(user.id, id);
  }

  @Patch(':id/state')
  @ApiOperation({ summary: 'Update conditions, temp HP, or concentration' })
  @ApiOkResponse({ type: CharacterStateResponseDto })
  @ApiNotFoundResponse()
  updateCharacterState(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: PatchCharacterStateDto,
  ): Promise<CharacterStateResponseDto> {
    return this.patchState.execute(user.id, id, dto);
  }

  @Post(':id/spells/cast')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({ summary: 'Cast a spell (spends slot, sets concentration)' })
  @ApiOkResponse({ type: CastSpellResponseDto })
  @ApiNotFoundResponse()
  castCharacterSpell(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: CastSpellDto,
  ): Promise<CastSpellResponseDto> {
    return this.castSpell.execute(user.id, id, dto);
  }

  @Post(':id/rest')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({ summary: 'Short or long rest' })
  @ApiOkResponse({ type: RestResponseDto })
  @ApiNotFoundResponse()
  takeRest(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: RestDto,
  ): Promise<RestResponseDto> {
    return this.rest.execute(user.id, id, dto);
  }

  @Post(':id/resources/use')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({ summary: 'Spend a class resource use (rage, surge, Risk…)' })
  @ApiOkResponse({ type: UseClassResourceResponseDto })
  @ApiNotFoundResponse()
  useClassResource(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UseClassResourceDto,
  ): Promise<UseClassResourceResponseDto> {
    return this.useResource.execute(user.id, id, dto);
  }

  @Get(':id/maneuvers')
  @ApiOperation({ summary: 'List Gunslinger maneuvers available at current level' })
  @ApiNotFoundResponse()
  listManeuvers(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
  ) {
    return this.gunslinger.listManeuvers(user.id, id);
  }

  @Post(':id/maneuvers/use')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({ summary: 'Spend Risk and resolve a Gunslinger maneuver' })
  @ApiOkResponse({ type: UseManeuverResponseDto })
  @ApiNotFoundResponse()
  useManeuver(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UseManeuverDto,
  ): Promise<UseManeuverResponseDto> {
    return this.gunslinger.useManeuver(user.id, id, dto);
  }

  @Post(':id/firearms/reload')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({ summary: 'Reload a firearm chamber to full capacity' })
  @ApiOkResponse({ type: CharacterStateResponseDto })
  reloadFirearm(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: ReloadFirearmDto,
  ): Promise<CharacterStateResponseDto> {
    return this.gunslinger.reloadFirearm(user.id, id, dto);
  }

  @Post(':id/firearms/fire')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({ summary: 'Spend shots from a firearm chamber' })
  @ApiOkResponse({ type: CharacterStateResponseDto })
  fireChamber(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: FireChamberDto,
  ): Promise<CharacterStateResponseDto> {
    return this.gunslinger.fireChamber(user.id, id, dto);
  }

  @Post(':id/resources/risk/recover')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({
    summary: 'Gambito Terrível — recover 1 Risk die (nv.15+, on init/crit)',
  })
  @ApiOkResponse({ type: CharacterStateResponseDto })
  recoverRisk(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<CharacterStateResponseDto> {
    return this.gunslinger.recoverRisk(user.id, id);
  }

  @Post(':id/rage/toggle')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({
    summary: 'Enter/exit Rage (spends 1 use when entering)',
  })
  @ApiOkResponse({ type: CharacterStateResponseDto })
  toggleRage(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: ToggleRageDto,
  ): Promise<CharacterStateResponseDto> {
    return this.barbarian.toggleRage(user.id, id, dto);
  }

  @Post(':id/reckless/toggle')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({ summary: 'Toggle Reckless Attack (Barbarian nv.2+)' })
  @ApiOkResponse({ type: CharacterStateResponseDto })
  toggleReckless(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: ToggleRecklessDto,
  ): Promise<CharacterStateResponseDto> {
    return this.barbarian.toggleReckless(user.id, id, dto);
  }

  @Post(':id/resources/rage/recover-all')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({
    summary: 'Persistent Rage — recover all Rage uses (nv.15+, on initiative)',
  })
  @ApiOkResponse({ type: CharacterStateResponseDto })
  recoverAllRage(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<CharacterStateResponseDto> {
    return this.barbarian.recoverAllRage(user.id, id);
  }

  @Post(':id/fighter/second-wind')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({
    summary: 'Recuperar Fôlego — gasta 1 uso e cura 1d10 + nível',
  })
  @ApiOkResponse({ type: SecondWindResponseDto })
  useSecondWind(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<SecondWindResponseDto> {
    return this.fighter.useSecondWind(user.id, id);
  }

  @Post(':id/fighter/tactical-mind')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({
    summary:
      'Mente Tática — +1d10 em teste; gasta Recuperar Fôlego só se virar sucesso',
  })
  @ApiOkResponse({ type: TacticalMindResponseDto })
  useTacticalMind(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: TacticalMindDto,
  ): Promise<TacticalMindResponseDto> {
    return this.fighter.useTacticalMind(user.id, id, dto);
  }

  @Post(':id/fighter/action-surge')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({ summary: 'Surto de Ação — gasta 1 uso' })
  @ApiOkResponse({ type: ActionSurgeResponseDto })
  useActionSurge(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<ActionSurgeResponseDto> {
    return this.fighter.useActionSurge(user.id, id);
  }

  @Get(':id/fighter/maneuvers')
  @ApiOperation({ summary: 'List Battle Master maneuvers' })
  @ApiNotFoundResponse()
  listBattleMasterManeuvers(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
  ) {
    return this.fighter.listBattleMasterManeuvers(user.id, id);
  }

  @Post(':id/fighter/maneuvers/use')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({
    summary: 'Roll and spend a Battle Master maneuver for tabletop use',
  })
  @ApiOkResponse({ type: FighterTableActionResponseDto })
  useBattleMasterManeuver(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UseBattleMasterManeuverDto,
  ): Promise<FighterTableActionResponseDto> {
    return this.fighter.useBattleMasterManeuver(user.id, id, dto);
  }

  @Post(':id/fighter/psi-action')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({
    summary: 'Resolve a Psi Warrior tabletop action and spend its resource',
  })
  @ApiOkResponse({ type: FighterTableActionResponseDto })
  usePsiWarriorAction(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UsePsiWarriorActionDto,
  ): Promise<FighterTableActionResponseDto> {
    return this.fighter.usePsiWarriorAction(user.id, id, dto);
  }

  @Post(':id/fighter/dungeon-precaution')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({
    summary: 'Cast a Dungeoneer precaution and spend one of its five uses',
  })
  @ApiOkResponse({ type: FighterTableActionResponseDto })
  useDungeonPrecaution(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UseDungeonPrecautionDto,
  ): Promise<FighterTableActionResponseDto> {
    return this.fighter.useDungeonPrecaution(user.id, id, dto);
  }

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
}
