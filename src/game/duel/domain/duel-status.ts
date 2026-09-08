export const DUEL_STATUSES = [
  'open',
  'ready',
  'active',
  'finished',
  'cancelled',
] as const;

export type DuelStatus = (typeof DUEL_STATUSES)[number];

export const DUEL_END_REASONS = ['hp', 'forfeit', 'cancel'] as const;

export type DuelEndReason = (typeof DUEL_END_REASONS)[number];

export const DUEL_MAX_MEMBERS = 2;
