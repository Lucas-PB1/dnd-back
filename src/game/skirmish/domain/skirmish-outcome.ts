import type {
  SkirmishEndReason,
  SkirmishStatus,
  SkirmishWinnerKind,
} from './skirmish-status';

export function skirmishWinnerFromHitPoints(
  pcHp: number,
  actorHp: number,
): SkirmishWinnerKind | null {
  if (pcHp > 0 && actorHp > 0) return null;
  return pcHp > 0 ? 'pc' : 'actor';
}

export function skirmishForfeitPatch(): {
  status: SkirmishStatus;
  endReason: SkirmishEndReason;
  winnerKind: null;
} {
  return {
    status: 'finished',
    endReason: 'forfeit',
    winnerKind: null,
  };
}
