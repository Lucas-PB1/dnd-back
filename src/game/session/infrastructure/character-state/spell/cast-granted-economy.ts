import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import { LoadGrantedSpellCatalog } from '@game/spellcasting/application/load-granted-spell-catalog';
import {
  annotateCharacterSpellSources,
  collectFeatGrantedSpellSlugs,
  collectSpeciesGrantedSpellSlugs,
} from '@game/spellcasting/domain/granted-spells';
import { resolveGrantedSpellCastEconomy } from '@game/spellcasting/domain/resolve-granted-spell-cast-economy';

export async function resolveSpellCastEconomyForCharacter(
  character: PlayerCharacter,
  spellSlug: string,
  sheetRepository: CharacterSheetRepository,
  grantedSpellCatalog: LoadGrantedSpellCatalog,
) {
  const sheet = await sheetRepository.load(
    character.id,
    character.backgroundSlug,
  );
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
  const [annotated] = annotateCharacterSpellSources(
    [{ spellSlug, listType: 'always_prepared' }],
    { featGrantedSlugs, speciesGrantedSlugs },
  );
  return resolveGrantedSpellCastEconomy({
    spellSlug,
    source: annotated.source,
    featOptions: sheet.featOptions,
    featFixedSpells,
    speciesSlug: character.speciesSlug,
    speciesChoices: sheet.speciesChoices,
    speciesCatalog,
  });
}
