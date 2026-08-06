/**
 * Regras de combate do Guerreiro (PHB 2024) e efeitos numéricos de subclasse.
 */

export function isFighterClass(classSlug: string | null | undefined): boolean {
  return classSlug === 'fighter';
}

/** Ataques por Ação Atacar: 1 → 2 (nv.5) → 3 (nv.11) → 4 (nv.20). */
export function attacksPerAction(level: number): number {
  if (level >= 20) return 4;
  if (level >= 11) return 3;
  if (level >= 5) return 2;
  return 1;
}

/** Cura de Recuperar Fôlego: 1d10 + nível de Guerreiro. */
export function secondWindHealDice(level: number): string {
  return `1d10+${Math.max(1, level)}`;
}

/** Usos de Indomável: 1 (nv.9), 2 (nv.13), 3 (nv.17). */
export function indomitableMaxUses(level: number): number {
  if (level >= 17) return 3;
  if (level >= 13) return 2;
  if (level >= 9) return 1;
  return 0;
}

/** Dados de Superioridade (Mestre da Batalha): quantidade. */
export function superiorityDiceCount(level: number): number {
  if (level >= 15) return 6;
  if (level >= 7) return 5;
  if (level >= 3) return 4;
  return 0;
}

/** Faces do Dado de Superioridade: d8 → d10 (nv.10) → d12 (nv.18). */
export function superiorityDieFaces(level: number): number | null {
  if (level < 3) return null;
  if (level >= 18) return 12;
  if (level >= 10) return 10;
  return 8;
}

export function superiorityDieLabel(level: number): string | null {
  const faces = superiorityDieFaces(level);
  return faces == null ? null : `d${faces}`;
}

/**
 * Dados de Energia Psiônica (Combatente Psíquico).
 * Nível → { faces, count }
 */
export function psiEnergyDiceSchedule(level: number): {
  faces: number;
  count: number;
} | null {
  if (level < 3) return null;
  if (level >= 17) return { faces: 12, count: 12 };
  if (level >= 13) return { faces: 10, count: 10 };
  if (level >= 11) return { faces: 10, count: 8 };
  if (level >= 9) return { faces: 8, count: 8 };
  if (level >= 5) return { faces: 8, count: 6 };
  return { faces: 6, count: 4 };
}

export function psiEnergyDiceCount(level: number): number {
  return psiEnergyDiceSchedule(level)?.count ?? 0;
}

export function psiEnergyDieFaces(level: number): number | null {
  return psiEnergyDiceSchedule(level)?.faces ?? null;
}

export function psiEnergyDieLabel(level: number): string | null {
  const faces = psiEnergyDieFaces(level);
  return faces == null ? null : `d${faces}`;
}

/** Crítico do Campeão: 19–20 (nv.3), 18–20 (nv.15). */
export function championCritThreshold(level: number): number {
  if (level >= 15) return 18;
  if (level >= 3) return 19;
  return 20;
}

export function resolveFighterAttackCritThreshold(input: {
  classSlug?: string | null;
  subclassSlug?: string | null;
  level?: number;
}): number {
  if (
    !isFighterClass(input.classSlug) ||
    input.subclassSlug !== 'champion' ||
    input.level == null
  ) {
    return 20;
  }
  return championCritThreshold(input.level);
}

export function hasStudiedAttacks(level: number): boolean {
  return level >= 13;
}

export function hasTacticalMaster(level: number): boolean {
  return level >= 9;
}

export function hasTacticalShift(level: number): boolean {
  return level >= 5;
}

export function hasTacticalMind(level: number): boolean {
  return level >= 2;
}

export function fighterCombatNotes(input: {
  classSlug?: string | null;
  subclassSlug?: string | null;
  level?: number;
  /** Labels de Matar Monstro (catálogo); omitido = sem nota de tipos. */
  dungeoneerSlayerLabels?: readonly string[];
}): string[] {
  if (!isFighterClass(input.classSlug)) return [];
  const level = input.level ?? 1;
  const notes: string[] = [];

  notes.push(`Ataques por ação: ${attacksPerAction(level)}`);

  if (hasTacticalMind(level)) {
    notes.push(
      'Mente Tática: ao falhar em teste de atributo, gaste Recuperar Fôlego para +1d10 (uso devolvido se ainda falhar)',
    );
  }
  if (hasTacticalShift(level)) {
    notes.push(
      'Ajuste Tático: ao usar Recuperar Fôlego, mova-se até metade do Deslocamento sem provocar AO',
    );
  }
  if (hasTacticalMaster(level)) {
    notes.push(
      'Mestre Tático: pode substituir a maestria da arma por Empurrar, Drenar ou Lentidão neste ataque',
    );
  }
  if (indomitableMaxUses(level) > 0) {
    notes.push(
      `Indomável: rerrolar salvaguarda com +${level} (até ${indomitableMaxUses(level)}× por descanso longo)`,
    );
  }
  if (hasStudiedAttacks(level)) {
    notes.push(
      'Ataques Estudados: se errar um ataque, vantagem no próximo ataque contra o mesmo alvo até o fim do próximo turno',
    );
  }

  if (input.subclassSlug === 'champion') {
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

  if (input.subclassSlug === 'battle-master' && level >= 3) {
    const die = superiorityDieLabel(level);
    notes.push(
      `Mestre da Batalha: ${superiorityDiceCount(level)} Dados de Superioridade (${die})`,
    );
  }

  if (input.subclassSlug === 'psi-warrior' && level >= 3) {
    const schedule = psiEnergyDiceSchedule(level);
    if (schedule) {
      notes.push(
        `Combatente Psíquico: ${schedule.count} Dados de Energia (d${schedule.faces})`,
      );
    }
  }

  if (input.subclassSlug === 'eldritch-knight' && level >= 3) {
    notes.push('Cavaleiro Místico: conjuração de 1/3 (lista de Mago, INT)');
    if (level >= 7) {
      notes.push(
        'Magia de Guerra: substitua 1 ataque por um truque (ação) na ação Atacar',
      );
    }
  }

  if (input.subclassSlug === 'dungeoneer') {
    if (level >= 3) {
      notes.push(
        'Chute na Porta: Vantagem nos ataques na primeira rodada de combate',
      );
    }
    if (level >= 10) {
      const labels = input.dungeoneerSlayerLabels ?? [];
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

  return notes;
}
