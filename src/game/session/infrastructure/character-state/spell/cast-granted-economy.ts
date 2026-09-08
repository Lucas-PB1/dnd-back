import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import { LoadEffectCatalog, loadGatedSpeciesEffects } from '@game/effects';
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
import { proficiencyBonusForLevel } from '@game/session/domain/proficiency-bonus-for-level';

export async function resolveSpellCastEconomyForCharacter(
  character: PlayerCharacter,
  spellSlug: string,
  sheetRepository: CharacterSheetRepository,
  grantedSpellCatalog: LoadGrantedSpellCatalog,
  effectCatalog?: LoadEffectCatalog,
): Promise<CastEconomy> {
  const budget = await resolveGrantedFreeCastBudget(
    character,
    spellSlug,
    sheetRepository,
    grantedSpellCatalog,
    effectCatalog,
  );
  return budget.economy;
}

/** Economia + teto de free casts (Greater Freyr = PB; efeitos tipados quando seedados). */
export async function resolveGrantedFreeCastBudget(
  character: PlayerCharacter,
  spellSlug: string,
  sheetRepository: CharacterSheetRepository,
  grantedSpellCatalog: LoadGrantedSpellCatalog,
  effectCatalog?: LoadEffectCatalog,
): Promise<{ economy: CastEconomy; maxUses: number }> {
  const sheet = await sheetRepository.load(
    character.id,
    character.backgroundSlug,
  );
  const featSlugs = sheet.characterFeats.map((f) => f.featSlug);
  const { featFixedSpells } =
    await grantedSpellCatalog.loadMergeCatalog({
      speciesSlugs: character.speciesSlug ? [character.speciesSlug] : [],
      featSlugs,
      classSlug: character.classSlug,
    });
  const featEffects = effectCatalog
    ? await effectCatalog.load({
        ownerKind: 'feat',
        ownerSlugs: featSlugs,
        kinds: ['grant_spell', 'free_cast'],
      })
    : [];
  const speciesEffects = effectCatalog
    ? await loadGatedSpeciesEffects({
        effectCatalog,
        speciesSlug: character.speciesSlug,
        speciesChoices: sheet.speciesChoices,
        kinds: ['grant_spell', 'grant_spell_by_level', 'free_cast'],
      })
    : undefined;
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
        speciesEffects,
      )
    : new Set<string>();
  const [annotated] = annotateCharacterSpellSources(
    [{ spellSlug, listType: 'always_prepared' }],
    { featGrantedSlugs, speciesGrantedSlugs },
  );
  const economy = resolveGrantedSpellCastEconomy({
    spellSlug,
    source: annotated.source,
    subclassSlug: character.subclassSlug,
    featOptions: sheet.featOptions,
    featFixedSpells,
    speciesSlug: character.speciesSlug ?? undefined,
    speciesChoices: sheet.speciesChoices,
    featEffects,
    speciesEffects,
  });
  const feat =
    annotated.source === 'feat'
      ? resolveFeatSlugForGrantedSpell(
          spellSlug,
          sheet.featOptions,
          featFixedSpells,
        )
      : null;
  const optionKey =
    sheet.featOptions.find((o) => o.valueId === spellSlug)?.optionKey ?? null;
  const maxUses = freeCastMaxUses({
    economy,
    spellSlug,
    featSlug: feat?.featSlug,
    optionKey,
    proficiencyBonus: proficiencyBonusForLevel(character.level),
    featEffects,
    speciesEffects,
  });
  return { economy, maxUses };
}
