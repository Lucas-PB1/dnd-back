import {
  computeArmorClassFromEquipment,
  type EquippedArmorPiece,
} from './armor-class';
import type { AbilityScores } from '../../shared/infrastructure/player-character.entity';

const scores: AbilityScores = {
  forca: 15,
  destreza: 14,
  constituicao: 13,
  inteligencia: 10,
  sabedoria: 12,
  carisma: 8,
};

const leather: EquippedArmorPiece = {
  itemSlug: 'leather',
  itemName: 'Armadura de Couro',
  categorySlug: 'light',
  acBase: 11,
};

const chainMail: EquippedArmorPiece = {
  itemSlug: 'chain-mail',
  itemName: 'Cota de Malha',
  categorySlug: 'heavy',
  acBase: 16,
};

const breastplate: EquippedArmorPiece = {
  itemSlug: 'breastplate',
  itemName: 'Peitoral',
  categorySlug: 'medium',
  acBase: 14,
};

const shield: EquippedArmorPiece = {
  itemSlug: 'shield',
  itemName: 'Escudo',
  categorySlug: 'shield',
  acBase: null,
};

describe('armor-class', () => {
  it('unarmored uses 10 + dex', () => {
    const result = computeArmorClassFromEquipment(scores, []);
    expect(result.armorClass).toBe(12);
    expect(result.armorClassNote).toBe('Sem armadura');
  });

  it('light armor adds full dex mod', () => {
    const result = computeArmorClassFromEquipment(scores, [leather]);
    expect(result.armorClass).toBe(13);
  });

  it('medium armor caps dex bonus at 2', () => {
    const highDex = { ...scores, destreza: 18 };
    const result = computeArmorClassFromEquipment(highDex, [breastplate]);
    expect(result.armorClass).toBe(16);
  });

  it('heavy armor ignores dex', () => {
    const result = computeArmorClassFromEquipment(scores, [chainMail]);
    expect(result.armorClass).toBe(16);
  });

  it('shield adds +2 on top of armor', () => {
    const result = computeArmorClassFromEquipment(scores, [leather, shield]);
    expect(result.armorClass).toBe(15);
    expect(result.armorClassNote).toContain('Escudo');
  });

  it('shield alone adds +2 to unarmored', () => {
    const result = computeArmorClassFromEquipment(scores, [shield]);
    expect(result.armorClass).toBe(14);
  });
});
