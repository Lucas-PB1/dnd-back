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
  ApiCreatedResponse,
  ApiOkResponse,
  ApiOperation,
  ApiTags,
  ApiUnauthorizedResponse,
} from '@nestjs/swagger';
import { SupabaseAuthGuard } from '@identity/guards/supabase-auth.guard';
import { CurrentUser } from '@identity/decorators/current-user.decorator';
import { AuthUser } from '@identity/auth-user';
import { DuelService } from './application/duel.service';
import {
  CreateDuelDto,
  DuelAttackDto,
  DuelCastSpellDto,
  DuelConditionDto,
  DuelDetailDto,
  DuelSummaryDto,
  JoinDuelDto,
  SetDuelReadyDto,
} from './dto/duel.dto';

@ApiTags('game-duels')
@ApiBearerAuth()
@ApiUnauthorizedResponse({ description: 'Missing or invalid Bearer token' })
@UseGuards(SupabaseAuthGuard)
@Controller('duels')
export class DuelsController {
  constructor(private readonly duels: DuelService) {}

  @Get()
  @ApiOperation({ summary: 'List duels for the authenticated user' })
  @ApiOkResponse({ type: [DuelSummaryDto] })
  list(@CurrentUser() user: AuthUser): Promise<DuelSummaryDto[]> {
    return this.duels.list(user.id);
  }

  @Post()
  @ApiOperation({ summary: 'Create a duel with own character (invite code)' })
  @ApiCreatedResponse({ type: DuelDetailDto })
  create(
    @CurrentUser() user: AuthUser,
    @Body() dto: CreateDuelDto,
  ): Promise<DuelDetailDto> {
    return this.duels.create(user.id, dto);
  }

  @Post('join')
  @ApiOperation({ summary: 'Join a duel by invite code with own character' })
  @ApiOkResponse({ type: DuelDetailDto })
  join(
    @CurrentUser() user: AuthUser,
    @Body() dto: JoinDuelDto,
  ): Promise<DuelDetailDto> {
    return this.duels.join(user.id, dto);
  }

  @Get(':id')
  @ApiOperation({
    summary:
      'Get duel lobby/combat detail (member = participant; other accounts = spectator via link)',
  })
  @ApiOkResponse({ type: DuelDetailDto })
  getOne(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<DuelDetailDto> {
    return this.duels.getDetail(user.id, id);
  }

  @Post(':id/ready')
  @ApiOperation({ summary: 'Set ready; when both ready, start combat' })
  @ApiOkResponse({ type: DuelDetailDto })
  setReady(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: SetDuelReadyDto,
  ): Promise<DuelDetailDto> {
    return this.duels.setReady(user.id, id, dto);
  }

  @Post(':id/attack')
  @ApiOperation({
    summary: 'Attack opponent on your turn (vs AC, apply damage on hit)',
  })
  @ApiOkResponse({ type: DuelDetailDto })
  attack(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: DuelAttackDto,
  ): Promise<DuelDetailDto> {
    return this.duels.attack(user.id, id, dto);
  }

  @Post(':id/cast')
  @ApiOperation({
    summary:
      'Cast a spell on your turn (Escuridão, Mísseis, Raio de Fogo tipados)',
  })
  @ApiOkResponse({ type: DuelDetailDto })
  cast(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: DuelCastSpellDto,
  ): Promise<DuelDetailDto> {
    return this.duels.castSpell(user.id, id, dto);
  }

  @Post(':id/conditions')
  @ApiOperation({ summary: 'Add or remove a condition on self or opponent' })
  @ApiOkResponse({ type: DuelDetailDto })
  conditions(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: DuelConditionDto,
  ): Promise<DuelDetailDto> {
    return this.duels.changeCondition(user.id, id, dto);
  }

  @Post(':id/forfeit')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({ summary: 'Forfeit the duel (opponent wins if present)' })
  @ApiOkResponse({ type: DuelDetailDto })
  forfeit(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<DuelDetailDto> {
    return this.duels.forfeit(user.id, id);
  }
}
