import { abilityModifier } from '../../sheet/domain/stats/ability-modifier';

export const BARD_SUBCLASS_SLUGS = [
  'dance',
  'glamour',
  'lore',
  'valor',
] as const;

export function isBardClass(classSlug: string | null | undefined): boolean {
  return classSlug === 'bard';
}

export function bardicInspirationDie(level: number): string {
  if (level >= 15) return 'd12';
  if (level >= 10) return 'd10';
  if (level >= 5) return 'd8';
  return 'd6';
}

export function bardicInspirationMaxUses(charismaScore: number): number {
  return Math.max(1, abilityModifier(charismaScore));
}

export function bardicInspirationRestRecovery(level: number): 'short' | 'long' {
  return level >= 5 ? 'short' : 'long';
}

export function bardCombatNotes(input: {
  classSlug?: string | null;
  subclassSlug?: string | null;
  level?: number;
}): string[] {
  if (!isBardClass(input.classSlug)) return [];

  const level = input.level ?? 1;
  const die = bardicInspirationDie(level);
  const recovery = bardicInspirationRestRecovery(level) === 'short' ? 'Curto/Longo' : 'Longo';

  const notes = [
    `Inspiração Bárdica (${die}): Ação Bônus para conceder a uma criatura a até 18 m; recarrega em Descanso ${recovery}.`,
  ];

  addBaseBardNotes(notes, level);
  addBardSubclassNotes(notes, input.subclassSlug, level);
  return notes;
}

function addBaseBardNotes(notes: string[], level: number): void {
  if (level >= 2) {
    notes.push(
      'Pau para Toda Obra: adicione metade da PB (arredondada para baixo) em testes de habilidade sem proficiência.',
    );
  }
  if (level >= 2) {
    notes.push(
      'Balada de Cura: criaturas que gastam Dados de Vida no Descanso Curto recuperam +1d6 PV extras.',
    );
  }
  if (level >= 5) {
    notes.push(
      'Fonte de Inspiração: Inspiração Bárdica recarrega em Descanso Curto ou Longo.',
    );
  }
  if (level >= 18) {
    notes.push(
      'Inspiração Superior: ao rolar iniciativa sem usos de Inspiração Bárdica, recupere 1 uso.',
    );
  }
}

function addBardSubclassNotes(
  notes: string[],
  subclassSlug: string | null | undefined,
  level: number,
): void {
  if (level < 3) return;

  if (subclassSlug === 'lore') {
    notes.push(
      'Colégio do Conhecimento: Palavras Cortantes (Reação: gasta Inspiração para subtrair do ataque/teste/dano inimigo).',
    );
    if (level >= 6) {
      notes.push(
        'Segredos Mágicos Aprimorados: aprenda 2 magias adicionais de qualquer lista.',
      );
    }
  }

  if (subclassSlug === 'glamour') {
    notes.push(
      'Colégio do Glamour: Desempenho Cativante (gasta Inspiração para dar PV temporários e mover aliados como Reação).',
    );
    if (level >= 6) {
      notes.push(
        'Manto de Majestade: conjure Comando como Ação Bônus sem gastar espaço.',
      );
    }
  }

  if (subclassSlug === 'dance') {
    notes.push(
      'Colégio da Dança: Dança Virtuosa (Ataque Desarmado com CAR e dado de Inspiração; move-se sem provocar Opport. Attacks ao gastar Ação Bônus ou rolar iniciativa).',
    );
    if (level >= 6) {
      notes.push(
        'Resposta Ágil: Reação para gastar Inspiração e conceder CA/movimento a você ou aliado.',
      );
    }
  }

  if (subclassSlug === 'valor') {
    notes.push(
      'Colégio da Bravura: Inspiração de Combate (aliados podem usar Inspiração na CA ou rolar no dano). Proficiência em Armas Marciais e Escudos.',
    );
    if (level >= 6) {
      notes.push(
        'Ataque Extra (Bravura): pode substituir um de seus ataques por um Truque conjurado.',
    );
    }
  }

  if (subclassSlug === 'college-of-masks') {
    notes.push(
      'Colégio das Máscaras: escolha Máscaras de Persona na mesa (3→4→5 nos nv. 3/6/14). Vestir/trocar como Ação Bônus; efeitos usam Inspiração Bárdica conforme a máscara.',
    );
    notes.push(
      'Artista Teatral: proficiência em Kit de Disfarce; some o dado de Inspiração em Performance sem gastar uso.',
    );
    if (level >= 6) {
      notes.push(
        'Habilidade de Virtuoso: 1×/turno faça um Teste d20 com Carisma (usos = mod. CAR; veja recurso).',
      );
    }
    if (level >= 14) {
      notes.push('Mestre de Muitas Faces: use duas máscaras ao mesmo tempo.');
    }
  }
}
