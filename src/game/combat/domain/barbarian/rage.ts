/**
 * Regras de combate do Bárbaro (PHB 2024): Fúria, Golpe Brutal e notas de nível.
 * Fonte: features de classe; o motor só aplica números.
 */

export function isBarbarianClass(
  classSlug: string | null | undefined,
): boolean {
  return classSlug === 'barbarian';
}

/** Dano da Fúria (coluna da tabela Características de Bárbaro). */
export function rageDamageBonus(level: number): number {
  if (level >= 16) return 4;
  if (level >= 9) return 3;
  if (level >= 1) return 2;
  return 0;
}

/**
 * Golpe Brutal: dados extras no acerto (abre mão da vantagem do Imprudente).
 * 1d10 (nv.9–16), 2d10 (nv.17+).
 */
export function brutalStrikeDice(level: number): string | null {
  if (level >= 17) return '2d10';
  if (level >= 9) return '1d10';
  return null;
}

/** Tipos de dano com Resistência enquanto a Fúria está ativa. */
export const RAGE_DAMAGE_RESISTANCES = [
  'Contundente',
  'Cortante',
  'Perfurante',
] as const;

export function appliesRageDamageBonus(input: {
  classSlug?: string | null;
  level?: number;
  rageActive?: boolean;
  mode: 'melee' | 'ranged';
  abilitySlug: 'forca' | 'destreza';
}): number {
  if (
    !input.rageActive ||
    !isBarbarianClass(input.classSlug) ||
    input.mode !== 'melee' ||
    input.abilitySlug !== 'forca' ||
    input.level == null
  ) {
    return 0;
  }
  return rageDamageBonus(input.level);
}

/** Movimento Rápido (nv.5+): +3 m enquanto sem armadura pesada (não modelamos armadura aqui). */
export function fastMovementBonusMeters(input: {
  classSlug?: string | null;
  level?: number;
}): number {
  if (!isBarbarianClass(input.classSlug) || (input.level ?? 0) < 5) return 0;
  return 3;
}

/** Fúria Divina (Fanático): 1d6 + metade do nível, uma vez por turno enquanto enfurecido. */
export function divineFuryExtraDice(level: number): string {
  const half = Math.floor(level / 2);
  return half > 0 ? `1d6+${half}` : '1d6';
}

export function hasDivineFury(input: {
  subclassSlug?: string | null;
  level?: number;
}): boolean {
  return input.subclassSlug === 'zealot' && (input.level ?? 0) >= 3;
}

/** Dados de Campeão dos Deuses (Fanático): 4→5→6→7. */
export function zealotHealingDiceCount(level: number): number {
  if (level >= 17) return 7;
  if (level >= 12) return 6;
  if (level >= 6) return 5;
  if (level >= 3) return 4;
  return 0;
}

/** Notas informativas da ficha (sem simular duração por turno). */
export function barbarianCombatNotes(input: {
  classSlug?: string | null;
  subclassSlug?: string | null;
  level?: number;
  rageActive?: boolean;
  recklessActive?: boolean;
}): string[] {
  if (!isBarbarianClass(input.classSlug)) return [];
  const level = input.level ?? 1;
  const notes: string[] = [];

  if (input.rageActive) {
    notes.push(
      `Fúria ativa (+${rageDamageBonus(level)} dano FOR; Resistência Contundente/Cortante/Perfurante; Vantagem em testes e salvaguardas de Força)`,
    );
  }
  if (input.recklessActive && level >= 2) {
    notes.push(
      'Ataque Imprudente: Vantagem em ataques com Força; ataques contra você têm Vantagem',
    );
  }
  if (level >= 2) {
    notes.push(
      'Sentido de Perigo: Vantagem em salvaguardas de Destreza (se não Incapacitado)',
    );
  }
  if (level >= 7) {
    notes.push(
      'Bote Instintivo: ao entrar em Fúria, mova-se até metade do Deslocamento',
    );
    notes.push('Instintos Primitivos: Vantagem na Iniciativa');
  }
  if (level >= 9) {
    const brutal = brutalStrikeDice(level);
    if (brutal) {
      notes.push(
        `Golpe Brutal: no acerto com Imprudente, pode abrir mão da Vantagem e causar +${brutal} (efeitos de empurrar etc. na mesa)`,
      );
    }
  }
  if (level >= 11) {
    notes.push(
      'Fúria Implacável: se cair a 0 PV com Fúria ativa, teste CON (CD 10+) para ficar com 1 PV',
    );
  }
  if (level >= 15) {
    notes.push(
      'Fúria Persistente: na Iniciativa pode recuperar todas as Fúrias (1× por descanso longo); Fúria dura 10 min sem extensão rodada a rodada',
    );
  }
  if (level >= 18) {
    notes.push(
      'Força Indomável: se o total de teste/salvaguarda de Força for menor que seu valor de Força, use o valor de Força',
    );
  }

  addBarbarianSubclassNotes(notes, input.subclassSlug, level);
  return notes;
}

