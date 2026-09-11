import { Injectable } from '@nestjs/common';
import { DataSource } from 'typeorm';
import { CharacterRollsService } from '@game/dice/application/character-rolls.service';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import { ResolveEquippedWeaponAttacks } from '@game/combat/application/resolve-equipped-weapon-attacks';
import { LoadEffectCatalog } from '@game/effects';
import type { Duel } from '../../infrastructure/duel.entity';
import type { DuelMember } from '../../infrastructure/duel-member.entity';
import { DuelRepository } from '../../infrastructure/duel.repository';
import { DuelCombatSnapshot } from '../duel-combat-snapshot';
import { attack } from './attack';
import { forfeit, setReady } from './lifecycle';
import { changeCondition, castSpell } from './spells';
import { useActionSurge, useSecondWind } from './fighter';

@Injectable()
export class DuelCombatService {
  constructor(
    private readonly repo: DuelRepository,
    private readonly rolls: CharacterRollsService,
    private readonly state: CharacterStateRepository,
    private readonly snapshot: DuelCombatSnapshot,
    private readonly sheet: CharacterSheetRepository,
    private readonly domain: CharacterDomainService,
    private readonly access: PlayerCharacterAccessService,
    private readonly mechanicalCatalog: LoadCombatMechanicalCatalog,
    private readonly weaponAttacks: ResolveEquippedWeaponAttacks,
    private readonly effectCatalog: LoadEffectCatalog,
    private readonly dataSource: DataSource,
  ) {}

  private coreDeps() {
    return {
      repo: this.repo,
      rolls: this.rolls,
      state: this.state,
      snapshot: this.snapshot,
      sheet: this.sheet,
      domain: this.domain,
      access: this.access,
      mechanicalCatalog: this.mechanicalCatalog,
      weaponAttacks: this.weaponAttacks,
      effectCatalog: this.effectCatalog,
      dataSource: this.dataSource,
    };
  }

  private lifecycleDeps() {
    return {
      repo: this.repo,
      rolls: this.rolls,
      state: this.state,
      snapshot: this.snapshot,
    };
  }

  private fighterDeps() {
    return {
      repo: this.repo,
      state: this.state,
      access: this.access,
      snapshot: this.snapshot,
    };
  }

  private spellsDeps() {
    return {
      repo: this.repo,
      state: this.state,
      sheet: this.sheet,
      access: this.access,
      snapshot: this.snapshot,
      domain: this.domain,
      dataSource: this.dataSource,
    };
  }

  private attackDeps() {
    const core = this.coreDeps();
    return {
      repo: core.repo,
      rolls: core.rolls,
      state: core.state,
      snapshot: core.snapshot,
      sheet: core.sheet,
      domain: core.domain,
      mechanicalCatalog: core.mechanicalCatalog,
      weaponAttacks: core.weaponAttacks,
      effectCatalog: core.effectCatalog,
      dataSource: core.dataSource,
    };
  }

  setReady(
    userId: string,
    duelId: string,
    ready: boolean,
  ): Promise<{ duel: Duel; members: DuelMember[] }> {
    return setReady(this.lifecycleDeps(), userId, duelId, ready);
  }

  attack(
    userId: string,
    duelId: string,
    input: {
      itemSlug: string;
      mode: 'melee' | 'ranged';
      bloodStrike?: { optionSlug: string; takeLowerBloodCost?: boolean };
      damageTypeOverride?: 'acid' | 'necrotic' | 'poison';
      bloodExplosionOnMiss?: boolean;
      masteryOverrideSlug?: 'push' | 'sap' | 'slow';
      graze?: boolean;
    },
  ): Promise<{ duel: Duel; members: DuelMember[] }> {
    return attack(this.attackDeps(), userId, duelId, input);
  }

  castSpell(
    userId: string,
    duelId: string,
    input: { spellSlug: string; slotLevel?: number },
  ): Promise<{ duel: Duel; members: DuelMember[] }> {
    return castSpell(this.spellsDeps(), userId, duelId, input);
  }

  changeCondition(
    userId: string,
    duelId: string,
    input: {
      action: 'add' | 'remove';
      target: 'self' | 'opponent';
      condition: string;
    },
  ): Promise<{ duel: Duel; members: DuelMember[] }> {
    return changeCondition(this.spellsDeps(), userId, duelId, input);
  }

  useSecondWind(
    userId: string,
    duelId: string,
  ): Promise<{ duel: Duel; members: DuelMember[] }> {
    return useSecondWind(this.fighterDeps(), userId, duelId);
  }

  useActionSurge(
    userId: string,
    duelId: string,
  ): Promise<{ duel: Duel; members: DuelMember[] }> {
    return useActionSurge(this.fighterDeps(), userId, duelId);
  }

  forfeit(
    userId: string,
    duelId: string,
  ): Promise<{ duel: Duel; members: DuelMember[] }> {
    return forfeit(this.lifecycleDeps(), userId, duelId);
  }
}
