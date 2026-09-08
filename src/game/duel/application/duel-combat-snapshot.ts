import { Injectable } from '@nestjs/common';
import { ResolveEquippedArmorClass } from '@game/combat/application/resolve-equipped-armor-class';
import { ResolveEquippedWeaponAttacks } from '@game/combat/application/resolve-equipped-weapon-attacks';
import { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { DuelWeaponOptionDto } from '../dto/duel.dto';
import type { DuelMember } from '../infrastructure/duel-member.entity';
import { characterSeesInMagicalDarkness } from '../domain/duel-combat-gates';

@Injectable()
export class DuelCombatSnapshot {
  constructor(
    private readonly armorClass: ResolveEquippedArmorClass,
    private readonly weaponAttacks: ResolveEquippedWeaponAttacks,
    private readonly domain: CharacterDomainService,
    private readonly state: CharacterStateRepository,
    private readonly sheet: CharacterSheetRepository,
  ) {}

  async resolveArmorByCharacter(
    characters: PlayerCharacter[],
  ): Promise<Map<string, number>> {
    const map = new Map<string, number>();
    await Promise.all(
      characters.map(async (character) => {
        const { armorClass } = await this.armorClass.resolve(
          character.id,
          character.abilityScores,
          {
            classSlug: character.classSlug,
            subclassSlug: character.subclassSlug,
          },
        );
        map.set(character.id, armorClass);
      }),
    );
    return map;
  }

  async resolveVitalsByCharacter(
    characters: PlayerCharacter[],
  ): Promise<Map<string, { tempHp: number; conditions: string[] }>> {
    const map = new Map<string, { tempHp: number; conditions: string[] }>();
    await Promise.all(
      characters.map(async (character) => {
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
    const attacks = await this.weaponAttacks.resolve(
      character.id,
      character.abilityScores,
      {
        classSlug: character.classSlug,
        subclassSlug: character.subclassSlug,
        level: character.level,
        proficiencyBonus,
      },
    );
    return attacks.map((attack) => ({
      itemSlug: attack.itemSlug,
      itemName: attack.itemName,
      mode: attack.mode,
      attackBonus: attack.attackBonus,
    }));
  }

  async buildMaps(input: {
    members: DuelMember[];
    charactersById: Map<string, PlayerCharacter>;
    viewerUserId: string;
  }): Promise<{
    armorByCharacterId: Map<string, number>;
    vitalsByCharacterId: Map<string, { tempHp: number; conditions: string[] }>;
    myWeapons: DuelWeaponOptionDto[];
    mySpells: { spellSlug: string; listType: string }[];
    seesInMagicalDarkness: boolean;
  }> {
    const characters = [...input.charactersById.values()];
    const [armorByCharacterId, vitalsByCharacterId] = await Promise.all([
      this.resolveArmorByCharacter(characters),
      this.resolveVitalsByCharacter(characters),
    ]);
    const mine = input.members.find((m) => m.userId === input.viewerUserId);
    const myCharacter = mine
      ? input.charactersById.get(mine.characterId)
      : undefined;
    const myWeapons = await this.resolveWeaponsFor(myCharacter);
    let mySpells: { spellSlug: string; listType: string }[] = [];
    let seesInMagicalDarkness = false;
    if (mine) {
      const sheet = await this.sheet.load(mine.characterId);
      mySpells = sheet.characterSpells.map((spell) => ({
        spellSlug: spell.spellSlug,
        listType: spell.listType,
      }));
      seesInMagicalDarkness = characterSeesInMagicalDarkness({
        classOptions: sheet.classOptions,
      });
    }
    return {
      armorByCharacterId,
      vitalsByCharacterId,
      myWeapons,
      mySpells,
      seesInMagicalDarkness,
    };
  }
}
