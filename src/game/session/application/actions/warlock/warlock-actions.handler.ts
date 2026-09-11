import { BadRequestException, Injectable } from '@nestjs/common';
import { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import { isWarlockClass } from '@game/combat/domain/warlock';
import { LoadEffectCatalog } from '@game/effects';
import { AssertCanBindPactWeaponService } from '@game/inventory/application/assert/assert-can-bind-pact-weapon.service';
import { CharacterInventoryRepository } from '@game/inventory/infrastructure/character-inventory.repository';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import {
  TableActionResponseDto,
} from '@game/session/dto/fighter/fighter-session.dto';
import {
  UseWarlockTableActionDto,
} from '@game/session/dto/table-actions/table-actions-caster.dto';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { applyDeclaredEconomyTableAction } from '../../core/apply-declared-economy-table-action';
import { applyInvokePactWeaponTableAction } from '../../core/apply-invoke-pact-weapon-table-action';

@Injectable()
export class WarlockActionsHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
    private readonly inventory: CharacterInventoryRepository,
    private readonly assertCanBindPact: AssertCanBindPactWeaponService,
    private readonly mechanicalCatalog: LoadCombatMechanicalCatalog,
    private readonly effectCatalog: LoadEffectCatalog,
  ) {}

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

    if (dto.actionSlug === 'invoke-pact-weapon') {
      return applyInvokePactWeaponTableAction({
        state: this.state,
        inventory: this.inventory,
        assertCanBindPact: this.assertCanBindPact,
        character,
        itemSlug: dto.itemSlug,
      });
    }

    return applyDeclaredEconomyTableAction(
      {
        state: this.state,
        mechanicalCatalog: this.mechanicalCatalog,
        effectCatalog: this.effectCatalog,
      },
      character,
      dto.actionSlug,
      dto.diceCount != null ? { diceCount: dto.diceCount } : {},
    );
  }
}
