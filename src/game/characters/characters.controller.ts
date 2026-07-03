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
import { SupabaseAuthGuard } from '../../identity/guards/supabase-auth.guard';
import { CurrentUser } from '../../identity/decorators/current-user.decorator';
import { AuthUser } from '../../identity/auth-user';
import { ListCharactersQuery } from './application/list-characters.query';
import { GetCharacterQuery } from './application/get-character.query';
import { CreateCharacterHandler } from './application/create-character.handler';
import { UpdateCharacterHandler } from './application/update-character.handler';
import { DeleteCharacterHandler } from './application/delete-character.handler';
import { RollAbilitiesHandler } from './application/roll-abilities.handler';
import { LevelUpPreviewQuery } from './application/level-up-preview.query';
import { LevelUpHandler } from './application/level-up.handler';
import { CreateCharacterDto } from './dto/create-character.dto';
import { UpdateCharacterDto } from './dto/update-character.dto';
import { CharacterResponseDto } from './dto/character-response.dto';
import { RollAbilitiesDto, RollAbilitiesResponseDto } from './dto/roll-abilities.dto';
import { LevelUpDto, LevelUpPreviewDto } from './dto/level-up.dto';

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
    private readonly rollAbilities: RollAbilitiesHandler,
    private readonly levelUpPreview: LevelUpPreviewQuery,
    private readonly levelUp: LevelUpHandler,
  ) {}

  @Post('roll-abilities')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({ summary: 'Roll or assign ability scores (no character created)' })
  @ApiOkResponse({ type: RollAbilitiesResponseDto })
  rollAbilityScores(
    @Body() dto: RollAbilitiesDto,
  ): RollAbilitiesResponseDto {
    return this.rollAbilities.execute(dto);
  }

  @Get()
  @ApiOperation({ summary: 'List characters for the authenticated user' })
  @ApiOkResponse({ type: [CharacterResponseDto] })
  findAll(@CurrentUser() user: AuthUser): Promise<CharacterResponseDto[]> {
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
