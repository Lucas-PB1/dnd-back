/**
 * Regras de combate do Patrulheiro (PHB 2024): Marca do Predador, Incansável,
 * Véu da Natureza e notas de arquétipo. O motor aplica os números; alvo/duração ficam na mesa.
 */

export type RangerSubclassSlug =
  | 'hunter'
  | 'beast-master'
  | 'fey-wanderer'
  | 'gloom-stalker'
  | 'beastborne';

export const HUNTERS_MARK_SPELL_SLUG = 'marca-do-predador';

export function isRangerClass(classSlug: string | null | undefined): boolean {
  return classSlug === 'ranger';
}

/** Marca do Predador: 1d6 Energético; Matador de Inimigos Favoritos (nv.20) → d10. */
export function huntersMarkDie(level: number): string {
  return level >= 20 ? '1d10' : '1d6';
}

/** Golpes Terríveis (Andarilho Feérico): 1d4 → 1d6 no nível 11. */
export function feyDreadfulStrikesDie(level: number): string {
  return level >= 11 ? '1d6' : '1d4';
}

/** Golpe Terrível (Vigilante das Sombras): 2d6 → 2d8 no nível 11. */
export function gloomDreadAmbusherDie(level: number): string {
  return level >= 11 ? '2d8' : '2d6';
}

export function hasPreciseHunter(level: number): boolean {
  return level >= 17;
}

export function hasRelentlessHunter(level: number): boolean {
  return level >= 13;
}

export function rangerAttacksPerAction(level: number): number {
  return level >= 5 ? 2 : 1;
}

/** Errante (nível 6): +3 m sem armadura pesada. */
export function rangerSpeedBonusMeters(input: {
  classSlug?: string | null;
  level?: number;
}): number {
  if (!isRangerClass(input.classSlug) || (input.level ?? 0) < 6) return 0;
  return 3;
}

export function rangerCombatNotes(input: {
  classSlug?: string | null;
  subclassSlug?: string | null;
  level?: number;
}): string[] {
  if (!isRangerClass(input.classSlug)) return [];
  const level = input.level ?? 1;
  const notes: string[] = [
    `Inimigo Favorito: Marca do Predador sempre preparada; usos gratuitos = PB (recuperam no Descanso Longo)`,
  ];
  addBaseRangerNotes(notes, level);
  addRangerSubclassNotes(notes, input.subclassSlug, level);
  return notes;
}

function addBaseRangerNotes(notes: string[], level: number): void {
  if (level >= 2) {
    notes.push(
      'Explorador Hábil: Especialização em 1 perícia e 2 idiomas',
    );
  }
  if (level >= 5) notes.push('Ataque Extra: dois ataques na ação Atacar');
  if (level >= 6) {
    notes.push(
      'Errante: +3 m de Deslocamento (sem Armadura Pesada); Escalada e Natação iguais ao Deslocamento',
    );
  }
  if (level >= 9) notes.push('Especialista: Especialização em mais 2 perícias');
  if (level >= 10) {
    notes.push(
      'Incansável: ação Usar Magia concede 1d8 + SAB PV temporários (usos = mod. SAB); Descanso Curto reduz Exaustão em 1',
    );
  }
  if (level >= 13) {
    notes.push(
      'Predador Implacável: dano não quebra Concentração da Marca do Predador',
    );
  }
  if (level >= 14) {
    notes.push(
      'Véu da Natureza: Ação Bônus para Invisível até o fim do próximo turno (usos = mod. SAB)',
    );
  }
  if (level >= 17) {
    notes.push(
      'Caçador Preciso: Vantagem nos ataques contra a criatura marcada',
    );
  }
  if (level >= 18) {
    notes.push('Sentidos Selvagens: Visão às Cegas 9 m');
  }
  if (level >= 20) {
    notes.push('Matador de Inimigos Favoritos: dado da Marca do Predador vira d10');
  }
}

function addRangerSubclassNotes(
  notes: string[],
  subclassSlug: string | null | undefined,
  level: number,
): void {
  if (subclassSlug === 'hunter') addHunterNotes(notes, level);
  if (subclassSlug === 'beast-master') addBeastMasterNotes(notes, level);
  if (subclassSlug === 'fey-wanderer') addFeyWandererNotes(notes, level);
  if (subclassSlug === 'gloom-stalker') addGloomStalkerNotes(notes, level);
  if (subclassSlug === 'beastborne') addBeastborneNotes(notes, level);
}

