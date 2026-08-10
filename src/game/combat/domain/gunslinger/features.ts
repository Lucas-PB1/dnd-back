/**
 * Notas de combate do Pistoleiro (classe + subclasses Valdas / Pack 2).
 */

import { isGunslingerClass } from './firearm';

export function gunslingerCombatNotes(input: {
  classSlug: string;
  subclassSlug?: string | null;
  level: number;
}): string[] {
  if (!isGunslingerClass(input.classSlug)) return [];
  const notes: string[] = [];
  const { subclassSlug, level } = input;

  if (level >= 2) {
    notes.push(
      'Dado de Risco: gaste em manobras (painel). Recarrega no Descanso Curto/Longo.',
    );
  }

  if (subclassSlug === 'pistolero' && level >= 3) {
    notes.push(
      'Pistolero — Tiro a Queima-Roupa: sem Desvantagem em ataques à distância a 1,5 m de inimigo.',
    );
    notes.push(
      'Abrir o Leque e Confronto: manobras no painel (gastam Dado de Risco).',
    );
    if (level >= 6) {
      notes.push(
        'Desarmar: em crítico com Tiro no Estômago, solte um objeto a até 4,5 m (mesa).',
      );
    }
    if (level >= 14) {
      notes.push(
        'Tempo Bala: 1×/turno, Vantagem em um ataque à distância com arma.',
      );
    }
  }

  if (subclassSlug === 'deadeye' && level >= 3) {
    notes.push(
      'Olho Morto — Olho de Águia: manobra no painel (erra → +risk no ataque).',
    );
    notes.push(
      'Postura do atirador: sem Desvantagem à distância por Caído; levantar com 1,5 m.',
    );
    if (level >= 6) {
      notes.push(
        'Posição oculta: Esconder Caído sem cobertura total; falha no ataque não revela se escondido.',
      );
    }
    if (level >= 10) {
      notes.push(
        'Reposicionar (Reação): ao ser errado, encerre Caído e mova até metade da Velocidade.',
      );
    }
    if (level >= 14) {
      notes.push(
        'Tiro Focado: Atacar com 1 ataque à distância (Vantagem = crítico) — Economia.',
      );
    }
  }

  if (subclassSlug === 'high-roller' && level >= 3) {
    notes.push(
      'Grande Apostador — Dados do Mentiroso: manobra no painel (blefe de dano).',
    );
    if (level >= 6) {
      notes.push(
        'Negócio Arriscado: 1×/turno Desvantagem no ataque → recupera 1 risk (± Economia).',
      );
    }
    if (level >= 10) {
      notes.push(
        'Assumidor de risco: Espírito Independente / Por um Triz podem usar d6 sem gastar risk (mesa).',
      );
    }
    if (level >= 14) {
      notes.push(
        'Duplo ou Nada: no crítico, aposte d20 (10+ = ×4 dano; 9− = acerto normal) — Economia.',
      );
    }
  }

  if (subclassSlug === 'secret-agent' && level >= 3) {
    notes.push(
      'Agente Secreto — Tiro de despedida: manobra no painel (Correr/Desengajar/Esquivar → BA ataque).',
    );
    if (level >= 6) {
      notes.push(
        'Artesanato de campo: fantasia com Kit de Disfarce (BA); Enganação/Persuasão mínimo 10 no d20.',
      );
    }
    if (level >= 10) {
      notes.push(
        'Estratégia de Saída: Reação Invisível + 3 m (1×/descanso; restaure com 1 risk) — Economia.',
      );
    }
    if (level >= 14) {
      notes.push(
        'Licença para Matar: 1–2 risk no dano (explode no máximo; teto = PB) — Economia.',
      );
    }
  }

  if (subclassSlug === 'spellslinger' && level >= 3) {
    notes.push(
      'Pistoleiro Arcano — Tiro Arcano: BA +1 risk no dano de Pistolas de Dedo — Economia.',
    );
    if (level >= 14) {
      notes.push(
        'Bala Mágica: manobra no painel (substitui ataque mágico por arma + risk).',
      );
    }
  }

  if (subclassSlug === 'trick-shot' && level >= 3) {
    notes.push(
      'Tiro de Trucagem — Ricochete: manobra no painel (erra → rerrole + risk).',
    );
    notes.push(
      'Trajetória Criativa: ataques à distância ignoram Meia Cobertura e Cobertura ¾.',
    );
    if (level >= 6) {
      notes.push(
        'Tiroteio extravagante: +risk grátis em Desempenho/Prestidigitação com arma; reload free no turno.',
      );
    }
    if (level >= 10) {
      notes.push(
        'Deflexão Hábil: manobra no painel (Reação — Por um Triz em aliado).',
      );
    }
    if (level >= 14) {
      notes.push(
        'Tiro de Pinball: ricochetes (1×/descanso; restaure com 2 risk) — Economia.',
      );
    }
  }

  if (subclassSlug === 'white-hat' && level >= 3) {
    notes.push(
      'Chapéu Branco — Estabeleça a Lei: manobra no painel (PV Temp. + Reação de tiro).',
    );
    notes.push(
      'Aura de Olhos de Aço (3 m): você e aliados com Vantagem vs Amedrontado.',
    );
    if (level >= 6) {
      notes.push(
        'Alcance os céus: no crítico, peça rendição (SAB vs CD de Manobra) — mesa.',
      );
    }
    if (level >= 10) {
      notes.push(
        'Longo braço da lei: 1×/turno, acerto em Grande ou menor → mancar (precisa Desengajar para se mover).',
      );
    }
    if (level >= 14) {
      notes.push(
        'Herói Estrela Dourada: aura 9 m; Estabeleça a Lei dá Resistência física; rendição Atordoado.',
      );
    }
  }

  return notes;
}
