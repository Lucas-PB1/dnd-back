import {
  hasSlipperyMind,
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

  addBaseRogueNotes(notes, level);
  addRogueSubclassNotes(notes, input.subclassSlug, level);
  return notes;
}

function addBaseRogueNotes(notes: string[], level: number): void {
  if (level >= 2) {
    notes.push(
      'Ação Ardilosa: Correr, Desengajar ou Esconder como Ação Bônus',
    );
  }
  if (level >= 3) {
    notes.push(
      'Mira Firme: vantagem no próximo ataque, sem movimento no turno',
    );
  }
  if (level >= 5) {
    notes.push(
      'Golpe Astuto: sacrifique dados de Ataque Furtivo para aplicar efeitos',
    );
    notes.push(
      'Esquiva Sobrenatural: use a Reação para reduzir pela metade o dano do ataque',
    );
  }
  if (level >= 7) {
    notes.push(
      'Evasão: sucesso em salvaguarda de Destreza causa 0 dano; falha causa metade',
    );
    notes.push(
      'Talento Confiável: resultados 9 ou menos viram 10 em testes com proficiência',
    );
  }
  if (level >= 11) {
    notes.push(
      'Golpe Astuto Aprimorado: aplique até dois efeitos, pagando ambos os custos',
    );
  }
  if (level >= 14) {
    notes.push('Golpes Sujos: Aturdir, Nocaute e Obscurecer disponíveis');
  }
  if (hasSlipperyMind(level)) {
    notes.push(
      'Mente Escorregadia: proficiência em salvaguardas de Sabedoria e Carisma',
    );
  }
  if (level >= 18) {
    notes.push(
      'Elusivo: ataques não têm Vantagem contra você enquanto não Incapacitado',
    );
  }
  if (level >= 20) {
    notes.push('Golpe de Sorte: transforme um Teste de D20 que falhou em 20');
  }
}

function addRogueSubclassNotes(
  notes: string[],
  subclassSlug: string | null | undefined,
  level: number,
): void {
  if (subclassSlug === 'soulknife') addSoulknifeNotes(notes, level);
  if (subclassSlug === 'assassin') addAssassinNotes(notes, level);
  if (subclassSlug === 'thief') addThiefNotes(notes, level);
  if (subclassSlug === 'arcane-trickster') addArcaneTricksterNotes(notes, level);
  if (subclassSlug === 'arachnoid-stalker') {
    addArachnoidStalkerNotes(notes, level);
  }
}

function addSoulknifeNotes(notes: string[], level: number): void {
  const schedule = soulknifePsiDiceSchedule(level);
  if (schedule) {
    notes.push(
      `Adaga Espiritual: ${schedule.count} Dados de Energia (d${schedule.faces})`,
    );
    notes.push(
      'Lâminas Psíquicas: 1d6 Psíquico; segunda lâmina 1d4 como Ação Bônus',
    );
  }
  if (level >= 9) {
    notes.push('Lâminas da Alma: Golpes Teleguiados e Teleporte Psíquico');
  }
  if (level >= 13) notes.push('Véu Psíquico: Invisível por até 1 hora');
  if (level >= 17) {
    notes.push('Rasgar Mente: salvaguarda de Sabedoria ou Atordoado');
  }
}

function addAssassinNotes(notes: string[], level: number): void {
  if (level >= 3) {
    notes.push('Assassinar: Vantagem na Iniciativa e Golpe Surpreendente');
  }
  if (level >= 9) {
    notes.push(
      'Especialista em Infiltração: Mimetismo Magistral e Mira Móvel',
    );
  }
  if (level >= 13) {
    notes.push(
      'Armas Venenosas: Envenenar causa 2d6 Venenoso adicional em falha',
    );
  }
  if (level >= 17) {
    notes.push('Golpe Mortal: salvaguarda de Constituição ou dobre o dano');
  }
}

function addThiefNotes(notes: string[], level: number): void {
  if (level >= 3) notes.push('Ladrão: Mão Leve e Andarilho de Telhados');
  if (level >= 9) {
    notes.push(
      'Furtividade Suprema: Ataque Escondido custa 1 dado de Ataque Furtivo',
    );
  }
  if (level >= 13) {
    notes.push(
      'Usar Dispositivo Mágico: quatro sintonizações e uso de pergaminhos',
    );
  }
  if (level >= 17) {
    notes.push('Reflexos de Ladrão: dois turnos na primeira rodada');
  }
}

function addArcaneTricksterNotes(notes: string[], level: number): void {
  if (level >= 3) {
    notes.push(
      'Trapaceiro Arcano: conjuração de Mago (INT) e Mãos Mágicas Ligeiras',
    );
  }
  if (level >= 9) {
    notes.push(
      'Emboscada Mágica: salvaguardas contra magia têm Desvantagem',
    );
  }
  if (level >= 13) {
    notes.push(
      'Trapaceiro Versátil: Golpe Astuto também afeta alvo junto à Mão Mágica',
    );
  }
  if (level >= 17) {
    notes.push('Ladrão de Magias: negue e roube uma magia com sua Reação');
  }
}

function addArachnoidStalkerNotes(notes: string[], level: number): void {
  if (level >= 3) {
    notes.push(
      'Golpe Venenoso: Ataque Furtivo pode causar d8s de dano Venenoso',
    );
    notes.push('Correia: teias para movimento, objetos, corda ou a magia Teia');
  }
  if (level >= 9) {
    notes.push(
      'Rastejando na Parede: escalada em paredes e tetos com mãos livres',
    );
  }
  if (level >= 13) {
    notes.push(
      'Sentido de Aranha: Esquiva Sobrenatural contra dano de salvaguarda',
    );
  }
  if (level >= 17) {
    notes.push(
      'Veneno Paralítico: Paralisar custa 4 dados de Ataque Furtivo',
    );
  }
}