function addBeastborneNotes(notes: string[], level: number): void {
  if (level < 3) return;
  notes.push(
    'Portador Bestial: garras (1d6 Cortante, DES/FOR), Escalada e Visão no Escuro +9 m.',
  );
  notes.push(
    'Aspecto Bestial: na mesa, suba o nível (0–5) ao causar dano (Ação Bônus); zera se 1 min sem dano. Níveis: Carnificina +2, Velocidade +3 m, Frenesi de Sangue, Pele +2 CA, Retaliação.',
  );
  if (level >= 7) {
    notes.push('Uivo Feral: na Iniciativa, role 1d4 e defina o Aspecto Bestial nesse valor.');
  }
  if (level >= 11) {
    notes.push(
      'Fúria Sedenta: Marca do Predador na Ação Bônus que sobe o Aspecto; Carnificina +3.',
    );
  }
  if (level >= 15) {
    notes.push(
      'Resiliência Monstruosa: 1×/turno reduza dano em mod. CON + nível de Aspecto (mín. 0).',
    );
  }
}

function addHunterNotes(notes: string[], level: number): void {
  if (level >= 3) {
    notes.push(
      'Presa do Caçador: Assassino de Colossos (+1d8 1×/turno vs alvo abaixo do máximo) ou Destruidor de Hordas (ataque extra a outro alvo a 1,5 m)',
    );
    notes.push(
      'Conhecimento do Caçador: enquanto marcado, saiba Imunidades/Resistências/Vulnerabilidades',
    );
  }
  if (level >= 7) {
    notes.push(
      'Táticas Defensivas: Defesa Contra Ataques Múltiplos ou Escapar de Hordas',
    );
  }
  if (level >= 11) {
    notes.push(
      'Presa do Caçador Superior: ao causar dano da Marca, cause o mesmo em outra criatura a até 9 m',
    );
  }
  if (level >= 15) {
    notes.push(
      'Defesa do Caçador Superior: Reação para Resistência ao dano recebido neste turno',
    );
  }
}

function addBeastMasterNotes(notes: string[], level: number): void {
  if (level >= 3) {
    notes.push(
      'Companheiro Primal: Ação Bônus para comandar a fera; pode sacrificar um ataque para o Golpe da Fera',
    );
  }
  if (level >= 7) {
    notes.push(
      'Treinamento Excepcional: comande Ajudar/Correr/Desengajar/Esquivar; dano Energético opcional',
    );
  }
  if (level >= 11) {
    notes.push(
      'Fúria Bestial: Golpe da Fera duas vezes; a fera também causa o bônus da Marca do Predador',
    );
  }
  if (level >= 15) {
    notes.push(
      'Compartilhar Magias: magias em si também afetam a fera a até 9 m',
    );
  }
}

function addFeyWandererNotes(notes: string[], level: number): void {
  if (level >= 3) {
    notes.push(
      `Golpes Terríveis: +${feyDreadfulStrikesDie(level)} Psíquico 1×/turno ao acertar com arma`,
    );
    notes.push(
      'Glamour Transcendental: +mod. SAB (mín. +1) em testes de Carisma',
    );
  }
  if (level >= 7) {
    notes.push(
      'Detalhe Sedutor: Vantagem vs Amedrontado/Enfeitiçado; Reação para redirecionar o efeito',
    );
  }
  if (level >= 11) {
    notes.push(
      'Reforços Feéricos: Convocar Feérico 1× sem espaço / longo (sem Concentração, 1 min)',
    );
  }
  if (level >= 15) {
    notes.push(
      'Andarilho Nebuloso: Passo Nebuloso gratuito (usos = mod. SAB); pode levar um aliado',
    );
  }
}

function addGloomStalkerNotes(notes: string[], level: number): void {
  if (level >= 3) {
    notes.push(
      'Emboscador das Sombras: +SAB na Iniciativa; Golpe Terrível +' +
        gloomDreadAmbusherDie(level) +
        ' Psíquico (usos = mod. SAB); +3 m no 1º turno',
    );
    notes.push(
      'Visão Umbrosa: Visão no Escuro 18 m (ou +18 m); Invisível na Escuridão contra Visão no Escuro',
    );
  }
  if (level >= 7) {
    notes.push(
      'Mente de Ferro: proficiência em salvaguarda de Sabedoria (ou INT/CAR se já tiver)',
    );
  }
  if (level >= 11) {
    notes.push(
      'Torrente do Vigilante: Golpe Terrível 2d8 + ataque/Medo em Massa',
    );
  }
  if (level >= 15) {
    notes.push(
      'Esquiva Sombria: Reação impõe Desvantagem e teleporte de 9 m',
    );
  }
}
