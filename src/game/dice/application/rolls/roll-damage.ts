import { BadRequestException } from '@nestjs/common';
import type { DataSource } from 'typeorm';
import {
  divineFuryExtraDice,
  hasDivineFury,
} from '../../../combat/domain/barbarian-rage';
import {
  DUNGEONEER_SLAYER_TYPES,
  psiEnergyDieFaces,
} from '../../../combat/domain/fighter-features';
import {
  cunningStrikeSaveDc,
  sneakAttackDieFaces,
  validateCunningStrikeSelection,
} from '../../../combat/domain/rogue-features';
import { divineSmiteDice } from '../../../combat/domain/paladin-features';
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

  const cunningStrikeEffects = input.dto.cunningStrikeEffects ?? [];
  if (
    (input.dto.sneakAttack ||
      cunningStrikeEffects.length > 0 ||
      input.dto.poisonousSneak ||
      input.dto.assassinSurprise ||
      input.dto.assassinDeathStrike ||
      input.dto.assassinPoisonFailedSave) &&
    character.classSlug !== 'rogue'
  ) {
    throw new BadRequestException('Rogue damage options require Rogue class');
  }
  if (cunningStrikeEffects.length > 0 && !input.dto.sneakAttack) {
    throw new BadRequestException('Cunning Strike requires Sneak Attack');
  }
  if (
    (input.dto.poisonousSneak ||
      input.dto.assassinSurprise ||
      input.dto.assassinDeathStrike ||
      input.dto.assassinPoisonFailedSave) &&
    !input.dto.sneakAttack
  ) {
    throw new BadRequestException(
      'This subclass damage option requires Sneak Attack',
    );
  }

  if (input.dto.sneakAttack) {
    if (!attack.sneakAttackEligible) {
      throw new BadRequestException(
        'Sneak Attack requires a Finesse weapon or a ranged attack',
      );
    }

    let selection: ReturnType<typeof validateCunningStrikeSelection>;
    try {
      selection = validateCunningStrikeSelection({
        level: character.level,
        subclassSlug: character.subclassSlug,
        effectSlugs: cunningStrikeEffects,
      });
    } catch (error) {
      throw new BadRequestException(
        error instanceof Error ? error.message : 'Invalid Cunning Strike',
      );
    }

    if (
      input.dto.poisonousSneak &&
      character.subclassSlug !== 'arachnoid-stalker'
    ) {
      throw new BadRequestException(
        'Poisonous Strike requires Arachnoid Stalker',
      );
    }
    if (
      selection.effects.some((effect) => effect.slug === 'paralyze') &&
      !input.dto.poisonousSneak
    ) {
      throw new BadRequestException(
        'Paralyze requires Poisonous Strike damage',
      );
    }

    const dieFaces = sneakAttackDieFaces(
      character.subclassSlug,
      input.dto.poisonousSneak,
    );
    if (selection.remainingSneakAttackDice > 0) {
      const sneak = rollDamageParts(
        `${selection.remainingSneakAttackDice}d${dieFaces}`,
        0,
        { critical: input.dto.critical },
      );
      total += sneak.total;
      expression = `${expression}+${sneak.expression}`;
      rolls.push(...(sneak.dice[0]?.rolls ?? []));
    }

    const pb = await input.domain.getProficiencyBonus(character.level);
    const saveDc = cunningStrikeSaveDc({
      dexterityModifier: abilityModifier(character.abilityScores.destreza),
      proficiencyBonus: pb,
    });
    notes.push(
      `Ataque Furtivo: ${selection.remainingSneakAttackDice}d${dieFaces}${input.dto.critical ? ' dobrado no crítico' : ''}`,
    );
    for (const effect of selection.effects) {
      notes.push(
        `${effect.name} (custo ${effect.cost}d): ${effect.note}${
          effect.saveAbility ? ` CD ${saveDc}` : ''
        }`,
      );
    }

    if (input.dto.assassinSurprise) {
      if (character.subclassSlug !== 'assassin' || character.level < 3) {
        throw new BadRequestException(
          'Surprising Strikes requires Assassin level 3',
        );
      }
      total += character.level;
      expression = `${expression}+${character.level}`;
      notes.push(
        `Golpe Surpreendente: +${character.level} de dano da arma na primeira rodada`,
      );
    }

    if (input.dto.assassinPoisonFailedSave) {
      if (
        character.subclassSlug !== 'assassin' ||
        character.level < 13 ||
        !selection.effects.some((effect) => effect.slug === 'poison')
      ) {
        throw new BadRequestException(
          'Poison Weapons requires Assassin level 13 and Poison Cunning Strike',
        );
      }
      const poison = rollDamageParts('2d6', 0);
      total += poison.total;
      expression = `${expression}+${poison.expression}`;
      rolls.push(...(poison.dice[0]?.rolls ?? []));
      notes.push(
        'Armas Venenosas: +2d6 Venenoso; ignora Resistência a Venenoso',
      );
    }

    if (input.dto.assassinDeathStrike) {
      if (
        character.subclassSlug !== 'assassin' ||
        character.level < 17
      ) {
        throw new BadRequestException(
          'Death Strike requires Assassin level 17',
        );
      }
      total *= 2;
      expression = `2×(${expression})`;
      notes.push(
        `Golpe Mortal: dano dobrado após falha em Constituição CD ${saveDc}`,
      );
    }
  }

  if (character.classSlug === 'paladin' && input.dto.divineSmite) {
    if (input.dto.mode !== 'melee') {
      throw new BadRequestException('Divine Smite requires a melee attack');
    }
    const slotLevel = input.dto.smiteSlotLevel ?? 1;
    await debitSpellSlot(input.dataSource, character, slotLevel);
    const dice = divineSmiteDice({
      slotLevel,
      vsUndeadOrFiend: input.dto.smiteVsUndeadOrFiend,
    });
    const smite = rollDamageParts(dice, 0, { critical: input.dto.critical });
    total += smite.total;
    expression = `${expression}+${smite.expression}`;
    rolls.push(...(smite.dice[0]?.rolls ?? []));
    notes.push(
      `Destruição Divina: ${dice} Radiante (espaço de ${slotLevel}º círculo gasto)`,
    );
  } else if (input.dto.divineSmite) {
    throw new BadRequestException('Divine Smite requires Paladin class');
  }

  if (
    character.classSlug === 'paladin' &&
    character.level >= 11 &&
    input.dto.mode === 'melee'
  ) {
    const radiant = rollDamageParts('1d8', 0, { critical: input.dto.critical });
    total += radiant.total;
    expression = `${expression}+${radiant.expression}`;
    rolls.push(...(radiant.dice[0]?.rolls ?? []));
    notes.push('Golpes Radiantes: +1d8 Radiante');
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
    input.dto.sneakAttack ? ' (Ataque Furtivo)' : '',
    input.dto.divineSmite ? ' (Destruição Divina)' : '',
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

/** Debita um espaço de magia da classe para a Destruição Divina. */
async function debitSpellSlot(
  dataSource: DataSource,
  character: { id: string; classSlug: string; level: number },
  slotLevel: number,
): Promise<void> {
  const slotRows = await dataSource.query<{ spell_slots: Record<string, number> }[]>(
    `SELECT spell_slots FROM rpg.v_class_spell_slots
     WHERE class_slug = $1 AND class_level = $2 LIMIT 1`,
    [character.classSlug, character.level],
  );
  const maxSlots = slotRows[0]?.spell_slots ?? {};
  const key = String(slotLevel);
  const max = maxSlots[key] ?? 0;
  if (max <= 0) {
    throw new BadRequestException(
      `No level-${slotLevel} spell slots available for this class`,
    );
  }

  const stateRows = await dataSource.query<
    { spell_slots_used: Record<string, number> }[]
  >(
    `SELECT spell_slots_used FROM rpg.player_character_state WHERE character_id = $1`,
    [character.id],
  );
  const used = stateRows[0]?.spell_slots_used ?? {};
  if ((used[key] ?? 0) >= max) {
    throw new BadRequestException(`No remaining level-${slotLevel} spell slots`);
  }
  const nextUsed = { ...used, [key]: (used[key] ?? 0) + 1 };
  await dataSource.query(
    `INSERT INTO rpg.player_character_state (character_id, spell_slots_used)
     VALUES ($1, $2::jsonb)
     ON CONFLICT (character_id)
     DO UPDATE SET spell_slots_used = $2::jsonb`,
    [character.id, JSON.stringify(nextUsed)],
  );
}
