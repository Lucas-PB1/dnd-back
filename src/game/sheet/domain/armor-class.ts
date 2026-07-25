import type { AbilityScores } from '../../shared/infrastructure/player-character.entity';

export type EquippedArmorPiece = {
  itemSlug: string;
  itemName: string;
  categorySlug: string;
  acBase: number | null;
};

export type ArmorClassContext = {
  classSlug?: string | null;
  subclassSlug?: string | null;
  /** Slugs de talentos selecionados (ex.: defense, medium-armor-master). */
  featSlugs?: string[];
  /** Estilos de luta via opção de subclasse/classe (ex.: defense). */
  fightingStyleSlugs?: string[];
};

type UnarmoredDefense = {
  label: string;
  secondAbility: keyof AbilityScores;
  allowsShield: boolean;
};

const BODY_ARMOR = new Set(['light', 'medium', 'heavy']);

function abilityMod(score: number): number {
  return Math.floor((score - 10) / 2);
}

function hasStyleOrFeat(
  context: ArmorClassContext | undefined,
  slug: string,
): boolean {
  return (
    (context?.featSlugs ?? []).includes(slug) ||
    (context?.fightingStyleSlugs ?? []).includes(slug)
  );
}

/** Passivos que substituem a CA base enquanto sem armadura corporal. */
function unarmoredDefenseCandidates(
  context: ArmorClassContext | undefined,
): UnarmoredDefense[] {
  const out: UnarmoredDefense[] = [];
  if (context?.classSlug === 'barbarian') {
    out.push({
      label: 'Defesa sem Armadura (bárbaro)',
      secondAbility: 'constituicao',
      allowsShield: true,
    });
  }
  if (context?.classSlug === 'monk') {
    out.push({
      label: 'Defesa sem Armadura (monge)',
      secondAbility: 'sabedoria',
      allowsShield: false,
    });
  }
  if (context?.subclassSlug === 'draconic') {
    out.push({
      label: 'Resiliência Dracônica',
      secondAbility: 'carisma',
      allowsShield: true,
    });
  }
  if (context?.subclassSlug === 'dance') {
    out.push({
      label: 'Defesa sem Armadura (dança)',
      secondAbility: 'carisma',
      allowsShield: false,
    });
  }
  return out;
}

function bodyArmorAc(
  piece: EquippedArmorPiece,
  scores: AbilityScores,
  mediumDexCap: number,
): number {
  const base = piece.acBase ?? 10;
  const dexMod = abilityMod(scores.destreza);
  switch (piece.categorySlug) {
    case 'light':
      return base + dexMod;
    case 'medium':
      return base + Math.min(dexMod, mediumDexCap);
    case 'heavy':
      return base;
    default:
      return base;
  }
}

function pickBestUnarmoredDefense(
  scores: AbilityScores,
  hasShield: boolean,
  candidates: UnarmoredDefense[],
): { armorClass: number; label: string } | null {
  let best: { armorClass: number; label: string } | null = null;
  for (const candidate of candidates) {
    if (hasShield && !candidate.allowsShield) continue;
    const value =
      10 +
      abilityMod(scores.destreza) +
      abilityMod(scores[candidate.secondAbility]);
    if (!best || value > best.armorClass) {
      best = { armorClass: value, label: candidate.label };
    }
  }
  return best;
}

export function computeArmorClassFromEquipment(
  scores: AbilityScores,
  equipped: EquippedArmorPiece[],
  context?: ArmorClassContext,
): { armorClass: number; armorClassNote: string } {
  const bodyArmor = equipped.find((piece) => BODY_ARMOR.has(piece.categorySlug));
  const shield = equipped.find((piece) => piece.categorySlug === 'shield');
  const hasShield = Boolean(shield);
  const noteParts: string[] = [];

  let armorClass: number;

  if (bodyArmor) {
    const mediumCap =
      bodyArmor.categorySlug === 'medium' &&
      hasStyleOrFeat(context, 'medium-armor-master') &&
      scores.destreza >= 16
        ? 3
        : 2;
    armorClass = bodyArmorAc(bodyArmor, scores, mediumCap);
    noteParts.push(bodyArmor.itemName);
    if (mediumCap === 3) {
      noteParts.push('Mestre em Armadura Média');
    }
  } else {
    const unarmored = pickBestUnarmoredDefense(
      scores,
      hasShield,
      unarmoredDefenseCandidates(context),
    );
    if (unarmored) {
      armorClass = unarmored.armorClass;
      noteParts.push(unarmored.label);
    } else {
      armorClass = 10 + abilityMod(scores.destreza);
      noteParts.push('Sem armadura');
    }
  }

  if (shield) {
    armorClass += 2;
    noteParts.push(shield.itemName);
  }

  if (bodyArmor && hasStyleOrFeat(context, 'defense')) {
    armorClass += 1;
    noteParts.push('Defensivo');
  }

  return {
    armorClass,
    armorClassNote: noteParts.join(' + '),
  };
}

/** Fallback simples (10 + DES) sem contexto de classe/talento. */
export function computeUnarmoredArmorClass(scores: AbilityScores): number {
  return 10 + abilityMod(scores.destreza);
}
