import { BadRequestException, Injectable } from '@nestjs/common';
import { DataSource } from 'typeorm';
import { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { TableActionResponseDto } from '@game/session/dto/fighter/fighter-session.dto';
import { UseTransformationTableActionDto } from '@game/session/dto/table-actions/table-actions-transformation.dto';
import { loadCharacterTransformation } from '@game/session/infrastructure/queries/transformation-character.queries';
import { resolveFeatEconomyTableAction } from '../../core/resolve-feat-economy-table-action';

@Injectable()
export class TransformationActionsHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
    private readonly mechanicalCatalog: LoadCombatMechanicalCatalog,
    private readonly dataSource: DataSource,
  ) {}

  async useTableAction(
    userId: string,
    characterId: string,
    dto: UseTransformationTableActionDto,
  ): Promise<TableActionResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    const transformation = await loadCharacterTransformation(
      this.dataSource,
      character.id,
    );
    if (!transformation) {
      throw new BadRequestException(
        'Personagem não possui transformação ativa',
      );
    }

    return resolveFeatEconomyTableAction(
      { state: this.state, mechanicalCatalog: this.mechanicalCatalog },
      character,
      transformation.slug,
      dto.actionSlug,
      transformation,
    );
  }
}
