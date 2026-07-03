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
import { GetCharacterInventoryQuery } from './application/get-character-inventory.query';
import { AddInventoryItemHandler } from './application/add-inventory-item.handler';
import { PatchInventoryItemHandler } from './application/patch-inventory-item.handler';
import { RemoveInventoryItemHandler } from './application/remove-inventory-item.handler';
import {
  AddInventoryItemDto,
  CharacterInventoryResponseDto,
  InventoryItemResponseDto,
  PatchInventoryItemDto,
} from './dto/inventory.dto';

@ApiTags('game-characters')
@ApiBearerAuth()
@ApiUnauthorizedResponse({ description: 'Missing or invalid Bearer token' })
@UseGuards(SupabaseAuthGuard)
@Controller('characters')
export class CharacterInventoryController {
  constructor(
    private readonly getInventory: GetCharacterInventoryQuery,
    private readonly addInventoryItem: AddInventoryItemHandler,
    private readonly patchInventoryItem: PatchInventoryItemHandler,
    private readonly removeInventoryItem: RemoveInventoryItemHandler,
  ) {}

  @Get(':id/inventory')
  @ApiOperation({ summary: 'List character inventory (backpack + equipped)' })
  @ApiOkResponse({ type: CharacterInventoryResponseDto })
  @ApiNotFoundResponse()
  listInventory(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<CharacterInventoryResponseDto> {
    return this.getInventory.execute(user.id, id);
  }

  @Post(':id/inventory')
  @ApiOperation({ summary: 'Add item to backpack' })
  @ApiCreatedResponse({ type: InventoryItemResponseDto })
  @ApiNotFoundResponse()
  addInventory(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: AddInventoryItemDto,
  ): Promise<InventoryItemResponseDto> {
    return this.addInventoryItem.execute(user.id, id, dto);
  }

  @Patch(':id/inventory/:itemSlug')
  @ApiOperation({ summary: 'Update quantity or equip / unequip item' })
  @ApiOkResponse({ type: InventoryItemResponseDto })
  @ApiNotFoundResponse()
  patchInventory(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Param('itemSlug') itemSlug: string,
    @Body() dto: PatchInventoryItemDto,
  ): Promise<InventoryItemResponseDto> {
    return this.patchInventoryItem.execute(user.id, id, itemSlug, dto);
  }

  @Delete(':id/inventory/:itemSlug')
  @HttpCode(HttpStatus.NO_CONTENT)
  @ApiOperation({ summary: 'Remove item from inventory' })
  @ApiNoContentResponse()
  @ApiNotFoundResponse()
  removeInventory(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Param('itemSlug') itemSlug: string,
  ): Promise<void> {
    return this.removeInventoryItem.execute(user.id, id, itemSlug);
  }
}
