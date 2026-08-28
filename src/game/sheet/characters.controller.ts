import {
  Body,
  Controller,
  Delete,
  Get,
  HttpCode,
  HttpStatus,
  Param,
  ParseUUIDPipe,
  Patch,
  Post,
  Put,
  UseGuards,
} from '@nestjs/common';
import {
  ApiBearerAuth,
  ApiCreatedResponse,
  ApiNoContentResponse,
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
  ApiTags,
  ApiUnauthorizedResponse,
} from '@nestjs/swagger';
import { SupabaseAuthGuard } from '@identity/guards/supabase-auth.guard';
import { CurrentUser } from '@identity/decorators/current-user.decorator';
import { AuthUser } from '@identity/auth-user';
import { ListCharactersQuery } from './application/list-characters.query';
import { GetCharacterQuery } from './application/get-character.query';
import { CreateCharacterHandler } from './application/create-character.handler';
import { UpdateCharacterHandler } from './application/update-character.handler';
import { DeleteCharacterHandler } from './application/delete-character.handler';
import { PatchCharacterWealthHandler } from './application/patch-character-wealth.handler';
import { GetCharacterNotesQuery } from './application/get-character-notes.query';
import { UpdateCharacterNotesHandler } from './application/update-character-notes.handler';
import { CreateCharacterDto } from './dto/create-character.dto';
import { UpdateCharacterDto } from './dto/update-character.dto';
import { PatchCharacterWealthDto } from './dto/coin-purse.dto';
import { CoinPurseDto } from './dto/coin-purse.dto';
import {
  CharacterNotesResponseDto,
  UpdateCharacterNotesDto,
} from './dto/character-notes.dto';
import {
  CharacterResponseDto,
  CharacterSummaryResponseDto,
} from './dto/character-response.dto';

@ApiTags('game-characters')
@ApiBearerAuth()
@ApiUnauthorizedResponse({ description: 'Missing or invalid Bearer token' })
@UseGuards(SupabaseAuthGuard)
@Controller('characters')
export class CharactersController {
  constructor(
    private readonly listCharacters: ListCharactersQuery,
    private readonly getCharacter: GetCharacterQuery,
    private readonly createCharacter: CreateCharacterHandler,
    private readonly updateCharacter: UpdateCharacterHandler,
    private readonly deleteCharacter: DeleteCharacterHandler,
    private readonly patchWealth: PatchCharacterWealthHandler,
    private readonly getNotes: GetCharacterNotesQuery,
    private readonly updateNotes: UpdateCharacterNotesHandler,
  ) {}

  @Get()
  @ApiOperation({
    summary: 'List characters for the authenticated user (summary only)',
  })
  @ApiOkResponse({ type: [CharacterSummaryResponseDto] })
  findAll(
    @CurrentUser() user: AuthUser,
  ): Promise<CharacterSummaryResponseDto[]> {
    return this.listCharacters.execute(user.id);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get a character by id' })
  @ApiOkResponse({ type: CharacterResponseDto })
  @ApiNotFoundResponse()
  findOne(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<CharacterResponseDto> {
    return this.getCharacter.execute(user.id, id);
  }

  @Post()
  @ApiOperation({ summary: 'Create a new character' })
  @ApiCreatedResponse({ type: CharacterResponseDto })
  create(
    @CurrentUser() user: AuthUser,
    @Body() dto: CreateCharacterDto,
  ): Promise<CharacterResponseDto> {
    return this.createCharacter.execute(user.id, dto);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update a character' })
  @ApiOkResponse({ type: CharacterResponseDto })
  @ApiNotFoundResponse()
  update(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UpdateCharacterDto,
  ): Promise<CharacterResponseDto> {
    return this.updateCharacter.execute(user.id, id, dto);
  }

  @Patch(':id/wealth')
  @ApiOperation({ summary: 'Set character coin balances (PC/PP/PE/PO/PL)' })
  @ApiOkResponse({ type: CoinPurseDto })
  @ApiNotFoundResponse()
  updateWealth(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: PatchCharacterWealthDto,
  ): Promise<CoinPurseDto> {
    return this.patchWealth.execute(user.id, id, dto);
  }

  @Get(':id/notes')
  @ApiOperation({ summary: 'Get session notes for a character' })
  @ApiOkResponse({ type: CharacterNotesResponseDto })
  @ApiNotFoundResponse()
  getNotesByCharacter(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<CharacterNotesResponseDto> {
    return this.getNotes.execute(user.id, id);
  }

  @Put(':id/notes')
  @ApiOperation({ summary: 'Save session notes for a character' })
  @ApiOkResponse({ type: CharacterNotesResponseDto })
  @ApiNotFoundResponse()
  saveNotes(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UpdateCharacterNotesDto,
  ): Promise<CharacterNotesResponseDto> {
    return this.updateNotes.execute(user.id, id, dto);
  }

  @Delete(':id')
  @HttpCode(HttpStatus.NO_CONTENT)
  @ApiOperation({ summary: 'Delete a character' })
  @ApiNoContentResponse()
  @ApiNotFoundResponse()
  remove(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<void> {
    return this.deleteCharacter.execute(user.id, id);
  }
}
