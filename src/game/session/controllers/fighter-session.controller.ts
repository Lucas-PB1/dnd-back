import {
  Controller,
  Get,
  Param,
  ParseUUIDPipe,
  UseGuards,
} from '@nestjs/common';
import {
  ApiBearerAuth,
  ApiNotFoundResponse,
  ApiOperation,
  ApiTags,
  ApiUnauthorizedResponse,
} from '@nestjs/swagger';
import { SupabaseAuthGuard } from '@identity/guards/supabase-auth.guard';
import { CurrentUser } from '@identity/decorators/current-user.decorator';
import { AuthUser } from '@identity/auth-user';
import { FighterActionsHandler } from '../application/actions/fighter-actions.handler';

@ApiTags('game-characters')
@ApiBearerAuth()
@ApiUnauthorizedResponse({ description: 'Missing or invalid Bearer token' })
@UseGuards(SupabaseAuthGuard)
@Controller('characters')
export class FighterSessionController {
  constructor(private readonly fighter: FighterActionsHandler) {}

  @Get(':id/fighter/maneuvers')
  @ApiOperation({
    summary: 'List Battle Master maneuvers known to the character',
  })
  @ApiNotFoundResponse()
  listBattleMasterManeuvers(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
  ) {
    return this.fighter.listBattleMasterManeuvers(user.id, id);
  }
}
