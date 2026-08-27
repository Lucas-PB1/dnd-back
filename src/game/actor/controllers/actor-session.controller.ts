import {
  Body,
  Controller,
  Get,
  Param,
  ParseUUIDPipe,
  Patch,
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
import { GetActorStateQuery } from '../application/get-actor-state.query';
import { PatchActorStateHandler } from '../application/patch-actor-state.handler';
import {
  ActorStateResponseDto,
  PatchActorStateDto,
} from '../dto/actor-state.dto';

@ApiTags('game-actors')
@ApiBearerAuth()
@ApiUnauthorizedResponse({ description: 'Missing or invalid Bearer token' })
@UseGuards(SupabaseAuthGuard)
@Controller('actors')
export class ActorSessionController {
  constructor(
    private readonly getState: GetActorStateQuery,
    private readonly patchState: PatchActorStateHandler,
  ) {}

  @Get(':id/state')
  @ApiOperation({ summary: 'Get live table state for an actor' })
  @ApiOkResponse({ type: ActorStateResponseDto })
  @ApiNotFoundResponse()
  getActorState(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<ActorStateResponseDto> {
    return this.getState.execute(user.id, id);
  }

  @Patch(':id/state')
  @ApiOperation({ summary: 'Update actor conditions, temp HP, HP, or concentration' })
  @ApiOkResponse({ type: ActorStateResponseDto })
  @ApiNotFoundResponse()
  patchActorState(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: PatchActorStateDto,
  ): Promise<ActorStateResponseDto> {
    return this.patchState.execute(user.id, id, dto);
  }
}
