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
import {
  CastSpellDto,
  CastSpellResponseDto,
  CharacterStateResponseDto,
  FireChamberDto,
  PatchCharacterStateDto,
  ReloadFirearmDto,
  RestDto,
  RestResponseDto,
  ToggleRageDto,
  ToggleRecklessDto,
  UseClassResourceDto,
  UseClassResourceResponseDto,
  UseManeuverDto,
  UseManeuverResponseDto,
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
}
