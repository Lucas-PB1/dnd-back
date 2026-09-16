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
import { ApplyVehicleSheetActionHandler } from '../application/apply-vehicle-sheet-action.handler';
import {
  BoardCharacterVehicleDto,
  CharacterVehicleBoardResponseDto,
  CharacterVehicleLinkResponseDto,
  LinkCharacterVehicleDto,
  VehicleSheetActionDto,
  VehicleSheetActionResponseDto,
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
    private readonly sheetAction: ApplyVehicleSheetActionHandler,
  ) {}

  @Post('link')
  @ApiOperation({
    summary:
      'Link a transport inventory item (or template) as a vehicle or mount actor on the character',
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

  @Post('sheet-actions')
  @ApiOperation({
    summary:
      'Ações de ficha do veículo: embarcar/desembarcar, métricas (tripulação/carga) e leme',
  })
  @ApiOkResponse({ type: VehicleSheetActionResponseDto })
  sheetActions(
    @CurrentUser() user: AuthUser,
    @Param('characterId', ParseUUIDPipe) characterId: string,
    @Body() dto: VehicleSheetActionDto,
  ): Promise<VehicleSheetActionResponseDto> {
    return this.sheetAction.execute(user.id, characterId, dto);
  }
}
