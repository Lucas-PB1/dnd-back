export const WIZARD_SUBCLASS_SLUGS = [
  'abjurer',
  'diviner',
  'evoker',
  'illusionist',
] as const;

export function isWizardClass(classSlug: string | null | undefined): boolean {
  return classSlug === 'wizard';
}

export function arcaneRecoveryMaxSlotLevels(level: number): number {
  return Math.ceil(level / 2);
}

export function abjurerArcaneWardHp(level: number, intMod: number): number {
  return 2 * level + Math.max(1, intMod);
}

export function portentDiceCount(level: number): number {
  return level >= 14 ? 3 : 2;
}

export function wizardCombatNotes(input: {
  classSlug?: string | null;
  subclassSlug?: string | null;
  level?: number;
}): string[] {
  if (!isWizardClass(input.classSlug)) return [];

  const level = input.level ?? 1;
  const maxLevels = arcaneRecoveryMaxSlotLevels(level);

  const notes = [
    `Recuperação Arcana: 1× por dia no Descanso Curto, recupe slots de magia cuja soma dos níveis seja até ${maxLevels} (até 5º círculo).`,
    'Ritualista Arcano: conjure magias de ritual diretamente do seu Grimório sem precisar tê-las preparadas.',
  ];

  addBaseWizardNotes(notes, level);
  addWizardSubclassNotes(notes, input.subclassSlug, level);
  return notes;
}

function addBaseWizardNotes(notes: string[], level: number): void {
  if (level >= 18) {
    notes.push(
      'Dominância de Magias: escolha 1 magia de 1º círculo e 1 de 2º círculo para conjurar à vontade sem gastar slots de magia.',
    );
  }
  if (level >= 20) {
    notes.push(
      'Assinatura de Magia: 2 magias de 3º círculo preparadas sempre disponíveis; 1× por descanso longo conjure cada uma sem gastar slot.',
    );
  }
}

function addWizardSubclassNotes(
  notes: string[],
  subclassSlug: string | null | undefined,
  level: number,
): void {
  if (level < 3) return;

  if (subclassSlug === 'abjurer') {
    notes.push(
      'Escola de Abjuração: Proteção Arcana (cria barreira de PV temporários ao conjurar magia de Abjuração de 1º+ círculo; absorve dano).',
    );
  }

  if (subclassSlug === 'diviner') {
    const count = portentDiceCount(level);
    notes.push(
      `Escola de Adivinhação: Presságio (guarde ${count}d20 no início do dia e substitua qualquer jogada de d20 sua ou de outra criatura).`,
    );
  }

  if (subclassSlug === 'evoker') {
    notes.push(
      'Escola de Evocação: Esculpir Magias (aliados passam automaticamente em salvaguardas de suas magias de Evocação e não sofrem dano).',
    );
    if (level >= 6) {
      notes.push(
        'Truque Potentado: truques de dano causam metade do dano mesmo em caso de sucesso na salvaguarda.',
      );
    }
  }

  if (subclassSlug === 'illusionist') {
    notes.push(
      'Escola de Ilusão: Ilusão Aprimorada (conjure truques e magias de ilusão como Ação Bônus sem componentes V e com maior alcance).',
    );
  }
}
