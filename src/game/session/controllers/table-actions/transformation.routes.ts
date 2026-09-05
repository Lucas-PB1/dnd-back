import { Body, Param, ParseUUIDPipe } from '@nestjs/common';
import { CurrentUser } from '@identity/decorators/current-user.decorator';
import { AuthUser } from '@identity/auth-user';
import { TransformationActionsHandler } from '../../application/actions/transformation/transformation-actions.handler';
import { TableActionResponseDto } from '../../dto/fighter/fighter-session.dto';
import { UseTransformationTableActionDto } from '../../dto/table-actions/table-actions-transformation.dto';
import { NestMixinCtor } from './mixin-ctor';
import { TableActionEndpoint } from './route-decorators';

/** Transformações Grim Hollow Cap. 6 — economy tipada por boon. */
export function WithTransformationTableActions<TBase extends NestMixinCtor>(
  Base: TBase,
) {
  abstract class TransformationTableActionsHost extends Base {
    abstract readonly transformation: TransformationActionsHandler;

    @TableActionEndpoint(
      'transformation',
      'Resolve a Grim Hollow transformation tabletop action (Cap. 6 boon)',
    )
    useTransformationTableAction(
      @CurrentUser() user: AuthUser,
      @Param('id', ParseUUIDPipe) id: string,
      @Body() dto: UseTransformationTableActionDto,
    ): Promise<TableActionResponseDto> {
      return this.transformation.useTableAction(user.id, id, dto);
    }
  }
  return TransformationTableActionsHost;
}
