import { BadRequestException } from '@nestjs/common';

export type { CombatSpellResolution } from '@game/combat/domain/resolve-combat-spell';
export { resolveCombatSpell } from '@game/combat/domain/resolve-combat-spell';

export function mergeConditions(input: {
  current: readonly string[];
  action: 'add' | 'remove';
  condition: string;
}): string[] {
  const set = new Set(input.current);
  if (input.action === 'add') {
    set.add(input.condition);
  } else {
    set.delete(input.condition);
  }
  return [...set].sort();
}

export function assertValidDuelConditionSlug(slug: string): void {
  const allowed = new Set([
    'blinded',
    'charmed',
    'deafened',
    'frightened',
    'grappled',
    'incapacitated',
    'invisible',
    'paralyzed',
    'petrified',
    'poisoned',
    'prone',
    'restrained',
    'stunned',
    'unconscious',
  ]);
  if (!allowed.has(slug)) {
    throw new BadRequestException(`Unsupported condition '${slug}'`);
  }
}
