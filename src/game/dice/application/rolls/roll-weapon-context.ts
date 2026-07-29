import { BadRequestException } from '@nestjs/common';
import type { DataSource } from 'typeorm';
import { PlayerCharacterAccessService } from '../../../shared/player-character-access.service';
import { CharacterDomainService } from '../../../sheet/domain/core/character-domain.service';
import { collectFightingStyleSlugsFromSubclassOptions } from '../../../sheet/domain/validation/class-options/fighting-style-feat-options';
import { collectMasteredWeaponSlugs } from '../../../sheet/domain/validation/class-options/class-weapon-mastery-slots';
import { CharacterSheetRepository } from '../../../sheet/infrastructure/character-sheet.repository';
import { resolveEffectiveAbilityScores } from '../../../sheet/infrastructure/load-class-ability-boosts';
import { ResolveEquippedWeaponAttacks } from '../../../combat/application/resolve-equipped-weapon-attacks';
import type { ResolveActivePermanentItemEffects } from '../../../inventory/application/resolve-active-permanent-item-effects';
import { applyItemAbilityBonuses } from '../../../inventory/domain/permanent-item-effects';
import type { AbilityScores } from '../../../shared/infrastructure/player-character.entity';

export type RollWeaponCharacter = {
  id: string;
  classSlug: string;
  subclassSlug: string | null;
  abilityScores: AbilityScores;
  level: number;
};

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
  const scores = itemEffects
    ? applyItemAbilityBonuses(
        classScores,
        itemEffects.abilityBonuses,
        itemEffects.abilityScoreCaps,
      )
    : classScores;
  const attacks = await deps.weaponAttacks.resolve(character.id, scores, {
    classSlug: character.classSlug,
    proficiencyBonus: pb,
    featSlugs,
    fightingStyleSlugs,
    masteredWeaponSlugs: collectMasteredWeaponSlugs({
      classOptions: sheet.classOptions,
      featOptions: sheet.featOptions,
    }),
    itemAttackBonus: itemEffects?.attackBonus,
    itemDamageBonus: itemEffects?.damageBonus,
  });
  const attack = attacks.find(
    (row) => row.itemSlug === itemSlug && row.mode === mode,
  );
  if (!attack) {
    throw new BadRequestException(
      `No equipped weapon attack for '${itemSlug}' (${mode})`,
    );
  }
  return attack;
}

export async function loadAccessibleCharacter(
  access: PlayerCharacterAccessService,
  userId: string,
  characterId: string,
) {
  return access.findAccessibleOrFail(userId, characterId, 'read');
}
