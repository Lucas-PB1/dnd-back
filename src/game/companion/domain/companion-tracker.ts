export type CompanionTracker = {
  actorId: string;
  name: string;
  templateSlug: string | null;
  hitPointsCurrent: number | null;
  hitPointsMax: number | null;
  armorClass: number | null;
  defeated: boolean;
  conditions: string[];
};

export function companionIsDefeated(
  hitPointsCurrent: number | null | undefined,
): boolean {
  return hitPointsCurrent == null || hitPointsCurrent <= 0;
}

export function toCompanionTracker(input: {
  id: string;
  name: string;
  templateSlug: string | null;
  hitPointsCurrent: number | null;
  hitPointsMax: number | null;
  armorClass: number | null;
  conditions?: string[] | null;
}): CompanionTracker {
  return {
    actorId: input.id,
    name: input.name,
    templateSlug: input.templateSlug,
    hitPointsCurrent: input.hitPointsCurrent,
    hitPointsMax: input.hitPointsMax,
    armorClass: input.armorClass,
    defeated: companionIsDefeated(input.hitPointsCurrent),
    conditions: input.conditions ?? [],
  };
}

export function pickCommandCompanion(
  trackers: CompanionTracker[],
  templateSlug?: string | null,
): CompanionTracker | null {
  if (trackers.length === 0) return null;
  const preferred = templateSlug
    ? trackers.find((row) => row.templateSlug === templateSlug)
    : undefined;
  const livingPreferred = preferred && !preferred.defeated ? preferred : null;
  if (livingPreferred) return livingPreferred;
  return trackers.find((row) => !row.defeated) ?? preferred ?? trackers[0];
}
