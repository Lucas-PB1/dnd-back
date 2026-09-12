

export function itemIsCursed(
  properties: Record<string, unknown> | null | undefined,
): boolean {
  return properties?.cursed === true;
}

export function instanceCurseBroken(
  instanceProperties: Record<string, unknown> | null | undefined,
): boolean {
  return instanceProperties?.curseBroken === true;
}

export function mayEndCursedAttunement(input: {
  properties: Record<string, unknown> | null | undefined;
  instanceProperties: Record<string, unknown> | null | undefined;
}): boolean {
  if (!itemIsCursed(input.properties)) return true;
  return instanceCurseBroken(input.instanceProperties);
}

export function withCurseBroken(
  instanceProperties: Record<string, unknown> | null | undefined,
): Record<string, unknown> {
  return {
    ...(instanceProperties && typeof instanceProperties === 'object'
      ? instanceProperties
      : {}),
    curseBroken: true,
  };
}
