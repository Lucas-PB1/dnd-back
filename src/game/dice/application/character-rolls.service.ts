import { BadRequestException, Injectable } from '@nestjs/common';
import { DataSource } from 'typeorm';
import { PlayerCharacterAccessService } from '../../shared/player-character-access.service';
import { CharacterDomainService } from '../../sheet/domain/character-domain.service';
import {
  collectSaveProficiencyAbilities,
  initiativeBonus,
  skillCheckBonus,
  skillProficiencyRank,
} from '../../sheet/domain/character-check-bonuses';
import { computeAbilityModifiers } from '../../sheet/domain/character-derived-stats';
import { collectFightingStyleSlugsFromSubclassOptions } from '../../sheet/domain/fighting-style-feat-options';
import { collectMasteredWeaponSlugs } from '../../sheet/domain/class-weapon-mastery-slots';
import { CharacterSheetRepository } from '../../sheet/infrastructure/character-sheet.repository';
import { EquippedWeaponAttacksService } from '../../sheet/infrastructure/equipped-weapon-attacks.service';
import type { AbilityKey } from '../../build/domain/ability-generation';
import {
  rollD20Check,
  rollDamageParts,
  type AdvantageMode,
} from '../domain/dice';
import {
  CharacterRollResponseDto,
  RollAttackDto,
  RollDamageDto,
  RollInitiativeDto,
  RollSavingThrowDto,
  RollSkillDto,
} from '../dto/character-roll.dto';

const ABILITY_LABELS: Record<AbilityKey, string> = {
  forca: 'Força',
  destreza: 'Destreza',
  constituicao: 'Constituição',
  inteligencia: 'Inteligência',
  sabedoria: 'Sabedoria',
  carisma: 'Carisma',
};

