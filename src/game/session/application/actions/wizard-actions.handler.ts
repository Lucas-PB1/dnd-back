import { BadRequestException, Injectable } from '@nestjs/common';
import { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import { isWizardClass } from '@game/combat/domain/wizard';
import { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import {
  TableActionResponseDto,
  UseWizardTableActionDto,
} from '@game/session/dto';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { resolveDeclaredEconomyTableAction } from '../core/resolve-declared-economy-table-action';
import type { WizardActionDeps } from './wizard/wizard-action-deps';
import {
  resolveArcaneRecovery,
  resolveSpellMastery,
} from './wizard/base-actions';
import {
  resolveArcaneWard,
  resolveArcaneWardRecharge,
  resolveProjectedWard,
  resolveSpellBreaker,
} from './wizard/abjurer-actions';
import { resolvePortent, resolveThirdEye } from './wizard/diviner-actions';
import {
  resolveOverchannel,
  resolveSculptSpells,
} from './wizard/evoker-actions';
import {
  resolveIllusoryReality,
  resolveIllusorySelf,
  resolveImprovedIllusions,
  resolveSpectralSummon,
} from './wizard/illusionist-actions';
import { resolveMissileFlag } from './wizard/missile-mage-actions';

@Injectable()
export class WizardActionsHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
    private readonly domain: CharacterDomainService,
    private readonly mechanicalCatalog: LoadCombatMechanicalCatalog,
  ) {}

  private deps(): WizardActionDeps {
    return { state: this.state, domain: this.domain };
  }

  async useTableAction(
    userId: string,
    characterId: string,
    dto: UseWizardTableActionDto,
  ): Promise<TableActionResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    if (!isWizardClass(character.classSlug)) {
      throw new BadRequestException('Wizard action is not available');
    }

    const deps = this.deps();
    switch (dto.actionSlug) {
      case 'arcane-recovery-1':
        return resolveArcaneRecovery(deps, character, 1);
      case 'arcane-recovery-2':
        return resolveArcaneRecovery(deps, character, 2);
      case 'arcane-recovery-3':
        return resolveArcaneRecovery(deps, character, 3);
      case 'arcane-recovery-4':
        return resolveArcaneRecovery(deps, character, 4);
      case 'arcane-recovery-5':
        return resolveArcaneRecovery(deps, character, 5);

      case 'arcane-ward':
        return resolveArcaneWard(deps, character);
      case 'arcane-ward-recharge':
        return resolveArcaneWardRecharge(deps, character);
      case 'projected-ward':
        return resolveProjectedWard(deps, character);
      case 'spell-breaker':
        return resolveSpellBreaker(deps, character);

      case 'portent':
        return resolvePortent(deps, character);
      case 'third-eye':
        return resolveThirdEye(deps, character);

      case 'sculpt-spells':
        return resolveSculptSpells(deps, character);
      case 'overchannel':
        return resolveOverchannel(deps, character);

      case 'improved-illusions':
        return resolveImprovedIllusions(deps, character);
      case 'spectral-summon':
        return resolveSpectralSummon(deps, character);
      case 'illusory-self':
        return resolveIllusorySelf(deps, character);
      case 'illusory-reality':
        return resolveIllusoryReality(deps, character);

      case 'spell-mastery':
        return resolveSpellMastery(deps, character);
      case 'arm-missile-shield':
        return resolveMissileFlag(deps, character, 'shield', true);
      case 'disarm-missile-shield':
        return resolveMissileFlag(deps, character, 'shield', false);
      case 'arm-giga-missile':
        return resolveMissileFlag(deps, character, 'giga', true);
      case 'disarm-giga-missile':
        return resolveMissileFlag(deps, character, 'giga', false);
      default:
        return resolveDeclaredEconomyTableAction(
          { state: this.state, mechanicalCatalog: this.mechanicalCatalog },
          character,
          dto.actionSlug,
        );
    }
  }
}
