import { resolveAttackVsArmorClass } from './attack-vs-armor-class';

export const SHIELD_SPELL_SLUG = 'escudo-arcano';
export const SHIELD_AC_BONUS = 5;
export const UNCANNY_DODGE_MIN_LEVEL = 5;

export type IncomingHitDefenseKind = 'shield' | 'uncanny_dodge' | 'parry';

export type ResolveIncomingHitInput = {
  attackTotal: number;
  naturalD20: number;
  targetAc: number;
  provisionalHit: boolean;
  provisionalCritical: boolean;
  damageTotal: number | null;
  reactionAvailable: boolean;
  defense: IncomingHitDefenseKind | null;
  /** Rogue L5+ for uncanny; shield eligibility is enforced by castSpell in the wire. */
  uncannyEligible: boolean;
  /** Redução tipada (Parry: dado + max FOR/DES). */
  parryReduction?: number;
};

export type ResolveIncomingHitResult = {
  hit: boolean;
  critical: boolean;
  effectiveAc: number;
  damageTotal: number | null;
  reactionSpent: boolean;
  defenseApplied: IncomingHitDefenseKind | null;
  /** Wire should call castSpell(escudo-arcano) when true. */
  spendShieldSlot: boolean;
  notes: string[];
};

export function canUseUncannyDodge(input: {
  classSlug: string | null | undefined;
  level: number;
}): boolean {
  return (
    input.classSlug === 'rogue' && input.level >= UNCANNY_DODGE_MIN_LEVEL
  );
}

/**
 * Ajusta acerto/dano após o roll provisório, quando o defensor gasta reação
 * (Escudo Arcano +5 CA ou Esquiva Sobrenatural = metade do dano).
 */
export function resolveIncomingHit(
  input: ResolveIncomingHitInput,
): ResolveIncomingHitResult {
  const base = {
    hit: input.provisionalHit,
    critical: input.provisionalCritical,
    effectiveAc: input.targetAc,
    damageTotal: input.damageTotal,
    reactionSpent: false,
    defenseApplied: null as IncomingHitDefenseKind | null,
    spendShieldSlot: false,
    notes: [] as string[],
  };

  if (!input.defense) return base;

  if (!input.reactionAvailable) {
    base.notes.push('Reação indisponível');
    return base;
  }

  if (!input.provisionalHit) {
    base.notes.push('Defesa ignorada (ataque não acertou)');
    return base;
  }

  if (input.defense === 'shield') {
    const effectiveAc = input.targetAc + SHIELD_AC_BONUS;
    const vs = resolveAttackVsArmorClass({
      attackTotal: input.attackTotal,
      targetAc: effectiveAc,
      naturalD20: input.naturalD20,
    });
    const notes = [`Escudo Arcano (+${SHIELD_AC_BONUS} CA → ${effectiveAc})`];
    if (!vs.hit) {
      notes.push('ataque erra');
      return {
        hit: false,
        critical: false,
        effectiveAc,
        damageTotal: null,
        reactionSpent: true,
        defenseApplied: 'shield',
        spendShieldSlot: true,
        notes,
      };
    }
    notes.push('ainda acerta');
    return {
      hit: true,
      critical: vs.critical,
      effectiveAc,
      damageTotal: input.damageTotal,
      reactionSpent: true,
      defenseApplied: 'shield',
      spendShieldSlot: true,
      notes,
    };
  }

  // uncanny_dodge
  if (input.defense === 'uncanny_dodge') {
    if (!input.uncannyEligible) {
      base.notes.push('Esquiva Sobrenatural indisponível');
      return base;
    }
    const raw = input.damageTotal ?? 0;
    const halved = Math.floor(raw / 2);
    return {
      hit: true,
      critical: input.provisionalCritical,
      effectiveAc: input.targetAc,
      damageTotal: halved,
      reactionSpent: true,
      defenseApplied: 'uncanny_dodge',
      spendShieldSlot: false,
      notes: [`Esquiva Sobrenatural (dano ${raw} → ${halved})`],
    };
  }

  if (input.defense === 'parry') {
    const raw = input.damageTotal ?? 0;
    const reduction = Math.max(0, input.parryReduction ?? 0);
    const reduced = Math.max(0, raw - reduction);
    return {
      hit: true,
      critical: input.provisionalCritical,
      effectiveAc: input.targetAc,
      damageTotal: reduced,
      reactionSpent: true,
      defenseApplied: 'parry',
      spendShieldSlot: false,
      notes: [`Aparar (−${reduction} dano → ${reduced})`],
    };
  }

  base.notes.push('Defesa desconhecida');
  return base;
}
