import type { ApplyCtx } from './types';

export type ApplyOneEffectResult = {
  state: ApplyCtx['state'];
  note: string;
  total?: number;
  expression?: string;
  roll?: number;
  saveDc?: number;
  resourceSpent: boolean;
  toggleEntered?: boolean | null;
};
