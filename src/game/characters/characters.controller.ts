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
import { CharactersService } from './characters.service';
import { CreateCharacterDto } from './dto/create-character.dto';
import { UpdateCharacterDto } from './dto/update-character.dto';
import { CharacterResponseDto } from './dto/character-response.dto';

@ApiTags('game-characters')
@ApiBearerAuth()
@ApiUnauthorizedResponse({ description: 'Missing or invalid Bearer token' })
@UseGuards(SupabaseAuthGuard)
@Controller('characters')
export class CharactersController {
  constructor(private readonly charactersService: CharactersService) {}

  @Get()
  @ApiOperation({ summary: 'List characters for the authenticated user' })
  @ApiOkResponse({ type: [CharacterResponseDto] })
  findAll(@CurrentUser() user: AuthUser): Promise<CharacterResponseDto[]> {
    return this.charactersService.findAllForUser(user.id);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get a character by id' })
  @ApiOkResponse({ type: CharacterResponseDto })
  @ApiNotFoundResponse()
  findOne(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<CharacterResponseDto> {
    return this.charactersService.findOneForUser(user.id, id);
  }

  @Post()
  @ApiOperation({ summary: 'Create a new character' })
  @ApiCreatedResponse({ type: CharacterResponseDto })
  create(
    @CurrentUser() user: AuthUser,
    @Body() dto: CreateCharacterDto,
  ): Promise<CharacterResponseDto> {
    return this.charactersService.create(user.id, dto);
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
    return this.charactersService.update(user.id, id, dto);
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
    return this.charactersService.remove(user.id, id);
  }
}
