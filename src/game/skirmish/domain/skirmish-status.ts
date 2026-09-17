export type SkirmishStatus = 'active' | 'finished';
export type SkirmishWinnerKind = 'pc' | 'actor';
export type SkirmishEndReason = 'hp' | 'forfeit';

export type SkirmishCombatLogEntry = {
  at: string;
  text: string;
};
