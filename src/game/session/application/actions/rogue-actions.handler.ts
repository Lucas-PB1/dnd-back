import { BadRequestException, Injectable } from '@nestjs/common';
import { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import {
  TableActionResponseDto,
  UseRogueTableActionDto,
} from '@game/session/dto';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { resolveDeclaredEconomyTableAction } from '../core/resolve-declared-economy-table-action';
import { assertCharacterSubclass } from '../core/table-action-guards';
import type { RogueActionDeps } from './rogue/rogue-action-deps';
import {
  resolveConditionalPsiBonus,
  rollPsychicBlade,
} from './rogue/psychic-blade-actions';
import {
  resolvePsychicTeleport,
  resolvePsychicVeil,
  resolvePsychicWhispers,
  resolveRendMind,
} from './rogue/soulknife-actions';
import {
  resolveArachnoidWeb,
  resolveMagicDeviceCharge,
  resolveSpellThief,
} from './rogue/subclass-actions';

@Injectable()
export class RogueActionsHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
    private readonly domain: CharacterDomainService,
    private readonly mechanicalCatalog: LoadCombatMechanicalCatalog,
  ) {}

  private deps(): RogueActionDeps {
    return {
      state: this.state,
      domain: this.domain,
      mechanicalCatalog: this.mechanicalCatalog,
    };
  }

  async useTableAction(
    userId: string,
    characterId: string,
    dto: UseRogueTableActionDto,
  ): Promise<TableActionResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    if (character.classSlug !== 'rogue') {
      throw new BadRequestException('Rogue action is not available');
    }

    if (dto.actionSlug.startsWith('psychic-')) {
      assertCharacterSubclass(character, 'soulknife', 'Soulknife');
    }

    const deps = this.deps();
    switch (dto.actionSlug) {
      case 'psychic-blade-main':
        return rollPsychicBlade(deps, character, false);
      case 'psychic-blade-bonus':
        return rollPsychicBlade(deps, character, true);
      case 'psi-bolstered-knack':
        return resolveConditionalPsiBonus(deps, character, dto, false);
      case 'guided-strike':
        return resolveConditionalPsiBonus(deps, character, dto, true);
      case 'psychic-whispers':
        return resolvePsychicWhispers(deps, character, dto.usePsiDie);
      case 'psychic-teleport':
        return resolvePsychicTeleport(deps, character);
      case 'psychic-veil':
        return resolvePsychicVeil(deps, character, dto.usePsiDie);
      case 'rend-mind':
        return resolveRendMind(deps, character, dto.usePsiDie);
      case 'spell-thief':
        return resolveSpellThief(deps, character);
      case 'arachnoid-web':
        return resolveArachnoidWeb(deps, character);
      case 'magic-device-charge':
        return resolveMagicDeviceCharge(deps, character);
      default:
        return resolveDeclaredEconomyTableAction(
          deps,
          character,
          dto.actionSlug,
        );
    }
  }
}
