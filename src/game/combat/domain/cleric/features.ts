import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';

export function isClericClass(classSlug: string | null | undefined): boolean {
  return classSlug === 'cleric';
}

export function destroyUndeadDice(wisdomScore: number): string {
  return `${Math.max(1, abilityModifier(wisdomScore))}d8`;
}

export function divineStrikeDice(level: number): string | null {
  if (level < 7) return null;
  return level >= 14 ? '2d8' : '1d8';
}
