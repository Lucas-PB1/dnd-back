import type { DataSource } from 'typeorm';
import type { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import type { LoadEffectCatalog, CatalogEffect } from '@game/effects';
import type { ClassEconomyActionRecord } from '@game/combat/domain/class-action-ui-catalog';
import type { SyncCharacterCompanionHandler } from '@game/actor/application/sync-character-companion.handler';
import type { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { TableActionResponseDto } from '@game/session/dto/fighter/fighter-session.dto';
import type { UseManeuverResponseDto } from '@game/session/dto/core/session-commands.dto';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import type { AssertCanBindPactWeaponService } from '@game/inventory/application/assert/assert-can-bind-pact-weapon.service';
import type { CharacterInventoryRepository } from '@game/inventory/infrastructure/character-inventory.repository';

export type DeclaredEconomyTableActionResult =
  | TableActionResponseDto
  | UseManeuverResponseDto;

export type DeclaredEconomyTableActionDeps = {
  state: CharacterStateRepository;
  mechanicalCatalog: LoadCombatMechanicalCatalog;
  effectCatalog?: LoadEffectCatalog;
  sheet?: CharacterSheetRepository;
  dataSource?: DataSource;
  getProficiencyBonus?: (level: number) => Promise<number>;
  inventory?: CharacterInventoryRepository;
  assertCanBindPact?: AssertCanBindPactWeaponService;
  companion?: {
    dataSource: DataSource;
    syncCompanion: SyncCharacterCompanionHandler;
  };
};

export type DeclaredEconomyTableActionOptions = {
  userId?: string;
  diceCount?: number;
  companionCommand?: string;
  checkTotal?: number;
  dc?: number;
  usePsiDie?: boolean;
  maneuverSlug?: string;
  metamagicSlug?: string;
  useRelentless?: boolean;
  spellSlug?: string;
  optionSlug?: string;
  takeLowerBloodCost?: boolean;
  amount?: number;
  masks?: string[];
  level?: number;
  itemSlug?: string;
  shots?: number;
  slotLevel?: number;
};

export type SpendPlan = {
  resourceSlug: string | null;
  amount: number;
};

export type ApplyCtx = {
  deps: DeclaredEconomyTableActionDeps;
  character: PlayerCharacter;
  action: ClassEconomyActionRecord;
  actionSlug: string;
  effect: CatalogEffect;
  state: TableActionResponseDto['state'];
  note: string;
  total?: number;
  expression?: string;
  roll?: number;
  saveDc?: number;
  resourceSpent: boolean;
  options: DeclaredEconomyTableActionOptions;
  rageBonus: number;
  strMod: number;
  intMod: number;
  castingMod: number;
  scheduleDieFaces?: number;
  scheduleCount?: number;
  pactSlotLevel?: number;
  pactSlotsRecoveryCount?: number;
  rageActive: boolean;
};
