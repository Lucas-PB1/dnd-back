import {
  isRogueClass,
  sneakAttackDiceExpression,
  soulknifePsiDiceSchedule,
} from './sneak-attack';

export function rogueCombatNotes(input: {
  classSlug?: string | null;
  subclassSlug?: string | null;
  level?: number;
}): string[] {
  if (!isRogueClass(input.classSlug)) return [];

  const level = input.level ?? 1;
  const notes = [
    `Ataque Furtivo: ${sneakAttackDiceExpression({
      level,
      subclassSlug: input.subclassSlug,
    })} uma vez por turno`,
  ];

  if (input.subclassSlug === 'soulknife') {
    const schedule = soulknifePsiDiceSchedule(level);
    if (schedule) {
      notes.push(
        `Adaga Espiritual: ${schedule.count} Dados de Energia (d${schedule.faces})`,
      );
    }
  }
  return notes;
}
