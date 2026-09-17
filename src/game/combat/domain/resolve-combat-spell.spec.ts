import { resolveCombatSpell } from './resolve-combat-spell';
import type { SpellCombatRow } from './resolve-combat-spell';

jest.mock('@game/dice/domain/dice', () => ({
  rollDie: jest.fn((sides: number) => sides),
  rollD20Check: jest.fn((bonus: number) => ({
    total: 15 + bonus,
    d20: { kept: [15], rolls: [15] },
  })),
}));

function baseRow(
  overrides: Partial<SpellCombatRow> &
    Pick<SpellCombatRow, 'spellSlug' | 'resolution' | 'label'>,
): SpellCombatRow {
  return {
    damageDie: null,
    flatPerDie: 0,
    autoUnitBase: null,
    autoUnitPerSlotAboveBase: null,
    diceCountBase: null,
    dicePerSlotAboveBase: null,
    spellLevel: 0,
    cantripScale: false,
    perDieAttack: false,
    includeSpellcastingMod: false,
    saveSuccessOutcome: null,
    saveAbilitySlug: null,
    conditionSlug: null,
    damageTypeSlug: null,
    ...overrides,
  };
}

const mmRow = baseRow({
  spellSlug: 'misseis-magicos',
  resolution: 'auto_damage',
  label: 'Mísseis Mágicos',
  damageDie: 4,
  flatPerDie: 1,
  autoUnitBase: 3,
  autoUnitPerSlotAboveBase: 1,
  spellLevel: 1,
});

const fireBoltRow = baseRow({
  spellSlug: 'raio-de-fogo',
  resolution: 'spell_attack',
  label: 'Raio de Fogo',
  damageDie: 10,
  cantripScale: true,
});

const sacredFlameRow = baseRow({
  spellSlug: 'chama-sagrada',
  resolution: 'save_damage',
  label: 'Chama Sagrada',
  damageDie: 8,
  cantripScale: true,
  saveSuccessOutcome: 'none',
  saveAbilitySlug: 'destreza',
});

const cureRow = baseRow({
  spellSlug: 'curar-ferimentos',
  resolution: 'heal_combatant',
  label: 'Curar Ferimentos',
  damageDie: 8,
  diceCountBase: 2,
  dicePerSlotAboveBase: 2,
  spellLevel: 1,
  includeSpellcastingMod: true,
});

