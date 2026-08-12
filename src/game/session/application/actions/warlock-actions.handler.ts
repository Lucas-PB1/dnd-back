import { BadRequestException, Injectable } from '@nestjs/common';
import { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import { isWarlockClass } from '@game/combat/domain/warlock';
import { AssertCanBindPactWeaponService } from '@game/inventory/application/assert-can-bind-pact-weapon.service';
import { CharacterInventoryRepository } from '@game/inventory/infrastructure/character-inventory.repository';
import { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import {
  TableActionResponseDto,
  UseWarlockTableActionDto,
} from '@game/session/dto';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { resolveDeclaredEconomyTableAction } from '../core/resolve-declared-economy-table-action';
import type { WarlockActionDeps } from './warlock/warlock-action-deps';
import {
  resolveDarkOnesOwnLuck,
  resolveHealingLight,
  resolveMagicalCunning,
} from './warlock/base-actions';
import {
  resolveAwakenedMind,
  resolveBeguilingDefenses,
  resolveClairvoyantCombatant,
  resolveFeyStepEffect,
  resolveFiendishResilience,
  resolveHurlThroughHell,
  resolveSearingVengeance,
} from './warlock/patron-actions';
import { resolveInvokePactWeapon } from './warlock/pact-blade-actions';

@Injectable()
export class WarlockActionsHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
    private readonly domain: CharacterDomainService,
    private readonly inventory: CharacterInventoryRepository,
    private readonly assertCanBindPact: AssertCanBindPactWeaponService,
    private readonly mechanicalCatalog: LoadCombatMechanicalCatalog,
  ) {}

  private deps(): WarlockActionDeps {
    return {
      access: this.access,
      state: this.state,
      domain: this.domain,
    };
  }

  async useTableAction(
    userId: string,
    characterId: string,
    dto: UseWarlockTableActionDto,
  ): Promise<TableActionResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    if (!isWarlockClass(character.classSlug)) {
      throw new BadRequestException('Warlock action is not available');
    }

    const deps = this.deps();
    switch (dto.actionSlug) {
      case 'magical-cunning':
        return resolveMagicalCunning(deps, character);
      case 'healing-light':
        return resolveHealingLight(deps, character, dto.diceCount);
      case 'dark-ones-luck':
        return resolveDarkOnesOwnLuck(deps, character);
      case 'fey-step-effect':
        return resolveFeyStepEffect(deps, character);
      case 'awakened-mind':
        return resolveAwakenedMind(deps, character);
      case 'fiendish-resilience':
        return resolveFiendishResilience(deps, character);
      case 'invoke-pact-weapon':
        return resolveInvokePactWeapon(
          {
            ...deps,
            inventory: this.inventory,
            assertCanBindPact: this.assertCanBindPact,
          },
          character,
          dto.itemSlug,
        );
      case 'hurl-through-hell':
        return resolveHurlThroughHell(deps, character);
      case 'searing-vengeance':
        return resolveSearingVengeance(deps, character);
      case 'beguiling-defenses':
        return resolveBeguilingDefenses(deps, character);
      case 'clairvoyant-combatant':
        return resolveClairvoyantCombatant(deps, character);
      default:
        return resolveDeclaredEconomyTableAction(
          { state: this.state, mechanicalCatalog: this.mechanicalCatalog },
          character,
          dto.actionSlug,
        );
    }
  }
}
