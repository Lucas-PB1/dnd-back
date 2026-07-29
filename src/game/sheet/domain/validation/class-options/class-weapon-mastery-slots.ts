/**
 * Maestria em Arma — deriva slots a partir de `phb_class_progression.weapon_mastery`.
 * Não hardcodar cotas por classe: a fonte de verdade é o banco / API de progressão.
 */

export type ClassWeaponMasterySlot = {
  optionKey: string;
  unlockLevel: number;
};

export type WeaponMasteryEligibility = 'any' | 'melee' | 'ranged';

export type ClassProgressionMasteryRow = {
  level: number;
  weaponMastery: number | null;
};

export const WEAPON_MASTER_FEAT_OPTION_KEY = 'masteryWeapon';

/** Converte a coluna cumulativa `weapon_mastery` em slots `masteryWeaponN`. */
export function classWeaponMasterySlotsFromProgression(
  rows: readonly ClassProgressionMasteryRow[],
): ClassWeaponMasterySlot[] {
  const sorted = [...rows].sort((a, b) => a.level - b.level);
  const slots: ClassWeaponMasterySlot[] = [];
  let previousCount = 0;

  for (const row of sorted) {
    const count = row.weaponMastery ?? 0;
    if (count <= previousCount) continue;
    for (let index = previousCount + 1; index <= count; index += 1) {
      slots.push({
        optionKey: `masteryWeapon${index}`,
        unlockLevel: row.level,
      });
    }
    previousCount = count;
  }

  return slots;
}

export function classWeaponMasterySlotsAtLevel(
  rows: readonly ClassProgressionMasteryRow[],
  level: number,
): ClassWeaponMasterySlot[] {
  return classWeaponMasterySlotsFromProgression(rows).filter(
    (slot) => slot.unlockLevel <= level,
  );
}

export function classWeaponMasterySlotsNewAtLevel(
  rows: readonly ClassProgressionMasteryRow[],
  level: number,
): ClassWeaponMasterySlot[] {
  return classWeaponMasterySlotsFromProgression(rows).filter(
    (slot) => slot.unlockLevel === level,
  );
}

export function isClassWeaponMasteryOptionKey(optionKey: string): boolean {
  return /^masteryWeapon\d+$/.test(optionKey);
}

export function parseWeaponMasteryEligibility(
  value: string | null | undefined,
): WeaponMasteryEligibility | null {
  if (value === 'any' || value === 'melee' || value === 'ranged') return value;
  return null;
}

type ClassOptionLike = { optionKey: string; valueId: string };
type FeatOptionLike = { optionKey: string; valueId: string };

/** Armas cujas propriedades de maestria o personagem pode usar. */
export function collectMasteredWeaponSlugs(input: {
  classOptions?: readonly ClassOptionLike[];
  featOptions?: readonly FeatOptionLike[];
}): string[] {
  const fromClass = (input.classOptions ?? [])
    .filter(
      (option) =>
        isClassWeaponMasteryOptionKey(option.optionKey) && option.valueId,
    )
    .map((option) => option.valueId);
  const fromFeat = (input.featOptions ?? [])
    .filter(
      (option) =>
        option.optionKey === WEAPON_MASTER_FEAT_OPTION_KEY && option.valueId,
    )
    .map((option) => option.valueId);
  return [...new Set([...fromClass, ...fromFeat])];
}
