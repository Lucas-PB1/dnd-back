import { rollD20Check } from '@game/dice/domain/dice';
import {
  battleMasterSaveDc,
  findBattleMasterManeuver,
  type BattleMasterManeuver,
} from './battle-master-maneuvers';

export type BattleMasterOnHitKind =
  | 'damage_save_prone'
  | 'damage_save_frightened'
  | 'damage_save_push'
  | 'damage_only';

/** Manobras tipadas no acerto (PVE-5b). */
export function battleMasterOnHitKind(
  slug: string,
): BattleMasterOnHitKind | null {
  switch (slug) {
    case 'trip-attack':
      return 'damage_save_prone';
    case 'menacing-attack':
      return 'damage_save_frightened';
    case 'pushing-attack':
      return 'damage_save_push';
    case 'disarming-attack':
    case 'goading-attack':
    case 'distracting-attack':
    case 'maneuvering-attack':
      return 'damage_only';
    default:
      return null;
  }
}

export type ResolveBattleMasterOnHitInput = {
  catalog: readonly BattleMasterManeuver[];
  maneuverSlug: string;
  dieFaces: number;
  dieRoll: number;
  proficiencyBonus: number;
  strengthMod: number;
  dexterityMod: number;
  /** Bônus de salvaguarda do alvo na habilidade correta. */
  targetSaveBonus: number;
};

export type ResolveBattleMasterOnHitResult = {
  maneuver: BattleMasterManeuver;
  kind: BattleMasterOnHitKind;
  extraDamage: number;
  dieFaces: number;
  dieRoll: number;
  saveDc: number;
  saveTotal: number | null;
  saved: boolean | null;
  conditionSlug: 'prone' | 'frightened' | null;
  pushNote: boolean;
  note: string;
};

/**
 * Resolve manobra BM no acerto: +dado de superioridade no dano e save tipado
 * (trip / menacing / pushing) ou só dano (outras on_hit com addsToDamage).
 */
export function resolveBattleMasterOnHit(
  input: ResolveBattleMasterOnHitInput,
): ResolveBattleMasterOnHitResult {
  const maneuver = findBattleMasterManeuver(
    input.catalog,
    input.maneuverSlug,
  );
  if (!maneuver) {
    throw new Error(`Unknown Battle Master maneuver '${input.maneuverSlug}'`);
  }
  if (maneuver.timing !== 'on_hit') {
    throw new Error(
      `Maneuver '${input.maneuverSlug}' is not an on-hit combat maneuver`,
    );
  }
  const kind = battleMasterOnHitKind(input.maneuverSlug);
  if (!kind) {
    throw new Error(
      `Maneuver '${input.maneuverSlug}' has no typed on-hit combat effect yet`,
    );
  }

  const saveDc = battleMasterSaveDc({
    proficiencyBonus: input.proficiencyBonus,
    strengthMod: input.strengthMod,
    dexterityMod: input.dexterityMod,
  });
  const extraDamage = maneuver.addsToDamage ? input.dieRoll : 0;

  let saveTotal: number | null = null;
  let saved: boolean | null = null;
  let conditionSlug: 'prone' | 'frightened' | null = null;
  let pushNote = false;

  if (
    kind === 'damage_save_prone' ||
    kind === 'damage_save_frightened' ||
    kind === 'damage_save_push'
  ) {
    const save = rollD20Check(input.targetSaveBonus, 'normal');
    saveTotal = save.total;
    saved = save.total >= saveDc;
    if (!saved) {
      if (kind === 'damage_save_prone') conditionSlug = 'prone';
      if (kind === 'damage_save_frightened') conditionSlug = 'frightened';
      if (kind === 'damage_save_push') pushNote = true;
    }
  }

  const parts = [
    `${maneuver.name}: Dado de Superioridade 1d${input.dieFaces}=${input.dieRoll}`,
  ];
  if (extraDamage > 0) parts.push(`+${extraDamage} dano`);
  if (saveTotal != null) {
    parts.push(
      `CD ${saveDc} · save ${saveTotal}${saved ? ' sucesso' : ' falha'}`,
    );
  }
  if (conditionSlug === 'prone') parts.push('alvo Caído');
  if (conditionSlug === 'frightened') parts.push('alvo Amedrontado');
  if (pushNote) parts.push('alvo empurrado 4,5 m (sem mapa)');

  return {
    maneuver,
    kind,
    extraDamage,
    dieFaces: input.dieFaces,
    dieRoll: input.dieRoll,
    saveDc,
    saveTotal,
    saved,
    conditionSlug,
    pushNote,
    note: parts.join(' · '),
  };
}
