import { BadRequestException } from '@nestjs/common';
import {
  computeEquipmentCompliance,
  type EquippedArmorCompliancePiece,
} from '@game/combat/domain/equipment';
import {
  isProficient,
  type EquippedWeaponPiece,
} from '@game/combat/domain/weapon-attacks';

export type AssertCanEquipArmorInput = {
  kind: 'armor';
  piece: EquippedArmorCompliancePiece;
  armorTrainingSlugs: readonly string[];
  featSlugs: readonly string[];
  strengthScore: number;
};

export type AssertCanEquipWeaponInput = {
  kind: 'weapon';
  piece: EquippedWeaponPiece;
  weaponProficiencySlugs: readonly string[];
  featSlugs: readonly string[];
  itemName: string;
};

/**
 * Bloqueia equipar armadura/escudo sem treino ou arma sem proficiência.
 * Avisos soft (Força, Furtividade) continuam só na ficha GET.
 */
export function assertCanEquipItem(
  input: AssertCanEquipArmorInput | AssertCanEquipWeaponInput,
): void {
  if (input.kind === 'armor') {
    const result = computeEquipmentCompliance([input.piece], {
      strengthScore: input.strengthScore,
      armorTrainingSlugs: input.armorTrainingSlugs,
      featSlugs: input.featSlugs,
    });
    const warning = result.warnings.find(
      (entry) => entry.code === 'lacks_armor_training',
    );
    if (warning) {
      throw new BadRequestException(warning.message);
    }
    return;
  }

  const proficient = isProficient(input.piece, {
    proficiencyBonus: 0,
    weaponProficiencySlugs: input.weaponProficiencySlugs,
    featSlugs: input.featSlugs,
  });
  if (!proficient) {
    throw new BadRequestException(
      `Sem proficiência com ${input.itemName}: não pode equipar.`,
    );
  }
}
