import { abilityModifier } from '../../sheet/domain/stats/ability-modifier';

export const CLERIC_SUBCLASS_SLUGS = [
  'life',
  'light',
  'trickery',
  'war',
] as const;

export function isClericClass(classSlug: string | null | undefined): boolean {
  return classSlug === 'cleric';
}

export function divineSparkDice(level: number): string {
  if (level >= 18) return '4d8';
  if (level >= 13) return '3d8';
  if (level >= 7) return '2d8';
  return '1d8';
}

export function destroyUndeadDice(wisdomScore: number): string {
  return `${Math.max(1, abilityModifier(wisdomScore))}d8`;
}

export function divineStrikeDice(level: number): string | null {
  if (level < 7) return null;
  return level >= 14 ? '2d8' : '1d8';
}

export function clericCombatNotes(input: {
  classSlug?: string | null;
  subclassSlug?: string | null;
  level?: number;
}): string[] {
  if (!isClericClass(input.classSlug)) return [];

  const level = input.level ?? 1;
  const notes = [
    'Ordem Divina: Protetor concede armas Marciais e Armadura Pesada; Taumaturgo concede um truque e +SAB (mín. +1) em Arcanismo/Religião',
  ];

  addBaseClericNotes(notes, level);
  addClericSubclassNotes(notes, input.subclassSlug, level);
  return notes;
}

function addBaseClericNotes(notes: string[], level: number): void {
  if (level >= 2) {
    notes.push(
      `Canalizar Divindade: Centelha Divina (${divineSparkDice(level)} + SAB para cura/dano) ou Expulsar Mortos-Vivos`,
    );
  }
  if (level >= 5) {
    notes.push(
      'Fulminar Mortos-Vivos: mortos-vivos que falham contra Expulsar sofrem dados Radiantes iguais ao mod. SAB (mín. 1d8)',
    );
  }
  if (level >= 7) {
    notes.push(
      `Golpes Abençoados: escolha Conjuração Poderosa (+SAB no dano de truques) ou Golpe Divino (+${divineStrikeDice(level)} Necrótico/Radiante com arma, 1×/turno)`,
    );
  }
  if (level >= 10) {
    notes.push(
      'Intervenção Divina: conjure uma magia de Clérigo de até 5º círculo sem espaço ou componente Material (1×/Descanso Longo)',
    );
  }
  if (level >= 14) {
    notes.push(
      'Golpes Abençoados Aprimorados: Conjuração Poderosa concede 2×SAB PV temporários ou Golpe Divino causa 2d8',
    );
  }
  if (level >= 20) {
    notes.push(
      'Intervenção Divina Maior: pode escolher Desejo; nesse caso, recarga após 2d4 Descansos Longos',
    );
  }
}

function addClericSubclassNotes(
  notes: string[],
  subclassSlug: string | null | undefined,
  level: number,
): void {
  if (level < 3) return;

  if (subclassSlug === 'life') {
    notes.push(
      'Domínio da Vida: Discípulo da Vida soma 2 + círculo à cura; Preservar a Vida distribui 5 × nível em PV até metade do máximo',
    );
    if (level >= 6) {
      notes.push(
        'Curandeiro Abençoado: ao curar outra criatura com espaço, recupere 2 + círculo em PV',
      );
    }
    if (level >= 17) notes.push('Cura Suprema: dados de cura usam o valor máximo');
  }

  if (subclassSlug === 'light') {
    notes.push(
      'Domínio da Luz: Brilho do Amanhecer causa 2d10 + nível Radiante; Labareda Protetora impõe Desvantagem como Reação',
    );
    if (level >= 6) {
      notes.push(
        'Labareda Protetora Aprimorada: recupera em Descanso Curto e concede 2d6 + SAB PV temporários',
      );
    }
    if (level >= 17) {
      notes.push(
        'Coroa de Luz: aura de luz solar; inimigos têm Desvantagem nas salvaguardas contra dano Ígneo/Radiante',
      );
    }
  }

  if (subclassSlug === 'trickery') {
    notes.push(
      'Domínio da Trapaça: Bênção do Trapaceiro dá Vantagem em Furtividade; Invocar Duplicidade cria a ilusão com Canalizar Divindade',
    );
    if (level >= 6) {
      notes.push('Transposição do Trapaceiro: troque de lugar com a ilusão');
    }
    if (level >= 17) {
      notes.push('Duplicidade Aprimorada: aliados também recebem a distração');
    }
  }

  if (subclassSlug === 'war') {
    notes.push(
      'Domínio da Guerra: Ataque Direcionado concede +10 após um erro; Sacerdote da Guerra faz ataque com Ação Bônus',
    );
    if (level >= 6) {
      notes.push(
        'Bênção do Deus da Guerra: Canalizar conjura Arma Espiritual ou Escudo da Fé sem espaço e sem Concentração',
      );
    }
    if (level >= 17) {
      notes.push(
        'Avatar da Guerra: Resistência a dano Contundente, Cortante e Perfurante',
      );
    }
  }

  if (subclassSlug === 'dragon-domain') {
    notes.push(
      'Domínio do Dragão: após Descanso Longo escolha Ácido/Frio/Fogo/Elétrico/Veneno; troque Necrótico/Radiante de Clérigo por esse tipo e cause dano extra = nível (usos = mod. SAB).',
    );
    notes.push(
      'Majestade Dracônica: Canalizar Divindade — Emanação 9 m Enfeitiçado ou Amedrontado (salvaguarda SAB).',
    );
    if (level >= 6) {
      notes.push(
        'Bênção da Serpe: Canalizar para Sopro do Dragão ou Proteção contra Energia em você sem Concentração.',
      );
    }
    if (level >= 17) {
      notes.push(
        'Aspecto Lendário: 3 ações lendárias/LR (Rasgar, Cauda, Asas) — veja recurso.',
      );
    }
  }
}
