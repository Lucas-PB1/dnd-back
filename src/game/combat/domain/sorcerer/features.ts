export function isSorcererClass(classSlug: string | null | undefined): boolean {
  return classSlug === 'sorcerer';
}

export const INNATE_SORCERY_RESOURCE = 'innate-sorcery';
export const SORCEROUS_RESTORATION_RESOURCE = 'sorcerous-restoration';

export function sorceryPointsMax(level: number): number {
  return level >= 2 ? level : 0;
}

export function sorceryPointCostToCreateSlot(slotLevel: number): number {
  switch (slotLevel) {
    case 1:
      return 2;
    case 2:
      return 3;
    case 3:
      return 5;
    case 4:
      return 6;
    case 5:
      return 7;
    default:
      throw new Error(`Slot level ${slotLevel} cannot be created with Sorcery Points`);
  }
}

export function sorcererCombatNotes(input: {
  classSlug?: string | null;
  subclassSlug?: string | null;
  level?: number;
}): string[] {
  if (!isSorcererClass(input.classSlug)) return [];

  const level = input.level ?? 1;
  const notes = [
    'Feitiçaria Inata (2×/DL): Ação Bônus libera a magia por 1 minuto (+1 na CD das suas magias de Feiticeiro e Vantagem nas jogadas de ataque das magias de Feiticeiro).',
  ];

  addBaseSorcererNotes(notes, level);
  addSorcererSubclassNotes(notes, input.subclassSlug, level);
  return notes;
}

function addBaseSorcererNotes(notes: string[], level: number): void {
  if (level >= 2) {
    notes.push(
      'Fonte de Magia: converta Slots de Magia em Pontos de Feitiçaria (1:1) ou Pontos de Feitiçaria em Slots de 1º a 5º círculo.',
    );
    notes.push(
      'Metamagia: aplique opções conhecidas gastando Pontos de Feitiçaria.',
    );
  }
  if (level >= 5) {
    notes.push(
      'Restauração Feiticeira (1×/DL): no Descanso Curto, recupere Pontos de Feitiçaria até metade do nível do Feiticeiro.',
    );
  }
  if (level >= 7) {
    notes.push(
      'Feitiçaria Encarnada: sem usos de Feitiçaria Inata, gaste 2 Pontos de Feitiçaria ao ativá-la; com Inata ativa, até 2 Metamagias por magia.',
    );
  }
  if (level >= 20) {
    notes.push(
      'Apoteose Arcana: enquanto a Feitiçaria Inata estiver ativa, você pode usar uma opção de Metamagia por turno sem gastar Pontos de Feitiçaria.',
    );
  }
}

function addSorcererSubclassNotes(
  notes: string[],
  subclassSlug: string | null | undefined,
  level: number,
): void {
  if (level < 3) return;

  if (subclassSlug === 'draconic') {
    notes.push(
      'Linhagem Dracônica: Resiliência Dracônica (CA sem armadura = 10 + DES + CAR; +1 PV por nível) e Afinidade Elemental (+CAR no dano de magias do elemento ancestral).',
    );
    if (level >= 14) {
      notes.push(
        'Asas de Dragão (L14): Ação Bônus — voo 18 m por 1 h (1×/DL ou 3 Pontos de Feitiçaria para restaurar o uso).',
      );
    }
  }

  if (subclassSlug === 'aberrant') {
    notes.push(
      'Feitiçaria Aberrante: Mente Psiónica (telepatia a 9 m) e Feitiçaria Psiónica (gaste Pontos de Feitiçaria em vez de slots para magias aberrantes sem componentes V, S ou M).',
    );
  }

  if (subclassSlug === 'clockwork') {
    notes.push(
      'Feitiçaria Mecânica: Restaurar Equilíbrio (Reação; usos = CAR) e Bastião da Lei (1–5 Pontos → N d8 de proteção).',
    );
  }

  if (subclassSlug === 'wild-magic') {
    notes.push(
      'Feitiçaria Selvagem: Marés do Caos (Vantagem em 1 Teste de D20; 1 uso).',
    );
    if (level >= 6) {
      notes.push(
        'Distorcer a Sorte (L6): Reação — 1 Ponto de Feitiçaria → ±1d4 no d20 de outra criatura.',
      );
    }
  }

  if (subclassSlug === 'heroic-sorcery') {
    notes.push(
      'Feitiçaria Heróica: Alma Heróica (1 Ponto de Feitiçaria no início do turno → PV temp. 1d6 + nível); treino marcial e Lâmina Inata (CAR no ataque com Feitiçaria Inata).',
    );
    if (level >= 6) {
      notes.push(
        'Ataque Extra: dois ataques; pode trocar um por um Truque de Feiticeiro.',
      );
    }
    if (level >= 14) {
      notes.push(
        'Manobras Místicas (2 SP): Cegar, Ruinoso (−3 CA) ou Ferimento (sangramento) +2d8 no dano — gaste na economia.',
      );
    }
    if (level >= 18) {
      notes.push(
        'Aceleração Heróica: Acelerar em você sem Concentração (sem letargia ao terminar).',
      );
    }
  }
}
