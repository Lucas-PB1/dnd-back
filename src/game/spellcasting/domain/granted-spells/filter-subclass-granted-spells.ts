import type { SubclassGrantedSpellRow } from '@game/spellcasting/domain/granted-spells';
import { resolveLandTerrainSlug } from '@game/sheet/domain/validation/class-options/subclass-option-effects';

type SubclassOptionPick = {
  optionKey: string;
  valueId: string;
};

export function filterSubclassGrantedSpellRows(
  rows: readonly SubclassGrantedSpellRow[],
  subclassSlug: string | null | undefined,
  subclassOptions: readonly SubclassOptionPick[] | undefined,
): SubclassGrantedSpellRow[] {
  const terrainSlug = resolveLandTerrainSlug(subclassSlug, subclassOptions);

  return rows.filter((row) => {
    if (!row.terrainSlug) return true;
    if (subclassSlug !== 'land') return false;
    return terrainSlug != null && row.terrainSlug === terrainSlug;
  });
}
