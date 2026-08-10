/** Parseia restrição de sintonia a partir do texto DMG em `properties.attunement`. */

export const SPELLCASTER_CLASS_SLUGS = [
  'bard',
  'cleric',
  'druid',
  'paladin',
  'ranger',
  'sorcerer',
  'warlock',
  'wizard',
] as const;

const CLASS_NAME_TO_SLUG: Record<string, string> = {
  barbaro: 'barbarian',
  bardo: 'bard',
  bruxo: 'warlock',
  clerigo: 'cleric',
  druida: 'druid',
  feiticeiro: 'sorcerer',
  guerreiro: 'fighter',
  ladino: 'rogue',
  mago: 'wizard',
  monge: 'monk',
  paladino: 'paladin',
  patrulheiro: 'ranger',
  ranger: 'ranger',
};

const SPECIES_NAME_TO_SLUG: Record<string, string> = {
  anao: 'dwarf',
};

export type AttunementRestriction =
  | { kind: 'unrestricted' }
  | {
      kind: 'restricted';
      classSlugs: string[];
      speciesSlugs: string[];
      allowAnySpellcaster: boolean;
      /** Texto original da cláusula "por …" (para mensagem de erro). */
      clause: string;
    };

function stripDiacritics(value: string): string {
  return value.normalize('NFD').replace(/\p{M}/gu, '');
}

function normalizeToken(value: string): string {
  return stripDiacritics(value)
    .toLowerCase()
    .replace(/[^a-z]/g, '');
}

function attunementText(
  properties: Record<string, unknown> | null | undefined,
): string {
  const attunement =
    typeof properties?.attunement === 'string' ? properties.attunement : '';
  if (attunement.trim()) return attunement.trim();
  const header = typeof properties?.header === 'string' ? properties.header : '';
  return header.trim();
}

/**
 * Extrai restrição de classe/espécie/conjurador.
 * Narrativo sem tokens conhecidos (ex. Lunâmina) → unrestricted.
 */
export function parseAttunementRestriction(
  properties: Record<string, unknown> | null | undefined,
): AttunementRestriction {
  const text = attunementText(properties);
  if (!text) return { kind: 'unrestricted' };

  const porMatch = text.match(
    /Requer\s+Sintoniza[cç][aã]o\s+por\s+(?:um[a]?\s+)?(.+)$/i,
  );
  if (!porMatch) return { kind: 'unrestricted' };

  const clause = porMatch[1].replace(/[.)]+$/, '').trim();
  const parts = clause
    .split(/\s*,\s*|\s+ou\s+/i)
    .map((part) => part.trim())
    .filter(Boolean);

  const classSlugs = new Set<string>();
  const speciesSlugs = new Set<string>();
  let allowAnySpellcaster = false;
  let knownToken = false;

  for (const part of parts) {
    const cleaned = part.replace(/^(um|uma)\s+/i, '').trim();
    const token = normalizeToken(cleaned);
    if (!token) continue;

    if (token === 'conjurador' || token.startsWith('conjurador')) {
      allowAnySpellcaster = true;
      knownToken = true;
      continue;
    }

    const classSlug = CLASS_NAME_TO_SLUG[token];
    if (classSlug) {
      classSlugs.add(classSlug);
      knownToken = true;
      continue;
    }

    const speciesSlug = SPECIES_NAME_TO_SLUG[token];
    if (speciesSlug) {
      speciesSlugs.add(speciesSlug);
      knownToken = true;
      continue;
    }

    // "Criatura da Escolha…", "Criatura Sintonizada a um Cinturão…"
    if (token.startsWith('criatura')) {
      return { kind: 'unrestricted' };
    }
  }

  if (!knownToken) return { kind: 'unrestricted' };

  return {
    kind: 'restricted',
    classSlugs: [...classSlugs],
    speciesSlugs: [...speciesSlugs],
    allowAnySpellcaster,
    clause,
  };
}

export function isSpellcasterClassSlug(classSlug: string): boolean {
  return (SPELLCASTER_CLASS_SLUGS as readonly string[]).includes(classSlug);
}

export function characterMatchesAttunementRestriction(input: {
  classSlug: string;
  speciesSlug: string | null | undefined;
  restriction: AttunementRestriction;
}): boolean {
  const { classSlug, speciesSlug, restriction } = input;
  if (restriction.kind === 'unrestricted') return true;

  if (restriction.classSlugs.includes(classSlug)) return true;
  if (
    restriction.allowAnySpellcaster &&
    isSpellcasterClassSlug(classSlug)
  ) {
    return true;
  }
  if (
    speciesSlug &&
    restriction.speciesSlugs.includes(speciesSlug)
  ) {
    return true;
  }
  return false;
}

export function assertCharacterMayAttune(input: {
  itemLabel: string;
  classSlug: string;
  speciesSlug: string | null | undefined;
  properties: Record<string, unknown> | null | undefined;
}): void {
  const restriction = parseAttunementRestriction(input.properties);
  if (
    characterMatchesAttunementRestriction({
      classSlug: input.classSlug,
      speciesSlug: input.speciesSlug,
      restriction,
    })
  ) {
    return;
  }

  const clause =
    restriction.kind === 'restricted'
      ? restriction.clause
      : 'requisito de sintonia';
  throw new Error(
    `Item '${input.itemLabel}' requer sintonia por ${clause} (personagem é '${input.classSlug}')`,
  );
}
