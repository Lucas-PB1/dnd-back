import type { ResolveEquippedWeaponAttacks } from '../resolve-equipped-weapon-attacks';
import type { ResolveEquipmentCompliance } from '../resolve-equipment-compliance';

export type MappedCombatSlice = {
  armorClass: number;
  armorClassNote: string;
  /** Soma tipada de `ac_bonus` (sticky/gate — front aplica com toggle). */
  featAcBonus: number;
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
  /** Flags de efeitos de talento p/ UI de roll/cast. */
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