@Injectable()
export class CharacterRollsService {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly sheet: CharacterSheetRepository,
    private readonly domain: CharacterDomainService,
    private readonly weaponAttacks: EquippedWeaponAttacksService,
    private readonly dataSource: DataSource,
  ) {}

  async rollAttack(
    userId: string,
    characterId: string,
    dto: RollAttackDto,
  ): Promise<CharacterRollResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'read',
    );
    const attack = await this.findWeaponAttack(character, dto.itemSlug, dto.mode);
    let mode: AdvantageMode = dto.advantage ?? 'normal';
    if (attack.attackDisadvantage && mode === 'normal') {
      mode = 'disadvantage';
    }
    const result = rollD20Check(attack.attackBonus, mode);
    return {
      kind: 'attack',
      label: `Ataque — ${attack.itemName} (${dto.mode === 'ranged' ? 'à distância' : 'corpo a corpo'})`,
      expression: result.expression,
      total: result.total,
      modifier: result.modifier,
      mode: result.mode,
      rolls: result.d20.rolls,
      kept: result.d20.kept,
    };
  }

  async rollDamage(
    userId: string,
    characterId: string,
    dto: RollDamageDto,
  ): Promise<CharacterRollResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'read',
    );
    const attack = await this.findWeaponAttack(character, dto.itemSlug, dto.mode);
    if (dto.grazeMiss) {
      if (attack.grazeOnMissDamage == null) {
        throw new BadRequestException(
          `Weapon '${dto.itemSlug}' has no active Graze mastery`,
        );
      }
      const modifier = attack.grazeOnMissDamage;
      return {
        kind: 'damage',
        label: `Dano no erro — ${attack.itemName} (Garantido)`,
        expression: modifier >= 0 ? `${modifier}` : `${modifier}`,
        total: modifier,
        modifier,
        critical: false,
        rolls: [],
      };
    }
    const result = rollDamageParts(attack.damageDice, attack.damageBonus, {
      critical: dto.critical,
      treatOnesAndTwosAsThree: attack.greatWeaponFighting,
    });
    return {
      kind: 'damage',
      label: `Dano — ${attack.itemName}${dto.critical ? ' (crítico)' : ''}${attack.greatWeaponFighting ? ' (GWF)' : ''}`,
      expression: result.expression,
      total: result.total,
      modifier: result.modifier,
      critical: result.critical,
      rolls: result.dice[0]?.rolls ?? [],
      kept: result.dice[0]?.kept,
    };
  }

  async rollSkill(
    userId: string,
    characterId: string,
    dto: RollSkillDto,
  ): Promise<CharacterRollResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'read',
    );
    const skillRows = await this.dataSource.query<
      { slug: string; name: string; ability_slug: string }[]
    >(
      `SELECT s.slug, s.name, a.slug AS ability_slug
       FROM rpg.phb_skill s
       JOIN rpg.phb_ability a ON a.id = s.ability_id
       WHERE s.slug = $1
       LIMIT 1`,
      [dto.skillSlug],
    );
    const skill = skillRows[0];
    if (!skill) {
      throw new BadRequestException(`Unknown skill '${dto.skillSlug}'`);
    }
    const ability = skill.ability_slug as AbilityKey;
    const sheet = await this.sheet.load(character.id, character.backgroundSlug);
    const pb = await this.domain.getProficiencyBonus(character.level);
    const mods = computeAbilityModifiers(character.abilityScores);
    const rank = skillProficiencyRank(dto.skillSlug, {
      classSkillSlugs: sheet.classSkillSlugs,
      backgroundSkillSlugs: sheet.backgroundSkillSlugs,
      speciesChoices: sheet.speciesChoices,
      featOptions: sheet.featOptions,
      classOptions: sheet.classOptions,
      classSlug: character.classSlug,
      level: character.level,
    });
    const bonus = skillCheckBonus(mods[ability], pb, rank);
    const result = rollD20Check(bonus, dto.advantage ?? 'normal');
    return {
      kind: 'skill',
      label: `Perícia — ${skill.name}`,
      expression: result.expression,
      total: result.total,
      modifier: result.modifier,
      mode: result.mode,
      rolls: result.d20.rolls,
      kept: result.d20.kept,
    };
  }

  async rollSavingThrow(
    userId: string,
    characterId: string,
    dto: RollSavingThrowDto,
  ): Promise<CharacterRollResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'read',
    );
    const ability = dto.abilitySlug as AbilityKey;
    const stRows = await this.dataSource.query<{ slug: string }[]>(
      `SELECT a.slug
       FROM rpg.phb_class_saving_throw cst
       JOIN rpg.phb_class c ON c.id = cst.class_id
       JOIN rpg.phb_ability a ON a.id = cst.ability_id
       WHERE c.slug = $1`,
      [character.classSlug],
    );
    const sheet = await this.sheet.load(character.id, character.backgroundSlug);
    const saveProficiencies = new Set(
      collectSaveProficiencyAbilities(
        stRows.map((row) => row.slug),
        sheet.featOptions,
      ),
    );
    const proficient = saveProficiencies.has(ability);
    const pb = await this.domain.getProficiencyBonus(character.level);
    const mods = computeAbilityModifiers(character.abilityScores);
    const bonus = mods[ability] + (proficient ? pb : 0);
    const result = rollD20Check(bonus, dto.advantage ?? 'normal');
    return {
      kind: 'saving_throw',
      label: `Salvaguarda — ${ABILITY_LABELS[ability]}`,
      expression: result.expression,
      total: result.total,
      modifier: result.modifier,
      mode: result.mode,
      rolls: result.d20.rolls,
      kept: result.d20.kept,
    };
  }

  async rollInitiative(
    userId: string,
    characterId: string,
    dto: RollInitiativeDto,
  ): Promise<CharacterRollResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'read',
    );
    const sheet = await this.sheet.load(character.id);
    const pb = await this.domain.getProficiencyBonus(character.level);
    const mods = computeAbilityModifiers(character.abilityScores);
    const bonus = initiativeBonus(
      mods.destreza,
      pb,
      sheet.characterFeats,
    );
    const result = rollD20Check(bonus, dto.advantage ?? 'normal');
    return {
      kind: 'initiative',
      label: 'Iniciativa',
      expression: result.expression,
      total: result.total,
      modifier: result.modifier,
      mode: result.mode,
      rolls: result.d20.rolls,
      kept: result.d20.kept,
    };
  }

  private async findWeaponAttack(
    character: {
      id: string;
      classSlug: string;
      subclassSlug: string | null;
      abilityScores: import('../../shared/infrastructure/player-character.entity').AbilityScores;
      level: number;
    },
    itemSlug: string,
    mode: 'melee' | 'ranged',
  ) {
    const sheet = await this.sheet.load(character.id);
    const pb = await this.domain.getProficiencyBonus(character.level);
    const featSlugs = sheet.characterFeats.map((f) => f.featSlug);
    const fightingStyleSlugs = collectFightingStyleSlugsFromSubclassOptions(
      sheet.subclassOptions,
    );
    const attacks = await this.weaponAttacks.resolve(
      character.id,
      character.abilityScores,
      {
        classSlug: character.classSlug,
        proficiencyBonus: pb,
        featSlugs,
        fightingStyleSlugs,
        masteredWeaponSlugs: collectMasteredWeaponSlugs({
          classOptions: sheet.classOptions,
          featOptions: sheet.featOptions,
        }),
      },
    );
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
}
