import {
  computeEquipmentCompliance,
  type EquippedArmorCompliancePiece,
} from './equipment-compliance';

describe('computeEquipmentCompliance', () => {
  const chainMail: EquippedArmorCompliancePiece = {
    itemSlug: 'chain-mail',
    itemName: 'Cota de Malha',
    categorySlug: 'heavy',
    strengthReq: 13,
    stealthDisadvantage: true,
  };

  const leather: EquippedArmorCompliancePiece = {
    itemSlug: 'leather-armor',
    itemName: 'Armadura de Couro',
    categorySlug: 'light',
    strengthReq: null,
    stealthDisadvantage: false,
  };

  it('flags missing heavy armor training', () => {
    const result = computeEquipmentCompliance([chainMail], {
      strengthScore: 15,
      armorTrainingSlugs: ['light'],
    });
    expect(result.lacksArmorTraining).toBe(true);
    expect(result.cannotCastSpells).toBe(true);
    expect(result.strDexTestDisadvantage).toBe(true);
    expect(result.warnings.some((w) => w.code === 'lacks_armor_training')).toBe(
      true,
    );
  });

  it('does not flag training when class is trained', () => {
    const result = computeEquipmentCompliance([chainMail], {
      strengthScore: 15,
      armorTrainingSlugs: ['light', 'medium', 'heavy', 'shield'],
    });
    expect(result.lacksArmorTraining).toBe(false);
    expect(result.cannotCastSpells).toBe(false);
  });

  it('applies strength penalty and speed when below req', () => {
    const result = computeEquipmentCompliance([chainMail], {
      strengthScore: 10,
      armorTrainingSlugs: ['heavy'],
    });
    expect(result.strengthPenalty).toEqual({
      required: 13,
      actual: 10,
      itemSlug: 'chain-mail',
    });
    expect(result.speedPenaltyMeters).toBe(3);
    expect(result.stealthDisadvantage).toBe(true);
  });

  it('passes leather with light training and no stealth flag', () => {
    const result = computeEquipmentCompliance([leather], {
      strengthScore: 8,
      armorTrainingSlugs: ['light'],
    });
    expect(result.lacksArmorTraining).toBe(false);
    expect(result.strengthPenalty).toBeNull();
    expect(result.stealthDisadvantage).toBe(false);
    expect(result.speedPenaltyMeters).toBe(0);
  });

  it('adds dual wield warning when requested', () => {
    const result = computeEquipmentCompliance([], {
      strengthScore: 10,
      armorTrainingSlugs: [],
      dualWieldNeedsFeat: true,
    });
    expect(result.warnings.some((w) => w.code === 'dual_wield_needs_feat')).toBe(
      true,
    );
  });
});
