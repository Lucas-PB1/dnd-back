import {
  Body,
  Controller,
  Delete,
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
  ApiNoContentResponse,
  ApiOkResponse,
  ApiOperation,
  ApiTags,
  ApiUnauthorizedResponse,
} from '@nestjs/swagger';
import { SupabaseAuthGuard } from '@identity/guards/supabase-auth.guard';
import { CurrentUser } from '@identity/decorators/current-user.decorator';
import { AuthUser } from '@identity/auth-user';
import { SkirmishService } from './application/skirmish.service';
import {
  AppendSkirmishLogDto,
  CastSkirmishSpellDto,
  CreateSkirmishDto,
  PatchSkirmishConditionDto,
  ResolveSkirmishAttackDto,
  SkirmishAttackResultDto,
  SkirmishDetailDto,
  SkirmishSummaryDto,
} from './dto/skirmish.dto';

@ApiTags('game-skirmishes')
@ApiBearerAuth()
@ApiUnauthorizedResponse({ description: 'Missing or invalid Bearer token' })
@UseGuards(SupabaseAuthGuard)
@Controller('skirmishes')
export class SkirmishesController {
  constructor(private readonly skirmishes: SkirmishService) {}

  @Get()
  @ApiOperation({ summary: 'List skirmishes for the authenticated user' })
  @ApiOkResponse({ type: [SkirmishSummaryDto] })
  list(@CurrentUser() user: AuthUser): Promise<SkirmishSummaryDto[]> {
    return this.skirmishes.list(user.id);
  }

  @Post()
  @ApiOperation({ summary: 'Start a solo skirmish vs a catalog creature' })
  @ApiCreatedResponse({ type: SkirmishDetailDto })
  create(
    @CurrentUser() user: AuthUser,
    @Body() dto: CreateSkirmishDto,
  ): Promise<SkirmishDetailDto> {
    return this.skirmishes.create(user.id, dto);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get skirmish combat detail' })
  @ApiOkResponse({ type: SkirmishDetailDto })
  getOne(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<SkirmishDetailDto> {
    return this.skirmishes.getDetail(user.id, id);
  }

  @Post(':id/attacks')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({ summary: 'Resolve a PC attack vs the creature' })
  @ApiOkResponse({ type: SkirmishAttackResultDto })
  attack(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: ResolveSkirmishAttackDto,
  ): Promise<SkirmishAttackResultDto> {
    return this.skirmishes.attack(user.id, id, dto);
  }

  @Post(':id/end-turn')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({
    summary: 'End the PC turn; resolves the creature turn automatically',
  })
  @ApiOkResponse({ type: SkirmishDetailDto })
  endTurn(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<SkirmishDetailDto> {
    return this.skirmishes.endTurn(user.id, id);
  }

  @Post(':id/finish')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({ summary: 'End the skirmish without a KO' })
  @ApiOkResponse({ type: SkirmishDetailDto })
  finish(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<SkirmishDetailDto> {
    return this.skirmishes.finish(user.id, id);
  }

  @Delete(':id')
  @HttpCode(HttpStatus.NO_CONTENT)
  @ApiOperation({ summary: 'Delete a skirmish' })
  @ApiNoContentResponse()
  remove(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<void> {
    return this.skirmishes.remove(user.id, id);
  }

  @Post(':id/cast')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({ summary: 'Cast a spell at the creature' })
  @ApiOkResponse({ type: SkirmishDetailDto })
  cast(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: CastSkirmishSpellDto,
  ): Promise<SkirmishDetailDto> {
    return this.skirmishes.cast(user.id, id, dto);
  }

  @Post(':id/conditions')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({ summary: 'Add or remove a condition' })
  @ApiOkResponse({ type: SkirmishDetailDto })
  patchCondition(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: PatchSkirmishConditionDto,
  ): Promise<SkirmishDetailDto> {
    return this.skirmishes.patchCondition(user.id, id, dto);
  }

  @Post(':id/log')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({ summary: 'Append a narration line to the combat log' })
  @ApiOkResponse({ type: SkirmishDetailDto })
  appendLog(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: AppendSkirmishLogDto,
  ): Promise<SkirmishDetailDto> {
    return this.skirmishes.appendNarration(user.id, id, dto.text);
  }

  @Post(':id/second-wind')
  @HttpCode(HttpStatus.OK)
  @ApiOkResponse({ type: SkirmishDetailDto })
  secondWind(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<SkirmishDetailDto> {
    return this.skirmishes.secondWind(user.id, id);
  }

  @Post(':id/action-surge')
  @HttpCode(HttpStatus.OK)
  @ApiOkResponse({ type: SkirmishDetailDto })
  actionSurge(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<SkirmishDetailDto> {
    return this.skirmishes.actionSurge(user.id, id);
  }
}
