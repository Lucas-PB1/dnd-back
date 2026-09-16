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
import { ApplyMountSheetActionHandler } from '../application/apply-mount-sheet-action.handler';
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
import {
  MountSheetActionDto,
  MountSheetActionResponseDto,
} from '../dto/character-mount.dto';

@ApiTags('game-character-mounts')
@ApiBearerAuth()
@ApiUnauthorizedResponse({ description: 'Missing or invalid Bearer token' })
@UseGuards(SupabaseAuthGuard)
@Controller('characters/:characterId/mounts')
export class CharacterMountsController {
  constructor(
    private readonly linkVehicle: LinkCharacterVehicleHandler,
    private readonly boardVehicle: BoardCharacterVehicleHandler,
    private readonly sheetAction: ApplyMountSheetActionHandler,
  ) {}

  @Post('link')
  @ApiOperation({
    summary: 'Vincula item/template de montaria como game_actor (kind mount)',
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
    summary: 'Embarca ou desmonta (actorId null) uma montaria vinculada',
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
      'Ações de ficha da montaria: board/dismount, Toque Curativo, declare Passo Feérico / Derrubar Brilho',
  })
  @ApiOkResponse({ type: MountSheetActionResponseDto })
  sheetActions(
    @CurrentUser() user: AuthUser,
    @Param('characterId', ParseUUIDPipe) characterId: string,
    @Body() dto: MountSheetActionDto,
  ): Promise<MountSheetActionResponseDto> {
    return this.sheetAction.execute(user.id, characterId, dto);
  }
}
