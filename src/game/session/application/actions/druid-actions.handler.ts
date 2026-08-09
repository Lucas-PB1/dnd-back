import { BadRequestException, Injectable } from '@nestjs/common';
import { isDruidClass } from '@game/combat/domain/druid-features';
import { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import {
  TableActionResponseDto,
  UseDruidTableActionDto,
} from '@game/session/dto/character-state.dto';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import type { DruidActionDeps } from './druid/druid-action-deps';
import {
  resolveWildResurgenceShape,
  resolveWildResurgenceSlot,
  resolveWildShape,
} from './druid/wild-shape-actions';
import {
  resolveMoonCombatWildShape,
  resolveStarryFormArcher,
  resolveStarryFormChalice,
  resolveStarryFormDragon,
  resolveWrathOfTheSea,
} from './druid/subclass-actions';

@Injectable()
export class DruidActionsHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
    private readonly domain: CharacterDomainService,
  ) {}

  private deps(): DruidActionDeps {
    return { state: this.state, domain: this.domain };
  }

  async useTableAction(
    userId: string,
    characterId: string,
    dto: UseDruidTableActionDto,
  ): Promise<TableActionResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    if (!isDruidClass(character.classSlug)) {
      throw new BadRequestException('Druid action is not available');
    }

    const deps = this.deps();
    switch (dto.actionSlug) {
      case 'wild-shape':
        return resolveWildShape(deps, character);
      case 'wild-resurgence-slot':
        return resolveWildResurgenceSlot(deps, character);
      case 'wild-resurgence-shape':
        return resolveWildResurgenceShape(deps, character);
      case 'starry-form-archer':
        return resolveStarryFormArcher(deps, character);
      case 'starry-form-chalice':
        return resolveStarryFormChalice(deps, character);
      case 'starry-form-dragon':
        return resolveStarryFormDragon(deps, character);
      case 'wrath-of-the-sea':
        return resolveWrathOfTheSea(deps, character);
      case 'moon-combat-wild-shape':
        return resolveMoonCombatWildShape(deps, character);
    }
  }
}
