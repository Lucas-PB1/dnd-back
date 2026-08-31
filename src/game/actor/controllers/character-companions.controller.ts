import {
  Body,
  Controller,
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
import {
  CharacterCompanionSyncResponseDto,
  SyncCharacterCompanionDto,
} from '../dto/character-companion.dto';

@ApiTags('game-character-companions')
@ApiBearerAuth()
@ApiUnauthorizedResponse({ description: 'Missing or invalid Bearer token' })
@UseGuards(SupabaseAuthGuard)
@Controller('characters/:characterId/companions')
export class CharacterCompanionsController {
  constructor(
    private readonly syncCompanion: SyncCharacterCompanionHandler,
  ) {}

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
}
