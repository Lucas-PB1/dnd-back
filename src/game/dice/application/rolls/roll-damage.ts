import { BadRequestException } from '@nestjs/common';
import type { DataSource } from 'typeorm';
import type { CharacterResourceSpender } from '@game/session/domain/character-resource-spender';
import type { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import type { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import type { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import { featureSchedulesFromCatalog } from '@game/combat/domain/feature-schedule';
import type { ResolveEquippedWeaponAttacks } from '@game/combat/application/resolve-equipped-weapon-attacks';
import type { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { rollDamageParts } from '@game/dice/domain/dice';
import { assertPolearmHaftBonusAttack } from '@game/combat/domain/feats/polearm-haft';
import type {
  CharacterRollResponseDto,
  RollDamageDto,
} from '@game/dice/dto/character-roll.dto';
import type { ResolveActivePermanentItemEffects } from '@game/inventory/application/effects/resolve-active-permanent-item-effects';
import {
  findEquippedWeaponAttack,
  loadAccessibleCharacter,
} from './roll-weapon-context';
import { createDamageAccumulator, addDamagePart } from './damage/damage-accumulator';
import { buildDamageRollResponse } from './damage/damage-response';
import { noteRageBonus } from './damage/apply-weapon-extras';
import { DAMAGE_EFFECT_PIPELINE } from './damage/pipeline';
import {
  hasDamageDieExplode,
  hasDamageDieFlip,
  hasDamageDieFloor,
  type LoadEffectCatalog,
} from '@game/effects';

export async function executeRollDamage(input: {
  access: PlayerCharacterAccessService;
  sheet: CharacterSheetRepository;
  domain: CharacterDomainService;
  weaponAttacks: ResolveEquippedWeaponAttacks;
  permanentItemEffects: ResolveActivePermanentItemEffects;
  dataSource: DataSource;
  resourceSpender: CharacterResourceSpender;
  mechanicalCatalog: LoadCombatMechanicalCatalog;
  effectCatalog: LoadEffectCatalog;
  userId: string;
  characterId: string;
  dto: RollDamageDto;
}): Promise<CharacterRollResponseDto> {
  const character = await loadAccessibleCharacter(
    input.access,
    input.userId,
    input.characterId,
  );
  const { attack, combatFlags, featSlugs, eldritchInvocationSlugs } =
    await findEquippedWeaponAttack(
    {
      sheet: input.sheet,
      domain: input.domain,
      weaponAttacks: input.weaponAttacks,
      permanentItemEffects: input.permanentItemEffects,
      dataSource: input.dataSource,
      effectCatalog: input.effectCatalog,
    },
    character,
    input.dto.itemSlug,
    input.dto.mode,
  );

  if (input.dto.grazeMiss) {
    if (attack.grazeOnMissDamage == null) {
      throw new BadRequestException(
        `Weapon '${input.dto.itemSlug}' has no active Graze mastery`,
      );
    }
    const modifier = attack.grazeOnMissDamage;
    return {
      kind: 'damage',
      label: `Dano no erro — ${attack.itemName} (Resvalar)`,
      expression: `${modifier}`,
      total: modifier,
      modifier,
      critical: false,
      rolls: [],
    };
  }

  const featEffects = await input.effectCatalog.load({
    ownerKind: 'feat',
    ownerSlugs: featSlugs,
  });
  if (input.dto.haftBonusAttack) {
    try {
      assertPolearmHaftBonusAttack({
        featSlugs,
        mode: input.dto.mode,
        itemSlug: input.dto.itemSlug,
      });
    } catch (error) {
      throw new BadRequestException(
        error instanceof Error ? error.message : 'Golpe de Haste inválido',
      );
    }
  }
  const damageDice = input.dto.haftBonusAttack ? '1d4' : attack.damageDice;
  const dieOpts = {
    critical: input.dto.critical,
    treatOnesAndTwosAsThree:
      !input.dto.haftBonusAttack && attack.greatWeaponFighting,
    // GWF (1–2→3) already covers floor; don't also apply Elemental Adept 1→2.
    treatOnesAsTwos:
      (!attack.greatWeaponFighting &&
        !input.dto.haftBonusAttack &&
        hasDamageDieFloor(featEffects, featSlugs)) ||
      Boolean(input.dto.damageDieFloor),
    flipLowestDie:
      hasDamageDieFlip(featEffects, featSlugs) &&
      Boolean(input.dto.damageDieFlip),
    explodeOnMax:
      hasDamageDieExplode(featEffects, featSlugs) &&
      Boolean(input.dto.damageDieExplode),
  };
  const base = rollDamageParts(damageDice, attack.damageBonus, dieOpts);
  const alternateBase = input.dto.savageAttacker
    ? rollDamageParts(damageDice, attack.damageBonus, dieOpts)
    : null;
  const acc = createDamageAccumulator(
    base.total,
    base.expression,
    base.dice[0]?.rolls ?? [],
  );
  noteRageBonus(acc, attack.rageDamageBonus);
  if (input.dto.haftBonusAttack) {
    acc.notes.push(
      'Golpe de Haste (PAM): 1d4 Contundente + mod (ação bônus após Atacar).',
    );
  }
  if (alternateBase) {
    acc.notes.push(
      'Atacante Selvagem: escolha entre esta rolagem e alternateRolls[0] (1×/turno).',
    );
  }
  if (input.dto.chargerStrike) {
    if (input.dto.mode !== 'melee') {
      throw new BadRequestException(
        'Investida (Charger) exige ataque corpo a corpo',
      );
    }
    if (!featSlugs.includes('charger')) {
      throw new BadRequestException(
        'Investida (Charger) exige o talento Agressor',
      );
    }
    addDamagePart(acc, '1d8', { critical: input.dto.critical });
    acc.notes.push(
      'Investida (Charger): +1d8 (desligue o toggle apos o uso).',
    );
  }

  const mechanical = await input.mechanicalCatalog.load();
  const ctx = {
    character,
    attack,
    combatFlags,
    dto: input.dto,
    domain: input.domain,
    resourceSpender: input.resourceSpender,
    cunningStrikeEffects: mechanical.cunningStrikeEffects,
    dungeoneerSlayerLabels: mechanical.dungeoneerSlayerLabels,
    featureSchedules: featureSchedulesFromCatalog(
      mechanical,
      character.classSlug,
      character.subclassSlug,
    ),
    featureGatesBySubclassSlug: mechanical.featureGatesBySubclassSlug,
    eldritchInvocationSlugs,
  };
  for (const effect of DAMAGE_EFFECT_PIPELINE) {
    await effect(ctx, acc);
  }

  return buildDamageRollResponse({
    attack,
    dto: input.dto,
    acc,
    modifier: base.modifier,
    critical: base.critical,
    kept: base.dice[0]?.kept,
    alternateRolls: alternateBase
      ? [
          {
            expression: alternateBase.expression,
            total: alternateBase.total,
            rolls: alternateBase.dice[0]?.rolls ?? [],
          },
        ]
      : undefined,
  });
}
