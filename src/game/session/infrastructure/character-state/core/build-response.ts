import { DataSource, Repository } from 'typeorm';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { VClassSpellSlots } from '@entities/views/v-class-spell-slots.entity';
import { VSubclassSpellSlots } from '@entities/views/v-subclass-spell-slots.entity';
import { loadEldritchInvocationEffectCatalog } from '@game/combat/application/load-eldritch-invocation-effect-catalog';
import {
  isWarlockClass,
  readEldritchInvocationPicks,
  resolveEldritchInvocationFreeCast,
} from '@game/combat/domain/warlock-features';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import { LoadGrantedSpellCatalog } from '@game/spellcasting/application/load-granted-spell-catalog';
import {
  annotateCharacterSpellSources,
  collectFeatGrantedSpellSlugs,
  collectSpeciesGrantedSpellSlugs,
} from '@game/spellcasting/domain/granted-spells';
import {
  freeCastsRemaining,
  resolveGrantedSpellCastEconomy,
} from '@game/spellcasting/domain/resolve-granted-spell-cast-economy';
import { CharacterStateResponseDto } from '@game/session/dto/character-state.dto';
import { PlayerCharacterState } from '@game/session/infrastructure/player-character-state.entity';
import { buildClassResourceState } from '../resources/class-resources';
import { clampHitDiceToLevel } from '../resources/hit-dice';
import { computeRemaining, loadMaxSlots } from '../resources/spell-slots';

export async function buildCharacterStateResponse(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  stateRepo: Repository<PlayerCharacterState>;
  classSlots: Repository<VClassSpellSlots>;
  subclassSlots: Repository<VSubclassSpellSlots>;
  catalogLookup: CatalogLookupService;
  dataSource: DataSource;
  sheetRepository: CharacterSheetRepository;
  grantedSpellCatalog: LoadGrantedSpellCatalog;
}): Promise<CharacterStateResponseDto> {
  const {
    character,
    state,
    stateRepo,
    classSlots,
    subclassSlots,
    catalogLookup,
    dataSource,
    sheetRepository,
    grantedSpellCatalog,
  } = input;

  await clampHitDiceToLevel(stateRepo, state, character.level);
  const spellSlotsMax = await loadMaxSlots(
    classSlots,
    subclassSlots,
    character.classSlug,
    character.level,
    character.subclassSlug,
  );
  const spellSlotsUsed = state.spellSlotsUsed ?? {};
  const phbClass = await catalogLookup.findClassOrFail(character.classSlug);
  const classResources = await buildClassResourceState(
    dataSource,
    character,
    state,
  );
  const grantedSpellUses = state.grantedSpellUses ?? {};
  const grantedSpellCastOptions = await buildGrantedSpellCastOptions(
    character,
    grantedSpellUses,
    sheetRepository,
    grantedSpellCatalog,
    dataSource,
  );

  return {
    spellSlotsMax,
    spellSlotsUsed,
    spellSlotsRemaining: computeRemaining(spellSlotsMax, spellSlotsUsed),
    classResources,
    concentratingOn: state.concentratingOn,
    conditions: state.conditions ?? [],
    tempHp: state.tempHp,
    hitPointsCurrent: character.hitPointsCurrent,
    hitPointsMax: character.hitPointsMax,
    hitDiceCurrent: state.hitDiceCurrent,
    hitDiceMax: character.level,
    hitDie: phbClass.hitDie,
    deathSaveSuccesses: state.deathSaveSuccesses ?? 0,
    deathSaveFailures: state.deathSaveFailures ?? 0,
    inspiration: state.inspiration ?? false,
    grantedSpellUses,
    highElfCantripSwapAvailable: state.highElfCantripSwapAvailable ?? false,
    grantedSpellCastOptions,
    firearmChambers: state.firearmChambers ?? {},
    rageActive: state.rageActive ?? false,
    recklessActive: state.recklessActive ?? false,
    personaMasks: state.personaMasks ?? [],
    bestialAspectLevel: state.bestialAspectLevel ?? 0,
    missileShieldArmed: state.missileShieldArmed ?? false,
    gigaMissileArmed: state.gigaMissileArmed ?? false,
  };
}

