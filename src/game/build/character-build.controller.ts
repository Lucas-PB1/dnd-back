import {
  Body,
  Controller,
  HttpCode,
  HttpStatus,
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
import { SupabaseAuthGuard } from '../../identity/guards/supabase-auth.guard';
import { RollAbilitiesHandler } from './application/roll-abilities.handler';
import { RollAbilitiesDto, RollAbilitiesResponseDto } from './dto/roll-abilities.dto';

@ApiTags('game-characters')
@ApiBearerAuth()
@ApiUnauthorizedResponse({ description: 'Missing or invalid Bearer token' })
@UseGuards(SupabaseAuthGuard)
@Controller('characters')
export class CharacterBuildController {
  constructor(private readonly rollAbilities: RollAbilitiesHandler) {}

  @Post('roll-abilities')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({ summary: 'Roll or assign ability scores (no character created)' })
  @ApiOkResponse({ type: RollAbilitiesResponseDto })
  rollAbilityScores(
    @Body() dto: RollAbilitiesDto,
  ): RollAbilitiesResponseDto {
    return this.rollAbilities.execute(dto);
  }
}
