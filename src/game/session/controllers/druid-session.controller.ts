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
  ApiOkResponse,
  ApiOperation,
  ApiTags,
  ApiUnauthorizedResponse,
} from '@nestjs/swagger';
import { SupabaseAuthGuard } from '@identity/guards/supabase-auth.guard';
import { CurrentUser } from '@identity/decorators/current-user.decorator';
import { AuthUser } from '@identity/auth-user';
import { DruidActionsHandler } from '../application/actions/druid/druid-actions.handler';
import { WildShapeEligibleListResponseDto } from '../dto/druid/wild-shape-eligible.dto';

@ApiTags('game-characters')
@ApiBearerAuth()
@ApiUnauthorizedResponse({ description: 'Missing or invalid Bearer token' })
@UseGuards(SupabaseAuthGuard)
@Controller('characters')
export class DruidSessionController {
  constructor(private readonly druid: DruidActionsHandler) {}

  @Get(':id/druid/wild-shape/eligible')
  @ApiOperation({
    summary:
      'Lista bestas elegíveis à Forma Selvagem (CR/fly) e formas conhecidas',
  })
  @ApiOkResponse({ type: WildShapeEligibleListResponseDto })
  @ApiNotFoundResponse()
  listEligibleWildShapeBeasts(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<WildShapeEligibleListResponseDto> {
    return this.druid.listEligibleWildShapeBeasts(user.id, id);
  }
}
