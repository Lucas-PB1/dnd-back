export const HERITAGE_TRAIT_SLOT_PREFIX = 'heritage_trait_';

export const HERITAGE_TRAIT_SLOTS = [
  'heritage_trait_1',
  'heritage_trait_2',
  'heritage_trait_3',
  'heritage_trait_4',
  'heritage_trait_5',
  'heritage_trait_6',
  'heritage_trait_7',
  'heritage_trait_8',
] as const;

export const HERITAGE_TRAIT_SLOT_9 = 'heritage_trait_9';
export const HERITAGE_SPEED_TRADE_KIND = 'heritage_speed_trade';
export const HERITAGE_SIZE_KIND = 'heritage_size';

export interface HeritageTraitPick {
  choiceKind: string;
  choiceSlug: string;
}

export interface AggregatedHeritageTraitTake {
  traitSlug: string;
  takeCount: number;
  slotIndexes: number[];
}

export function isHeritageTraitSlot(choiceKind: string): boolean {
  return choiceKind.startsWith(HERITAGE_TRAIT_SLOT_PREFIX);
}

export function heritageTraitSlotIndex(choiceKind: string): number | null {
  const match = choiceKind.match(/^heritage_trait_(\d+)$/);
  return match ? Number.parseInt(match[1], 10) : null;
}

export function aggregateTraitTakes(
  picks: readonly HeritageTraitPick[],
): AggregatedHeritageTraitTake[] {
  const bySlug = new Map<string, AggregatedHeritageTraitTake>();

  for (const pick of picks) {
    if (!isHeritageTraitSlot(pick.choiceKind)) continue;
    const slotIndex = heritageTraitSlotIndex(pick.choiceKind);
    const traitSlug = pick.choiceSlug?.trim();
    if (!traitSlug || slotIndex === null) continue;

    const existing = bySlug.get(traitSlug);
    if (existing) {
      existing.takeCount += 1;
      existing.slotIndexes.push(slotIndex);
      continue;
    }
    bySlug.set(traitSlug, {
      traitSlug,
      takeCount: 1,
      slotIndexes: [slotIndex],
    });
  }

  return [...bySlug.values()].sort((left, right) =>
    left.traitSlug.localeCompare(right.traitSlug),
  );
}

export function collectHeritageTraitPicks(
  choices: readonly HeritageTraitPick[],
): HeritageTraitPick[] {
  return choices.filter((choice) => isHeritageTraitSlot(choice.choiceKind));
}
