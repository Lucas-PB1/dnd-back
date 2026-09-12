import { Body, Param, ParseUUIDPipe } from '@nestjs/common';
import { CurrentUser } from '@identity/decorators/current-user.decorator';
import { AuthUser } from '@identity/auth-user';
import { FeatEconomyActionsHandler } from '../../application/actions/feat/feat-economy-actions.handler';
import { TableActionResponseDto } from '../../dto/fighter/fighter-session.dto';
import { UseFeatTableActionDto } from '../../dto/table-actions/table-actions-feat.dto';
import { TransformationTableActionsHost } from './transformation.routes';
import { TableActionEndpoint } from './route-decorators';

export abstract class TableActionsHost extends TransformationTableActionsHost {
  abstract readonly featEconomy: FeatEconomyActionsHandler;

  @TableActionEndpoint(
    'feat',
    'Resolve a feat economy tabletop action (origin / general feats)',
  )
  useFeatTableAction(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UseFeatTableActionDto,
  ): Promise<TableActionResponseDto> {
    return this.featEconomy.useTableAction(user.id, id, dto);
  }
}
