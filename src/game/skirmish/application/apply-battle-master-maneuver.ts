import { BadRequestException } from '@nestjs/common';
import type { Repository } from 'typeorm';
import {
  listBattleMasterManeuvers,
  resolveBattleMasterOnHit,
  superiorityDieFaces,
} from '@game/combat/domain/fighter';
import { featureSchedulesFromCatalog } from '@game/combat/domain/feature-schedule';
import type { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import { rollDie } from '@game/dice/domain/dice';
import { computeAbilityModifiers } from '@game/shared/domain/ability-scores';
import { abilityModifierFromSlug } from '@game/combat/domain/spell-save-dc';
import type { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import type { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import type { ActorStateRepository } from '@game/actor/infrastructure/actor-state.repository';
import type { GameActor } from '@game/actor/infrastructure/game-actor.entity';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { SkirmishCombatant } from '../infrastructure/skirmish-combatant.entity';
import { mergeConditions } from '@game/duel/domain/duel-spell-resolve';

export type ApplyBattleMasterManeuverDeps = {
  mechanicalCatalog: LoadCombatMechanicalCatalog;
  sheet: CharacterSheetRepository;
  characterState: CharacterStateRepository;
  actorState: ActorStateRepository;
  actors: Repository<GameActor>;
  domain: CharacterDomainService;
};

/**
 * No acerto do PC: gasta Dado de Superioridade, soma dano e aplica save tipado.
 */
export async function applyBattleMasterOnHitManeuver(input: {
  deps: ApplyBattleMasterManeuverDeps;
  character: PlayerCharacter;
  target: SkirmishCombatant;
  targetActor: GameActor | null;
  maneuverSlug: string;
}): Promise<{ extraDamage: number; note: string }> {
  const { character, deps } = input;
  if (
    character.classSlug !== 'fighter' ||
    character.subclassSlug !== 'battle-master'
  ) {
    throw new BadRequestException('Battle Master maneuver is not available');
  }

  const catalog = await deps.mechanicalCatalog.load();
  const maneuvers = listBattleMasterManeuvers(catalog.battleMasterManeuvers);
  const sheet = await deps.sheet.load(
    character.id,
    character.backgroundSlug,
  );
  const selected = new Set(
    sheet.subclassOptions
      .filter((option) => option.optionKey.startsWith('maneuver'))
      .map((option) => option.valueId),
  );
  const available =
    selected.size === 0
      ? maneuvers
      : maneuvers.filter((row) => selected.has(row.slug));
  if (!available.some((row) => row.slug === input.maneuverSlug)) {
    throw new BadRequestException(
      `Maneuver '${input.maneuverSlug}' is not selected by this character`,
    );
  }

  const bands = featureSchedulesFromCatalog(
    catalog,
    character.classSlug,
    character.subclassSlug,
  );
  const dieFaces = superiorityDieFaces(character.level, bands);
  if (dieFaces == null) {
    throw new BadRequestException('Superiority Die is not available');
  }

  await deps.characterState.useClassResource(
    character,
    'superiority-dice',
    1,
  );

  const mods = computeAbilityModifiers(character.abilityScores);
  const pb = await deps.domain.getProficiencyBonus(character.level);
  const targetMods = input.targetActor
    ? computeAbilityModifiers(input.targetActor.abilityScores)
    : {
        forca: 0,
        destreza: 0,
        constituicao: 0,
        inteligencia: 0,
        sabedoria: 0,
        carisma: 0,
      };
  const saveAbility =
    input.maneuverSlug === 'menacing-attack' ? 'sabedoria' : 'forca';
  const targetSaveBonus = abilityModifierFromSlug(targetMods, saveAbility);

  let resolved;
  try {
    resolved = resolveBattleMasterOnHit({
      catalog: catalog.battleMasterManeuvers,
      maneuverSlug: input.maneuverSlug,
      dieFaces,
      dieRoll: rollDie(dieFaces),
      proficiencyBonus: pb,
      strengthMod: mods.forca,
      dexterityMod: mods.destreza,
      targetSaveBonus,
    });
  } catch (error) {
    throw new BadRequestException(
      error instanceof Error ? error.message : 'Cannot use maneuver',
    );
  }

  if (
    resolved.conditionSlug &&
    input.target.kind === 'actor' &&
    input.targetActor
  ) {
    const state = await deps.actorState.ensureState(input.targetActor.id);
    const next = mergeConditions({
      current: state.conditions ?? [],
      action: 'add',
      condition: resolved.conditionSlug,
    });
    await deps.actorState.patch(
      input.targetActor,
      { conditions: next },
      deps.actors,
    );
  }

  return { extraDamage: resolved.extraDamage, note: resolved.note };
}
