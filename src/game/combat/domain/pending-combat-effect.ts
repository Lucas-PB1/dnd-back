

export type PendingEffectConsumeOn = 'next_attack' | 'turn_start';

export function pendingEffectToken(kind: string, characterId: string): string {
  if (!kind || kind.includes(':')) {
    throw new Error(`Invalid pending effect kind: ${kind}`);
  }
  return `${kind}:${characterId}`;
}

export function addPendingEffect(
  effects: readonly string[] | null | undefined,
  kind: string,
  characterId: string,
): string[] {
  const token = pendingEffectToken(kind, characterId);
  const current = [...(effects ?? [])];
  if (!current.includes(token)) current.push(token);
  return current;
}

export function removePendingEffect(
  effects: readonly string[] | null | undefined,
  kind: string,
  characterId: string,
): string[] {
  const token = pendingEffectToken(kind, characterId);
  return (effects ?? []).filter((effect) => effect !== token);
}

export function hasPendingEffect(
  effects: readonly string[] | null | undefined,
  kind: string,
  characterId: string,
): boolean {
  return (effects ?? []).includes(pendingEffectToken(kind, characterId));
}

export function consumePendingEffect(
  effects: readonly string[] | null | undefined,
  kind: string,
  characterId: string,
): { effects: string[]; consumed: boolean } {
  if (!hasPendingEffect(effects, kind, characterId)) {
    return { effects: [...(effects ?? [])], consumed: false };
  }
  return {
    effects: removePendingEffect(effects, kind, characterId),
    consumed: true,
  };
}
