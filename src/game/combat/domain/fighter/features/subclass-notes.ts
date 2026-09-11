/** Notas dinâmicas de subclasse de Guerreiro. Estáticas → catálogo. */
import {
  championCritThreshold,
  psiEnergyDiceSchedule,
  superiorityDiceCount,
  superiorityDieLabel,
} from './rules';

export function addFighterSubclassNotes(
  notes: string[],
  subclassSlug: string | null | undefined,
  level: number,
  dungeoneerSlayerLabels?: readonly string[],
): void {
  if (subclassSlug === 'champion' && level >= 3) {
    notes.push(
      `Campeão: crítico ${championCritThreshold(level)}–20; Vantagem em Iniciativa e Atletismo`,
    );
  }
  if (subclassSlug === 'battle-master' && level >= 3) {
    const die = superiorityDieLabel(level);
    notes.push(
      `Mestre da Batalha: ${superiorityDiceCount(level)} Dados de Superioridade (${die})`,
    );
  }
  if (subclassSlug === 'psi-warrior' && level >= 3) {
    const schedule = psiEnergyDiceSchedule(level);
    if (schedule) {
      notes.push(
        `Combatente Psíquico: ${schedule.count} Dados de Energia (d${schedule.faces})`,
      );
    }
  }
  if (subclassSlug === 'dungeoneer' && level >= 10) {
    const labels = dungeoneerSlayerLabels ?? [];
    notes.push(
      labels.length > 0
        ? `Matar Monstro: +1d10 1×/turno vs ${labels.join(', ')}`
        : 'Matar Monstro: +1d10 1×/turno vs tipos escolhidos',
    );
  }
}
