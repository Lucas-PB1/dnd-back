import type { ResolveEquippedWeaponAttacks } from '../resolve-equipped-weapon-attacks';
import type { ResolveEquipmentCompliance } from '../resolve-equipment-compliance';

export type MappedCombatSlice = {
  armorClass: number;
  armorClassNote: string;
  featAcBonus: number;
  featAcBonusSources: readonly { featSlug: string; bonus: number }[];
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
  transformationHpBonus: number;
  classCombatNotes: string[];
  attacksPerAction: number;
  savingThrowAuraBonus: number;
  featEffectFlags: {
    inspirationRefundOnFail: boolean;
    damageDieFloor: boolean;
    damageDieFlip: boolean;
    damageDieExplode: boolean;
    improveCritical: boolean;
    slotElevate: boolean;
    slotReduce: boolean;
    wieldTwoHandedOneHand: boolean;
    versatileOneHandFullDamage: boolean;
  };
};
