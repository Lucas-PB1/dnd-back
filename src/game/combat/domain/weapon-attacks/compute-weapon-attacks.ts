import type { AbilityScores } from '../../../shared/infrastructure/player-character.entity';
import type { SizeCategory } from '../equipment/creature-size';
import { analyzeDualWield } from '../equipment/dual-wield';
import {
  MONK_UNARMED_ITEM_SLUG,
  isMonkClass,
} from '../monk/features';
import { buildModes, hasProperty } from './weapon-attack-predicates';
import type {
  EquippedWeaponPiece,
  WeaponAttack,
  WeaponAttackContext,
  WeaponAttackRole,
} from './weapon-attack.types';
import { computeOneAttack } from './compute-one-attack';

const MONK_UNARMED_PIECE: EquippedWeaponPiece = {
  itemSlug: MONK_UNARMED_ITEM_SLUG,
  itemName: 'Ataque Desarmado',
  category: 'simple',
  damage: '1',
  damageType: 'Contundente',
  versatileDamage: null,
  propertySlugs: [],
  equipmentSlot: 'main_hand',
  masterySlug: null,
  masteryName: null,
  reloadCapacity: null,
};

/** Calcula ataques passivos das armas equipadas (main_hand / off_hand). */
export function computeWeaponAttacks(
  scores: AbilityScores,
  equipped: EquippedWeaponPiece[],
  context: WeaponAttackContext,
): WeaponAttack[] {
  const weapons = equipped.filter(
    (piece) =>
      piece.equipmentSlot === 'main_hand' || piece.equipmentSlot === 'off_hand',
  );
  const dual = analyzeDualWield(weapons, context);
  const attacks: WeaponAttack[] = [];
  if (isMonkClass(context.classSlug)) {
    attacks.push(
      computeOneAttack(
        scores,
        MONK_UNARMED_PIECE,
        'melee',
        context,
        weapons,
        'main',
      ),
    );
  }
  for (const piece of weapons) {
    const role: WeaponAttackRole =
      piece.equipmentSlot === 'off_hand' && dual.bonusRole
        ? dual.bonusRole
        : 'main';
    for (const mode of buildModes(piece)) {
      // Ataque adicional TWF/Dual é corpo a corpo; modos ranged da off-hand ficam main.
      const effectiveRole = role !== 'main' && mode === 'ranged' ? 'main' : role;
      attacks.push(
        computeOneAttack(scores, piece, mode, context, weapons, effectiveRole),
      );
    }
  }
  return attacks;
}

export function heavyWeaponSlugsForSmallSize(
  weapons: EquippedWeaponPiece[],
  sizeCategory: SizeCategory | undefined,
): string[] {
  if (sizeCategory !== 'small') return [];
  return weapons.filter((w) => hasProperty(w, 'heavy')).map((w) => w.itemSlug);
}

export { computeOneAttack } from './compute-one-attack';
