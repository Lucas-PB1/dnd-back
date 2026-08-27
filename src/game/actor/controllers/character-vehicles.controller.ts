import {
  Body,
  Controller,
  Param,
  ParseUUIDPipe,
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
import {
  BoardCharacterVehicleHandler,
  LinkCharacterVehicleHandler,
} from '../application/character-vehicle.handlers';
import {
  BoardCharacterVehicleDto,
  CharacterVehicleBoardResponseDto,
  CharacterVehicleLinkResponseDto,
  LinkCharacterVehicleDto,
} from '../dto/character-vehicle.dto';

@ApiTags('game-character-vehicles')
@ApiBearerAuth()
@ApiUnauthorizedResponse({ description: 'Missing or invalid Bearer token' })
@UseGuards(SupabaseAuthGuard)
@Controller('characters/:characterId/vehicles')
export class CharacterVehiclesController {
  constructor(
    private readonly linkVehicle: LinkCharacterVehicleHandler,
    private readonly boardVehicle: BoardCharacterVehicleHandler,
  ) {}

  @Post('link')
  @ApiOperation({
    summary:
      'Link a transport inventory item (or template) as a vehicle actor on the character',
  })
  @ApiOkResponse({ type: CharacterVehicleLinkResponseDto })
  link(
    @CurrentUser() user: AuthUser,
    @Param('characterId', ParseUUIDPipe) characterId: string,
    @Body() dto: LinkCharacterVehicleDto,
  ): Promise<CharacterVehicleLinkResponseDto> {
    return this.linkVehicle.execute(user.id, characterId, dto);
  }

  @Post('board')
  @ApiOperation({
    summary: 'Board a linked vehicle/mount, or leave (actorId null)',
  })
  @ApiOkResponse({ type: CharacterVehicleBoardResponseDto })
  board(
    @CurrentUser() user: AuthUser,
    @Param('characterId', ParseUUIDPipe) characterId: string,
    @Body() dto: BoardCharacterVehicleDto,
  ): Promise<CharacterVehicleBoardResponseDto> {
    return this.boardVehicle.execute(user.id, characterId, dto);
  }
}
