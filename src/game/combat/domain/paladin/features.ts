/**
 * Regras de combate do Paladino (PHB 2024): Destruição Divina, Golpes Radiantes,
 * auras e notas de nível. O motor aplica os números; alvo/duração ficam na mesa.
 */

export type PaladinSubclassSlug =
  | 'devotion'
  | 'glory'
  | 'ancients'
  | 'vengeance'
  | 'oath-of-revelry';

export function isPaladinClass(classSlug: string | null | undefined): boolean {
  return classSlug === 'paladin';
}

/**
 * Destruição Divina (Divine Smite): 2d8 Radiante num espaço de 1º círculo,
 * +1d8 por círculo acima do 1º e +1d8 contra Corruptores/Mortos-vivos.
 */
export function divineSmiteDice(input: {
  slotLevel: number;
  vsUndeadOrFiend?: boolean;
}): string {
  const base = 1 + Math.max(1, input.slotLevel);
  const bonus = input.vsUndeadOrFiend ? 1 : 0;
  return `${base + bonus}d8`;
}

/** Golpes Radiantes (nível 11): +1d8 Radiante em ataques corpo a corpo. */
export function radiantStrikesDie(level: number): string | null {
  return level >= 11 ? '1d8' : null;
}

/** Aura de Proteção (nível 6+): você e aliados somam o mod. de Carisma às salvaguardas. */
export function hasAuraOfProtection(level: number): boolean {
  return level >= 6;
}

export function auraOfProtectionBonus(charismaModifier: number): number {
  return Math.max(1, charismaModifier);
}

export function auraRangeMeters(level: number): number {
  return level >= 18 ? 9 : 3;
}

/** Ataque Extra do Paladino (nível 5). */
export function paladinAttacksPerAction(level: number): number {
  return level >= 5 ? 2 : 1;
}

export function paladinCombatNotes(input: {
  classSlug?: string | null;
  subclassSlug?: string | null;
  level?: number;
}): string[] {
  if (!isPaladinClass(input.classSlug)) return [];
  const level = input.level ?? 1;
  const notes: string[] = [
    'Mãos Consagradas: reserva de cura = 5 × nível (Ação Bônus; 5 PV removem Envenenado)',
  ];

  addBasePaladinNotes(notes, level);
  addPaladinSubclassNotes(notes, input.subclassSlug, level);
  return notes;
}

function addBasePaladinNotes(notes: string[], level: number): void {
  if (level >= 2) {
    notes.push(
      'Destruição Divina: gaste um espaço de magia no acerto para +2d8 Radiante (+1d8 por círculo acima do 1º; +1d8 vs Corruptor/Morto-vivo)',
    );
  }
  if (level >= 3) {
    notes.push(
      'Canalizar Divindade: Sentido Divino e opções do juramento (usos por descanso)',
    );
  }
  if (level >= 5) notes.push('Ataque Extra: dois ataques na ação Atacar');
  if (level >= 6) {
    notes.push(
      `Aura de Proteção (${auraRangeMeters(level)} m): você e aliados somam o mod. de Carisma às salvaguardas`,
    );
  }
  if (level >= 9) {
    notes.push('Repudiar Inimigos: Canalizar Divindade para Amedrontar inimigos');
  }
  if (level >= 10) {
    notes.push('Aura de Coragem: imunidade a Amedrontado na aura');
  }
  if (level >= 11) {
    notes.push('Golpes Radiantes: +1d8 Radiante em cada ataque corpo a corpo');
  }
  if (level >= 14) {
    notes.push('Toque Restaurador: gaste 5 PV das Mãos Consagradas para remover condições');
  }
  if (level >= 18) notes.push('Aura Expandida: alcance das auras vai a 9 m');
}

function addPaladinSubclassNotes(
  notes: string[],
  subclassSlug: string | null | undefined,
  level: number,
): void {
  if (subclassSlug === 'devotion') addDevotionNotes(notes, level);
  if (subclassSlug === 'glory') addGloryNotes(notes, level);
  if (subclassSlug === 'ancients') addAncientsNotes(notes, level);
  if (subclassSlug === 'vengeance') addVengeanceNotes(notes, level);
  if (subclassSlug === 'oath-of-revelry') addRevelryNotes(notes, level);
}

function addDevotionNotes(notes: string[], level: number): void {
  if (level >= 3) {
    notes.push('Arma Sagrada: Canalizar Divindade adiciona Carisma ao ataque e luz Radiante');
  }
  if (level >= 7) notes.push('Aura de Devoção: imunidade a Enfeitiçado na aura');
  if (level >= 15) notes.push('Destruição Protetora: reduza dano com sua Reação');
  if (level >= 20) notes.push('Resplendor Sagrado: aura de dano Radiante por 1 minuto');
}

function addGloryNotes(notes: string[], level: number): void {
  if (level >= 3) {
    notes.push('Destruição Inspiradora: Canalizar Divindade para dano extra e PV temporários');
    notes.push('Atleta Inigualável: Canalizar Divindade para Vantagem em Atletismo/Acrobacia');
  }
  if (level >= 7) notes.push('Aura de Vivacidade: aliados na aura ganham deslocamento extra');
  if (level >= 15) notes.push('Defesa Gloriosa: Reação concede CA e contra-ataque');
  if (level >= 20) notes.push('Lenda Viva: Vantagem e rerolagens por 1 minuto');
}

function addAncientsNotes(notes: string[], level: number): void {
  if (level >= 3) {
    notes.push('A Ira da Natureza: Canalizar Divindade para Imobilizar com vinhas');
  }
  if (level >= 7) {
    notes.push('Aura de Resistência: Resistência a dano de magias na aura');
  }
  if (level >= 15) notes.push('Sentinela Imortal: continue de pé a 0 PV (1×/descanso longo)');
  if (level >= 20) notes.push('Campeão Ancestral: transforme-se por 1 minuto');
}

function addVengeanceNotes(notes: string[], level: number): void {
  if (level >= 3) {
    notes.push('Voto de Inimizade: Canalizar Divindade para Vantagem contra um alvo');
  }
  if (level >= 7) {
    notes.push('Vingador Implacável: mova-se ao acertar Ataques de Oportunidade');
  }
  if (level >= 15) notes.push('Alma Vingativa: Vantagem na Iniciativa');
  if (level >= 20) notes.push('Anjo Vingador: voe e Amedronte por 1 hora');
}

function addRevelryNotes(notes: string[], level: number): void {
  if (level >= 3) {
    notes.push('Conjurar Bebida: Canalizar Divindade para efeitos de bebida em área');
  }
  if (level >= 7) notes.push('Aura de Fraternidade: aliados na aura resistem a efeitos');
  if (level >= 15) notes.push('Folião: usos = mod. de Carisma por descanso longo');
  if (level >= 20) notes.push('Animal de Festa: transformação festiva (1×/longo ou espaço de 5º)');
}
