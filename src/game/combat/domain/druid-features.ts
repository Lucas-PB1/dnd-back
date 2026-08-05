export const DRUID_SUBCLASS_SLUGS = [
  'land',
  'moon',
  'sea',
  'stars',
] as const;

export function isDruidClass(classSlug: string | null | undefined): boolean {
  return classSlug === 'druid';
}

export function wildShapeMaxUses(level: number): number {
  if (level < 2) return 0;
  if (level >= 17) return 4;
  if (level >= 6) return 3;
  return 2;
}

export function moonWildShapeTempHp(level: number): number {
  return 3 * level;
}

export function druidCombatNotes(input: {
  classSlug?: string | null;
  subclassSlug?: string | null;
  level?: number;
}): string[] {
  if (!isDruidClass(input.classSlug)) return [];

  const level = input.level ?? 1;
  const uses = wildShapeMaxUses(level);

  const notes = [
    'Ordem Primal: escolha entre Protetor (Armaduras Médias e Armas Marciais) ou Magista (+1 truque de Druida).',
  ];

  addBaseDruidNotes(notes, level, uses);
  addDruidSubclassNotes(notes, input.subclassSlug, level);
  return notes;
}

function addBaseDruidNotes(notes: string[], level: number, uses: number): void {
  if (level >= 2) {
    notes.push(
      `Forma Selvagem (${uses} usos): Ação Bônus assume forma besta ou ativa Companheiro Selvagem (1 uso recarrega em Descanso Curto; todos no Longo).`,
    );
  }
  if (level >= 5) {
    notes.push(
      'Ressurgimento Selvagem: gaste 1 uso de Forma Selvagem para recuperar 1 Slot de 1º círculo (ou 1 slot de 1º círculo para recuperar 1 uso de Forma Selvagem).',
    );
  }
  if (level >= 18) {
    notes.push(
      'Besta Feiticeira: conjure magias na Forma Selvagem sem componentes V ou S.',
    );
  }
  if (level >= 20) {
    notes.push(
      'Arquidruida: recupere 1 uso de Forma Selvagem ao rolar Iniciativa se não houver usos restantes.',
    );
  }
}

function addDruidSubclassNotes(
  notes: string[],
  subclassSlug: string | null | undefined,
  level: number,
): void {
  if (level < 3) return;

  if (subclassSlug === 'moon') {
    notes.push(
      `Círculo da Lua: Forma Selvagem de Combate (concede ${moonWildShapeTempHp(level)} PV temporários, CA = 13 + Mod. Sabedoria e Ataques de Radiante).`,
    );
    notes.push(
      'Cura Lunar: na Forma Selvagem, Ação Bônus gasta slot para recuperar 1d8 de PV por nível do slot.',
    );
  }

  if (subclassSlug === 'land') {
    notes.push(
      'Círculo da Terra: Recuperação Natural (recupera slots de magia acumulados no descanso curto) e Terreno Habitual (Ação Bônus sintoniza com bioma).',
    );
  }

  if (subclassSlug === 'stars') {
    notes.push(
      'Círculo das Estrelas: Forma Estelar (Arquiro: 1d8+SAB dano radiante Bônus; Cálice: +1d8+SAB cura extra; Dragão: mínimo 10 em Concentração/INT/SAB).',
    );
  }

  if (subclassSlug === 'sea') {
    notes.push(
      'Círculo do Mar: Ira do Mar (Ação Bônus emana aura de tempestade a 3 m: causa d6s de dano elétrico/concussão = Mod. Sabedoria e empurra a 4.5 m).',
    );
  }
}
