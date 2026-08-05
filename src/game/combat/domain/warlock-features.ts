import { abilityModifier } from '../../sheet/domain/stats/ability-modifier';

export const WARLOCK_SUBCLASS_SLUGS = [
  'archfey',
  'celestial',
  'fiend',
  'great-old-one',
] as const;

export function isWarlockClass(classSlug: string | null | undefined): boolean {
  return classSlug === 'warlock';
}

export function warlockPactSlotLevel(level: number): number {
  if (level >= 9) return 5;
  if (level >= 7) return 4;
  if (level >= 5) return 3;
  if (level >= 3) return 2;
  return 1;
}

export function warlockPactSlotCount(level: number): number {
  if (level >= 17) return 4;
  if (level >= 11) return 3;
  if (level >= 2) return 2;
  return 1;
}

export function healingLightDiceMax(level: number): number {
  return 1 + level;
}

export function warlockCombatNotes(input: {
  classSlug?: string | null;
  subclassSlug?: string | null;
  level?: number;
}): string[] {
  if (!isWarlockClass(input.classSlug)) return [];

  const level = input.level ?? 1;
  const slotLvl = warlockPactSlotLevel(level);
  const slotQty = warlockPactSlotCount(level);

  const notes = [
    `Magia de Pacto (${slotQty} slots de ${slotLvl}º círculo): todos os slots recarregam em Descanso Curto ou Longo.`,
  ];

  addBaseWarlockNotes(notes, level);
  addWarlockSubclassNotes(notes, input.subclassSlug, level);
  return notes;
}

function addBaseWarlockNotes(notes: string[], level: number): void {
  if (level >= 2) {
    notes.push(
      'Invocações Místicas: habilidades e truques aprimorados ativos na sua ficha.',
    );
  }
  if (level >= 5) {
    notes.push(
      'Contato Arcano: Ação Bônus recupera 1 Slot de Pacto (1×/Descanso Longo).',
    );
  }
  if (level >= 11) {
    notes.push(
      'Arcanum Místico: conjura magias de 6º a 9º círculo sem gastar slots de pacto (1×/Descanso Longo cada).',
    );
  }
}

function addWarlockSubclassNotes(
  notes: string[],
  subclassSlug: string | null | undefined,
  level: number,
): void {
  if (level < 3) return;

  if (subclassSlug === 'celestial') {
    notes.push(
      `Patrono Celestial: Luz Curativa (reserva de ${healingLightDiceMax(level)}d6; Ação Bônus cura até CAR d6s) e Alma Radiante (+CAR no dano Fogo/Radiante).`,
    );
  }

  if (subclassSlug === 'fiend') {
    notes.push(
      'Patrono Ínfero: Bênção do Obscuro (PV temp = CAR + nível ao reduzir inimigo a 0 PV) e Sorte do Próprio Inferno (+1d10 em teste ou salvaguarda).',
    );
    if (level >= 10) {
      notes.push('Resiliência Ínfera: escolha resistência a um tipo de dano após descanso.');
    }
  }

  if (subclassSlug === 'archfey') {
    notes.push(
      'Patrono Arquifada: Passo de Bruma Aprimorado (usos gratuitos de Passo de Bruma com efeitos adicionais de Taunt, Desorientar ou Invisibilidade).',
    );
  }

  if (subclassSlug === 'great-old-one') {
    notes.push(
      'Patrono Grande Antigo: Mente Desperta (telepatia a 9 m) e Feitiçaria Psiónica (modifica o dano de Hex para Psíquico e impõe Desvantagem).',
    );
  }
}
