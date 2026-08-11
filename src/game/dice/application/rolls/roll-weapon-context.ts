import { BadRequestException } from '@nestjs/common';
import type { DataSource } from 'typeorm';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import { collectFightingStyleSlugsFromSubclassOptions } from '@game/sheet/domain/validation/class-options/fighting-style-feat-options';
import { collectMasteredWeaponSlugs } from '@game/sheet/domain/validation/class-options/class-weapon-mastery-slots';
import { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import { resolveEffectiveAbilityScores } from '@game/sheet/infrastructure/load-class-ability-boosts';
import { ResolveEquippedWeaponAttacks } from '@game/combat/application/resolve-equipped-weapon-attacks';
import type { ResolveActivePermanentItemEffects } from '@game/inventory/application/resolve-active-permanent-item-effects';
import { applyItemAbilityBonuses } from '@game/inventory/domain/permanent-item-effects';
import {
  applyAbilityPenalties,
  collectAbilityPenaltiesFromInventory,
} from '@game/inventory/domain/artifact/artifact-instance-ops';
import { PlayerCharacterItem } from '@game/inventory/infrastructure/player-character-item.entity';
import type { AbilityScores } from '@game/shared/infrastructure/player-character.entity';

export type RollWeaponCharacter = {
  id: string;
  classSlug: string;
  subclassSlug: string | null;
  abilityScores: AbilityScores;
  level: number;
};

export type WeaponCombatFlags = {
  rageActive: boolean;
  recklessActive: boolean;
  bestialAspectLevel: number;
};

async function loadWeaponCombatFlags(
  dataSource: DataSource | undefined,
  characterId: string,
): Promise<WeaponCombatFlags> {
  if (!dataSource) {
    return { rageActive: false, recklessActive: false, bestialAspectLevel: 0 };
  }
  const rows = await dataSource.query<
    {
      rage_active: boolean;
      reckless_active: boolean;
      bestial_aspect_level: number | null;
    }[]
  >(
    `SELECT rage_active, reckless_active, bestial_aspect_level
     FROM rpg.player_character_state
     WHERE character_id = $1
     LIMIT 1`,
    [characterId],
  );
  const row = rows[0];
  return {
    rageActive: Boolean(row?.rage_active),
    recklessActive: Boolean(row?.reckless_active),
    bestialAspectLevel: Number(row?.bestial_aspect_level ?? 0),
  };
}

export async function findEquippedWeaponAttack(
  deps: {
    sheet: CharacterSheetRepository;
    domain: CharacterDomainService;
    weaponAttacks: ResolveEquippedWeaponAttacks;
    permanentItemEffects?: ResolveActivePermanentItemEffects;
    dataSource?: DataSource;
  },
  character: RollWeaponCharacter,
  itemSlug: string,
  mode: 'melee' | 'ranged',
) {
  const sheet = await deps.sheet.load(character.id);
  const pb = await deps.domain.getProficiencyBonus(character.level);
  const featSlugs = sheet.characterFeats.map((f) => f.featSlug);
  const fightingStyleSlugs = collectFightingStyleSlugsFromSubclassOptions(
    sheet.subclassOptions,
  );
  const itemEffects = deps.permanentItemEffects
    ? await deps.permanentItemEffects.resolve(character.id)
    : null;
  const classScores = deps.dataSource
    ? await resolveEffectiveAbilityScores(
        deps.dataSource,
        character.classSlug,
        character.level,
        character.abilityScores,
      )
    : character.abilityScores;
  const scoresWithItems = itemEffects
    ? applyItemAbilityBonuses(
        classScores,
        itemEffects.abilityBonuses,
        itemEffects.abilityScoreCaps,
      )
    : classScores;
  const inventoryRows = deps.dataSource
    ? await deps.dataSource.getRepository(PlayerCharacterItem).find({
        where: { characterId: character.id },
      })
    : [];
  const scores = applyAbilityPenalties(
    scoresWithItems,
    collectAbilityPenaltiesFromInventory(inventoryRows),
  );
  const combatFlags = await loadWeaponCombatFlags(
    deps.dataSource,
    character.id,
  );
  const attacks = await deps.weaponAttacks.resolve(character.id, scores, {
    classSlug: character.classSlug,
    subclassSlug: character.subclassSlug,
    level: character.level,
    proficiencyBonus: pb,
    featSlugs,
    fightingStyleSlugs,
    masteredWeaponSlugs: collectMasteredWeaponSlugs({
      classOptions: sheet.classOptions,
      featOptions: sheet.featOptions,
    }),
    itemAttackBonus: itemEffects?.attackBonus,
    itemDamageBonus: itemEffects?.damageBonus,
    rageActive: combatFlags.rageActive,
    recklessActive: combatFlags.recklessActive,
  });
  const attack = attacks.find(
    (row) => row.itemSlug === itemSlug && row.mode === mode,
  );
  if (!attack) {
    throw new BadRequestException(
      `No equipped weapon attack for '${itemSlug}' (${mode})`,
    );
  }
  return { attack, combatFlags };
}

export async function loadAccessibleCharacter(
  access: PlayerCharacterAccessService,
  userId: string,
  characterId: string,
) {
  return access.findAccessibleOrFail(userId, characterId, 'read');
}
