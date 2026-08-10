import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';

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
    `Inspiração de Bardo (${die}): Ação Bônus para conceder a uma criatura a até 18 m; recarrega em Descanso ${recovery}.`,
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
      'Fonte de Inspiração: Inspiração de Bardo recarrega em Descanso Curto ou Longo.',
    );
  }
  if (level >= 18) {
    notes.push(
      'Inspiração Superior: ao rolar iniciativa sem usos de Inspiração de Bardo, recupere 1 uso.',
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
      'Colégio do Conhecimento: Palavras de Interrupção (Reação: gasta Inspiração para subtrair do ataque/teste/dano inimigo).',
    );
    if (level >= 6) {
      notes.push(
        'Descobertas Mágicas: aprenda 2 magias adicionais de qualquer lista.',
      );
    }
    if (level >= 14) {
      notes.push(
        'Perícia Inigualável: após falhar teste/ataque, some o dado de Inspiração (só gasta se virar sucesso).',
      );
    }
  }

  if (subclassSlug === 'glamour') {
    notes.push(
      'Colégio do Glamour: Manto de Inspiração (gasta Inspiração para PV temp. 2×dado e movimento por Reação).',
    );
    if (level >= 6) {
      notes.push(
        'Manto de Majestade: Comando sem espaço (1×/DL; restaurável com espaço 3+).',
      );
    }
    if (level >= 14) {
      notes.push(
        'Majestade Inquebrável: presença 1 min — atacante falha salvo CAR ou o ataque falha.',
      );
    }
  }

  if (subclassSlug === 'dance') {
    notes.push(
      'Colégio da Dança: Dança Virtuosa (Ataque Desarmado com DES + dado de Inspiração; Golpes Ágeis ao gastar Inspiração).',
    );
    if (level >= 6) {
      notes.push(
        'Movimento Coordenado (iniciativa) e Movimento Inspirador (Reação a 1,5 m).',
      );
    }
    if (level >= 14) {
      notes.push('Evasão Liderada: Evasão e compartilhe com aliado a 1,5 m.');
    }
  }

  if (subclassSlug === 'valor') {
    notes.push(
      'Colégio da Bravura: Inspiração em Combate (aliados usam Inspiração na CA ou no dano). Proficiência Marcial/Escudo.',
    );
    if (level >= 6) {
      notes.push(
        'Ataque Extra (Bravura): pode substituir um ataque por um Truque.',
      );
    }
    if (level >= 14) {
      notes.push(
        'Magia de Batalha: após magia de ação, ataque com arma como Ação Bônus.',
      );
    }
  }

  if (subclassSlug === 'college-of-masks') {
    notes.push(
      'Colégio das Máscaras: vista máscaras no painel; efeitos que gastam Inspiração têm Usar (Anjo/Diabo/Dragão/Gladiador/Bobão).',
    );
    notes.push(
      'Artista Teatral: Kit de Disfarce; some o dado de Inspiração em Atuação sem gastar uso.',
    );
    if (level >= 6) {
      notes.push(
        'Habilidade de Virtuoso: 1×/turno Teste d20 com Carisma (usos = mod. CAR).',
      );
    }
    if (level >= 14) {
      notes.push('Mestre de Muitas Faces: use duas máscaras ao mesmo tempo.');
    }
  }
}