function addBarbarianSubclassNotes(
  notes: string[],
  subclassSlug: string | null | undefined,
  level: number,
): void {
  if (level < 3 || !subclassSlug) return;

  if (subclassSlug === 'berserker') {
    notes.push(
      'Berserker: Frenesi — com Fúria + Imprudente, +Nd6 (N = bônus de Fúria) no 1º acerto FOR do turno.',
    );
    if (level >= 6) {
      notes.push(
        'Fúria Irracional: Imunidade a Amedrontado/Enfeitiçado enquanto enfurecido.',
      );
    }
    if (level >= 10) {
      notes.push(
        'Retaliação: Reação ao sofrer dano a 1,5 m — ataque corpo a corpo.',
      );
    }
    if (level >= 14) {
      notes.push(
        'Presença Intimidante: AB — CD FOR; Amedrontado 1 min (1×/DL; restaure gastando Fúria).',
      );
    }
  }

  if (subclassSlug === 'wild-heart') {
    notes.push(
      'Coração Selvagem: ao entrar em Fúria escolha Águia/Lobo/Urso. Águia tem Usar (AB: Correr+Desengajar).',
    );
    if (level >= 6) {
      notes.push(
        'Aspecto dos Selvagens: Coruja/Pantera/Salmão (escolha no DL — mesa).',
      );
    }
    if (level >= 14) {
      notes.push(
        'Poder dos Selvagens: ao entrar em Fúria escolha Carneiro/Falcão/Leão.',
      );
    }
  }

  if (subclassSlug === 'world-tree') {
    notes.push(
      'Árvore do Mundo: ao entrar em Fúria, PV temp. = nível; no início do turno (Fúria), aliado a 3 m pode ganhar Nd6 PV temp. (N = bônus de Fúria).',
    );
    if (level >= 6) {
      notes.push(
        'Ramos: Reação — teleporte inimigo a 9 m (salvaguarda FOR).',
      );
    }
    if (level >= 10) {
      notes.push(
        'Raízes Devastadoras: +3 m de alcance com armas Pesadas/Versáteis; no acerto pode Derrubar ou Empurrar além de outra maestria.',
      );
    }
    if (level >= 14) {
      notes.push(
        'Percorrer a Árvore: teleporte 18 m (AB); 1×/Fúria até 45 m + aliados.',
      );
    }
  }

  if (subclassSlug === 'zealot') {
    notes.push(
      'Fanático: Campeão dos Deuses (reserva d12); Fúria Divina (+1d6 + metade do nível no 1º acerto/turno).',
    );
    if (level >= 6) {
      notes.push(
        'Concentração Fanática: 1×/Fúria, rerrolar salvaguarda com +bônus de Fúria.',
      );
    }
    if (level >= 10) {
      notes.push(
        'Presença Zelosa: AB — Vantagem em ataque/salvaguarda a aliados até seu próximo turno (1×/DL).',
      );
    }
    if (level >= 14) {
      notes.push(
        'Fúria dos Deuses: forma divina 1 min ao entrar em Fúria (1×/DL).',
      );
    }
  }

  if (subclassSlug === 'path-of-the-muscle-wizard') {
    notes.push(
      'Mago Musculoso: “Truques” (Mãos Mágicas / Toque Chocante / Ataque Certeiro); “Magias” 1× cada / DL enquanto enfurecido; Reação pode entrar em Fúria sem gastar uso.',
    );
    if (level >= 10) {
      notes.push(
        'Resistência Mágica: Vantagem em salvaguardas vs magias enquanto enfurecido.',
      );
    }
    if (level >= 14) {
      notes.push(
        'Eu lancei o punho: 1×/Fúria — Ataque Desarmado com Vantagem, 6d6+FOR Contundente.',
      );
    }
  }
}
