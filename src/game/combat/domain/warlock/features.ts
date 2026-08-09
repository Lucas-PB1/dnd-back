import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';

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

/** Astúcia Mágica: recupera metade dos slots (ceil). L20 Mestre Místico: todos. */
export function magicalCunningSlotRecoveryCount(level: number): number {
  const max = warlockPactSlotCount(level);
  if (level >= 20) return max;
  return Math.ceil(max / 2);
}

/** Contagem PHB 2024 — coluna Invocações da tabela do Bruxo. */
export function warlockInvocationLimit(level: number): number {
  if (level >= 18) return 10;
  if (level >= 15) return 9;
  if (level >= 12) return 8;
  if (level >= 9) return 7;
  if (level >= 7) return 6;
  if (level >= 5) return 5;
  if (level >= 2) return 3;
  if (level >= 1) return 1;
  return 0;
}

export const ELDRITCH_INVOCATION_OPTION_KEY = 'eldritch-invocation';
/** Sibling: mesmo instanceIndex da invocação de blast → slug do truque vinculado. */
export const ELDRITCH_INVOCATION_CANTRIP_OPTION_KEY =
  'eldritch-invocation-cantrip';

export const BLAST_INVOCATION_SLUGS = [
  'agonizing-blast',
  'repelling-blast',
  'eldritch-spear',
] as const;

export type BlastInvocationSlug = (typeof BLAST_INVOCATION_SLUGS)[number];

export function isBlastInvocationSlug(
  slug: string,
): slug is BlastInvocationSlug {
  return (BLAST_INVOCATION_SLUGS as readonly string[]).includes(slug);
}

export const MAGICAL_CUNNING_RESOURCE = 'magical-cunning';
export const DARK_ONES_LUCK_RESOURCE = 'dark-ones-luck';
export const FEY_STEPS_RESOURCE = 'fey-steps';
export const HURL_THROUGH_HELL_RESOURCE = 'hurl-through-hell';
export const SEARING_VENGEANCE_RESOURCE = 'searing-vengeance';
export const BEGUILING_DEFENSES_RESOURCE = 'beguiling-defenses';
export const CLAIRVOYANT_COMBATANT_RESOURCE = 'clairvoyant-competitor';

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
  const invocationLimit = warlockInvocationLimit(level);
  if (invocationLimit > 0) {
    notes.push(
      `Invocações Místicas: até ${invocationLimit} invocação(ões) conhecida(s) (veja o painel/ficha).`,
    );
  }
  if (level >= 2) {
    const recover = magicalCunningSlotRecoveryCount(level);
    notes.push(
      `Astúcia Mágica: rito de 1 min recupera ${recover} slot(s) de Pacto (1×/Descanso Longo).`,
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
      `Patrono Celestial: Luz Medicinal (reserva de ${healingLightDiceMax(level)}d6; Ação Bônus gasta 1–CAR d6s para curar).`,
    );
    if (level >= 6) {
      notes.push(
        'Alma Radiante: Resistência a Radiante; 1×/turno +CAR no dano de Fogo ou Radiante de uma magia sua.',
      );
    }
    if (level >= 10) {
      notes.push(
        'Resiliência Celestial: após Astúcia Mágica ou Descanso Curto/Longo, PV temp = nível + CAR (você e até 5 aliados a 9 m).',
      );
    }
    if (level >= 14) {
      notes.push(
        'Vingança Calcinante: quando você ou aliado a 18 m for fazer salvaguarda contra morte (1×/DL).',
      );
    }
  }

  if (subclassSlug === 'fiend') {
    notes.push(
      'Patrono Ínfero: Bênção do Tenebroso (PV temp = CAR + nível ao reduzir inimigo a 0 PV).',
    );
    if (level >= 6) {
      notes.push(
        'A Sorte do Próprio Tenebroso: +1d10 a um teste ou salvaguarda (usos = CAR).',
      );
    }
    if (level >= 10) {
      notes.push(
        'Resistência Ínfera: após Descanso Curto ou Longo, escolha Resistência a um tipo de dano (exceto Energético).',
      );
    }
    if (level >= 14) {
      notes.push(
        'Lançar no Inferno: ao acertar, envie o alvo aos Infernos (1×/DL; recarrega com Slot de Pacto).',
      );
    }
  }

  if (subclassSlug === 'archfey') {
    notes.push(
      level >= 6
        ? 'Patrono Arquifada: Passos Feéricos (usos = CAR) — Passo Nebuloso + efeito (Provocante, Revigorante, Desvanecedor ou Terrível).'
        : 'Patrono Arquifada: Passos Feéricos (usos = CAR) — Passo Nebuloso + efeito (Provocante ou Revigorante).',
    );
    if (level >= 6) {
      notes.push(
        'Fuga em Névoa: Reação ao sofrer dano — conjure Passo Nebuloso; efeitos Desvanecedor e Terrível entram nas opções de Passos Feéricos.',
      );
    }
    if (level >= 10) {
      notes.push(
        'Defesas Sedutoras: imune a Enfeitiçado; Reação após ser acertado — metade do dano + psíquico no atacante (1×/DL ou Slot de Pacto).',
      );
    }
    if (level >= 14) {
      notes.push(
        'Magia Sedutora: após conjurar Encantamento ou Ilusão com ação e espaço, conjure Passo Nebuloso como parte da mesma ação sem gastar espaço.',
      );
    }
  }

  if (subclassSlug === 'great-old-one') {
    notes.push(
      'Patrono Grande Antigo: Mente Desperta (telepatia BA a 9 m) e Magias Psíquicas (dano de Bruxo pode ser Psíquico; Encantamento/Ilusão sem V/S).',
    );
    if (level >= 6) {
      notes.push(
        'Combatente Clarividente: ao usar Mente Desperta, alvo salva Sabedoria; falha → desv. vs você / você vant. vs alvo (1× SR/LR ou Slot).',
      );
    }
    if (level >= 10) {
      notes.push(
        'Danação Mística: sempre tem Danação preparada; alvo também tem Desvantagem nas salvaguardas do atributo escolhido.',
      );
      notes.push(
        'Escudo Mental: pensamentos ilegíveis; Resistência a Psíquico; quem causar Psíquico a você também sofre o dano.',
      );
    }
    if (level >= 14) {
      notes.push(
        'Criar Servo: Invocar Aberração sem Concentração (duração 1 min) + PV temp = nível; dano psíquico extra vs alvo da sua Danação.',
      );
    }
  }
}
