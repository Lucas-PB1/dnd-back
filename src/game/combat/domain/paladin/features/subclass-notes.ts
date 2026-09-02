/** Notas de combate por subclasse/juramento de Paladino (PHB 2024). */

export function addPaladinSubclassNotes(
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
    notes.push(
      'Arma Sagrada: na ação Atacar, Canalizar — +Carisma no ataque e luz por 10 min',
    );
  }
  if (level >= 7) notes.push('Aura de Devoção: imunidade a Enfeitiçado na aura');
  if (level >= 15) {
    notes.push(
      'Destruição Protetora: ao usar Destruição Divina, Cobertura Parcial na aura até seu próximo turno',
    );
  }
  if (level >= 20) notes.push('Resplendor Sagrado: aura de dano Radiante por 10 minutos');
}

function addGloryNotes(notes: string[], level: number): void {
  if (level >= 3) {
    notes.push(
      'Destruição Inspiradora: após Destruição Divina, Canalizar para distribuir PV temp. (2d8 + nível)',
    );
    notes.push(
      'Atleta Inigualável: Canalizar — Vantagem em Atletismo/Acrobacia e saltos +3 m por 1 h',
    );
  }
  if (level >= 7) {
    notes.push('Aura de Vivacidade: +3 m de deslocamento (você e aliados na aura)');
  }
  if (level >= 15) {
    notes.push(
      'Defesa Gloriosa: Reação — +CA (Carisma) contra um ataque; se errar, possível contra-ataque',
    );
  }
  if (level >= 20) notes.push('Lenda Viva: Vantagem em Carisma, golpe infalível e rerrolar salvaguarda');
}

function addAncientsNotes(notes: string[], level: number): void {
  if (level >= 3) {
    notes.push('A Ira da Natureza: Canalizar — Contém criaturas a 4,5 m (salvaguarda de Força)');
  }
  if (level >= 7) {
    notes.push(
      'Aura de Resistência: Resistência a Necrótico, Psíquico e Radiante na aura',
    );
  }
  if (level >= 15) {
    notes.push('Sentinela Imortal: a 0 PV, fica com 1 + cura 3× nível (1×/DL)');
  }
  if (level >= 20) notes.push('Campeão Ancestral: transformação por 1 minuto');
}

function addVengeanceNotes(notes: string[], level: number): void {
  if (level >= 3) {
    notes.push(
      'Voto de Inimizade: na ação Atacar, Canalizar — Vantagem vs um alvo por 1 min',
    );
  }
  if (level >= 7) {
    notes.push(
      'Vingador Implacável: ao acertar AO, Desloc. 0 no alvo e metade do seu movimento',
    );
  }
  if (level >= 15) {
    notes.push(
      'Alma Vingativa: Reação para atacar o alvo do Voto após ele atacar',
    );
  }
  if (level >= 20) notes.push('Anjo Vingador: voo e aura Amedrontar por 10 minutos');
}

function addRevelryNotes(notes: string[], level: number): void {
  if (level >= 3) {
    notes.push('Conjurar Bebida: Canalizar Divindade para efeitos de bebida em área');
  }
  if (level >= 7) notes.push('Aura de Fraternidade: +1d4 dano corpo a corpo na aura');
  if (level >= 15) notes.push('Folião: usos = mod. de Carisma por descanso longo');
  if (level >= 20) notes.push('Animal de Festa: transformação festiva (1×/longo ou espaço de 5º)');
}
