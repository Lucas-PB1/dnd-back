import { BadRequestException } from '@nestjs/common';
import { Repository } from 'typeorm';
import { VClassSpellSlots } from '@entities/views/v-class-spell-slots.entity';
import { VSubclassSpellSlots } from '@entities/views/v-subclass-spell-slots.entity';
import { PlayerCharacterState } from '@game/session/infrastructure/player-character-state.entity';
import {
  computeRemaining,
  consumeSpellSlot,
  loadMaxSlots,
} from './spell-slots';

describe('spell-slots', () => {
  describe('computeRemaining', () => {
    it('subtracts used slots per level without going below zero', () => {
      expect(
        computeRemaining({ '1': 4, '2': 2 }, { '1': 2, '2': 5 }),
      ).toEqual({ '1': 2, '2': 0 });
    });

    it('treats missing used counts as zero', () => {
      expect(computeRemaining({ '1': 3 }, {})).toEqual({ '1': 3 });
    });
  });

  describe('consumeSpellSlot', () => {
    function state(used: Record<string, number> = {}): PlayerCharacterState {
      return { spellSlotsUsed: used } as PlayerCharacterState;
    }

    const maxSlots = { '1': 4, '2': 2, '3': 1 };

    it('consumes at spell level by default', () => {
      const row = state();
      expect(consumeSpellSlot(row, maxSlots, 1, undefined)).toBe(1);
      expect(row.spellSlotsUsed).toEqual({ '1': 1 });
    });

    it('allows upcasting to a higher slot', () => {
      const row = state();
      expect(consumeSpellSlot(row, maxSlots, 1, 2)).toBe(2);
      expect(row.spellSlotsUsed).toEqual({ '2': 1 });
    });

    it('rejects slot level below spell level', () => {
      expect(() =>
        consumeSpellSlot(state(), maxSlots, 2, 1),
      ).toThrow(BadRequestException);
    });

    it('rejects when class has no slots at that level', () => {
      expect(() =>
        consumeSpellSlot(state(), maxSlots, 4, undefined),
      ).toThrow(/No level-4 spell slots/);
    });

    it('rejects when all slots at level are spent', () => {
      expect(() =>
        consumeSpellSlot(state({ '1': 4 }), maxSlots, 1, undefined),
      ).toThrow(/No remaining level-1 spell slots/);
    });

    it('increments used count immutably on state', () => {
      const row = state({ '1': 1 });
      consumeSpellSlot(row, maxSlots, 1, undefined);
      expect(row.spellSlotsUsed).toEqual({ '1': 2 });
    });
  });

  describe('loadMaxSlots', () => {
    function repos(input: {
      subclass?: { spellSlots: Record<string, number> } | null;
      class?: { spellSlots: Record<string, number> } | null;
    }) {
      const subclassSlots = {
        findOne: jest.fn().mockResolvedValue(input.subclass ?? null),
      } as unknown as Repository<VSubclassSpellSlots>;
      const classSlots = {
        findOne: jest.fn().mockResolvedValue(input.class ?? null),
      } as unknown as Repository<VClassSpellSlots>;
      return { subclassSlots, classSlots };
    }

    it('prefers subclass slots when present', async () => {
      const { subclassSlots, classSlots } = repos({
        subclass: { spellSlots: { '1': 2 } },
        class: { spellSlots: { '1': 4 } },
      });
      const result = await loadMaxSlots(
        classSlots,
        subclassSlots,
        'cleric',
        3,
        'life',
      );
      expect(result).toEqual({ '1': 2 });
      expect(subclassSlots.findOne).toHaveBeenCalledWith({
        where: { subclassSlug: 'life', classLevel: 3 },
      });
    });

    it('falls back to class slots when subclass has none', async () => {
      const { subclassSlots, classSlots } = repos({
        subclass: null,
        class: { spellSlots: { '1': 4, '2': 2 } },
      });
      const result = await loadMaxSlots(
        classSlots,
        subclassSlots,
        'wizard',
        5,
        'evocation',
      );
      expect(result).toEqual({ '1': 4, '2': 2 });
    });

    it('skips subclass lookup when slug is absent', async () => {
      const { subclassSlots, classSlots } = repos({
        class: { spellSlots: { '1': 2 } },
      });
      await loadMaxSlots(classSlots, subclassSlots, 'fighter', 1, null);
      expect(subclassSlots.findOne).not.toHaveBeenCalled();
    });

    it('returns empty object when no rows exist', async () => {
      const { subclassSlots, classSlots } = repos({});
      expect(
        await loadMaxSlots(classSlots, subclassSlots, 'fighter', 1),
      ).toEqual({});
    });
  });
});
