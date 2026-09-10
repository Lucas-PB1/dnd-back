import { Injectable } from '@nestjs/common';
import { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import { ResolveEquippedArmorClass } from '@game/combat/application/resolve-equipped-armor-class';
import { ResolveEquippedWeaponAttacks } from '@game/combat/application/resolve-equipped-weapon-attacks';
import {
  BLOOD_STRIKE_RESOURCE_SLUG,
  BLOOD_STRIKE_TABLE_ACTION,
  attacksPerAction,
  canTakeLowerBloodCost,
  canUseBloodArmament,
  canUseBloodExplosion,
  hasTacticalMaster,
  isBloodHoundSubclass,
  isFighterClass,
} from '@game/combat/domain/fighter';
import {
  findStrikeOptionForTableAction,
  strikeSaveDc,
} from '@game/combat/domain/strike-option';
import { LoadEffectCatalog } from '@game/effects';
import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import { BLOOD_STRIKE_OPTION_KEY_RE } from '@game/sheet/domain/validation/class-options/subclass-option-effects';
import { collectFightingStyleSlugsFromSubclassOptions } from '@game/sheet/domain/validation/class-options/fighting-style-feat-options';
import { collectMasteredWeaponSlugs } from '@game/sheet/domain/validation/class-options/class-weapon-mastery-slots';
import { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type {
  DuelBloodStrikePanelDto,
  DuelFighterPanelDto,
  DuelWeaponOptionDto,
} from '../dto/duel.dto';
import type { Duel } from '../infrastructure/duel.entity';
import type { DuelMember } from '../infrastructure/duel-member.entity';
import { characterSeesInMagicalDarkness } from '../domain/duel-combat-gates';
import { hitPointsOf } from './to-dto';

@Injectable()
export class DuelCombatSnapshot {
  constructor(
    private readonly armorClass: ResolveEquippedArmorClass,
    private readonly weaponAttacks: ResolveEquippedWeaponAttacks,
    private readonly domain: CharacterDomainService,
    private readonly state: CharacterStateRepository,
    private readonly sheet: CharacterSheetRepository,
    private readonly mechanicalCatalog: LoadCombatMechanicalCatalog,
    private readonly effectCatalog: LoadEffectCatalog,
  ) {}

  private async loadFeatCombatContext(characterId: string): Promise<{
    featSlugs: string[];
    fightingStyleSlugs: string[];
    featEffects: Awaited<ReturnType<LoadEffectCatalog['load']>>;
    masteredWeaponSlugs: string[];
  }> {
    const sheet = await this.sheet.load(characterId);
    const featSlugs = sheet.characterFeats.map((f) => f.featSlug);
    const fightingStyleSlugs = collectFightingStyleSlugsFromSubclassOptions(
      sheet.subclassOptions,
    );
    const featEffects = await this.effectCatalog.load({
      ownerKind: 'feat',
      ownerSlugs: featSlugs,
    });
    return {
      featSlugs,
      fightingStyleSlugs,
      featEffects,
      masteredWeaponSlugs: collectMasteredWeaponSlugs({
        classOptions: sheet.classOptions,
        featOptions: sheet.featOptions,
      }),
    };
  }

  async resolveArmorByCharacter(
    characters: PlayerCharacter[],
  ): Promise<Map<string, number>> {
    const map = new Map<string, number>();
    await Promise.all(
      characters.map(async (character) => {
        const ctx = await this.loadFeatCombatContext(character.id);
        const { armorClass } = await this.armorClass.resolve(
          character.id,
          character.abilityScores,
          {
            classSlug: character.classSlug,
            subclassSlug: character.subclassSlug,
            featSlugs: ctx.featSlugs,
            fightingStyleSlugs: ctx.fightingStyleSlugs,
            featEffects: ctx.featEffects,
          },
        );
        map.set(character.id, armorClass);
      }),
    );
    return map;
  }

  async resolveVitalsByCharacter(
    characters: PlayerCharacter[],
    members?: DuelMember[],
  ): Promise<
    Map<
      string,
      {
        tempHp: number;
        conditions: string[];
        hitPointsCurrent?: number;
        hitPointsMax?: number;
      }
    >
  > {
    const membersByCharacter = new Map(
      (members ?? []).map((m) => [m.characterId, m]),
    );
    const map = new Map<
      string,
      {
        tempHp: number;
        conditions: string[];
        hitPointsCurrent?: number;
        hitPointsMax?: number;
      }
    >();
    await Promise.all(
      characters.map(async (character) => {
        const member = membersByCharacter.get(character.id);
        if (member != null && member.hitPointsCurrent != null) {
          map.set(character.id, {
            tempHp: member.tempHp ?? 0,
            conditions: member.conditions ?? [],
            hitPointsCurrent: member.hitPointsCurrent,
            hitPointsMax: member.hitPointsMax ?? hitPointsOf(character).max,
          });
          return;
        }
        const state = await this.state.buildResponse(character);
        map.set(character.id, {
          tempHp: state.tempHp ?? 0,
          conditions: state.conditions ?? [],
        });
      }),
    );
    return map;
  }

  async resolveWeaponsFor(
    character: PlayerCharacter | undefined,
  ): Promise<DuelWeaponOptionDto[]> {
    if (!character) return [];
    const proficiencyBonus = await this.domain.getProficiencyBonus(
      character.level,
    );
    const ctx = await this.loadFeatCombatContext(character.id);
    const attacks = await this.weaponAttacks.resolve(
      character.id,
      character.abilityScores,
      {
        classSlug: character.classSlug,
        subclassSlug: character.subclassSlug,
        level: character.level,
        proficiencyBonus,
        featSlugs: ctx.featSlugs,
        fightingStyleSlugs: ctx.fightingStyleSlugs,
        featEffects: ctx.featEffects,
        masteredWeaponSlugs: ctx.masteredWeaponSlugs,
      },
    );
    return attacks.map((attack) => ({
      itemSlug: attack.itemSlug,
      itemName: attack.itemName,
      mode: attack.mode,
      attackBonus: attack.attackBonus,
      masterySlug: attack.masterySlug,
    }));
  }

  async hasNickMasteryWeapon(
    character: PlayerCharacter | undefined,
  ): Promise<boolean> {
    if (!character || !isFighterClass(character.classSlug)) return false;
    const weapons = await this.resolveWeaponsFor(character);
    return weapons.some((w) => w.masterySlug === 'nick');
  }

  async resolveTurnAttackBudget(
    character: PlayerCharacter | undefined,
  ): Promise<number> {
    if (!character) return 1;
    if (!isFighterClass(character.classSlug)) return 1;
    const nick = await this.hasNickMasteryWeapon(character);
    return attacksPerAction(character.level) + (nick ? 1 : 0);
  }

  async resolveBloodStrikePanel(
    character: PlayerCharacter | undefined,
  ): Promise<DuelBloodStrikePanelDto | null> {
    if (!character || !isBloodHoundSubclass(character.subclassSlug)) {
      return null;
    }
    if (character.level < 3) {
      return {
        available: false,
        remaining: 0,
        max: 0,
        saveDc: 8,
        options: [],
        canTakeLowerCost: false,
        canArmament: false,
        canExplosion: false,
      };
    }

    const [sheet, state, proficiencyBonus, catalog] = await Promise.all([
      this.sheet.load(character.id),
      this.state.buildResponse(character),
      this.domain.getProficiencyBonus(character.level),
      this.mechanicalCatalog.load(),
    ]);
    const resource = state.classResources.find(
      (row) => row.slug === BLOOD_STRIKE_RESOURCE_SLUG,
    );
    const knownSlugs = (sheet.subclassOptions ?? [])
      .filter((opt) => BLOOD_STRIKE_OPTION_KEY_RE.test(opt.optionKey))
      .map((opt) => opt.valueId);

    const options = knownSlugs
      .map((slug) =>
        findStrikeOptionForTableAction(
          catalog.strikeOptions,
          slug,
          BLOOD_STRIKE_TABLE_ACTION,
        ),
      )
      .filter((row): row is NonNullable<typeof row> => Boolean(row?.costDice))
      .map((row) => ({
        slug: row.slug,
        label: row.name,
        costDice: row.costDice!,
      }));

    const conMod = abilityModifier(character.abilityScores.constituicao);
    return {
      available: options.length > 0 && (resource?.remaining ?? 0) > 0,
      remaining: resource?.remaining ?? 0,
      max: resource?.max ?? 0,
      saveDc: strikeSaveDc(conMod, proficiencyBonus),
      options,
      canTakeLowerCost: canTakeLowerBloodCost(character.level),
      canArmament: canUseBloodArmament(character.level),
      canExplosion: canUseBloodExplosion(character.level),
    };
  }

  async resolveFighterPanel(
    character: PlayerCharacter | undefined,
    duel: Duel,
  ): Promise<DuelFighterPanelDto | null> {
    if (!character || !isFighterClass(character.classSlug)) {
      return null;
    }
    const state = await this.state.buildResponse(character);
    const resourceOf = (slug: string) =>
      state.classResources.find((row) => row.slug === slug);
    const secondWind = resourceOf('secondWind');
    const actionSurge = resourceOf('actionSurge');
    const indomitable = resourceOf('indomitable');
    const budget = await this.resolveTurnAttackBudget(character);
    return {
      available: true,
      attacksPerAction: budget,
      turnAttacksRemaining: duel.turnAttacksRemaining,
      tacticalMaster: hasTacticalMaster(character.level),
      secondWindRemaining: secondWind?.remaining ?? 0,
      secondWindMax: secondWind?.max ?? 0,
      actionSurgeRemaining: actionSurge?.remaining ?? 0,
      actionSurgeMax: actionSurge?.max ?? 0,
      indomitableRemaining: indomitable?.remaining ?? 0,
      indomitableMax: indomitable?.max ?? 0,
    };
  }

  async buildMaps(input: {
    members: DuelMember[];
    charactersById: Map<string, PlayerCharacter>;
    viewerUserId: string;
    duel: Duel;
  }): Promise<{
    armorByCharacterId: Map<string, number>;
    vitalsByCharacterId: Map<
      string,
      {
        tempHp: number;
        conditions: string[];
        hitPointsCurrent?: number;
        hitPointsMax?: number;
      }
    >;
    myWeapons: DuelWeaponOptionDto[];
    mySpells: { spellSlug: string; listType: string }[];
    bloodStrike: DuelBloodStrikePanelDto | null;
    fighter: DuelFighterPanelDto | null;
    seesInMagicalDarkness: boolean;
  }> {
    const characters = [...input.charactersById.values()];
    const [armorByCharacterId, vitalsByCharacterId] = await Promise.all([
      this.resolveArmorByCharacter(characters),
      this.resolveVitalsByCharacter(
        characters,
        input.duel.status === 'active' ? input.members : undefined,
      ),
    ]);
    const mine = input.members.find((m) => m.userId === input.viewerUserId);
    const myCharacter = mine
      ? input.charactersById.get(mine.characterId)
      : undefined;
    const myWeapons = await this.resolveWeaponsFor(myCharacter);
    let mySpells: { spellSlug: string; listType: string }[] = [];
    let seesInMagicalDarkness = false;
    let bloodStrike: DuelBloodStrikePanelDto | null = null;
    let fighter: DuelFighterPanelDto | null = null;
    if (mine) {
      const sheet = await this.sheet.load(mine.characterId);
      mySpells = sheet.characterSpells.map((spell) => ({
        spellSlug: spell.spellSlug,
        listType: spell.listType,
      }));
      seesInMagicalDarkness = characterSeesInMagicalDarkness({
        classOptions: sheet.classOptions,
      });
      bloodStrike = await this.resolveBloodStrikePanel(myCharacter);
      fighter = await this.resolveFighterPanel(myCharacter, input.duel);
    }
    return {
      armorByCharacterId,
      vitalsByCharacterId,
      myWeapons,
      mySpells,
      bloodStrike,
      fighter,
      seesInMagicalDarkness,
    };
  }
}
