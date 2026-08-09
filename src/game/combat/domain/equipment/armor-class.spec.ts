import {
  computeArmorClassFromEquipment,
  type EquippedArmorPiece,
  type UnarmoredDefenseRow,
} from './armor-class';
import type { AbilityScores } from '@game/shared/infrastructure/player-character.entity';

const BARBARIAN_UD: UnarmoredDefenseRow = {
  label: 'Defesa sem Armadura (bárbaro)',
  secondAbility: 'constituicao',
  allowsShield: true,
};
const MONK_UD: UnarmoredDefenseRow = {
  label: 'Defesa sem Armadura (monge)',
  secondAbility: 'sabedoria',
  allowsShield: false,
};
const DRACONIC_UD: UnarmoredDefenseRow = {
  label: 'Resiliência Dracônica',
  secondAbility: 'carisma',
  allowsShield: true,
};
const DANCE_UD: UnarmoredDefenseRow = {
  label: 'Defesa sem Armadura (dança)',
  secondAbility: 'carisma',
  allowsShield: false,
};

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

  it('barbarian unarmored defense uses 10 + dex + con', () => {
    const barb = { ...scores, destreza: 14, constituicao: 16 };
    const result = computeArmorClassFromEquipment(barb, [], {
      unarmoredDefenses: [BARBARIAN_UD],
    });
    // 10 + 2 + 3
    expect(result.armorClass).toBe(15);
    expect(result.armorClassNote).toContain('bárbaro');
  });

  it('barbarian unarmored defense allows shield', () => {
    const barb = { ...scores, destreza: 14, constituicao: 16 };
    const result = computeArmorClassFromEquipment(barb, [shield], {
      unarmoredDefenses: [BARBARIAN_UD],
    });
    expect(result.armorClass).toBe(17);
  });

  it('monk unarmored defense uses 10 + dex + wis and forbids shield', () => {
    const monk = { ...scores, destreza: 16, sabedoria: 16 };
    const withoutShield = computeArmorClassFromEquipment(monk, [], {
      unarmoredDefenses: [MONK_UD],
    });
    // 10 + 3 + 3
    expect(withoutShield.armorClass).toBe(16);

    const withShield = computeArmorClassFromEquipment(monk, [shield], {
      unarmoredDefenses: [MONK_UD],
    });
    // Escudo anula a defesa sem armadura → 10 + DES + 2
    expect(withShield.armorClass).toBe(15);
  });

  it('draconic resilience uses 10 + dex + cha', () => {
    const sorc = { ...scores, destreza: 14, carisma: 16 };
    const result = computeArmorClassFromEquipment(sorc, [], {
      unarmoredDefenses: [DRACONIC_UD],
    });
    expect(result.armorClass).toBe(15);
    expect(result.armorClassNote).toContain('Dracônica');
  });

  it('dance unarmored defense forbids shield', () => {
    const bard = { ...scores, destreza: 14, carisma: 16 };
    const result = computeArmorClassFromEquipment(bard, [], {
      unarmoredDefenses: [DANCE_UD],
    });
    expect(result.armorClass).toBe(15);
  });

  it('defense fighting style adds +1 while armored', () => {
    const result = computeArmorClassFromEquipment(scores, [leather], {
      featSlugs: ['defense'],
    });
    expect(result.armorClass).toBe(14);
    expect(result.armorClassNote).toContain('Defensivo');
  });

  it('defense style from subclass options also applies', () => {
    const result = computeArmorClassFromEquipment(scores, [leather], {
      fightingStyleSlugs: ['defense'],
    });
    expect(result.armorClass).toBe(14);
  });

  it('defense does not apply without body armor', () => {
    const result = computeArmorClassFromEquipment(scores, [], {
      featSlugs: ['defense'],
    });
    expect(result.armorClass).toBe(12);
  });

  it('medium armor master raises dex cap to 3 when dex >= 16', () => {
    const highDex = { ...scores, destreza: 16 };
    const result = computeArmorClassFromEquipment(highDex, [breastplate], {
      featSlugs: ['medium-armor-master'],
    });
    expect(result.armorClass).toBe(17);
  });

  it('body armor suppresses unarmored defenses', () => {
    const barb = { ...scores, destreza: 14, constituicao: 16 };
    const result = computeArmorClassFromEquipment(barb, [leather], {
      unarmoredDefenses: [BARBARIAN_UD],
    });
    expect(result.armorClass).toBe(13);
  });
});
