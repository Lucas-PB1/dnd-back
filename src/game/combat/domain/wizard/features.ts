export const MAGIC_MISSILE_SPELL_SLUG = 'misseis-magicos';
export const MAGIC_MISSILE_MAGE_SUBCLASS = 'magic-missile-mage';
export const MAGIC_MISSILE_FREE_RESOURCE = 'magic-missile-free';
export const MISSILE_SHIELD_RESOURCE = 'missile-shield';
export const GIGA_MISSILE_RESOURCE = 'giga-missile';

/** classOptions: Dominância de Magias (nv. 18). */
export const SPELL_MASTERY_LEVEL_1_KEY = 'spellMastery1';
export const SPELL_MASTERY_LEVEL_2_KEY = 'spellMastery2';
export const SPELL_MASTERY_UNLOCK_LEVEL = 18;

/** Dardos base da magia PHB (antes de upcast / extras da subclasse). */
export const MAGIC_MISSILE_BASE_DARTS = 3;

export function isWizardClass(classSlug: string | null | undefined): boolean {
  return classSlug === 'wizard';
}

export function isMagicMissileMage(
  subclassSlug: string | null | undefined,
): boolean {
  return subclassSlug === MAGIC_MISSILE_MAGE_SUBCLASS;
}

export function isSpellMasteryOptionKey(optionKey: string): boolean {
  return (
    optionKey === SPELL_MASTERY_LEVEL_1_KEY ||
    optionKey === SPELL_MASTERY_LEVEL_2_KEY
  );
}

export function spellMasteryRequiredLevelForKey(
  optionKey: string,
): 1 | 2 | null {
  if (optionKey === SPELL_MASTERY_LEVEL_1_KEY) return 1;
  if (optionKey === SPELL_MASTERY_LEVEL_2_KEY) return 2;
  return null;
}

export function readSpellMasterySlugs(
  classOptions: readonly { optionKey: string; valueId: string }[] | null | undefined,
): { level1: string | null; level2: string | null } {
  let level1: string | null = null;
  let level2: string | null = null;
  for (const option of classOptions ?? []) {
    if (option.optionKey === SPELL_MASTERY_LEVEL_1_KEY) {
      level1 = option.valueId;
    } else if (option.optionKey === SPELL_MASTERY_LEVEL_2_KEY) {
      level2 = option.valueId;
    }
  }
  return { level1, level2 };
}

export function isSpellMasterySpell(
  spellSlug: string,
  classOptions: readonly { optionKey: string; valueId: string }[] | null | undefined,
): boolean {
  const { level1, level2 } = readSpellMasterySlugs(classOptions);
  return spellSlug === level1 || spellSlug === level2;
}

export function arcaneRecoveryMaxSlotLevels(level: number): number {
  return Math.ceil(level / 2);
}

/** Dardos extras do Sábio dos Mísseis (nv. 3/6/10/14 → 1/2/3/4). */
export function magicMissileExtraDarts(level: number): number {
  if (level >= 14) return 4;
  if (level >= 10) return 3;
  if (level >= 6) return 2;
  if (level >= 3) return 1;
  return 0;
}

/**
 * Total de dardos: 3 base + 1 por círculo acima do 1º + extras da subclasse.
 */
export function magicMissileDartCount(
  level: number,
  slotLevelUsed: number | null,
): number {
  const upcastExtra =
    slotLevelUsed != null && slotLevelUsed > 1 ? slotLevelUsed - 1 : 0;
  return (
    MAGIC_MISSILE_BASE_DARTS + upcastExtra + magicMissileExtraDarts(level)
  );
}

export function buildMagicMissileCastNote(input: {
  level: number;
  slotLevelUsed: number | null;
  usedFreeResource: boolean;
  missileShield: boolean;
  gigaMissile: boolean;
  intModifier: number;
}): string {
  const darts = magicMissileDartCount(input.level, input.slotLevelUsed);
  const extras = magicMissileExtraDarts(input.level);
  const parts = [
    `Mísseis Mágicos: ${darts} dardo(s)`,
    extras > 0 ? `(+${extras} da subclasse)` : null,
    input.usedFreeResource ? 'sem espaço (uso gratuito)' : null,
    'penetram Escudo',
  ].filter(Boolean);

  let note = parts.join(' · ');
  if (input.missileShield) {
    note += `. Escudo de Mísseis: orbite até ${Math.min(darts, 5)} dardo(s) (+CA, Emanação 3 m, até 1 min).`;
  }
  if (input.gigaMissile) {
    const bonus = Math.max(1, input.intModifier);
    note += ` Giga-Míssil: +${bonus} de Força em cada dardo.`;
  }
  return note;
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
      'Dominância de Magias: escolha 1º e 2º círculo na aba Magias; conjure à vontade sem espaço.',
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

  if (subclassSlug === 'magic-missile-mage') {
    notes.push(
      'Mago dos Mísseis: +1–4 dardos nos nv. 3/6/10/14; penetram Escudo. Economia na aba Ações (gratuitos, Versáteis, Escudo, Giga).',
    );
  }
}
