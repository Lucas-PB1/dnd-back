import { DataSource, Repository } from 'typeorm';
import { CatalogLookupService } from '../../../../catalog/catalog-lookup.service';
import { VClassSpellSlots } from '../../../../entities/views/v-class-spell-slots.entity';
import { VSubclassSpellSlots } from '../../../../entities/views/v-subclass-spell-slots.entity';
import { PlayerCharacter } from '../../../shared/infrastructure/player-character.entity';
import { CharacterSheetRepository } from '../../../sheet/infrastructure/character-sheet.repository';
import { LoadGrantedSpellCatalog } from '../../../spellcasting/application/load-granted-spell-catalog';
import {
  annotateCharacterSpellSources,
  collectFeatGrantedSpellSlugs,
  collectSpeciesGrantedSpellSlugs,
} from '../../../spellcasting/domain/granted-spells';
import {
  freeCastsRemaining,
  resolveGrantedSpellCastEconomy,
} from '../../../spellcasting/domain/resolve-granted-spell-cast-economy';
import { CharacterStateResponseDto } from '../../dto/character-state.dto';
import { PlayerCharacterState } from '../player-character-state.entity';
import { buildClassResourceState } from './class-resources';
import { clampHitDiceToLevel } from './hit-dice';
import { computeRemaining, loadMaxSlots } from './spell-slots';

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
  };
}

async function buildGrantedSpellCastOptions(
  character: PlayerCharacter,
  grantedSpellUses: Record<string, number>,
  sheetRepository: CharacterSheetRepository,
  grantedSpellCatalog: LoadGrantedSpellCatalog,
): Promise<CharacterStateResponseDto['grantedSpellCastOptions']> {
  const sheet = await sheetRepository.load(character.id, character.backgroundSlug);
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

  return annotated
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
}
