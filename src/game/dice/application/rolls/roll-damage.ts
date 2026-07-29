import { BadRequestException } from '@nestjs/common';
import type { DataSource } from 'typeorm';
import {
  divineFuryExtraDice,
  hasDivineFury,
} from '../../../combat/domain/barbarian-rage';
import {
  DUNGEONEER_SLAYER_TYPES,
  psiEnergyDieFaces,
  superiorityDieFaces,
} from '../../../combat/domain/fighter-features';
import { abilityModifier } from '../../../sheet/domain/stats/ability-modifier';
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

  const result = rollDamageParts(attack.damageDice, attack.damageBonus, {
    critical: input.dto.critical,
    treatOnesAndTwosAsThree: attack.greatWeaponFighting,
  });
  let total = result.total;
  let expression = result.expression;
  const rolls = [...(result.dice[0]?.rolls ?? [])];
  const notes: string[] = [];

  if (attack.rageDamageBonus > 0) {
    notes.push(`Fúria +${attack.rageDamageBonus}`);
  }

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
    const reroll = rollDamageParts(
      `1d${attack.damageDice.replace(/^\d+d/i, '').replace(/[+-].*$/, '') || '8'}`,
      0,
    );
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

  if (
    input.dto.brutalStrike &&
    attack.brutalStrikeDice &&
    input.dto.mode === 'melee' &&
    attack.abilitySlug === 'forca'
  ) {
    const brutal = rollDamageParts(attack.brutalStrikeDice, 0, {
      critical: input.dto.critical,
    });
    total += brutal.total;
    expression = `${expression}+${brutal.expression}`;
    rolls.push(...(brutal.dice[0]?.rolls ?? []));
    notes.push(
      'Golpe Brutal: efeito à escolha (empurrão/lentidão — narrativo); sem vantagem do Imprudente neste ataque',
    );
  }

  if (
    input.dto.divineFury &&
    combatFlags.rageActive &&
    hasDivineFury({
      subclassSlug: character.subclassSlug,
      level: character.level,
    })
  ) {
    const dice = divineFuryExtraDice(character.level);
    const divine = rollDamageParts(dice, 0, { critical: false });
    total += divine.total;
    expression = `${expression}+${divine.expression}`;
    rolls.push(...(divine.dice[0]?.rolls ?? []));
    notes.push('Fúria Divina (Necrótico ou Radiante, à escolha)');
  }

  if (
    input.dto.psiStrike &&
    character.subclassSlug === 'psi-warrior' &&
    character.level >= 3
  ) {
    const faces = psiEnergyDieFaces(character.level);
    if (faces != null) {
      const intMod = abilityModifier(character.abilityScores.inteligencia);
      const psi = rollDamageParts(`1d${faces}+${intMod}`, 0, {
        critical: false,
      });
      total += psi.total;
      expression = `${expression}+${psi.expression}`;
      rolls.push(...(psi.dice[0]?.rolls ?? []));
      const telekineticThrust =
        character.level >= 7
          ? `; Estocada Telecinética CD ${8 + (await input.domain.getProficiencyBonus(character.level)) + intMod}: Caído ou mova 3 m`
          : '';
      notes.push(
        `Golpe Psiônico: dano Energético (1 Dado de Energia Psiônica gasto na ficha)${telekineticThrust}`,
      );
    }
  }

  if (
    input.dto.monsterSlayer &&
    character.subclassSlug === 'dungeoneer' &&
    character.level >= 10
  ) {
    const slayer = rollDamageParts('1d10', 0, {
      critical: input.dto.critical,
    });
    total += slayer.total;
    expression = `${expression}+${slayer.expression}`;
    rolls.push(...(slayer.dice[0]?.rolls ?? []));
    notes.push(
      `Matar Monstro: +1d10 vs ${DUNGEONEER_SLAYER_TYPES.join(', ')} (1×/turno)`,
    );
  }

  if (
    input.dto.precisionAttack &&
    character.subclassSlug === 'battle-master' &&
    character.level >= 3
  ) {
    const faces = superiorityDieFaces(character.level);
    if (faces != null) {
      const precision = rollDamageParts(`1d${faces}`, 0, { critical: false });
      total += precision.total;
      expression = `${expression}+${precision.expression}`;
      rolls.push(...(precision.dice[0]?.rolls ?? []));
      notes.push(
        'Ataque Preciso / manobra: Dado de Superioridade (gaste 1 uso)',
      );
    }
  }

  const labelExtras = [
    input.dto.critical ? ' (crítico)' : '',
    attack.greatWeaponFighting ? ' (GWF)' : '',
    attack.overkillExtraDice ? ' (Exagero)' : '',
    input.dto.headShot ? ' (Tiro na cabeça)' : '',
    input.dto.brutalStrike ? ' (Golpe Brutal)' : '',
    input.dto.divineFury ? ' (Fúria Divina)' : '',
    input.dto.psiStrike ? ' (Golpe Psiônico)' : '',
    input.dto.monsterSlayer ? ' (Matar Monstro)' : '',
    input.dto.precisionAttack ? ' (Superioridade)' : '',
  ].join('');

  return {
    kind: 'damage',
    label: `Dano — ${attack.itemName}${labelExtras}`,
    expression,
    total,
    modifier: result.modifier,
    critical: result.critical,
    rolls,
    kept: result.dice[0]?.kept,
    note: notes.length > 0 ? notes.join(' · ') : undefined,
  };
}
