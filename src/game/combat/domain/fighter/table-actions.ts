import {
  battleMasterSaveDc,
  findBattleMasterManeuver,
  type BattleMasterManeuver,
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

export function resolveBattleMasterTableRoll(input: BattleMasterRollInput) {
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
  const abilityModifier =
    maneuver.slug === 'rally'
      ? input.charismaModifier
      : Math.max(input.strengthModifier, input.dexterityModifier);
  const effectValue =
    maneuver.slug === 'parry' || maneuver.slug === 'rally'
      ? Math.max(0, input.dieRoll + abilityModifier)
      : input.dieRoll;

  return {
    maneuver,
    dieFaces,
    expression:
      maneuver.slug === 'parry' || maneuver.slug === 'rally'
        ? `1d${dieFaces}${abilityModifier >= 0 ? '+' : ''}${abilityModifier}`
        : `1d${dieFaces}`,
    roll: input.dieRoll,
    effectValue,
    saveDc,
    resourceSpent: !input.useRelentless,
    note: buildManeuverNote(
      maneuver.slug,
      maneuver.name,
      effectValue,
      saveDc,
      maneuver.description,
      Boolean(input.useRelentless),
    ),
  };
}

function buildManeuverNote(
  slug: string,
  name: string,
  value: number,
  saveDc: number,
  description: string,
  relentless: boolean,
): string {
  const prefix = `${name}: ${relentless ? 'Implacável d8' : 'Dado de Superioridade'} = ${value}.`;
  if (slug === 'parry') return `${prefix} Reduza ${value} do dano.`;
  if (slug === 'rally') {
    return `${prefix} Conceda ${value} PV temporários (aplicados neste PC; aliado = ajuste na mesa).`;
  }
  if (slug === 'precision-attack') {
    return `${prefix} Some ${value} à jogada de ataque que errou.`;
  }
  return `${prefix} CD ${saveDc}, quando aplicável. ${description}`;
}

export function findDungeoneerPrecautionSpell(
  catalog: readonly PrecautionSpell[],
  spellSlug: string,
) {
  return findPrecautionSpell(catalog, spellSlug);
}
