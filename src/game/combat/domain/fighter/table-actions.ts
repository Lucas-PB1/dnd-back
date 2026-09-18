import {
  battleMasterSaveDc,
  findBattleMasterManeuver,
  type BattleMasterManeuver,
  type BattleMasterMesaRollKind,
} from './battle-master-maneuvers';
import {
  findPrecautionSpell,
  type PrecautionSpell,
} from './dungeoneer-catalog';
import { superiorityDieFaces } from './features';
import type { FeatureScheduleBand } from '../feature-schedule';

type BattleMasterRollInput = {
  catalog: readonly BattleMasterManeuver[];
  maneuverSlug: string;
  level: number;
  proficiencyBonus: number;
  strengthModifier: number;
  dexterityModifier: number;
  charismaModifier: number;
  dieRoll: number;
  useRelentless?: boolean;
  bands: readonly FeatureScheduleBand[];
};

export type BattleMasterTableRollResult = {
  maneuver: BattleMasterManeuver;
  kind: BattleMasterMesaRollKind;
  dieFaces: number;
  expression: string;
  roll: number;
  effectValue: number;
  saveDc: number;
  resourceSpent: boolean;
  note: string;
};

export function resolveBattleMasterTableRoll(
  input: BattleMasterRollInput,
): BattleMasterTableRollResult {
  const maneuver = findBattleMasterManeuver(input.catalog, input.maneuverSlug);
  if (!maneuver) {
    throw new Error(`Unknown Battle Master maneuver '${input.maneuverSlug}'`);
  }
  if (input.level < 3) {
    throw new Error('Battle Master maneuvers require Fighter level 3+');
  }
  if (input.useRelentless && input.level < 15) {
    throw new Error('Relentless requires Fighter level 15+');
  }

  const dieFaces = input.useRelentless
    ? 8
    : superiorityDieFaces(input.level, input.bands);
  if (dieFaces == null) {
    throw new Error('Superiority Die is not available');
  }

  const saveDc = battleMasterSaveDc({
    proficiencyBonus: input.proficiencyBonus,
    strengthMod: input.strengthModifier,
    dexterityMod: input.dexterityModifier,
  });
  const kind = maneuver.mesaRollKind;
  const abilityModifier = abilityModifierForKind(kind, input);
  const includesAbility = kindAddsAbilityModifier(kind);
  const effectValue = includesAbility
    ? Math.max(0, input.dieRoll + abilityModifier)
    : input.dieRoll;

  return {
    maneuver,
    kind,
    dieFaces,
    expression: includesAbility
      ? `1d${dieFaces}${abilityModifier >= 0 ? '+' : ''}${abilityModifier}`
      : `1d${dieFaces}`,
    roll: input.dieRoll,
    effectValue,
    saveDc,
    resourceSpent: !input.useRelentless,
    note: buildManeuverNote({
      kind,
      name: maneuver.name,
      value: effectValue,
      saveDc,
      description: maneuver.description,
      relentless: Boolean(input.useRelentless),
    }),
  };
}

function kindAddsAbilityModifier(kind: BattleMasterMesaRollKind): boolean {
  return kind === 'parry_reduce_damage' || kind === 'rally_temp_hp';
}

function abilityModifierForKind(
  kind: BattleMasterMesaRollKind,
  input: BattleMasterRollInput,
): number {
  if (kind === 'rally_temp_hp') return input.charismaModifier;
  return Math.max(input.strengthModifier, input.dexterityModifier);
}

function buildManeuverNote(input: {
  kind: BattleMasterMesaRollKind;
  name: string;
  value: number;
  saveDc: number;
  description: string;
  relentless: boolean;
}): string {
  const prefix = `${input.name}: ${input.relentless ? 'Implacável d8' : 'Dado de Superioridade'} = ${input.value}.`;
  switch (input.kind) {
    case 'parry_reduce_damage':
      return `${prefix} Reduza ${input.value} do dano.`;
    case 'rally_temp_hp':
      return `${prefix} Conceda ${input.value} PV temporários (aplicados neste PC; aliado = ajuste na mesa).`;
    case 'precision_add_attack':
      return `${prefix} Some ${input.value} à jogada de ataque que errou.`;
    case 'superiority_die':
      return `${prefix} CD ${input.saveDc}, quando aplicável. ${input.description}`;
  }
}

export function findDungeoneerPrecautionSpell(
  catalog: readonly PrecautionSpell[],
  spellSlug: string,
) {
  return findPrecautionSpell(catalog, spellSlug);
}
