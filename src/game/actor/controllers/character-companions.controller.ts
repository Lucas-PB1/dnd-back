import {
  Body,
  Controller,
  Get,
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
import { SyncCharacterCompanionHandler } from '../application/sync-character-companion.handler';
import { ListCharacterCompanionsQuery } from '../application/list-character-companions.query';
import { DismissCharacterCompanionHandler } from '../application/dismiss-character-companion.handler';
import {
  CharacterCompanionSyncResponseDto,
  CompanionTrackerDto,
  DismissCharacterCompanionDto,
  SyncCharacterCompanionDto,
} from '../dto/character-companion.dto';

@ApiTags('game-character-companions')
@ApiBearerAuth()
@ApiUnauthorizedResponse({ description: 'Missing or invalid Bearer token' })
@UseGuards(SupabaseAuthGuard)
@Controller('characters/:characterId/companions')
export class CharacterCompanionsController {
  constructor(
    private readonly listCompanions: ListCharacterCompanionsQuery,
    private readonly syncCompanion: SyncCharacterCompanionHandler,
    private readonly dismissCompanion: DismissCharacterCompanionHandler,
  ) {}

  @Get()
  @ApiOperation({
    summary: 'Tracker leve dos companheiros vinculados (PV, derrotado, condições)',
  })
  @ApiOkResponse({ type: [CompanionTrackerDto] })
  list(
    @CurrentUser() user: AuthUser,
    @Param('characterId', ParseUUIDPipe) characterId: string,
  ): Promise<CompanionTrackerDto[]> {
    return this.listCompanions.execute(user.id, characterId);
  }

  @Post('sync')
  @ApiOperation({
    summary:
      'Sincroniza o companheiro da ficha (spawn ou troca de template) a partir das opções de subclasse',
  })
  @ApiOkResponse({ type: CharacterCompanionSyncResponseDto })
  sync(
    @CurrentUser() user: AuthUser,
    @Param('characterId', ParseUUIDPipe) characterId: string,
    @Body() dto: SyncCharacterCompanionDto,
  ): Promise<CharacterCompanionSyncResponseDto> {
    return this.syncCompanion.execute(user.id, characterId, dto);
  }

  @Post('dismiss')
  @ApiOperation({ summary: 'Dispensa (remove) um companheiro vinculado' })
  @ApiOkResponse({ schema: { example: { dismissedActorId: 'uuid' } } })
  dismiss(
    @CurrentUser() user: AuthUser,
    @Param('characterId', ParseUUIDPipe) characterId: string,
    @Body() dto: DismissCharacterCompanionDto,
  ): Promise<{ dismissedActorId: string }> {
    return this.dismissCompanion.execute(user.id, characterId, dto);
  }
}
