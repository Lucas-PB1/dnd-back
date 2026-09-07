import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import { LoadEffectCatalog } from '@game/effects';
import { PlayerCharacterItem } from '@game/inventory/infrastructure/player-character-item.entity';
import { parseHitDieLabel } from '@game/sheet/domain/stats/hit-points.calc';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { TableActionResponseDto } from '@game/session/dto/fighter/fighter-session.dto';
import { resolveFeatEconomyTableAction } from '../../core/resolve-feat-economy-table-action';

export type UseFeatTableActionDto = {
  featSlug: string;
  actionSlug: string;
  itemSlug?: string;
  enabled?: boolean;
};

@Injectable()
export class FeatEconomyActionsHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
    private readonly mechanicalCatalog: LoadCombatMechanicalCatalog,
    private readonly effectCatalog: LoadEffectCatalog,
    private readonly dataSource: DataSource,
    @InjectRepository(PlayerCharacterItem)
    private readonly items: Repository<PlayerCharacterItem>,
  ) {}

  async useTableAction(
    userId: string,
    characterId: string,
    dto: UseFeatTableActionDto,
  ): Promise<TableActionResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    const ownsFeat = await this.characterOwnsFeat(character.id, dto.featSlug);
    if (!ownsFeat) {
      throw new BadRequestException(
        `Personagem não possui o talento '${dto.featSlug}'`,
      );
    }
    const hitDieFaces = await this.loadHitDieFaces(character.classSlug);
    return resolveFeatEconomyTableAction(
      {
        state: this.state,
        mechanicalCatalog: this.mechanicalCatalog,
        effectCatalog: this.effectCatalog,
        hitDieFaces,
        items: this.items,
        dataSource: this.dataSource,
      },
      character,
      dto.featSlug,
      dto.actionSlug,
      null,
      { itemSlug: dto.itemSlug, enabled: dto.enabled },
    );
  }

  private async characterOwnsFeat(
    characterId: string,
    featSlug: string,
  ): Promise<boolean> {
    const rows = await this.dataSource.query<{ ok: number }[]>(
      `SELECT 1 AS ok
       FROM rpg.player_character_feat
       WHERE character_id = $1 AND feat_slug = $2
       LIMIT 1`,
      [characterId, featSlug],
    );
    return rows.length > 0;
  }

  private async loadHitDieFaces(
    classSlug: string | null | undefined,
  ): Promise<number> {
    if (!classSlug) return 8;
    const rows = await this.dataSource.query<{ hit_die: string }[]>(
      `SELECT hit_die FROM rpg.phb_class WHERE slug = $1 LIMIT 1`,
      [classSlug],
    );
    const label = rows[0]?.hit_die;
    if (!label) return 8;
    return parseHitDieLabel(label);
  }
}
