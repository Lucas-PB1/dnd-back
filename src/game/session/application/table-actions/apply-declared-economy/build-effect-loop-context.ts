import { rageDamageBonus } from '@game/combat/domain/barbarian';
import { isWarlockClass } from '@game/combat/domain/warlock';
import { isBardClass } from '@game/combat/domain/bard';
import { isMonkClass } from '@game/combat/domain/monk';
import {
  magicalCunningSlotRecoveryCount,
  warlockPactSlotLevel,
} from '@game/combat/domain/warlock';
import { psiEnergyDieFaces } from '@game/combat/domain/fighter';
import {
  FEATURE_SCHEDULE_KEYS,
  featureSchedulesFromCatalog,
  scheduleIntAtLevel,
} from '@game/combat/domain/feature-schedule';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { DeclaredEconomyTableActionDeps } from './types';
import { computeAbilityMods } from './flat-override';

export function buildEffectLoopContext(
  catalog: Awaited<
    ReturnType<DeclaredEconomyTableActionDeps['mechanicalCatalog']['load']>
  >,
  character: PlayerCharacter,
) {
  const bands = featureSchedulesFromCatalog(
    {
      featureSchedulesByClassSlug:
        catalog.featureSchedulesByClassSlug ?? new Map(),
      featureSchedulesBySubclassSlug:
        catalog.featureSchedulesBySubclassSlug ?? new Map(),
    },
    character.classSlug,
    character.subclassSlug,
  );
  const rageBonus = rageDamageBonus(character.level, bands);
  const { strMod, intMod, castingMod } = computeAbilityMods(character);
  const scheduleDieFaces = isBardClass(character.classSlug)
    ? scheduleIntAtLevel(
        bands,
        FEATURE_SCHEDULE_KEYS.bardicInspirationDieFaces,
        character.level,
        6,
      )
    : isMonkClass(character.classSlug)
      ? scheduleIntAtLevel(
          bands,
          FEATURE_SCHEDULE_KEYS.martialArtsDieFaces,
          character.level,
          6,
        )
      : (psiEnergyDieFaces(character.level, bands) ?? undefined);
  const pactSlotLevel = isWarlockClass(character.classSlug)
    ? warlockPactSlotLevel(character.level, bands)
    : undefined;
  const pactSlotsRecoveryCount = isWarlockClass(character.classSlug)
    ? magicalCunningSlotRecoveryCount(character.level, bands)
    : undefined;

  return {
    rageBonus,
    strMod,
    intMod,
    castingMod,
    scheduleDieFaces,
    pactSlotLevel,
    pactSlotsRecoveryCount,
  };
}
