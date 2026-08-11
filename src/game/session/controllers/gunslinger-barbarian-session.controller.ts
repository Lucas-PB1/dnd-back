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
import { GunslingerActionsHandler } from '../application/actions/gunslinger-actions.handler';

@ApiTags('game-characters')
@ApiBearerAuth()
@ApiUnauthorizedResponse({ description: 'Missing or invalid Bearer token' })
@UseGuards(SupabaseAuthGuard)
@Controller('characters')
export class GunslingerBarbarianSessionController {
  constructor(private readonly gunslinger: GunslingerActionsHandler) {}

  @Get(':id/maneuvers')
  @ApiOperation({ summary: 'List Gunslinger maneuvers available at current level' })
  @ApiNotFoundResponse()
  listManeuvers(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
  ) {
    return this.gunslinger.listManeuvers(user.id, id);
  }
}
