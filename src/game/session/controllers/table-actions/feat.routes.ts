import { Body, Param, ParseUUIDPipe } from '@nestjs/common';
import { CurrentUser } from '@identity/decorators/current-user.decorator';
import { AuthUser } from '@identity/auth-user';
import { FeatEconomyActionsHandler } from '../../application/actions/feat/feat-economy-actions.handler';
import { TableActionResponseDto } from '../../dto/fighter/fighter-session.dto';
import { UseFeatTableActionDto } from '../../dto/table-actions/table-actions-feat.dto';
import { NestMixinCtor } from './mixin-ctor';
import { TableActionEndpoint } from './route-decorators';

/** Talentos PHB (economy tipada) — paralelo ao endpoint por classe. */
export function WithFeatTableActions<TBase extends NestMixinCtor>(Base: TBase) {
  abstract class FeatTableActionsHost extends Base {
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
  return FeatTableActionsHost;
}
