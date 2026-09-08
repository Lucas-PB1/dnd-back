import type {
  DuelCharacterSummaryDto,
  DuelCombatLogEntryDto,
  DuelCombatantDto,
  DuelDetailDto,
  DuelMemberDto,
  DuelSummaryDto,
  DuelWeaponOptionDto,
} from '../dto/duel.dto';
import type { Duel } from '../infrastructure/duel.entity';
import type { DuelMember } from '../infrastructure/duel-member.entity';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';

function toCharacterSummary(
  character: PlayerCharacter | undefined,
  characterId: string,
): DuelCharacterSummaryDto {
  return {
    characterId,
    name: character?.name ?? '—',
    level: character?.level ?? 1,
    classSlug: character?.classSlug ?? '—',
    speciesSlug: character?.speciesSlug ?? null,
  };
}

export function hitPointsOf(character: PlayerCharacter | undefined): {
  current: number;
  max: number;
} {
  const max = character?.hitPointsMax ?? 1;
  const current = character?.hitPointsCurrent ?? max;
  return { current: Math.max(0, current), max: Math.max(1, max) };
}

export function toMemberDto(
  member: DuelMember,
  character: PlayerCharacter | undefined,
): DuelMemberDto {
  const summary = toCharacterSummary(character, member.characterId);
  return {
    userId: member.userId,
    characterId: summary.characterId,
    characterName: summary.name,
    level: summary.level,
    classSlug: summary.classSlug,
    speciesSlug: summary.speciesSlug,
    ready: member.ready,
    initiative: member.initiative,
    joinedAt: member.joinedAt.toISOString(),
  };
}

export function toCombatantDto(
  member: DuelMember,
  character: PlayerCharacter | undefined,
  armorClass: number,
  vitals: { tempHp: number; conditions: string[] },
): DuelCombatantDto {
  const summary = toCharacterSummary(character, member.characterId);
  const hp = hitPointsOf(character);
  return {
    userId: member.userId,
    characterId: summary.characterId,
    characterName: summary.name,
    level: summary.level,
    classSlug: summary.classSlug,
    speciesSlug: summary.speciesSlug,
    ready: member.ready,
    initiative: member.initiative,
    hitPointsCurrent: hp.current,
    hitPointsMax: hp.max,
    armorClass,
    portraitUrl: character?.portraitUrl ?? null,
    tempHp: vitals.tempHp,
    conditions: vitals.conditions,
    joinedAt: member.joinedAt.toISOString(),
  };
}

export function toSummaryDto(
  duel: Duel,
  members: DuelMember[],
  charactersById: Map<string, PlayerCharacter>,
  viewerUserId: string,
): DuelSummaryDto {
  const mine = members.find((m) => m.userId === viewerUserId);
  const opponent = members.find((m) => m.userId !== viewerUserId);

  return {
    id: duel.id,
    status: duel.status,
    inviteCode: duel.inviteCode,
    createdBy: duel.createdBy,
    myCharacter: mine
      ? toCharacterSummary(
          charactersById.get(mine.characterId),
          mine.characterId,
        )
      : null,
    opponentCharacter: opponent
      ? toCharacterSummary(
          charactersById.get(opponent.characterId),
          opponent.characterId,
        )
      : null,
    winnerUserId: duel.winnerUserId,
    endReason: duel.endReason,
    createdAt: duel.createdAt.toISOString(),
    updatedAt: duel.updatedAt.toISOString(),
  };
}

export function toDetailDto(input: {
  duel: Duel;
  members: DuelMember[];
  charactersById: Map<string, PlayerCharacter>;
  viewerUserId: string;
  armorByCharacterId: Map<string, number>;
  vitalsByCharacterId: Map<string, { tempHp: number; conditions: string[] }>;
  myWeapons: DuelWeaponOptionDto[];
  mySpells: { spellSlug: string; listType: string }[];
  seesInMagicalDarkness: boolean;
}): DuelDetailDto {
  const {
    duel,
    members,
    charactersById,
    viewerUserId,
    armorByCharacterId,
    vitalsByCharacterId,
  } = input;
  const mine = members.find((m) => m.userId === viewerUserId);
  const combatLog: DuelCombatLogEntryDto[] = (duel.combatLog ?? []).map(
    (entry) => ({ at: entry.at, text: entry.text }),
  );

  return {
    ...toSummaryDto(duel, members, charactersById, viewerUserId),
    members: members.map((member) =>
      toMemberDto(member, charactersById.get(member.characterId)),
    ),
    combatants: members.map((member) =>
      toCombatantDto(
        member,
        charactersById.get(member.characterId),
        armorByCharacterId.get(member.characterId) ?? 10,
        vitalsByCharacterId.get(member.characterId) ?? {
          tempHp: 0,
          conditions: [],
        },
      ),
    ),
    turnCharacterId: duel.turnCharacterId,
    round: duel.round,
    myTurn:
      duel.status === 'active' &&
      mine != null &&
      duel.turnCharacterId === mine.characterId,
    myWeapons: input.myWeapons,
    mySpells: input.mySpells,
    arenaEffects: (duel.arenaEffects ?? []) as DuelDetailDto['arenaEffects'],
    arenaEffectSourceCharacterId: duel.arenaEffectSourceCharacterId,
    seesInMagicalDarkness: input.seesInMagicalDarkness,
    combatLog,
  };
}
