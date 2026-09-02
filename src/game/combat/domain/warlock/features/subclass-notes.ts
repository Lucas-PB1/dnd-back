/** Notas de combate por subclasse/patrono de Bruxo (PHB 2024). */
import { healingLightDiceMax } from './rules';

export function addWarlockSubclassNotes(
  notes: string[],
  subclassSlug: string | null | undefined,
  level: number,
): void {
  if (level < 3) return;

  if (subclassSlug === 'celestial') addCelestialNotes(notes, level);
  if (subclassSlug === 'fiend') addFiendNotes(notes, level);
  if (subclassSlug === 'archfey') addArchfeyNotes(notes, level);
  if (subclassSlug === 'great-old-one') addGreatOldOneNotes(notes, level);
}

function addCelestialNotes(notes: string[], level: number): void {
  notes.push(
    `Patrono Celestial: Luz Medicinal (reserva de ${healingLightDiceMax(level)}d6; Ação Bônus gasta 1–CAR d6s para curar).`,
  );
  if (level >= 6) {
    notes.push(
      'Alma Radiante: Resistência a Radiante; 1×/turno +CAR no dano de Fogo ou Radiante de uma magia sua.',
    );
  }
  if (level >= 10) {
    notes.push(
      'Resiliência Celestial: após Astúcia Mágica ou Descanso Curto/Longo, PV temp = nível + CAR (você e até 5 aliados a 9 m).',
    );
  }
  if (level >= 14) {
    notes.push(
      'Vingança Calcinante: quando você ou aliado a 18 m for fazer salvaguarda contra morte (1×/DL).',
    );
  }
}

function addFiendNotes(notes: string[], level: number): void {
  notes.push(
    'Patrono Ínfero: Bênção do Tenebroso (PV temp = CAR + nível ao reduzir inimigo a 0 PV).',
  );
  if (level >= 6) {
    notes.push(
      'A Sorte do Próprio Tenebroso: +1d10 a um teste ou salvaguarda (usos = CAR).',
    );
  }
  if (level >= 10) {
    notes.push(
      'Resistência Ínfera: após Descanso Curto ou Longo, escolha Resistência a um tipo de dano (exceto Energético).',
    );
  }
  if (level >= 14) {
    notes.push(
      'Lançar no Inferno: ao acertar, envie o alvo aos Infernos (1×/DL; recarrega com Slot de Pacto).',
    );
  }
}

function addArchfeyNotes(notes: string[], level: number): void {
  notes.push(
    level >= 6
      ? 'Patrono Arquifada: Passos Feéricos (usos = CAR) — Passo Nebuloso + efeito (Provocante, Revigorante, Desvanecedor ou Terrível).'
      : 'Patrono Arquifada: Passos Feéricos (usos = CAR) — Passo Nebuloso + efeito (Provocante ou Revigorante).',
  );
  if (level >= 6) {
    notes.push(
      'Fuga em Névoa: Reação ao sofrer dano — conjure Passo Nebuloso; efeitos Desvanecedor e Terrível entram nas opções de Passos Feéricos.',
    );
  }
  if (level >= 10) {
    notes.push(
      'Defesas Sedutoras: imune a Enfeitiçado; Reação após ser acertado — metade do dano + psíquico no atacante (1×/DL ou Slot de Pacto).',
    );
  }
  if (level >= 14) {
    notes.push(
      'Magia Sedutora: após conjurar Encantamento ou Ilusão com ação e espaço, conjure Passo Nebuloso como parte da mesma ação sem gastar espaço.',
    );
  }
}

function addGreatOldOneNotes(notes: string[], level: number): void {
  notes.push(
    'Patrono Grande Antigo: Mente Desperta (telepatia BA a 9 m) e Magias Psíquicas (dano de Bruxo pode ser Psíquico; Encantamento/Ilusão sem V/S).',
  );
  if (level >= 6) {
    notes.push(
      'Combatente Clarividente: ao usar Mente Desperta, alvo salva Sabedoria; falha → desv. vs você / você vant. vs alvo (1× SR/LR ou Slot).',
    );
  }
  if (level >= 10) {
    notes.push(
      'Danação Mística: sempre tem Danação preparada; alvo também tem Desvantagem nas salvaguardas do atributo escolhido.',
    );
    notes.push(
      'Escudo Mental: pensamentos ilegíveis; Resistência a Psíquico; quem causar Psíquico a você também sofre o dano.',
    );
  }
  if (level >= 14) {
    notes.push(
      'Criar Servo: Invocar Aberração sem Concentração (duração 1 min) + PV temp = nível; dano psíquico extra vs alvo da sua Danação.',
    );
  }
}
