/**
 * Notas de combate por subclasse de Mago (PHB 2024 + Sangromante / Mago dos Mísseis).
 */
import { portentDiceCount } from './rules';

export function addWizardSubclassNotes(
  notes: string[],
  subclassSlug: string | null | undefined,
  level: number,
): void {
  if (level < 3) return;

  if (subclassSlug === 'abjurer') {
    notes.push(
      'Abjurador: Proteção Arcana (barreira ao conjurar Abjuração 1º+; Ação Bônus gasta slot para recuperar 2× círculo).',
    );
    if (level >= 14) {
      notes.push(
        'Resistência à Magia: vantagem em salvaguardas contra magias; Resistência a dano de magias.',
      );
    }
  }

  if (subclassSlug === 'diviner') {
    const count = portentDiceCount(level);
    notes.push(
      `Adivinhador: Presságio (guarde ${count}d20 no início do dia e substitua qualquer d20 seu ou de outra criatura).`,
    );
    if (level >= 6) {
      notes.push(
        'Perito em Adivinhação: ao conjurar Adivinhação com espaço de 2º+, recupere um espaço de nível inferior.',
      );
    }
  }

  if (subclassSlug === 'evoker') {
    notes.push(
      'Evocador: Truque Potente (em salvaguarda bem-sucedida contra seu truque de dano, o alvo ainda sofre metade).',
    );
    if (level >= 6) {
      notes.push(
        'Esculpir Magias: escolha aliados na área de Evocação; passam automaticamente e não sofrem dano.',
      );
    }
    if (level >= 10) {
      notes.push(
        'Evocação Potencializada: ao rolar dano de Evocação conjurada com espaço, trate 1s no dado como 2s.',
      );
    }
  }

  if (subclassSlug === 'illusionist') {
    notes.push(
      'Ilusionista: Ilusão Aprimorada (truques de Ilusão e Imagem Silenciosa como Ação Bônus, sem V, alcance dobrado).',
    );
  }

  if (subclassSlug === 'magic-missile-mage') {
    notes.push(
      'Mago dos Mísseis: +1–4 dardos nos nv. 3/6/10/14; penetram Escudo. Economia na aba Ações (gratuitos, Versáteis, Escudo, Giga).',
    );
  }

  if (subclassSlug === 'sangromancer') {
    notes.push(
      'Sangromante: Dados de Sangromancia (d12; máx. = 1 + nível de Mago). Gaste no lugar de Dados de Vida ao conjurar magias de Sangromancia. Recupera 1 no Descanso Curto, todos no Longo.',
    );
    notes.push(
      'Especialista em Sangromancia: magias de Sangromancia contam como de Mago; grimório ganha escolhas gratuitas na aba de opções de subclasse.',
    );
    if (level >= 6) {
      notes.push(
        'Vigor Sanguíneo: +1 PV máx. por nível (já na ficha). Ao conjurar magia de Sangromancia com espaço, recupera PV = nível do espaço.',
      );
    }
    if (level >= 10) {
      notes.push(
        'Sangue por Sangue: 1×/turno, ao causar dano com magia de Mago, gaste DV ou Dado de Sangromancia para dano extra (Ferido: role 2×, use o maior).',
      );
    }
    if (level >= 14) {
      notes.push(
        'Renovação Rubra: após Descanso Curto, recupere metade do nível em DV e Dados de Sangromancia (1× até o próximo Descanso Longo).',
      );
    }
  }
}
