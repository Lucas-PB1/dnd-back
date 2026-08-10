import type { CharacterSheetInput } from '@game/sheet/domain/character-sheet.types';

export const BACKGROUND_GOLD_PACKAGE_SLUG = 'gold';

type EquipmentRow = NonNullable<CharacterSheetInput['equipment']>[number];

type BackgroundGoldCatalog = {
  equipmentGoldOption: number | null;
};

type ClassEquipmentGoldRow = {
  packageSlug: string;
  goldAmount: number | null;
};

type BackgroundEquipmentGoldRow = {
  packageSlug: string;
  packageGold: number | null;
};

/**
 * Soma PO inicial a partir das escolhas de equipamento (pacote ouro do
 * antecedente + gold_amount / package_gold dos pacotes).
 */
export function resolveStartingGoldPieces(input: {
  equipment: EquipmentRow[] | undefined;
  background: BackgroundGoldCatalog;
  classEquipmentRows: ClassEquipmentGoldRow[];
  backgroundEquipmentRows: BackgroundEquipmentGoldRow[];
}): number {
  const equipment = input.equipment ?? [];
  let gold = 0;

  const classPackages = new Set(
    equipment.filter((row) => row.source === 'class').map((row) => row.packageSlug),
  );
  for (const packageSlug of classPackages) {
    for (const row of input.classEquipmentRows) {
      if (row.packageSlug !== packageSlug) continue;
      if (row.goldAmount != null && row.goldAmount > 0) {
        gold += row.goldAmount;
      }
    }
  }

  const backgroundPackages = new Set(
    equipment
      .filter((row) => row.source === 'background')
      .map((row) => row.packageSlug),
  );
  for (const packageSlug of backgroundPackages) {
    if (packageSlug === BACKGROUND_GOLD_PACKAGE_SLUG) {
      const option = input.background.equipmentGoldOption;
      if (option != null && option > 0) {
        gold += option;
      }
      continue;
    }
    const packageGold = input.backgroundEquipmentRows.find(
      (row) => row.packageSlug === packageSlug,
    )?.packageGold;
    if (packageGold != null && packageGold > 0) {
      gold += packageGold;
    }
  }

  return gold;
}
