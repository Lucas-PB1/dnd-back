import { BadRequestException } from '@nestjs/common';
import type { DataSource } from 'typeorm';
import type { CharacterResourceSpender } from '../../../session/domain/character-resource-spender';
import type { CharacterDomainService } from '../../../sheet/domain/core/character-domain.service';
import type { CharacterSheetRepository } from '../../../sheet/infrastructure/character-sheet.repository';
import type { ResolveEquippedWeaponAttacks } from '../../../combat/application/resolve-equipped-weapon-attacks';
import type { PlayerCharacterAccessService } from '../../../shared/player-character-access.service';
import { rollDamageParts } from '../../domain/dice';
import type {
  CharacterRollResponseDto,
  RollDamageDto,
} from '../../dto/character-roll.dto';
import type { ResolveActivePermanentItemEffects } from '../../../inventory/application/resolve-active-permanent-item-effects';
import {
  findEquippedWeaponAttack,
  loadAccessibleCharacter,
} from './roll-weapon-context';
import { createDamageAccumulator } from './damage/damage-accumulator';
import { buildDamageRollResponse } from './damage/damage-response';
import { noteRageBonus } from './damage/apply-weapon-extras';
import { DAMAGE_EFFECT_PIPELINE } from './damage/pipeline';

export async function executeRollDamage(input: {
  access: PlayerCharacterAccessService;
  sheet: CharacterSheetRepository;
  domain: CharacterDomainService;
  weaponAttacks: ResolveEquippedWeaponAttacks;
  permanentItemEffects: ResolveActivePermanentItemEffects;
  dataSource: DataSource;
  resourceSpender: CharacterResourceSpender;
  userId: string;
  characterId: string;
  dto: RollDamageDto;
}): Promise<CharacterRollResponseDto> {
  const character = await loadAccessibleCharacter(
    input.access,
    input.userId,
    input.characterId,
  );
  const { attack, combatFlags } = await findEquippedWeaponAttack(
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
      label: `Dano no erro — ${attack.itemName} (Garantido)`,
      expression: `${modifier}`,
      total: modifier,
      modifier,
      critical: false,
      rolls: [],
    };
  }

  const base = rollDamageParts(attack.damageDice, attack.damageBonus, {
    critical: input.dto.critical,
    treatOnesAndTwosAsThree: attack.greatWeaponFighting,
  });
  const acc = createDamageAccumulator(
    base.total,
    base.expression,
    base.dice[0]?.rolls ?? [],
  );
  noteRageBonus(acc, attack.rageDamageBonus);

  const ctx = {
    character,
    attack,
    combatFlags,
    dto: input.dto,
    domain: input.domain,
    resourceSpender: input.resourceSpender,
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
  });
}
