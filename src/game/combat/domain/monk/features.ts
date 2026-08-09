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
  if (level >= 6) notes.push('Integridade Corporal: gaste recurso para curar-se');
  if (level >= 11) notes.push('Passo Veloz: acelera após Defesa Paciente');
  if (level >= 17) notes.push('Palma Vibrante: salvaguarda CON ou dano massivo');
}

function addElementsNotes(notes: string[], level: number): void {
  if (level >= 3) {
    notes.push(
      'Sintonia Elemental: 1 Foco para Explosão Elemental e alcance dos Golpes',
    );
  }
  if (level >= 6) notes.push('Explosão Elemental: dado de Artes Marciais à distância');
  if (level >= 11) notes.push('Passo dos Elementos: voo/velocidade elemental');
  if (level >= 17) notes.push('Ápice Elemental: 5 Foco para efeitos elementais');
}

function addMercyNotes(notes: string[], level: number): void {
  if (level >= 3) {
    notes.push('Mão de Cura: gaste 1 Foco para curar SAB + dado de Artes Marciais');
    notes.push('Mão de Dolo: gaste 1 Foco para dano Necrótico extra (1×/turno)');
  }
  if (level >= 6) notes.push('Toque de Médico: remove condições ao curar');
  if (level >= 11) notes.push('Torrente de Cura e Dolo: aplique as Mãos na Torrente');
  if (level >= 17) notes.push('Mão da Misericórdia Final: reviver ou matar');
}

function addShadowNotes(notes: string[], level: number): void {
  if (level >= 3) {
    notes.push('Artes das Sombras: 1 Foco para escuridão, visão e magias');
  }
  if (level >= 6) notes.push('Passo da Sombra: teleporte entre sombras com Vantagem');
  if (level >= 11) notes.push('Passo da Sombra Aprimorado: teleporte na Torrente');
  if (level >= 17) notes.push('Manto da Sombra: torne-se Invisível na escuridão');
}

function addWarriorOfTheStreetNotes(notes: string[], level: number): void {
  if (level >= 3) {
    notes.push('Combinação: reposicione-se ao acertar Ataques Desarmados');
    notes.push('Punho de Ferro: aumente o dado de Artes Marciais gastando Foco');
  }
  if (level >= 6) notes.push('Movimentos Especiais: manobras de rua com Foco');
  if (level >= 11) notes.push('Traço Aéreo: mobilidade aérea em combate');
  if (level >= 17) notes.push('K.O.: 1×/descanso (ou 5 Foco) para nocautear');
}
