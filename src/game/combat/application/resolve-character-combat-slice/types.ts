import type { ResolveEquippedWeaponAttacks } from '../resolve-equipped-weapon-attacks';
import type { ResolveEquipmentCompliance } from '../resolve-equipment-compliance';

export type MappedCombatSlice = {
  armorClass: number;
  armorClassNote: string;
  weaponAttacks: Awaited<ReturnType<ResolveEquippedWeaponAttacks['resolve']>>;
  equipmentWarnings: Awaited<
    ReturnType<ResolveEquipmentCompliance['resolve']>
  >['warnings'];
  cannotCastSpellsInArmor: boolean;
  speedPenaltyMeters: Awaited<
    ReturnType<ResolveEquipmentCompliance['resolve']>
  >['speedPenaltyMeters'];
  itemSpeedBonusMeters: number;
  itemHpBonus: number;
  heritageHpBonus: number;
  classCombatNotes: string[];
  attacksPerAction: number;
  savingThrowAuraBonus: number;
};
