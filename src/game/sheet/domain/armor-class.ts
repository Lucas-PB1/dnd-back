import type { AbilityScores } from '../../shared/infrastructure/player-character.entity';

export type EquippedArmorPiece = {
  itemSlug: string;
  itemName: string;
  categorySlug: string;
  acBase: number | null;
};

function dexModifier(scores: AbilityScores): number {
  return Math.floor((scores.destreza - 10) / 2);
}

function bodyArmorAc(
  piece: EquippedArmorPiece,
  dexMod: number,
): number {
  const base = piece.acBase ?? 10;
  switch (piece.categorySlug) {
    case 'light':
      return base + dexMod;
    case 'medium':
      return base + Math.min(dexMod, 2);
    case 'heavy':
      return base;
    default:
      return base;
  }
}

export function computeArmorClassFromEquipment(
  scores: AbilityScores,
  equipped: EquippedArmorPiece[],
): { armorClass: number; armorClassNote: string } {
  const bodyArmor = equipped.find((piece) =>
    ['light', 'medium', 'heavy'].includes(piece.categorySlug),
  );
  const shield = equipped.find((piece) => piece.categorySlug === 'shield');
  const dexMod = dexModifier(scores);

  let armorClass: number;
  let note: string;

  if (bodyArmor) {
    armorClass = bodyArmorAc(bodyArmor, dexMod);
    note = bodyArmor.itemName;
  } else {
    armorClass = 10 + dexMod;
    note = 'Sem armadura';
  }

  if (shield) {
    armorClass += 2;
    note = bodyArmor ? `${note} + ${shield.itemName}` : `${note} + ${shield.itemName}`;
  }

  return { armorClass, armorClassNote: note };
}

/** Fallback quando não há inventário equipado relevante. */
export function computeUnarmoredArmorClass(scores: AbilityScores): number {
  return 10 + dexModifier(scores);
}
