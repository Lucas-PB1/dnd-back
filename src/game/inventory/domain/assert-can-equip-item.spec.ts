import {
  assertCanEquipItem,
  type AssertCanEquipArmorInput,
  type AssertCanEquipWeaponInput,
} from './assert-can-equip-item';

describe('assertCanEquipItem', () => {
  const leather: AssertCanEquipArmorInput = {
    kind: 'armor',
    piece: {
      itemSlug: 'leather-armor',
      itemName: 'Armadura de Couro',
      categorySlug: 'light',
      strengthReq: null,
      stealthDisadvantage: false,
    },
    armorTrainingSlugs: ['light'],
    featSlugs: [],
    strengthScore: 10,
  };

  const chainMail: AssertCanEquipArmorInput = {
    kind: 'armor',
    piece: {
      itemSlug: 'chain-mail',
      itemName: 'Cota de Malha',
      categorySlug: 'heavy',
      strengthReq: 13,
      stealthDisadvantage: true,
    },
    armorTrainingSlugs: ['light'],
    featSlugs: [],
    strengthScore: 15,
  };

  const longsword: AssertCanEquipWeaponInput = {
    kind: 'weapon',
    piece: {
      itemSlug: 'longsword',
      itemName: 'Espada Longa',
      category: 'martial',
      damage: '1d8',
      damageType: 'slashing',
      versatileDamage: '1d10',
      propertySlugs: ['versatile'],
      equipmentSlot: 'main_hand',
    },
    weaponProficiencySlugs: ['armas-simples'],
    featSlugs: [],
    itemName: 'Espada Longa',
  };

  it('allows armor when trained', () => {
    expect(() => assertCanEquipItem(leather)).not.toThrow();
  });

  it('blocks armor without training', () => {
    expect(() => assertCanEquipItem(chainMail)).toThrow(
      /Sem treino com Cota de Malha/,
    );
  });

  it('allows strength penalty without blocking', () => {
    expect(() =>
      assertCanEquipItem({
        ...chainMail,
        armorTrainingSlugs: ['heavy'],
        strengthScore: 10,
      }),
    ).not.toThrow();
  });

  it('blocks weapon without proficiency', () => {
    expect(() => assertCanEquipItem(longsword)).toThrow(
      /Sem proficiência com Espada Longa/,
    );
  });

  it('allows martial weapon with class proficiency', () => {
    expect(() =>
      assertCanEquipItem({
        ...longsword,
        weaponProficiencySlugs: ['armas-simples', 'armas-marciais'],
      }),
    ).not.toThrow();
  });

  it('allows martial via martial-weapon-training feat', () => {
    expect(() =>
      assertCanEquipItem({
        ...longsword,
        featSlugs: ['martial-weapon-training'],
      }),
    ).not.toThrow();
  });
});
