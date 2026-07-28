import type { AbilityScores } from '../../../shared/infrastructure/player-character.entity';
import type { SizeCategory } from './creature-size';
import { analyzeDualWield } from './dual-wield';
import {
  abilityShortLabel,
  buildModes,
  formatDamageNote,
  hasProperty,
  hasStyleOrFeat,
  isProficient,
  isThrownWeapon,
  pickAbility,
  qualifiesForDueling,
  qualifiesForGreatWeaponFighting,
  usesVersatileTwoHanded,
} from './weapon-attack-predicates';
import type {
  EquippedWeaponPiece,
  WeaponAttack,
  WeaponAttackContext,
  WeaponAttackRole,
} from './weapon-attack.types';

function computeOneAttack(
  scores: AbilityScores,
  piece: EquippedWeaponPiece,
  mode: 'melee' | 'ranged',
  context: WeaponAttackContext,
  equippedWeapons: EquippedWeaponPiece[],
  role: WeaponAttackRole,
): WeaponAttack {
  const proficient = isProficient(piece, context);
  const ability = pickAbility(scores, piece, mode);
  const attackParts: string[] = [abilityShortLabel(ability.slug)];
  let attackBonus = ability.mod;

  if (proficient) {
    attackBonus += context.proficiencyBonus;
    attackParts.push('PB');
  }
  if (mode === 'ranged' && hasStyleOrFeat(context, 'archery')) {
    attackBonus += 2;
    attackParts.push('Arquearia');
  }

  const isBonusAttack = role === 'light_bonus' || role === 'dual_bonus';
  const hasTwf = hasStyleOrFeat(context, 'two-weapon-fighting');
  const omitAbilityDamage = isBonusAttack && !hasTwf && ability.mod >= 0;
  let damageBonus = omitAbilityDamage ? 0 : ability.mod;
  const damageParts: string[] = omitAbilityDamage
    ? []
    : [abilityShortLabel(ability.slug)];

  if (omitAbilityDamage && ability.mod < 0) {
    damageBonus = ability.mod;
    damageParts.push(abilityShortLabel(ability.slug));
  }
  if (
    hasStyleOrFeat(context, 'dueling') &&
    qualifiesForDueling(piece, mode, equippedWeapons)
  ) {
    damageBonus += 2;
    damageParts.push('Duelismo');
  }
  if (
    mode === 'ranged' &&
    isThrownWeapon(piece) &&
    hasStyleOrFeat(context, 'thrown-weapon-fighting')
  ) {
    damageBonus += 2;
    damageParts.push('Arremesso');
  }
  if (hasProperty(piece, 'heavy') && hasStyleOrFeat(context, 'great-weapon-master')) {
    damageBonus += context.proficiencyBonus;
    damageParts.push('Mestre em Armas Grandes');
  }

  const versatile2h = usesVersatileTwoHanded(
    piece,
    equippedWeapons,
    Boolean(context.hasShield),
  );
  const damageDice = versatile2h
    ? (piece.versatileDamage ?? piece.damage ?? '1')
    : (piece.damage ?? '1');
  const greatWeaponFighting =
    hasStyleOrFeat(context, 'great-weapon-fighting') &&
    qualifiesForGreatWeaponFighting(piece, mode, versatile2h);

  const masterySlug = piece.masterySlug ?? null;
  const masteryName = piece.masteryName ?? null;
  const masteryActive =
    Boolean(masterySlug) &&
    (context.masteredWeaponSlugs ?? []).includes(piece.itemSlug);
  const nickUsesAttackAction =
    masteryActive &&
    masterySlug === 'nick' &&
    (role === 'light_bonus' || role === 'dual_bonus');
  const grazeOnMissDamage =
    masteryActive && masterySlug === 'graze' ? ability.mod : null;

  const modeLabel = mode === 'ranged' ? 'à distância' : 'corpo a corpo';
  const noteExtras: string[] = [];
  if (hasProperty(piece, 'versatile')) {
    noteExtras.push(versatile2h ? 'versátil (2 mãos)' : 'versátil (1 mão)');
  }
  if (role === 'light_bonus') {
    noteExtras.push(
      nickUsesAttackAction
        ? 'ataque adicional (Ágil · ação Atacar)'
        : 'ataque adicional (Leve)',
    );
  }
  if (role === 'dual_bonus') noteExtras.push('ataque adicional (Ambidestro)');
  if (greatWeaponFighting) noteExtras.push('Luta com Armas Grandes');
  if (masteryActive && masteryName) noteExtras.push(`Maestria: ${masteryName}`);

  const attackDisadvantage =
    context.sizeCategory === 'small' && hasProperty(piece, 'heavy');
  if (attackDisadvantage) {
    noteExtras.push('desvantagem (Pesada / tamanho Pequeno)');
  }

  const attackNoteBase = `${modeLabel}: ${attackParts.join(' + ')}`;
  const attackNote =
    noteExtras.length > 0
      ? `${attackNoteBase} · ${noteExtras.join(' · ')}`
      : attackNoteBase;
  const damageNoteParts = greatWeaponFighting
    ? [...damageParts, 'GWF']
    : damageParts;

  return {
    itemSlug: piece.itemSlug,
    itemName: piece.itemName,
    mode,
    attackBonus,
    abilitySlug: ability.slug,
    proficient,
    damageDice,
    damageBonus,
    damageType: piece.damageType,
    attackNote,
    damageNote: formatDamageNote(damageDice, damageBonus, damageNoteParts),
    role,
    attackDisadvantage,
    omitsAbilityDamage: omitAbilityDamage,
    greatWeaponFighting,
    masteryActive,
    masterySlug: masteryActive ? masterySlug : null,
    masteryName: masteryActive ? masteryName : null,
    nickUsesAttackAction,
    grazeOnMissDamage,
  };
}

/** Calcula ataques passivos das armas equipadas (main_hand / off_hand). */
export function computeWeaponAttacks(
  scores: AbilityScores,
  equipped: EquippedWeaponPiece[],
  context: WeaponAttackContext,
): WeaponAttack[] {
  const weapons = equipped.filter(
    (piece) =>
      piece.equipmentSlot === 'main_hand' || piece.equipmentSlot === 'off_hand',
  );
  const dual = analyzeDualWield(weapons, context);
  const attacks: WeaponAttack[] = [];
  for (const piece of weapons) {
    const role: WeaponAttackRole =
      piece.equipmentSlot === 'off_hand' && dual.bonusRole
        ? dual.bonusRole
        : 'main';
    for (const mode of buildModes(piece)) {
      // Ataque adicional TWF/Dual é corpo a corpo; modos ranged da off-hand ficam main.
      const effectiveRole = role !== 'main' && mode === 'ranged' ? 'main' : role;
      attacks.push(
        computeOneAttack(scores, piece, mode, context, weapons, effectiveRole),
      );
    }
  }
  return attacks;
}

export function heavyWeaponSlugsForSmallSize(
  weapons: EquippedWeaponPiece[],
  sizeCategory: SizeCategory | undefined,
): string[] {
  if (sizeCategory !== 'small') return [];
  return weapons.filter((w) => hasProperty(w, 'heavy')).map((w) => w.itemSlug);
}
