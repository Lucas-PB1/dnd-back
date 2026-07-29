import {
  applyItemAbilityBonuses,
  parsePermanentItemEffects,
  resolveActivePermanentItemEffects,
} from './permanent-item-effects';

describe('permanent-item-effects', () => {
  describe('parsePermanentItemEffects', () => {
    it('returns empty effects when permanentEffects is missing', () => {
      expect(parsePermanentItemEffects({ magic: true })).toEqual({
        acBonus: 0,
        attackBonus: 0,
        damageBonus: 0,
        abilityBonuses: {},
        savingThrowBonuses: {},
        speedBonusMeters: 0,
        hpBonus: 0,
      });
    });

    it('parses structured permanentEffects', () => {
      expect(
        parsePermanentItemEffects({
          permanentEffects: {
            acBonus: 1,
            attackBonus: 2,
            damageBonus: 3,
            abilityBonuses: { forca: 1, destreza: 0, invalid: 9 },
            savingThrowBonuses: { sabedoria: 2 },
            speedBonusMeters: 1.5,
            hpBonus: 5,
          },
        }),
      ).toEqual({
        acBonus: 1,
        attackBonus: 2,
        damageBonus: 3,
        abilityBonuses: { forca: 1 },
        savingThrowBonuses: { sabedoria: 2 },
        speedBonusMeters: 1.5,
        hpBonus: 5,
      });
    });
  });

  describe('resolveActivePermanentItemEffects', () => {
    it('sums only active items', () => {
      const result = resolveActivePermanentItemEffects([
        {
          location: 'equipped',
          attuned: true,
          itemName: 'Anel Ativo',
          properties: {
            requiresAttunement: true,
            permanentEffects: { acBonus: 1, attackBonus: 1 },
          },
        },
        {
          location: 'backpack',
          attuned: true,
          itemName: 'Na Mochila',
          properties: {
            requiresAttunement: true,
            permanentEffects: { acBonus: 5 },
          },
        },
        {
          location: 'equipped',
          attuned: false,
          itemName: 'Sem Sintonia',
          properties: {
            requiresAttunement: true,
            permanentEffects: { damageBonus: 4 },
          },
        },
        {
          location: 'equipped',
          attuned: false,
          itemName: 'Sem Exigência',
          properties: {
            permanentEffects: { damageBonus: 2, speedBonusMeters: 3 },
          },
        },
      ]);

      expect(result).toMatchObject({
        acBonus: 1,
        attackBonus: 1,
        damageBonus: 2,
        speedBonusMeters: 3,
        sourceNames: ['Anel Ativo', 'Sem Exigência'],
      });
    });

    it('ignores items without permanentEffects even when active', () => {
      const result = resolveActivePermanentItemEffects([
        {
          location: 'equipped',
          attuned: true,
          itemName: 'Só ativado',
          properties: { requiresAttunement: true, magic: true },
        },
      ]);
      expect(result.sourceNames).toEqual([]);
      expect(result.acBonus).toBe(0);
    });
  });

  describe('applyItemAbilityBonuses', () => {
    it('returns a copy with bonuses applied', () => {
      const base = {
        forca: 10,
        destreza: 12,
        constituicao: 14,
        inteligencia: 8,
        sabedoria: 10,
        carisma: 16,
      };
      const next = applyItemAbilityBonuses(base, { forca: 2, carisma: 1 });
      expect(next).toEqual({ ...base, forca: 12, carisma: 17 });
      expect(next).not.toBe(base);
    });
  });
});
