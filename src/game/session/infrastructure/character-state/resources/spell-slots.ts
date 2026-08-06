import { BadRequestException } from '@nestjs/common';
import { Repository } from 'typeorm';
import { VClassSpellSlots } from '../../../../../entities/views/v-class-spell-slots.entity';
import { VSubclassSpellSlots } from '../../../../../entities/views/v-subclass-spell-slots.entity';
import {
  PlayerCharacterState,
  SpellSlotsUsed,
} from '../../player-character-state.entity';

export async function loadMaxSlots(
  classSlots: Repository<VClassSpellSlots>,
  subclassSlots: Repository<VSubclassSpellSlots>,
  classSlug: string,
  level: number,
  subclassSlug?: string | null,
): Promise<Record<string, number>> {
  if (subclassSlug) {
    const subclassRow = await subclassSlots.findOne({
      where: { subclassSlug, classLevel: level },
    });
    if (subclassRow?.spellSlots) {
      return subclassRow.spellSlots;
    }
  }
  const row = await classSlots.findOne({
    where: { classSlug, classLevel: level },
  });
  return row?.spellSlots ?? {};
}

export function computeRemaining(
  max: Record<string, number>,
  used: SpellSlotsUsed,
): Record<string, number> {
  const remaining: Record<string, number> = {};
  for (const [slotLevel, total] of Object.entries(max)) {
    remaining[slotLevel] = Math.max(0, total - (used[slotLevel] ?? 0));
  }
  return remaining;
}

/** Mutates `state.spellSlotsUsed`; returns the slot level consumed. */
export function consumeSpellSlot(
  state: PlayerCharacterState,
  maxSlots: Record<string, number>,
  spellLevel: number,
  requestedSlotLevel: number | undefined,
): number {
  const slotLevel = requestedSlotLevel ?? spellLevel;
  if (slotLevel < spellLevel) {
    throw new BadRequestException(
      `Slot level ${slotLevel} is below spell level ${spellLevel}`,
    );
  }

  const key = String(slotLevel);
  const max = maxSlots[key] ?? 0;
  const used = state.spellSlotsUsed[key] ?? 0;

  if (max <= 0) {
    throw new BadRequestException(
      `No level-${slotLevel} spell slots available for this class`,
    );
  }
  if (used >= max) {
    throw new BadRequestException(`No remaining level-${slotLevel} spell slots`);
  }

  state.spellSlotsUsed = {
    ...state.spellSlotsUsed,
    [key]: used + 1,
  };
  return slotLevel;
}

/** Recupa/desfaz o gasto de um espaço de magia. */
export function recoverSpellSlot(
  state: PlayerCharacterState,
  slotLevel: number,
): void {
  const key = String(slotLevel);
  const used = state.spellSlotsUsed[key] ?? 0;
  if (used > 0) {
    state.spellSlotsUsed = {
      ...state.spellSlotsUsed,
      [key]: used - 1,
    };
  }
}
