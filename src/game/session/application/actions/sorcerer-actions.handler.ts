import { BadRequestException, Injectable } from '@nestjs/common';
import { isSorcererClass } from '@game/combat/domain/sorcerer-features';
import { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import {
  TableActionResponseDto,
  UseSorcererTableActionDto,
} from '@game/session/dto/character-state.dto';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import type { SorcererActionDeps } from './sorcerer/sorcerer-action-deps';
import {
  convertPointsToSlot,
  convertSlotToPoints,
  useMetamagic,
} from './sorcerer/font-of-magic-actions';
import {
  resolveBastionOfLaw,
  resolveInnateSorcery,
  resolveSorcerousRestoration,
  resolveTidesOfChaos,
} from './sorcerer/feature-actions';

@Injectable()
export class SorcererActionsHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
    private readonly domain: CharacterDomainService,
  ) {}

  private deps(): SorcererActionDeps {
    return { state: this.state, domain: this.domain };
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

      case 'use-metamagic-1':
        return useMetamagic(deps, character, 1, 'Metamágica (1 ponto)');
      case 'use-metamagic-2':
        return useMetamagic(deps, character, 2, 'Metamágica (2 pontos)');
      case 'use-metamagic-3':
        return useMetamagic(deps, character, 3, 'Metamágica (3 pontos)');

      case 'innate-sorcery':
        return resolveInnateSorcery(deps, character);
      case 'sorcerous-restoration':
        return resolveSorcerousRestoration(deps, character);
      case 'tides-of-chaos':
        return resolveTidesOfChaos(deps, character);
      case 'bastion-of-law':
        return resolveBastionOfLaw(deps, character);
    }
  }
}
