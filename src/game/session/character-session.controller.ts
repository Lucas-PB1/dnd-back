import {
  Body,
  Controller,
  Get,
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
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
  ApiTags,
  ApiUnauthorizedResponse,
} from '@nestjs/swagger';
import { SupabaseAuthGuard } from '../../identity/guards/supabase-auth.guard';
import { CurrentUser } from '../../identity/decorators/current-user.decorator';
import { AuthUser } from '../../identity/auth-user';
import { GetCharacterStateQuery } from './application/get-character-state.query';
import { PatchCharacterStateHandler } from './application/patch-character-state.handler';
import { CastSpellHandler } from './application/cast-spell.handler';
import { RestHandler } from './application/rest.handler';
import {
  CastSpellDto,
  CastSpellResponseDto,
  CharacterStateResponseDto,
  PatchCharacterStateDto,
  RestDto,
  RestResponseDto,
} from './dto/character-state.dto';

@ApiTags('game-characters')
@ApiBearerAuth()
@ApiUnauthorizedResponse({ description: 'Missing or invalid Bearer token' })
@UseGuards(SupabaseAuthGuard)
@Controller('characters')
export class CharacterSessionController {
  constructor(
    private readonly getState: GetCharacterStateQuery,
    private readonly patchState: PatchCharacterStateHandler,
    private readonly castSpell: CastSpellHandler,
    private readonly rest: RestHandler,
  ) {}

  @Get(':id/state')
  @ApiOperation({ summary: 'Get live table state (slots, concentration, conditions)' })
  @ApiOkResponse({ type: CharacterStateResponseDto })
  @ApiNotFoundResponse()
  getCharacterState(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<CharacterStateResponseDto> {
    return this.getState.execute(user.id, id);
  }

  @Patch(':id/state')
  @ApiOperation({ summary: 'Update conditions, temp HP, or concentration' })
  @ApiOkResponse({ type: CharacterStateResponseDto })
  @ApiNotFoundResponse()
  updateCharacterState(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: PatchCharacterStateDto,
  ): Promise<CharacterStateResponseDto> {
    return this.patchState.execute(user.id, id, dto);
  }

  @Post(':id/spells/cast')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({ summary: 'Cast a spell (spends slot, sets concentration)' })
  @ApiOkResponse({ type: CastSpellResponseDto })
  @ApiNotFoundResponse()
  castCharacterSpell(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: CastSpellDto,
  ): Promise<CastSpellResponseDto> {
    return this.castSpell.execute(user.id, id, dto);
  }

  @Post(':id/rest')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({ summary: 'Short or long rest' })
  @ApiOkResponse({ type: RestResponseDto })
  @ApiNotFoundResponse()
  takeRest(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: RestDto,
  ): Promise<RestResponseDto> {
    return this.rest.execute(user.id, id, dto);
  }
}
