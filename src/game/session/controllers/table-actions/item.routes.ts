import { Body, Param, ParseUUIDPipe } from '@nestjs/common';
import { CurrentUser } from '@identity/decorators/current-user.decorator';
import { AuthUser } from '@identity/auth-user';
import { ItemEconomyActionsHandler } from '../../application/actions/item/item-economy-actions.handler';
import { TableActionResponseDto } from '../../dto/fighter/fighter-session.dto';
import { UseItemTableActionDto } from '../../dto/table-actions/table-actions-item.dto';
import { TableActionsHost } from './feat.routes';
import { TableActionEndpoint } from './route-decorators';

export abstract class ItemTableActionsHost extends TableActionsHost {
  abstract readonly itemEconomy: ItemEconomyActionsHandler;

  @TableActionEndpoint(
    'item',
    'Resolve an item economy tabletop action (charges / consumable sheet apply)',
  )
  useItemTableAction(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UseItemTableActionDto,
  ): Promise<TableActionResponseDto> {
    return this.itemEconomy.useTableAction(user.id, id, dto);
  }
}
