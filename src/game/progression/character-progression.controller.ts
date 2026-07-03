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
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
  ApiTags,
  ApiUnauthorizedResponse,
} from '@nestjs/swagger';
import { SupabaseAuthGuard } from '../../identity/guards/supabase-auth.guard';
import { CurrentUser } from '../../identity/decorators/current-user.decorator';
import { AuthUser } from '../../identity/auth-user';
import { LevelUpPreviewQuery } from './application/level-up-preview.query';
import { LevelUpHandler } from './application/level-up.handler';
import { LevelUpDto, LevelUpPreviewDto } from './dto/level-up.dto';
import { CharacterResponseDto } from '../characters/dto/character-response.dto';

@ApiTags('game-characters')
@ApiBearerAuth()
@ApiUnauthorizedResponse({ description: 'Missing or invalid Bearer token' })
@UseGuards(SupabaseAuthGuard)
@Controller('characters')
export class CharacterProgressionController {
  constructor(
    private readonly levelUpPreview: LevelUpPreviewQuery,
    private readonly levelUp: LevelUpHandler,
  ) {}

  @Get(':id/level-up/preview')
  @ApiOperation({ summary: 'Preview the next level (HP, PB, spells, subclass)' })
  @ApiOkResponse({ type: LevelUpPreviewDto })
  @ApiNotFoundResponse()
  previewLevelUp(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<LevelUpPreviewDto> {
    return this.levelUpPreview.execute(user.id, id);
  }

  @Post(':id/level-up')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({ summary: 'Increase level by 1 with optional choices' })
  @ApiOkResponse({ type: CharacterResponseDto })
  @ApiNotFoundResponse()
  applyLevelUp(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: LevelUpDto,
  ): Promise<CharacterResponseDto> {
    return this.levelUp.execute(user.id, id, dto);
  }
}
