import { DataSource } from 'typeorm';
import { isWarlockClass } from '@game/combat/domain/warlock';
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
  freeCastsRemaining,
  resolveGrantedSpellCastEconomy,
} from '@game/spellcasting/domain/resolve-granted-spell-cast-economy';
import { resolveFeatSlugForGrantedSpell } from '@game/spellcasting/domain/resolve-granted-spellcasting-ability';
import { proficiencyBonusForLevel } from '@game/session/application/core/apply-species-resource-spend-side-effects';
import { CharacterStateResponseDto } from '@game/session/dto/core/character-state-response.dto';
import {
  appendEldritchFreeCastOptions,
  type GrantedSpellCastOption,
} from './eldritch-free-cast-options';

export async function buildGrantedSpellCastOptions(
  character: PlayerCharacter,
  grantedSpellUses: Record<string, number>,
  sheetRepository: CharacterSheetRepository,
  grantedSpellCatalog: LoadGrantedSpellCatalog,
  dataSource: DataSource,
): Promise<CharacterStateResponseDto['grantedSpellCastOptions']> {
  const sheet = await sheetRepository.loadGrantedSpellSlice(character.id);
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
  const annotated = annotateCharacterSpellSources(sheet.characterSpells, {
    featGrantedSlugs,
    speciesGrantedSlugs,
  });

  const proficiencyBonus = proficiencyBonusForLevel(character.level);
  const options: GrantedSpellCastOption[] = annotated
    .filter((spell) => spell.source === 'feat' || spell.source === 'species')
    .map((spell) => {
      const castEconomy = resolveGrantedSpellCastEconomy({
        spellSlug: spell.spellSlug,
        source: spell.source,
        featOptions: sheet.featOptions,
        featFixedSpells,
        speciesSlug: character.speciesSlug ?? undefined,
        speciesChoices: sheet.speciesChoices,
        speciesCatalog,
      });
      const feat =
        spell.source === 'feat'
          ? resolveFeatSlugForGrantedSpell(
              spell.spellSlug,
              sheet.featOptions,
              featFixedSpells,
            )
          : null;
      const maxUses = freeCastMaxUses({
        economy: castEconomy,
        spellSlug: spell.spellSlug,
        featSlug: feat?.featSlug,
        proficiencyBonus,
      });
      return {
        spellSlug: spell.spellSlug,
        castEconomy,
        freeCastsRemaining: freeCastsRemaining(
          castEconomy,
          spell.spellSlug,
          grantedSpellUses,
          maxUses,
        ),
      };
    });

  if (!isWarlockClass(character.classSlug)) {
    return options;
  }

  await appendEldritchFreeCastOptions({
    sheet,
    grantedSpellUses,
    dataSource,
    options,
  });

  return options;
}
