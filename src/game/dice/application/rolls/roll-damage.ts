import { BadRequestException } from '@nestjs/common';
import type { DataSource } from 'typeorm';
import type { CharacterDomainService } from '../../../sheet/domain/core/character-domain.service';
import type { CharacterSheetRepository } from '../../../sheet/infrastructure/character-sheet.repository';
import type { ResolveEquippedWeaponAttacks } from '../../../combat/application/resolve-equipped-weapon-attacks';
import type { PlayerCharacterAccessService } from '../../../shared/player-character-access.service';
import { rollDamageParts } from '../../domain/dice';
import type { CharacterRollResponseDto, RollDamageDto } from '../../dto/character-roll.dto';
import type { ResolveActivePermanentItemEffects } from '../../../inventory/application/resolve-active-permanent-item-effects';
import {
  findEquippedWeaponAttack,
  loadAccessibleCharacter,
} from './roll-weapon-context';

export async function executeRollDamage(input: {
  access: PlayerCharacterAccessService;
  sheet: CharacterSheetRepository;
  domain: CharacterDomainService;
  weaponAttacks: ResolveEquippedWeaponAttacks;
  permanentItemEffects: ResolveActivePermanentItemEffects;
  dataSource: DataSource;
  userId: string;
  characterId: string;
  dto: RollDamageDto;
}): Promise<CharacterRollResponseDto> {
  const character = await loadAccessibleCharacter(
    input.access,
    input.userId,
    input.characterId,
  );
  const attack = await findEquippedWeaponAttack(
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

  const result = rollDamageParts(attack.damageDice, attack.damageBonus, {
    critical: input.dto.critical,
    treatOnesAndTwosAsThree: attack.greatWeaponFighting,
  });
  let total = result.total;
  let expression = result.expression;
  const rolls = [...(result.dice[0]?.rolls ?? [])];
  const notes: string[] = [];

  if (attack.overkillExtraDice) {
    const extra = rollDamageParts(attack.overkillExtraDice, 0, {
      critical: input.dto.critical,
    });
    total += extra.total;
    expression = `${expression}+${extra.expression}`;
    rolls.push(...(extra.dice[0]?.rolls ?? []));
  }

  if (
    input.dto.sightedReroll &&
    attack.masteryActive &&
    attack.masterySlug === 'sighted' &&
    rolls.length > 0
  ) {
    const idx = rolls.indexOf(Math.min(...rolls));
    const reroll = rollDamageParts(`1d${attack.damageDice.replace(/^\d+d/i, '').replace(/[+-].*$/, '') || '8'}`, 0);
    const newFace = reroll.dice[0]?.rolls[0] ?? rolls[idx];
    total = total - rolls[idx] + newFace;
    rolls[idx] = newFace;
    notes.push('Mira: dado rerrolado');
  }

  if (
    input.dto.headShot &&
    input.dto.critical &&
    character.classSlug === 'gunslinger' &&
    character.level >= 20
  ) {
    const head = rollDamageParts('10d10', 0, { critical: false });
    total += head.total;
    expression = `${expression}+${head.expression}`;
    rolls.push(...(head.dice[0]?.rolls ?? []));
    notes.push('Tiro na cabeça: morte se <100 PV; senão +10d10');
  }

  return {
    kind: 'damage',
    label: `Dano — ${attack.itemName}${input.dto.critical ? ' (crítico)' : ''}${attack.greatWeaponFighting ? ' (GWF)' : ''}${attack.overkillExtraDice ? ' (Exagero)' : ''}${input.dto.headShot ? ' (Tiro na cabeça)' : ''}`,
    expression,
    total,
    modifier: result.modifier,
    critical: result.critical,
    rolls,
    kept: result.dice[0]?.kept,
    note: notes.length > 0 ? notes.join(' · ') : undefined,
  };
}
