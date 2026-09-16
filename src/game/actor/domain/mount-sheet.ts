export const OTHERWORLDLY_STEED_PREFIX = 'montaria-sobrenatural-';
export const PHANTOM_STEED_TEMPLATE = 'montaria-fantasmagorica';

export const MOUNT_SHEET_ACTIONS = [
  'board',
  'dismount',
  'healing-touch',
  'fey-step',
  'frighten',
] as const;

export type MountSheetAction = (typeof MOUNT_SHEET_ACTIONS)[number];

export const MOUNT_LONG_REST_USE_KEYS = [
  'toque-curativo',
  'passo-feerico',
  'derrubar-brilho',
] as const;

export function isMountSheetAction(value: string): value is MountSheetAction {
  return (MOUNT_SHEET_ACTIONS as readonly string[]).includes(value);
}

export function isVitalBondMountTemplate(
  templateSlug: string | null | undefined,
): boolean {
  return (templateSlug ?? '').startsWith(OTHERWORLDLY_STEED_PREFIX);
}

export function isPhantomSteedTemplate(
  templateSlug: string | null | undefined,
): boolean {
  return templateSlug === PHANTOM_STEED_TEMPLATE;
}

export function isCelestialSteedTemplate(
  templateSlug: string | null | undefined,
): boolean {
  return templateSlug === `${OTHERWORLDLY_STEED_PREFIX}celestial`;
}

export function isFeySteedTemplate(
  templateSlug: string | null | undefined,
): boolean {
  return templateSlug === `${OTHERWORLDLY_STEED_PREFIX}feerico`;
}

export function isFiendSteedTemplate(
  templateSlug: string | null | undefined,
): boolean {
  return templateSlug === `${OTHERWORLDLY_STEED_PREFIX}infero`;
}

export function applyHealToActorVitals(input: {
  hitPointsCurrent: number | null;
  hitPointsMax: number | null;
  amount: number;
}): { hitPointsCurrent: number | null; healed: number } {
  const { hitPointsCurrent, hitPointsMax, amount } = input;
  if (
    amount <= 0 ||
    hitPointsCurrent == null ||
    hitPointsMax == null
  ) {
    return { hitPointsCurrent, healed: 0 };
  }
  const after = Math.min(hitPointsMax, hitPointsCurrent + amount);
  return { hitPointsCurrent: after, healed: after - hitPointsCurrent };
}

export function longRestUseRemaining(
  uses: Record<string, number> | null | undefined,
  key: string,
): boolean {
  return (uses?.[key] ?? 0) < 1;
}

export function consumeLongRestUse(
  uses: Record<string, number> | null | undefined,
  key: string,
): Record<string, number> {
  return { ...(uses ?? {}), [key]: 1 };
}

export function clearMountLongRestUses(
  uses: Record<string, number> | null | undefined,
): Record<string, number> {
  const next = { ...(uses ?? {}) };
  for (const key of MOUNT_LONG_REST_USE_KEYS) {
    delete next[key];
  }
  return next;
}
