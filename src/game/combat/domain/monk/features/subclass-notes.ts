/** Notas de combate por subclasse de Monge (PHB 2024 + Warrior of the Street). */

export function addMonkSubclassNotes(
  notes: string[],
  subclassSlug: string | null | undefined,
  level: number,
): void {
  if (subclassSlug === 'open-hand') addOpenHandNotes(notes, level);
  if (subclassSlug === 'elements') addElementsNotes(notes, level);
  if (subclassSlug === 'mercy') addMercyNotes(notes, level);
  if (subclassSlug === 'shadow') addShadowNotes(notes, level);
  if (subclassSlug === 'warrior-of-the-street') {
    addWarriorOfTheStreetNotes(notes, level);
  }
}

function addOpenHandNotes(notes: string[], level: number): void {
  if (level >= 3) {
    notes.push(
      'Técnica da Mão Espalmada: na Torrente, cada acerto impõe Caído, empurrão ou sem Reação',
    );
  }
  if (level >= 6) {
    notes.push(
      'Integridade Corporal: Ação Bônus — cura MA + Sabedoria (usos = Sabedoria/DL)',
    );
  }
  if (level >= 11) {
    notes.push(
      'Passo Veloz: após Ação Bônus que não seja Passos do Vento, use Passos do Vento de imediato',
    );
  }
  if (level >= 17) {
    notes.push(
      'Palma Vibrante: 4 Foco no acerto desarmado → vibrações; encerrar força CON vs 10d12 Energético',
    );
  }
}

function addElementsNotes(notes: string[], level: number): void {
  if (level >= 3) {
    notes.push(
      'Sintonia Elemental: 1 Foco no início do turno (10 min) — tipo elemental, +3 m de alcance',
    );
    notes.push('Manipular Elementos: conhece Elementalismo (SAB)');
  }
  if (level >= 6) {
    notes.push(
      'Explosão Elemental: 2 Foco, esfera 6 m / 36 m, 3× MA (Destreza)',
    );
  }
  if (level >= 11) {
    notes.push(
      'Passo dos Elementos: com Sintonia ativa — natação e voo = Deslocamento',
    );
  }
  if (level >= 17) {
    notes.push(
      'Ápice Elemental: com Sintonia — dano extra MA 1×/turno; Passos do Vento aprimorados',
    );
  }
}

function addMercyNotes(notes: string[], level: number): void {
  if (level >= 3) {
    notes.push('Mão de Cura: 1 Foco para curar SAB + dado de Artes Marciais');
    notes.push('Mão de Dolo: 1 Foco para dano Necrótico extra (1×/turno)');
  }
  if (level >= 6) {
    notes.push(
      'Toque de Médico: cura remove condição; dolo pode impor Envenenado',
    );
  }
  if (level >= 11) {
    notes.push(
      'Torrente de Cura e Dolo: na Torrente, cura/dolo sem Foco extra (usos = Sabedoria/DL)',
    );
  }
  if (level >= 17) {
    notes.push(
      'Mão da Misericórdia Final: 5 Foco + 1 uso/DL para reviver (4d10 + SAB)',
    );
  }
}

function addShadowNotes(notes: string[], level: number): void {
  if (level >= 3) {
    notes.push(
      'Artes das Sombras: Visão no Escuro; 1 Foco → Escuridão (vê na área); Ilusão Menor',
    );
  }
  if (level >= 6) {
    notes.push(
      'Passo da Sombra: teleporte 18 m entre Meia-luz/Escuridão + Vantagem',
    );
  }
  if (level >= 11) {
    notes.push(
      'Passo Aprimorado: 1 Foco no Passo — sem requisito de sombra + Ataque Desarmado',
    );
  }
  if (level >= 17) {
    notes.push(
      'Manto da Sombra: 3 Foco — Invisível 1 min; Torrente sem Foco',
    );
  }
}

function addWarriorOfTheStreetNotes(notes: string[], level: number): void {
  if (level >= 3) {
    notes.push(
      'Combinação: 1 Foco no acerto → +2 a +6 nos ataques desarmados no turno',
    );
    notes.push('Punho de Ferro: acerto desarmado em objeto = crítico');
  }
  if (level >= 6) {
    notes.push(
      'Movimentos: Explosão de Energia, Quebrador de Guarda, Corte Superior (1 Foco cada)',
    );
  }
  if (level >= 11) {
    notes.push('Traço Aéreo: 1 Foco — voo até o fim do próximo turno');
  }
  if (level >= 17) {
    notes.push(
      'K.O.: +3× MA; ≤100 PV → Inconsciente (1×/descanso ou 5 Foco para recuperar)',
    );
  }
}
