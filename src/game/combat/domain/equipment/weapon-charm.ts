import { formatSigned } from '../weapon-attacks/weapon-attack-predicates';
import type {
  EquippedWeaponPiece,
  WeaponAttack,
} from '../weapon-attacks/weapon-attack.types';

export const WEAPON_CHARM_KINDS = [
  'arrowhead',
  'blade',
  'die',
  'flame',
  'hook',
  'spear',
  'lightning',
  'quiver',
] as const;

export type WeaponCharmKind = (typeof WEAPON_CHARM_KINDS)[number];

export type WeaponCharm = {
  kind: WeaponCharmKind;
  attackBonus?: number;
  damageBonus?: number;
  damageTypeOverride?: string;
  extraDamageDice?: string;
};

const KIND_SET = new Set<string>(WEAPON_CHARM_KINDS);

function isRecord(value: unknown): value is Record<string, unknown> {
  return typeof value === 'object' && value !== null && !Array.isArray(value);
}

function optionalPositiveInt(value: unknown): number | undefined {
  if (typeof value !== 'number' || !Number.isFinite(value)) return undefined;
  const n = Math.trunc(value);
  return n > 0 ? n : undefined;
}

function optionalNonEmptyString(value: unknown): string | undefined {
  if (typeof value !== 'string') return undefined;
  const trimmed = value.trim();
  return trimmed.length > 0 ? trimmed : undefined;
}

/** Lê `properties.weaponCharm` do catálogo de um encanto. */
export function parseWeaponCharm(
  properties: Record<string, unknown> | null | undefined,
): WeaponCharm | null {
  if (!isRecord(properties)) return null;
  const raw = properties.weaponCharm;
  if (!isRecord(raw)) return null;
  const kind = typeof raw.kind === 'string' ? raw.kind : '';
  if (!KIND_SET.has(kind)) return null;

  const charm: WeaponCharm = { kind: kind as WeaponCharmKind };
  const attackBonus = optionalPositiveInt(raw.attackBonus);
  const damageBonus = optionalPositiveInt(raw.damageBonus);
  const damageTypeOverride = optionalNonEmptyString(raw.damageTypeOverride);
  const extraDamageDice = optionalNonEmptyString(raw.extraDamageDice);
  if (attackBonus !== undefined) charm.attackBonus = attackBonus;
  if (damageBonus !== undefined) charm.damageBonus = damageBonus;
  if (damageTypeOverride !== undefined) {
    charm.damageTypeOverride = damageTypeOverride;
  }
  if (extraDamageDice !== undefined) charm.extraDamageDice = extraDamageDice;
  return charm;
}

/** Notas de ficha por kind (efeitos não numéricos). */
export function charmNotes(kind: WeaponCharmKind): string[] {
  switch (kind) {
    case 'arrowhead':
      return ['ignora meia / ¾ cobertura (à distância)'];
    case 'blade':
      return [];
    case 'die':
      return ['crítico explosivo (máx. +5 dados)'];
    case 'flame':
      return ['aplica Queimar (1 min)'];
    case 'hook':
      return ['ação bônus: teleporta arma à mão'];
    case 'spear':
      return ['carga 4,5 m antes do ataque CdC'];
    case 'lightning':
      return [];
    case 'quiver':
      return ['ignora Recarga'];
    default: {
      const _exhaustive: never = kind;
      return _exhaustive;
    }
  }
}

/**
 * Aplica bônus / override do encanto preso a esta peça.
 * Só age quando `piece.weaponCharm` está definido (arma com attachedCharmSlug).
 */
export function applyWeaponCharmToAttack(
  piece: EquippedWeaponPiece,
  attack: WeaponAttack,
): WeaponAttack {
  const charmMeta = {
    attachedCharmSlug: piece.attachedCharmSlug ?? null,
    attachedCharmName: piece.attachedCharmName ?? null,
  };
  const charm = piece.weaponCharm;
  if (!charm) {
    return { ...attack, ...charmMeta };
  }

  let attackBonus = attack.attackBonus;
  let damageBonus = attack.damageBonus;
  let damageType = attack.damageType;
  let damageDice = attack.damageDice;
  let damageNote = attack.damageNote;
  let reloadCapacity = attack.reloadCapacity;
  const attackExtras: string[] = [];

  if (charm.attackBonus) {
    attackBonus += charm.attackBonus;
    attackExtras.push(`encanto ${formatSigned(charm.attackBonus)}`);
  }
  if (charm.damageBonus) {
    damageBonus += charm.damageBonus;
    damageNote = `${damageNote} · encanto ${formatSigned(charm.damageBonus)}`;
  }
  if (charm.damageTypeOverride) {
    damageType = charm.damageTypeOverride;
    damageNote = `${damageNote} · ${charm.damageTypeOverride}`;
  }
  if (charm.extraDamageDice) {
    damageDice = `${damageDice}+${charm.extraDamageDice}`;
    damageNote = `${damageNote} · +${charm.extraDamageDice} encanto`;
  }
  if (charm.kind === 'quiver') {
    reloadCapacity = null;
  }

  attackExtras.push(...charmNotes(charm.kind));
  const attackNote =
    attackExtras.length > 0
      ? `${attack.attackNote} · ${attackExtras.join(' · ')}`
      : attack.attackNote;

  return {
    ...attack,
    ...charmMeta,
    attackBonus,
    damageBonus,
    damageType,
    damageDice,
    attackNote,
    damageNote,
    reloadCapacity,
  };
}
