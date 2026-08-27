import {
  Controller,
  Get,
  Param,
  ParseUUIDPipe,
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
import { ListCharacterActorsQuery } from '../application/list-character-actors.query';
import { ActorSummaryResponseDto } from '../dto/actor.dto';

@ApiTags('game-actors')
@ApiBearerAuth()
@ApiUnauthorizedResponse({ description: 'Missing or invalid Bearer token' })
@UseGuards(SupabaseAuthGuard)
@Controller('characters/:characterId/actors')
export class CharacterActorsController {
  constructor(private readonly listActors: ListCharacterActorsQuery) {}

  @Get()
  @ApiOperation({ summary: 'List actors linked to a player character' })
  @ApiOkResponse({ type: [ActorSummaryResponseDto] })
  findAll(
    @CurrentUser() user: AuthUser,
    @Param('characterId', ParseUUIDPipe) characterId: string,
  ): Promise<ActorSummaryResponseDto[]> {
    return this.listActors.execute(user.id, characterId);
  }
}
