import {
  Body,
  Controller,
  Get,
  HttpCode,
  HttpStatus,
  Param,
  ParseUUIDPipe,
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
import { SupabaseAuthGuard } from '@identity/guards/supabase-auth.guard';
import { CurrentUser } from '@identity/decorators/current-user.decorator';
import { AuthUser } from '@identity/auth-user';
import { FighterActionsHandler } from '../application/actions/fighter-actions.handler';
import {
  ActionSurgeResponseDto,
  FighterTableActionResponseDto,
  SecondWindResponseDto,
  TacticalMindDto,
  TacticalMindResponseDto,
  UseBattleMasterManeuverDto,
  UseDungeonPrecautionDto,
  UsePsiWarriorActionDto,
} from '../dto';

@ApiTags('game-characters')
@ApiBearerAuth()
@ApiUnauthorizedResponse({ description: 'Missing or invalid Bearer token' })
@UseGuards(SupabaseAuthGuard)
@Controller('characters')
export class FighterSessionController {
  constructor(private readonly fighter: FighterActionsHandler) {}

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
      'Mente Tática — gasta Recuperar Fôlego e rola +1d10 (opcional: check+CD para gastar só em sucesso)',
  })
  @ApiOkResponse({ type: TacticalMindResponseDto })
  useTacticalMind(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: TacticalMindDto = {},
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
}