describe('resolveCombatSpell', () => {
  const common = {
    spellAttackBonus: 0,
    spellSaveDc: 13,
    spellcastingAbilityMod: 3,
    targetAc: 10,
    targetSaveBonus: 0,
    advantage: 'normal' as const,
  };

  it('returns slot_only when row missing', () => {
    const r = resolveCombatSpell({
      row: null,
      slotLevel: 1,
      characterLevel: 1,
      ...common,
    });
    expect(r.kind).toBe('slot_only');
  });

  it('auto_damage scales darts with slot (MM parity)', () => {
    const r = resolveCombatSpell({
      row: mmRow,
      slotLevel: 2,
      characterLevel: 5,
      ...common,
    });
    expect(r.kind).toBe('auto_damage');
    if (r.kind === 'auto_damage') {
      expect(r.damage).toBe(4 * (4 + 1));
      expect(r.label).toContain('4');
    }
  });

  it('spell_attack cantrip at L1 hits with 1d10', () => {
    const r = resolveCombatSpell({
      row: fireBoltRow,
      slotLevel: 0,
      characterLevel: 1,
      ...common,
    });
    expect(r.kind).toBe('spell_attack');
    if (r.kind === 'spell_attack') {
      expect(r.hit).toBe(true);
      expect(r.damage).toBe(10);
    }
  });

  it('save_damage deals full when save fails', () => {
    const r = resolveCombatSpell({
      row: sacredFlameRow,
      slotLevel: 0,
      characterLevel: 1,
      ...common,
      spellSaveDc: 20,
    });
    expect(r.kind).toBe('save_damage');
    if (r.kind === 'save_damage') {
      expect(r.saved).toBe(false);
      expect(r.damage).toBe(8);
    }
  });

  it('save_damage deals none when save succeeds (outcome none)', () => {
    const r = resolveCombatSpell({
      row: sacredFlameRow,
      slotLevel: 0,
      characterLevel: 1,
      ...common,
      spellSaveDc: 10,
    });
    expect(r.kind).toBe('save_damage');
    if (r.kind === 'save_damage') {
      expect(r.saved).toBe(true);
      expect(r.damage).toBe(0);
    }
  });

  it('heal_combatant scales with slot and adds casting mod', () => {
    const r = resolveCombatSpell({
      row: cureRow,
      slotLevel: 2,
      characterLevel: 3,
      ...common,
    });
    expect(r.kind).toBe('heal');
    if (r.kind === 'heal') {
      // 2 + (2-1)*2 = 4 dados d8 + mod 3 → 4*8+3
      expect(r.amount).toBe(4 * 8 + 3);
    }
  });

  it('auto_damage scales units from spell_level (Cloud of Daggers)', () => {
    const r = resolveCombatSpell({
      row: baseRow({
        spellSlug: 'nuvem-de-adagas',
        resolution: 'auto_damage',
        label: 'Nuvem de Adagas',
        damageDie: 4,
        autoUnitBase: 4,
        autoUnitPerSlotAboveBase: 2,
        spellLevel: 2,
      }),
      slotLevel: 3,
      characterLevel: 5,
      ...common,
    });
    expect(r.kind).toBe('auto_damage');
    if (r.kind === 'auto_damage') {
      // 4 + (3-2)*2 = 6 dados d4
      expect(r.damage).toBe(6 * 4);
      expect(r.label).toContain('6');
    }
  });

  it('arena_darkness from catalog', () => {
    const r = resolveCombatSpell({
      row: baseRow({
        spellSlug: 'escuridao',
        resolution: 'arena_darkness',
        label: 'Escuridão',
        spellLevel: 2,
      }),
      slotLevel: 2,
      characterLevel: 3,
      ...common,
    });
    expect(r).toEqual({ kind: 'arena_darkness' });
  });

  it('apply_condition applies on failed save (Hold Person)', () => {
    const { rollD20Check } = jest.requireMock('@game/dice/domain/dice') as {
      rollD20Check: jest.Mock;
    };
    rollD20Check.mockReturnValueOnce({
      total: 8,
      d20: { kept: [8], rolls: [8] },
    });
    const r = resolveCombatSpell({
      row: baseRow({
        spellSlug: 'paralisar-pessoa',
        resolution: 'apply_condition',
        label: 'Paralisar Pessoa',
        spellLevel: 2,
        saveAbilitySlug: 'sabedoria',
        conditionSlug: 'paralyzed',
      }),
      slotLevel: 2,
      characterLevel: 5,
      ...common,
    });
    expect(r.kind).toBe('apply_condition');
    if (r.kind === 'apply_condition') {
      expect(r.conditionSlug).toBe('paralyzed');
      expect(r.dc).toBe(13);
      expect(r.saved).toBe(false);
      expect(r.applied).toBe(true);
    }
  });

  it('apply_condition skips when save succeeds', () => {
    const { rollD20Check } = jest.requireMock('@game/dice/domain/dice') as {
      rollD20Check: jest.Mock;
    };
    rollD20Check.mockReturnValueOnce({
      total: 20,
      d20: { kept: [20], rolls: [20] },
    });
    const r = resolveCombatSpell({
      row: baseRow({
        spellSlug: 'medo',
        resolution: 'apply_condition',
        label: 'Medo',
        spellLevel: 3,
        saveAbilitySlug: 'sabedoria',
        conditionSlug: 'frightened',
      }),
      slotLevel: 3,
      characterLevel: 5,
      ...common,
    });
    expect(r.kind).toBe('apply_condition');
    if (r.kind === 'apply_condition') {
      expect(r.saved).toBe(true);
      expect(r.applied).toBe(false);
    }
  });

  it('heightened-spell forces save at disadvantage', () => {
    const { rollD20Check } = jest.requireMock('@game/dice/domain/dice') as {
      rollD20Check: jest.Mock;
    };
    rollD20Check.mockClear();
    rollD20Check.mockReturnValue({
      total: 12,
      d20: { kept: [12], rolls: [12] },
    });
    resolveCombatSpell({
      row: sacredFlameRow,
      slotLevel: 0,
      characterLevel: 1,
      ...common,
      spellSaveDc: 20,
      metamagicSlug: 'heightened-spell',
    });
    expect(rollD20Check).toHaveBeenCalledWith(0, 'disadvantage');
  });

  it('seeking-spell rerolls a missed spell attack', () => {
    const { rollD20Check } = jest.requireMock('@game/dice/domain/dice') as {
      rollD20Check: jest.Mock;
    };
    rollD20Check.mockClear();
    rollD20Check
      .mockReturnValueOnce({
        total: 5,
        d20: { kept: [5], rolls: [5] },
      })
      .mockReturnValueOnce({
        total: 18,
        d20: { kept: [18], rolls: [18] },
      });
    const r = resolveCombatSpell({
      row: fireBoltRow,
      slotLevel: 0,
      characterLevel: 1,
      ...common,
      targetAc: 15,
      metamagicSlug: 'seeking-spell',
    });
    expect(r.kind).toBe('spell_attack');
    if (r.kind === 'spell_attack') {
      expect(r.hit).toBe(true);
      expect(r.attackTotal).toBe(18);
      expect(r.damage).toBe(10);
    }
    expect(rollD20Check).toHaveBeenCalledTimes(2);
  });
});
