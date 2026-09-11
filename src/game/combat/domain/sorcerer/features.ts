export function isSorcererClass(classSlug: string | null | undefined): boolean {
  return classSlug === 'sorcerer';
}

export const INNATE_SORCERY_RESOURCE = 'innate-sorcery';
export const SORCEROUS_RESTORATION_RESOURCE = 'sorcerous-restoration';

export function sorceryPointsMax(level: number): number {
  return level >= 2 ? level : 0;
}

export function sorceryPointCostToCreateSlot(slotLevel: number): number {
  switch (slotLevel) {
    case 1:
      return 2;
    case 2:
      return 3;
    case 3:
      return 5;
    case 4:
      return 6;
    case 5:
      return 7;
    default:
      throw new Error(`Slot level ${slotLevel} cannot be created with Sorcery Points`);
  }
}

export function sorcererCombatNotes(input: {
  classSlug?: string | null;
  subclassSlug?: string | null;
  level?: number;
}): string[] {
  if (!isSorcererClass(input.classSlug)) return [];
  // Notas estáticas → `phb_level_combat_note` (class/subclass).
  return [];
}
