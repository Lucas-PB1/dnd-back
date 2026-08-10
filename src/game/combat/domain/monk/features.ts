/**
 * Regras de combate do Monge (PHB 2024): Artes Marciais, Foco e notas de nível.
 * O motor aplica apenas os números; duração e alvo ficam na mesa.
 */
import type { EquippedWeaponPiece } from '../weapon-attacks/weapon-attack.types';

/** Slug sintético do Ataque Desarmado (não existe item no catálogo). */
export const MONK_UNARMED_ITEM_SLUG = 'unarmed-strike';

export type MonkSubclassSlug =
  | 'open-hand'
  | 'elements'
  | 'mercy'
  | 'shadow'
  | 'warrior-of-the-street';

export function isMonkClass(classSlug: string | null | undefined): boolean {
  return classSlug === 'monk';
}

/** Dado de Artes Marciais: 1d6 → 1d8 → 1d10 → 1d12. */
export function martialArtsDieFaces(level: number): 6 | 8 | 10 | 12 {
  if (level >= 17) return 12;
  if (level >= 11) return 10;
  if (level >= 5) return 8;
  return 6;
}

export function martialArtsDie(level: number): string {
  return `1d${martialArtsDieFaces(level)}`;
}

/** CD de Foco (Empurrar/Imobilizar, Golpe Atordoante etc.): 8 + SAB + PB. */
export function monkFocusSaveDc(input: {
  wisdomModifier: number;
  proficiencyBonus: number;
}): number {
  return 8 + input.wisdomModifier + input.proficiencyBonus;
}

/** Movimento sem Armadura (metros): +3 → +4,5 → +6 → +7,5 → +9. */
export function unarmoredMovementBonusMeters(input: {
  classSlug?: string | null;
  level?: number;
}): number {
  if (!isMonkClass(input.classSlug)) return 0;
  const level = input.level ?? 0;
  if (level >= 18) return 9;
  if (level >= 14) return 7.5;
  if (level >= 10) return 6;
  if (level >= 6) return 4.5;
  if (level >= 2) return 3;
  return 0;
}

/**
 * Arma de Monge para fins de Artes Marciais: Ataque Desarmado, armas Simples
 * corpo a corpo e armas Marciais corpo a corpo com a propriedade Leve.
 */
export function isMonkWeaponForAttack(
  piece: EquippedWeaponPiece,
  mode: 'melee' | 'ranged',
): boolean {
  if (mode !== 'melee') return false;
  if (piece.itemSlug === MONK_UNARMED_ITEM_SLUG) return true;
  if (piece.category === 'simple') return true;
  return piece.category === 'martial' && piece.propertySlugs.includes('light');
}

/** Ataque Extra do Monge (nível 5): dois ataques na ação Atacar. */
export function monkAttacksPerAction(level: number): number {
  return level >= 5 ? 2 : 1;
}

export function monkCombatNotes(input: {
  classSlug?: string | null;
  subclassSlug?: string | null;
  level?: number;
}): string[] {
  if (!isMonkClass(input.classSlug)) return [];
  const level = input.level ?? 1;
  const notes = [
    `Artes Marciais: Ataque Desarmado e armas de Monge usam ${martialArtsDie(
      level,
    )} e o melhor de FOR/DES (sem armadura nem escudo)`,
  ];

  addBaseMonkNotes(notes, level);
  addMonkSubclassNotes(notes, input.subclassSlug, level);
  return notes;
}

function addBaseMonkNotes(notes: string[], level: number): void {
  if (level >= 2) {
    notes.push(
      'Foco do Monge: Torrente de Golpes, Defesa Paciente e Passos do Vento (Pontos de Foco)',
    );
    notes.push(
      `Movimento sem Armadura: +${unarmoredMovementBonusMeters({
        classSlug: 'monk',
        level,
      })} m de Deslocamento`,
    );
  }
  if (level >= 3) {
    notes.push('Defletir Ataques: Reação reduz dano corpo a corpo/à distância');
  }
  if (level >= 4) notes.push('Queda Lenta: Reação reduz dano de queda');
  if (level >= 5) {
    notes.push('Ataque Extra: dois ataques na ação Atacar');
    notes.push(
      'Golpe Atordoante: gaste 1 Foco no acerto para forçar salvaguarda de Constituição',
    );
  }
  if (level >= 6) notes.push('Golpes Potencializados: dano pode ser Energético');
  if (level >= 7) {
    notes.push(
      'Evasão: sucesso em salvaguarda de Destreza causa 0 dano; falha, metade',
    );
  }
  if (level >= 10) notes.push('Foco Aprimorado: aprimora Foco do Monge');
  if (level >= 13) notes.push('Defletir Energia: Defletir contra qualquer dano');
  if (level >= 14) {
    notes.push(
      'Sobrevivente Disciplinado: proficiência em todas as salvaguardas; 1 Foco para rerrolar',
    );
  }
  if (level >= 18) {
    notes.push('Defesa Superior: 3 Foco para Resistência a quase tudo (1 min)');
  }
}

function addMonkSubclassNotes(
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
