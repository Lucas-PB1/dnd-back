import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import { LoadGrantedSpellCatalog } from '@game/spellcasting/application/load-granted-spell-catalog';
import {
  annotateCharacterSpellSources,
  collectFeatGrantedSpellSlugs,
  collectSpeciesGrantedSpellSlugs,
} from '@game/spellcasting/domain/granted-spells';
import {
  freeCastMaxUses,
  resolveGrantedSpellCastEconomy,
  type CastEconomy,
} from '@game/spellcasting/domain/resolve-granted-spell-cast-economy';
import { resolveFeatSlugForGrantedSpell } from '@game/spellcasting/domain/resolve-granted-spellcasting-ability';
import { proficiencyBonusForLevel } from '@game/session/application/core/apply-species-resource-spend-side-effects';

export async function resolveSpellCastEconomyForCharacter(
  character: PlayerCharacter,
  spellSlug: string,
  sheetRepository: CharacterSheetRepository,
  grantedSpellCatalog: LoadGrantedSpellCatalog,
): Promise<CastEconomy> {
  const budget = await resolveGrantedFreeCastBudget(
    character,
    spellSlug,
    sheetRepository,
    grantedSpellCatalog,
  );
  return budget.economy;
}

/** Economia + teto de free casts (Greater Freyr = PB). */
export async function resolveGrantedFreeCastBudget(
  character: PlayerCharacter,
  spellSlug: string,
  sheetRepository: CharacterSheetRepository,
  grantedSpellCatalog: LoadGrantedSpellCatalog,
): Promise<{ economy: CastEconomy; maxUses: number }> {
  const sheet = await sheetRepository.load(
    character.id,
    character.backgroundSlug,
  );
  const { speciesCatalog, featFixedSpells } =
    await grantedSpellCatalog.loadMergeCatalog({
      speciesSlugs: character.speciesSlug ? [character.speciesSlug] : [],
      featSlugs: sheet.characterFeats.map((f) => f.featSlug),
      classSlug: character.classSlug,
    });
  const featGrantedSlugs = collectFeatGrantedSpellSlugs(
    sheet.featOptions,
    sheet.characterFeats,
    featFixedSpells,
  );
  const speciesGrantedSlugs = character.speciesSlug
    ? collectSpeciesGrantedSpellSlugs(
        character.speciesSlug,
        sheet.speciesChoices,
        character.level,
        speciesCatalog,
      )
    : new Set<string>();
  const [annotated] = annotateCharacterSpellSources(
    [{ spellSlug, listType: 'always_prepared' }],
    { featGrantedSlugs, speciesGrantedSlugs },
  );
  const economy = resolveGrantedSpellCastEconomy({
    spellSlug,
    source: annotated.source,
    featOptions: sheet.featOptions,
    featFixedSpells,
    speciesSlug: character.speciesSlug ?? undefined,
    speciesChoices: sheet.speciesChoices,
    speciesCatalog,
  });
  const feat =
    annotated.source === 'feat'
      ? resolveFeatSlugForGrantedSpell(
          spellSlug,
          sheet.featOptions,
          featFixedSpells,
        )
      : null;
  const maxUses = freeCastMaxUses({
    economy,
    spellSlug,
    featSlug: feat?.featSlug,
    proficiencyBonus: proficiencyBonusForLevel(character.level),
  });
  return { economy, maxUses };
}
