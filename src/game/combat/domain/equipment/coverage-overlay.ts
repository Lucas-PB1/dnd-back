import { formatSigned } from '../weapon-attacks/weapon-attack-predicates';
import type {
  EquippedWeaponPiece,
  WeaponAttack,
} from '../weapon-attacks/weapon-attack.types';

/** Aplica bônus de cobertura DMG por peça (após encanto Valdas). */
export function applyCoverageBonusToAttack(
  piece: EquippedWeaponPiece,
  attack: WeaponAttack,
): WeaponAttack {
  const meta = {
    attachedCoverageSlug: piece.attachedCoverageSlug ?? null,
    attachedCoverageName: piece.attachedCoverageName ?? null,
  };
  const attackAdd = piece.coverageAttackBonus ?? 0;
  const damageAdd = piece.coverageDamageBonus ?? 0;
  if (!attackAdd && !damageAdd) {
    return { ...attack, ...meta };
  }

  let attackNote = attack.attackNote;
  let damageNote = attack.damageNote;
  if (attackAdd) {
    attackNote = `${attackNote} · cobertura ${formatSigned(attackAdd)}`;
  }
  if (damageAdd) {
    damageNote = `${damageNote} · cobertura ${formatSigned(damageAdd)}`;
  }

  return {
    ...attack,
    ...meta,
    attackBonus: attack.attackBonus + attackAdd,
    damageBonus: attack.damageBonus + damageAdd,
    attackNote,
    damageNote,
  };
}
