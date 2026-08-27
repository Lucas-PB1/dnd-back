import {
  Body,
  Controller,
  HttpCode,
  HttpStatus,
  Param,
  ParseUUIDPipe,
  Patch,
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
import { CharacterThreadCommands } from './application/character-thread.commands';
import {
  AttachCharacterThreadDto,
  CharacterThreadBundleDto,
  ReachCharacterThreadMilestoneDto,
  SetCharacterThreadGoalDto,
} from './dto/character-thread.dto';

@ApiTags('game-character-threads')
@ApiBearerAuth()
@ApiUnauthorizedResponse({ description: 'Missing or invalid Bearer token' })
@UseGuards(SupabaseAuthGuard)
@Controller('characters/:characterId/thread')
export class CharacterThreadController {
  constructor(private readonly commands: CharacterThreadCommands) {}

  @Post()
  @ApiOperation({ summary: 'Attach an active Character Thread (max 1)' })
  @ApiOkResponse({ type: CharacterThreadBundleDto })
  attach(
    @CurrentUser() user: AuthUser,
    @Param('characterId', ParseUUIDPipe) characterId: string,
    @Body() dto: AttachCharacterThreadDto,
  ): Promise<CharacterThreadBundleDto> {
    return this.commands.attach(user.id, characterId, dto);
  }

  @Patch('goal')
  @ApiOperation({ summary: 'Set goal on the active Character Thread' })
  @ApiOkResponse({ type: CharacterThreadBundleDto })
  setGoal(
    @CurrentUser() user: AuthUser,
    @Param('characterId', ParseUUIDPipe) characterId: string,
    @Body() dto: SetCharacterThreadGoalDto,
  ): Promise<CharacterThreadBundleDto> {
    return this.commands.setGoal(user.id, characterId, dto);
  }

  @Post('milestones')
  @ApiOperation({ summary: 'Reach a milestone rank on the active thread' })
  @ApiOkResponse({ type: CharacterThreadBundleDto })
  reachMilestone(
    @CurrentUser() user: AuthUser,
    @Param('characterId', ParseUUIDPipe) characterId: string,
    @Body() dto: ReachCharacterThreadMilestoneDto,
  ): Promise<CharacterThreadBundleDto> {
    return this.commands.reachMilestone(user.id, characterId, dto);
  }

  @Post('complete')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({ summary: 'Complete the active thread (keep benefits)' })
  @ApiOkResponse({ type: CharacterThreadBundleDto })
  complete(
    @CurrentUser() user: AuthUser,
    @Param('characterId', ParseUUIDPipe) characterId: string,
  ): Promise<CharacterThreadBundleDto> {
    return this.commands.complete(user.id, characterId);
  }

  @Post('abandon')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({ summary: 'Abandon the active thread (clear benefits)' })
  @ApiOkResponse({ type: CharacterThreadBundleDto })
  abandon(
    @CurrentUser() user: AuthUser,
    @Param('characterId', ParseUUIDPipe) characterId: string,
  ): Promise<CharacterThreadBundleDto> {
    return this.commands.abandon(user.id, characterId);
  }
}
