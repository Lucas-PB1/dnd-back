import { In, type DataSource, type Repository } from 'typeorm';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { GameActor } from '@game/actor/infrastructure/game-actor.entity';
import type { PlayerCharacterItem } from '@game/inventory/infrastructure/player-character-item.entity';
import type { ResolveEquippedArmorClass } from '@game/combat/application/resolve-equipped-armor-class';
import { loadFeatSlugsByCharacterIds } from '@game/sheet/infrastructure/load-feat-slugs-by-character-ids';
import type { Skirmish } from '../infrastructure/skirmish.entity';
import type { SkirmishCombatant } from '../infrastructure/skirmish-combatant.entity';
import type {
  SkirmishCombatantDto,
  SkirmishDetailDto,
  SkirmishFighterPanelDto,
  SkirmishSpellOptionDto,
  SkirmishSummaryDto,
  SkirmishWeaponOptionDto,
} from '../dto/skirmish.dto';
import { resolveOpportunityAttackGate } from '../domain/resolve-opportunity-attack-gate';

export async function toSkirmishSummary(input: {
  skirmish: Skirmish;
  characterName: string;
  opponentName: string | null;
}): Promise<SkirmishSummaryDto> {
  return {
    id: input.skirmish.id,
    status: input.skirmish.status,
    characterId: input.skirmish.characterId,
    characterName: input.characterName,
    opponentName: input.opponentName,
    round: input.skirmish.round,
    winnerKind: input.skirmish.winnerKind,
    createdAt: input.skirmish.createdAt.toISOString(),
    updatedAt: input.skirmish.updatedAt.toISOString(),
  };
}

export async function resolvePcArmorClass(input: {
  dataSource: DataSource;
  armorClass: ResolveEquippedArmorClass;
  character: PlayerCharacter;
}): Promise<number> {
  const featSlugs =
    (
      await loadFeatSlugsByCharacterIds(input.dataSource, [input.character.id])
    ).get(input.character.id) ?? [];
  const { armorClass } = await input.armorClass.resolve(
    input.character.id,
    input.character.abilityScores,
    {
      classSlug: input.character.classSlug,
      subclassSlug: input.character.subclassSlug,
      featSlugs,
    },
  );
  return armorClass;
}

export async function equippedWeaponOptions(
  items: Repository<PlayerCharacterItem>,
  characterId: string,
): Promise<SkirmishWeaponOptionDto[]> {
  const equipped = await items.find({
    where: {
      characterId,
      location: 'equipped',
      equipmentSlot: In(['main_hand', 'off_hand']),
    },
  });
  const options: SkirmishWeaponOptionDto[] = [];
  for (const row of equipped) {
    options.push({ itemSlug: row.itemSlug, mode: 'melee' });
    options.push({ itemSlug: row.itemSlug, mode: 'ranged' });
  }
  return options;
}

export async function buildCombatantDto(input: {
  row: SkirmishCombatant;
  currentCombatantId: string | null;
  character: PlayerCharacter | null;
  actor: GameActor | null;
  pcArmorClass: number | null;
  pcConditions: string[];
  actorConditions: string[];
}): Promise<SkirmishCombatantDto> {
  const isPc = input.row.kind === 'pc';
  return {
    id: input.row.id,
    kind: input.row.kind,
    characterId: input.row.characterId,
    actorId: input.row.actorId,
    displayName: input.row.displayName,
    initiativeTotal: input.row.initiativeTotal,
    initiativeModifier: input.row.initiativeModifier,
    sortOrder: input.row.sortOrder,
    isActive: input.row.isActive,
    isCurrentTurn: input.row.id === input.currentCombatantId,
    armorClass: isPc
      ? input.pcArmorClass
      : (input.actor?.armorClass ?? null),
    hpCurrent: isPc
      ? (input.character?.hitPointsCurrent ?? null)
      : (input.actor?.hitPointsCurrent ?? null),
    hpMax: isPc
      ? (input.character?.hitPointsMax ?? null)
      : (input.actor?.hitPointsMax ?? null),
    conditions: isPc ? input.pcConditions : input.actorConditions,
  };
}

export async function toSkirmishDetail(input: {
  skirmish: Skirmish;
  combatants: SkirmishCombatant[];
  character: PlayerCharacter;
  actor: GameActor | null;
  pcArmorClass: number;
  weapons: SkirmishWeaponOptionDto[];
  pcConditions: string[];
  actorConditions: string[];
  spells: SkirmishSpellOptionDto[];
  fighter: SkirmishFighterPanelDto | null;
}): Promise<SkirmishDetailDto> {
  const current = input.skirmish.currentCombatantId;
  const dtos: SkirmishCombatantDto[] = [];
  for (const row of input.combatants) {
    dtos.push(
      await buildCombatantDto({
        row,
        currentCombatantId: current,
        character: row.kind === 'pc' ? input.character : null,
        actor: row.kind === 'actor' ? input.actor : null,
        pcArmorClass: row.kind === 'pc' ? input.pcArmorClass : null,
        pcConditions: input.pcConditions,
        actorConditions: input.actorConditions,
      }),
    );
  }
  const currentRow = input.combatants.find((row) => row.id === current);
  const awaitingActor =
    input.skirmish.status === 'active' && currentRow?.kind === 'actor';
  const oaGate = resolveOpportunityAttackGate({
    currentTurnIsActor: awaitingActor,
    reactionAvailable: input.skirmish.pcReactionAvailable ?? true,
    opportunityAvailable: input.skirmish.pcOaAvailable ?? false,
    conditions: input.pcConditions,
  });
  return {
    ...(await toSkirmishSummary({
      skirmish: input.skirmish,
      characterName: input.character.name,
      opponentName: input.actor?.name ?? null,
    })),
    combatants: dtos,
    currentCombatantId: current,
    myTurn:
      input.skirmish.status === 'active' && currentRow?.kind === 'pc',
    turnAttacksRemaining: input.skirmish.turnAttacksRemaining,
    myWeapons: input.weapons,
    mySpells: input.spells,
    fighter: input.fighter,
    arenaEffects: input.skirmish.arenaEffects ?? [],
    pcReactionAvailable: input.skirmish.pcReactionAvailable ?? true,
    awaitingActorResolution: awaitingActor,
    canOpportunityAttack: oaGate.ok,
    combatLog: input.skirmish.combatLog,
  };
}
