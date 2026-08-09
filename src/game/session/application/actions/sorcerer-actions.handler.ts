import { BadRequestException, Injectable } from '@nestjs/common';
import { DataSource } from 'typeorm';
import {
  isSorcererClass,
  METAMAGIC_OPTION_KEY,
  type MetamagicCatalogRow,
} from '@game/combat/domain/sorcerer';
import { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import {
  TableActionResponseDto,
  UseSorcererTableActionDto,
} from '@game/session/dto';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import type { SorcererActionDeps } from './sorcerer/sorcerer-action-deps';
import {
  convertPointsToSlot,
  convertSlotToPoints,
  useMetamagicOption,
} from './sorcerer/font-of-magic-actions';
import {
  resolveBastionOfLaw,
  resolveBendLuck,
  resolveDragonWings,
  resolveHeroicSoul,
  resolveInnateSorcery,
  resolveMysticalManeuver,
  resolveRestoreBalance,
  resolveSorcerousRestoration,
  resolveTidesOfChaos,
} from './sorcerer/feature-actions';

@Injectable()
export class SorcererActionsHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
    private readonly domain: CharacterDomainService,
    private readonly dataSource: DataSource,
  ) {}

  private deps(): SorcererActionDeps {
    return { state: this.state, domain: this.domain };
  }

  private async loadKnownMetamagicSlugs(
    characterId: string,
  ): Promise<string[]> {
    const rows = await this.dataSource.query<{ value_id: string }[]>(
      `SELECT value_id
       FROM rpg.player_character_option
       WHERE character_id = $1
         AND scope = 'class'
         AND option_key = $2
       ORDER BY instance_index ASC`,
      [characterId, METAMAGIC_OPTION_KEY],
    );
    return rows.map((row) => row.value_id);
  }

  private async loadMetamagicOption(
    slug: string,
  ): Promise<MetamagicCatalogRow | null> {
    const rows = await this.dataSource.query<
      {
        slug: string;
        name: string;
        description: string;
        cost: number;
        stacks_with_other: boolean;
      }[]
    >(
      `SELECT slug, name, description, cost, stacks_with_other
       FROM rpg.phb_metamagic
       WHERE slug = $1
       LIMIT 1`,
      [slug],
    );
    const row = rows[0];
    if (!row) return null;
    return {
      slug: row.slug,
      name: row.name,
      description: row.description,
      cost: Number(row.cost),
      stacksWithOther: row.stacks_with_other,
    };
  }

  async useTableAction(
    userId: string,
    characterId: string,
    dto: UseSorcererTableActionDto,
  ): Promise<TableActionResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    if (!isSorcererClass(character.classSlug)) {
      throw new BadRequestException('Sorcerer action is not available');
    }

    const deps = this.deps();
    switch (dto.actionSlug) {
      case 'convert-slot-1-to-points':
        return convertSlotToPoints(deps, character, 1);
      case 'convert-slot-2-to-points':
        return convertSlotToPoints(deps, character, 2);
      case 'convert-slot-3-to-points':
        return convertSlotToPoints(deps, character, 3);
      case 'convert-slot-4-to-points':
        return convertSlotToPoints(deps, character, 4);
      case 'convert-slot-5-to-points':
        return convertSlotToPoints(deps, character, 5);

      case 'convert-points-to-slot-1':
        return convertPointsToSlot(deps, character, 1);
      case 'convert-points-to-slot-2':
        return convertPointsToSlot(deps, character, 2);
      case 'convert-points-to-slot-3':
        return convertPointsToSlot(deps, character, 3);
      case 'convert-points-to-slot-4':
        return convertPointsToSlot(deps, character, 4);
      case 'convert-points-to-slot-5':
        return convertPointsToSlot(deps, character, 5);

      case 'use-metamagic': {
        if (!dto.metamagicSlug) {
          throw new BadRequestException('metamagicSlug é obrigatório');
        }
        const option = await this.loadMetamagicOption(dto.metamagicSlug);
        if (!option) {
          throw new BadRequestException(
            `Metamagia desconhecida: '${dto.metamagicSlug}'`,
          );
        }
        const known = await this.loadKnownMetamagicSlugs(character.id);
        return useMetamagicOption(deps, character, option, known);
      }

      case 'innate-sorcery':
        return resolveInnateSorcery(deps, character);
      case 'sorcerous-restoration':
        return resolveSorcerousRestoration(deps, character);
      case 'tides-of-chaos':
        return resolveTidesOfChaos(deps, character);
      case 'bastion-of-law':
        return resolveBastionOfLaw(deps, character, dto.pointsSpent);
      case 'restore-balance':
        return resolveRestoreBalance(deps, character);
      case 'dragon-wings':
        return resolveDragonWings(deps, character);
      case 'bend-luck':
        return resolveBendLuck(deps, character);
      case 'heroic-soul':
        return resolveHeroicSoul(deps, character);
      case 'mystical-maneuver':
        return resolveMysticalManeuver(deps, character);
    }
  }
}
