import type { AbilityScores } from '../../shared/infrastructure/player-character.entity';
import type { SizeCategory } from './creature-size';
import { analyzeDualWield } from './dual-wield';
import {
  appliesRageDamageBonus,
  brutalStrikeDice as resolveBrutalStrikeDice,
} from './barbarian-rage';
import {
  applyOverkillDamageBonus,
  resolveAttackCritThreshold,
} from './gunslinger-firearm';
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
  const isFirearm = hasProperty(piece, 'firearm');
  const overkill =
    mode === 'ranged'
      ? applyOverkillDamageBonus({
          level: context.level ?? 1,
          isFirearm,
          abilityMod: ability.mod,
        })
      : {
          abilityDamageBonus: ability.mod,
          extraDamageDice: null as string | null,
        };

  let damageBonus = 0;
  const damageParts: string[] = [];

  if (omitAbilityDamage) {
    if (ability.mod < 0) {
      damageBonus = ability.mod;
      damageParts.push(abilityShortLabel(ability.slug));
    }
  } else if (isFirearm && mode === 'ranged') {
    damageBonus = overkill.abilityDamageBonus;
    if (damageBonus !== 0) {
      damageParts.push(abilityShortLabel(ability.slug));
      if ((context.level ?? 1) >= 11) damageParts.push('Exagero');
    } else {
      damageParts.push('arma de fogo');
    }
  } else {
    damageBonus = overkill.abilityDamageBonus;
    damageParts.push(abilityShortLabel(ability.slug));
    if (overkill.extraDamageDice) damageParts.push('Exagero');
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

  const rageBonus = appliesRageDamageBonus({
    classSlug: context.classSlug,
    level: context.level,
    rageActive: context.rageActive,
    mode,
    abilitySlug: ability.slug,
  });
  if (rageBonus > 0) {
    damageBonus += rageBonus;
    damageParts.push(`Fúria +${rageBonus}`);
  }

  const itemAttackBonus = context.itemAttackBonus ?? 0;
  if (itemAttackBonus !== 0) {
    attackBonus += itemAttackBonus;
    attackParts.push('item');
  }
  const itemDamageBonus = context.itemDamageBonus ?? 0;
  if (itemDamageBonus !== 0) {
    damageBonus += itemDamageBonus;
    damageParts.push('item');
  }

  const versatile2h = usesVersatileTwoHanded(
    piece,
    equippedWeapons,
    Boolean(context.hasShield),
  );
  const damageDice = versatile2h
    ? (piece.versatileDamage ?? piece.damage ?? '1')
    : (piece.damage ?? '1');
  const overkillExtraDice =
    mode === 'ranged' && !isFirearm && !omitAbilityDamage
      ? overkill.extraDamageDice
      : null;
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
  if (isFirearm) noteExtras.push('arma de fogo');
  if (hasProperty(piece, 'recoil')) noteExtras.push('recuo');
  if (hasProperty(piece, 'reload')) {
    const cap = piece.reloadCapacity;
    noteExtras.push(cap != null ? `recarga (${cap})` : 'recarga');
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
  if (masteryActive && masterySlug === 'scatter') {
    noteExtras.push('Dispersão: sem desv. a 1,5 m');
  }
  if (masteryActive && masterySlug === 'sighted') {
    noteExtras.push('Mira: sem desv. a longa distância');
  }
  if (masteryActive && masterySlug === 'automatic') {
    noteExtras.push('Automática: opção 2 ataques c/ desv.');
  }
  if (masteryActive && masterySlug === 'explode') {
    noteExtras.push('Explosiva: opção esfera 1,5 m');
  }

  const attackDisadvantage =
    context.sizeCategory === 'small' && hasProperty(piece, 'heavy');
  if (attackDisadvantage) {
    noteExtras.push('desvantagem (Pesada / tamanho Pequeno)');
  }

  const critThreshold = resolveAttackCritThreshold({
    classSlug: context.classSlug,
    subclassSlug: context.subclassSlug,
    level: context.level,
    mode,
  });
  if (critThreshold < 20) {
    noteExtras.push(`crítico ${critThreshold}–20`);
  }

  const brutalDice =
    mode === 'melee' && ability.slug === 'forca'
      ? resolveBrutalStrikeDice(context.level ?? 0)
      : null;
  if (brutalDice) {
    noteExtras.push(`Golpe Brutal ${brutalDice}`);
  }

  const attackNoteBase = `${modeLabel}: ${attackParts.join(' + ')}`;
  const attackNote =
    noteExtras.length > 0
      ? `${attackNoteBase} · ${noteExtras.join(' · ')}`
      : attackNoteBase;
  const damageNoteParts = greatWeaponFighting
    ? [...damageParts, 'GWF']
    : damageParts;
  const damageNoteDice = overkillExtraDice
    ? `${damageDice}+${overkillExtraDice}`
    : damageDice;

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
    damageNote: formatDamageNote(damageNoteDice, damageBonus, damageNoteParts),
    role,
    attackDisadvantage,
    omitsAbilityDamage:
      omitAbilityDamage || (isFirearm && mode === 'ranged' && overkill.abilityDamageBonus === 0),
    greatWeaponFighting,
    masteryActive,
    masterySlug: masteryActive ? masterySlug : null,
    masteryName: masteryActive ? masteryName : null,
    nickUsesAttackAction,
    grazeOnMissDamage,
    isFirearm,
    critThreshold,
    overkillExtraDice,
    reloadCapacity: hasProperty(piece, 'reload')
      ? (piece.reloadCapacity ?? null)
      : null,
    hasRecoil: hasProperty(piece, 'recoil'),
    rageDamageBonus: rageBonus,
    brutalStrikeDice: brutalDice,
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
