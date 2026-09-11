import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';

export function isBardClass(classSlug: string | null | undefined): boolean {
  return classSlug === 'bard';
}

export function bardicInspirationDie(level: number): string {
  if (level >= 15) return 'd12';
  if (level >= 10) return 'd10';
  if (level >= 5) return 'd8';
  return 'd6';
}

export function bardicInspirationMaxUses(charismaScore: number): number {
  return Math.max(1, abilityModifier(charismaScore));
}

export function bardicInspirationRestRecovery(level: number): 'short' | 'long' {
  return level >= 5 ? 'short' : 'long';
}

/** Notas dinâmicas. Estáticas → `phb_level_combat_note`. */
export function bardCombatNotes(input: {
  classSlug?: string | null;
  subclassSlug?: string | null;
  level?: number;
}): string[] {
  if (!isBardClass(input.classSlug)) return [];

  const level = input.level ?? 1;
  const die = bardicInspirationDie(level);
  const recovery =
    bardicInspirationRestRecovery(level) === 'short' ? 'Curto/Longo' : 'Longo';

  return [
    `Inspiração de Bardo (${die}): Ação Bônus para conceder a uma criatura a até 18 m; recarrega em Descanso ${recovery}.`,
  ];
}