async function buildGrantedSpellCastOptions(
  character: PlayerCharacter,
  grantedSpellUses: Record<string, number>,
  sheetRepository: CharacterSheetRepository,
  grantedSpellCatalog: LoadGrantedSpellCatalog,
  dataSource: DataSource,
): Promise<CharacterStateResponseDto['grantedSpellCastOptions']> {
  const sheet = await sheetRepository.loadGrantedSpellSlice(character.id);
  const { speciesCatalog, featFixedSpells } =
    await grantedSpellCatalog.loadMergeCatalog({
      speciesSlugs: [character.speciesSlug],
      featSlugs: sheet.characterFeats.map((f) => f.featSlug),
    });
  const featGrantedSlugs = collectFeatGrantedSpellSlugs(
    sheet.featOptions,
    sheet.characterFeats,
    featFixedSpells,
  );
  const speciesGrantedSlugs = collectSpeciesGrantedSpellSlugs(
    character.speciesSlug,
    sheet.speciesChoices,
    character.level,
    speciesCatalog,
  );
  const annotated = annotateCharacterSpellSources(sheet.characterSpells, {
    featGrantedSlugs,
    speciesGrantedSlugs,
  });

  const options = annotated
    .filter((spell) => spell.source === 'feat' || spell.source === 'species')
    .map((spell) => {
      const castEconomy = resolveGrantedSpellCastEconomy({
        spellSlug: spell.spellSlug,
        source: spell.source,
        featOptions: sheet.featOptions,
        featFixedSpells,
        speciesSlug: character.speciesSlug,
        speciesChoices: sheet.speciesChoices,
        speciesCatalog,
      });
      return {
        spellSlug: spell.spellSlug,
        castEconomy,
        freeCastsRemaining: freeCastsRemaining(
          castEconomy,
          spell.spellSlug,
          grantedSpellUses,
        ),
      };
    });

  if (!isWarlockClass(character.classSlug)) {
    return options;
  }

  const fullSheet = await sheetRepository.load(
    character.id,
    character.backgroundSlug,
  );
  const picks = readEldritchInvocationPicks(fullSheet.classOptions);
  if (picks.length === 0) return options;

  const catalog = await loadEldritchInvocationEffectCatalog(dataSource);
  const pickedSlugs = picks.map((pick) => pick.slug);
  const seen = new Set(options.map((row) => row.spellSlug));

  for (const spell of fullSheet.characterSpells) {
    if (seen.has(spell.spellSlug)) continue;
    const freeCast = resolveEldritchInvocationFreeCast({
      spellSlug: spell.spellSlug,
      pickedSlugs,
      catalog,
    });
    if (!freeCast) continue;
    seen.add(spell.spellSlug);
    options.push({
      spellSlug: spell.spellSlug,
      castEconomy: freeCast.economy,
      freeCastsRemaining: freeCastsRemaining(
        freeCast.economy,
        spell.spellSlug,
        grantedSpellUses,
      ),
    });
  }

  for (const row of catalog) {
    if (row.kind !== 'free_cast' || !row.grantedSpellSlug) continue;
    if (seen.has(row.grantedSpellSlug)) continue;
    const freeCast = resolveEldritchInvocationFreeCast({
      spellSlug: row.grantedSpellSlug,
      pickedSlugs,
      catalog,
    });
    if (!freeCast) continue;
    seen.add(row.grantedSpellSlug);
    options.push({
      spellSlug: row.grantedSpellSlug,
      castEconomy: freeCast.economy,
      freeCastsRemaining: freeCastsRemaining(
        freeCast.economy,
        row.grantedSpellSlug,
        grantedSpellUses,
      ),
    });
  }

  return options;
}
