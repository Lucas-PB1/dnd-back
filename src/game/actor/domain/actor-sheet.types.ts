import type { ActorKind } from '../infrastructure/game-actor.entity';

export type ActorSpeedDto = {
  movementKind: string;
  speedFt: number;
};

export type ActorActionDto = {
  id: string;
  name: string;
  actionBucket: string;
  attackBonus: number | null;
  damageExpression: string | null;
  reachFt: number | null;
  sortOrder: number;
};

export type ActorSpellDto = {
  spellSlug: string;
  usageKind: string;
  usesPerDay: number | null;
  slotLevel: number | null;
  rechargeDice: string | null;
  sortOrder: number;
};

export type ActorStateDto = {
  conditions: string[];
  tempHp: number;
  concentratingOn: string | null;
  innateSpellUses: Record<string, number>;
};

export type ActorSheetData = {
  speeds: ActorSpeedDto[];
  actions: ActorActionDto[];
  spells: ActorSpellDto[];
  state: ActorStateDto | null;
};

export const EMPTY_ACTOR_SHEET: ActorSheetData = {
  speeds: [],
  actions: [],
  spells: [],
  state: null,
};

export type CreateActorInput = {
  actorKind: ActorKind;
  name: string;
  campaignId?: string | null;
  parentCharacterId?: string | null;
  templateSlug?: string | null;
  hitPointsMax?: number | null;
  hitPointsCurrent?: number | null;
  armorClass?: number | null;
  initiativeModifier?: number | null;
  proficiencyBonus?: number | null;
  abilityScores?: import('@game/shared/domain/ability-scores').AbilityScores;
  sizeSlug?: string | null;
  notes?: string | null;
  spellcastingAbilitySlug?: string | null;
  spellSaveDc?: number | null;
  spellAttackBonus?: number | null;
  damageThreshold?: number | null;
  crewCapacity?: number | null;
  cargoCapacityLb?: number | null;
  speeds?: ActorSpeedDto[];
  actions?: Omit<ActorActionDto, 'id'>[];
  spells?: Omit<ActorSpellDto, 'sortOrder'> & { sortOrder?: number }[];
};
