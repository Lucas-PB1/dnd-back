import { applyItemAbilityBonuses } from '../../inventory/domain/permanent-item-effects';
import {
  barbarianCombatNotes,
  fastMovementBonusMeters,
} from '../domain/barbarian-rage';
import {
  attacksPerAction as resolveAttacksPerAction,
  fighterCombatNotes,
  isFighterClass,
} from '../domain/fighter-features';
import { rogueCombatNotes } from '../domain/rogue-features';
import {
  isMonkClass,
  monkAttacksPerAction,
  monkCombatNotes,
  unarmoredMovementBonusMeters,
} from '../domain/monk-features';
import {
  isPaladinClass,
  paladinAttacksPerAction,
  paladinCombatNotes,
} from '../domain/paladin-features';
import { ResolveEquippedArmorClass } from './resolve-equipped-armor-class';
import { ResolveEquippedWeaponAttacks } from './resolve-equipped-weapon-attacks';
import { ResolveEquipmentCompliance } from './resolve-equipment-compliance';
import { PlayerCharacterItem } from '../../inventory/infrastructure/player-character-item.entity';
import { Repository } from 'typeorm';
import type { ResolveActivePermanentItemEffects } from '../../inventory/application/resolve-active-permanent-item-effects';
import type { AbilityScores } from '../../shared/infrastructure/player-character.entity';
import type { SizeCategory } from '../domain/creature-size';

export type MappedCombatSlice = {
  armorClass: number;
  armorClassNote: string;
  weaponAttacks: Awaited<ReturnType<ResolveEquippedWeaponAttacks['resolve']>>;
  equipmentWarnings: Awaited<
    ReturnType<ResolveEquipmentCompliance['resolve']>
  >['warnings'];
  cannotCastSpellsInArmor: boolean;
  speedPenaltyMeters: Awaited<
    ReturnType<ResolveEquipmentCompliance['resolve']>
  >['speedPenaltyMeters'];
  /** Bônus de deslocamento de itens ativos (metros). */
  itemSpeedBonusMeters: number;
  /** Bônus de PV máximos de itens ativos. */
  itemHpBonus: number;
  /** Notas de combate de classe (Bárbaro, Guerreiro etc.). */
  classCombatNotes: string[];
  /** Ataques por Ação Atacar (Guerreiro Extra Attack). */
  attacksPerAction: number;
};

export async function resolveCharacterCombatSlice(input: {
  characterId: string;
  abilityScores: AbilityScores;
  classSlug: string;
  subclassSlug: string | null;
  level: number;
  proficiencyBonus: number;
  featSlugs: string[];
  fightingStyleSlugs: string[];
  masteredWeaponSlugs: string[];
  sizeCategory: SizeCategory;
  equippedArmorClass: ResolveEquippedArmorClass;
  equippedWeaponAttacks: ResolveEquippedWeaponAttacks;
  equipmentCompliance: ResolveEquipmentCompliance;
  inventoryItems: Repository<PlayerCharacterItem>;
  permanentItemEffects: ResolveActivePermanentItemEffects;
}): Promise<MappedCombatSlice> {
  const {
    characterId,
    abilityScores,
    classSlug,
    subclassSlug,
    level,
    proficiencyBonus,
    featSlugs,
    fightingStyleSlugs,
    masteredWeaponSlugs,
    sizeCategory,
    equippedArmorClass,
    equippedWeaponAttacks,
    equipmentCompliance,
    inventoryItems,
    permanentItemEffects,
  } = input;

  const itemEffects = await permanentItemEffects.resolve(characterId);
  const combatScores = applyItemAbilityBonuses(
    abilityScores,
    itemEffects.abilityBonuses,
    itemEffects.abilityScoreCaps,
  );

  const hasShield = await inventoryItems.exist({
    where: {
      characterId,
      location: 'equipped',
      equipmentSlot: 'shield',
    },
  });

  const armor = await equippedArmorClass.resolve(characterId, combatScores, {
    classSlug,
    subclassSlug,
    featSlugs,
    fightingStyleSlugs,
    itemAcBonus: itemEffects.acBonus,
    itemAcBonusNames: itemEffects.sourceNames,
  });
  const weaponAttacks = await equippedWeaponAttacks.resolve(
    characterId,
    combatScores,
    {
      classSlug,
      subclassSlug,
      level,
      proficiencyBonus,
      featSlugs,
      fightingStyleSlugs,
      sizeCategory,
      hasShield,
      masteredWeaponSlugs,
      itemAttackBonus: itemEffects.attackBonus,
      itemDamageBonus: itemEffects.damageBonus,
    },
  );

  const compliance = await equipmentCompliance.resolve(characterId, {
    classSlug,
    strengthScore: combatScores.forca,
    featSlugs,
    sizeCategory,
    hasShield,
  });

  const classSpeedBonus =
    fastMovementBonusMeters({ classSlug, level }) +
    unarmoredMovementBonusMeters({ classSlug, level });
  const notes = [
    ...barbarianCombatNotes({ classSlug, level }),
    ...fighterCombatNotes({ classSlug, subclassSlug, level }),
    ...rogueCombatNotes({ classSlug, subclassSlug, level }),
    ...monkCombatNotes({ classSlug, subclassSlug, level }),
    ...paladinCombatNotes({ classSlug, subclassSlug, level }),
  ];

  return {
    armorClass: armor.armorClass,
    armorClassNote: armor.armorClassNote,
    weaponAttacks,
    equipmentWarnings: compliance.warnings,
    cannotCastSpellsInArmor: compliance.cannotCastSpells,
    speedPenaltyMeters: compliance.speedPenaltyMeters,
    itemSpeedBonusMeters: itemEffects.speedBonusMeters + classSpeedBonus,
    itemHpBonus: itemEffects.hpBonus,
    classCombatNotes: notes,
    attacksPerAction: isFighterClass(classSlug)
      ? resolveAttacksPerAction(level)
      : isMonkClass(classSlug)
        ? monkAttacksPerAction(level)
        : isPaladinClass(classSlug)
          ? paladinAttacksPerAction(level)
          : 1,
  };
}
