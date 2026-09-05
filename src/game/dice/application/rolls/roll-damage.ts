import { BadRequestException } from '@nestjs/common';
import type { DataSource } from 'typeorm';
import type { CharacterResourceSpender } from '@game/session/domain/character-resource-spender';
import type { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import type { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import type { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import type { ResolveEquippedWeaponAttacks } from '@game/combat/application/resolve-equipped-weapon-attacks';
import type { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { rollDamageParts } from '@game/dice/domain/dice';
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
  const { attack, combatFlags, featSlugs } = await findEquippedWeaponAttack(
    {
      sheet: input.sheet,
      domain: input.domain,
      weaponAttacks: input.weaponAttacks,
      permanentItemEffects: input.permanentItemEffects,
      dataSource: input.dataSource,
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
  const dieOpts = {
    critical: input.dto.critical,
    treatOnesAndTwosAsThree: attack.greatWeaponFighting,
    treatOnesAsTwos:
      hasDamageDieFloor(featEffects, featSlugs) ||
      Boolean(input.dto.damageDieFloor),
    flipLowestDie:
      hasDamageDieFlip(featEffects, featSlugs) &&
      Boolean(input.dto.damageDieFlip),
    explodeOnMax:
      hasDamageDieExplode(featEffects, featSlugs) &&
      Boolean(input.dto.damageDieExplode),
  };
  const base = rollDamageParts(
    attack.damageDice,
    attack.damageBonus,
    dieOpts,
  );
  const alternateBase = input.dto.savageAttacker
    ? rollDamageParts(attack.damageDice, attack.damageBonus, dieOpts)
    : null;
  const acc = createDamageAccumulator(
    base.total,
    base.expression,
    base.dice[0]?.rolls ?? [],
  );
  noteRageBonus(acc, attack.rageDamageBonus);
  if (alternateBase) {
    acc.notes.push(
      'Atacante Selvagem: escolha entre esta rolagem e alternateRolls[0] (1×/turno).',
    );
  }
  if (input.dto.chargerStrike) {
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
