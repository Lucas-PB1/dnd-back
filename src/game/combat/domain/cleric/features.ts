import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';

export function isClericClass(classSlug: string | null | undefined): boolean {
  return classSlug === 'cleric';
}

export function divineSparkDice(level: number): string {
  if (level >= 18) return '4d8';
  if (level >= 13) return '3d8';
  if (level >= 7) return '2d8';
  return '1d8';
}

export function destroyUndeadDice(wisdomScore: number): string {
  return `${Math.max(1, abilityModifier(wisdomScore))}d8`;
}

export function divineStrikeDice(level: number): string | null {
  if (level < 7) return null;
  return level >= 14 ? '2d8' : '1d8';
}

/** Notas dinâmicas. Estáticas → `phb_level_combat_note`. */
export function clericCombatNotes(input: {
  classSlug?: string | null;
  subclassSlug?: string | null;
  level?: number;
}): string[] {
  if (!isClericClass(input.classSlug)) return [];

  const level = input.level ?? 1;
  const notes: string[] = [];

  if (level >= 2) {
    notes.push(
      `Canalizar Divindade: Centelha Divina (${divineSparkDice(level)} + SAB para cura/dano) ou Expulsar Mortos-Vivos`,
    );
  }
  if (level >= 7) {
    notes.push(
      `Golpes Abençoados: escolha Conjuração Poderosa (+SAB no dano de truques) ou Golpe Divino (+${divineStrikeDice(level)} Necrótico/Radiante com arma, 1×/turno)`,
    );
  }
  return notes;
}
