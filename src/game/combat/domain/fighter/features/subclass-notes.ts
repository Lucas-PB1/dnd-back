/** Notas de combate por subclasse de Guerreiro (PHB 2024 + Dungeoneer). */
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
  if (subclassSlug === 'champion') addChampionNotes(notes, level);
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
  if (subclassSlug === 'eldritch-knight') addEldritchKnightNotes(notes, level);
  if (subclassSlug === 'dungeoneer') {
    addDungeoneerNotes(notes, level, dungeoneerSlayerLabels);
  }
}

function addChampionNotes(notes: string[], level: number): void {
  if (level >= 3) {
    notes.push(
      `Campeão: crítico ${championCritThreshold(level)}–20; Vantagem em Iniciativa e Atletismo`,
    );
  }
  if (level >= 10) {
    notes.push(
      'Combatente Heroico: no início do turno sem Inspiração Heroica, conceda-a a si',
    );
  }
  if (level >= 18) {
    notes.push(
      'Sobrevivente: Vantagem em salvaguardas contra morte; Regeneração Heroica se Sangrando',
    );
  }
}

function addEldritchKnightNotes(notes: string[], level: number): void {
  if (level >= 3) {
    notes.push('Cavaleiro Místico: conjuração de 1/3 (lista de Mago, INT)');
  }
  if (level >= 7) {
    notes.push(
      'Magia de Guerra: substitua 1 ataque por um truque (ação) na ação Atacar',
    );
  }
}

function addDungeoneerNotes(
  notes: string[],
  level: number,
  dungeoneerSlayerLabels?: readonly string[],
): void {
  if (level >= 3) {
    notes.push(
      'Chute na Porta: Vantagem nos ataques na primeira rodada de combate',
    );
  }
  if (level >= 10) {
    const labels = dungeoneerSlayerLabels ?? [];
    notes.push(
      labels.length > 0
        ? `Matar Monstro: +1d10 1×/turno vs ${labels.join(', ')}`
        : 'Matar Monstro: +1d10 1×/turno vs tipos escolhidos',
    );
  }
  if (level >= 15) {
    notes.push(
      'Evitar: em salvaguarda FOR/DES/CON por metade do dano, sucesso = 0 e falha = metade',
    );
  }
}
