import { DataSource } from 'typeorm';
import { CreateCharacterDto } from '../../dto/create-character.dto';
import { CharacterSheetInput } from '../../domain/character-sheet.types';
import { LoadGrantedSpellCatalog } from '@game/spellcasting/application/load-granted-spell-catalog';
import { ResolveSubclassOptionGrantedSpells } from '@game/spellcasting/application/resolve-subclass-option-granted-spells';
import { mergeGrantedSpells } from '@game/spellcasting/application/merge-granted-spells';
import { resolveEldritchGrantedSpellSlugs } from '../eldritch-granted-spells';

function unionSpellSlugSets(...sets: ReadonlySet<string>[]): Set<string> {
  const result = new Set<string>();
  for (const set of sets) {
    for (const slug of set) result.add(slug);
  }
  return result;
}

export async function mergeCreateCharacterSpells(input: {
  dto: CreateCharacterDto;
  sheetInput: CharacterSheetInput;
  level: number;
  grantedSpellCatalog: LoadGrantedSpellCatalog;
  resolveSubclassOptionGrants: ResolveSubclassOptionGrantedSpells;
  dataSource: DataSource;
}): Promise<void> {
  const {
    dto,
    sheetInput,
    level,
    grantedSpellCatalog,
    resolveSubclassOptionGrants,
    dataSource,
  } = input;

  const featSlugs = (sheetInput.characterFeats ?? []).map((f) => f.featSlug);
  const { speciesCatalog, featFixedSpells, subclassGrantedSpells, classGrantedSpells } =
    await grantedSpellCatalog.loadMergeCatalog({
      speciesSlugs: dto.speciesSlug ? [dto.speciesSlug] : [],
      featSlugs,
      subclassSlug: dto.subclassSlug,
      classSlug: dto.classSlug,
      subclassOptions: sheetInput.subclassOptions,
    });
  const eldritchGranted = await resolveEldritchGrantedSpellSlugs(
    dataSource,
    sheetInput.classOptions,
  );
  const loreGranted = await resolveSubclassOptionGrants.resolveExtraGrantedSlugs(
    dto.subclassSlug,
    level,
    sheetInput.subclassOptions,
  );
  const extraGrantedSpellSlugs = unionSpellSlugSets(eldritchGranted, loreGranted);
  sheetInput.characterSpells = mergeGrantedSpells(
    sheetInput.characterSpells ?? [],
    {
      featOptions: sheetInput.featOptions,
      characterFeats: sheetInput.characterFeats,
      speciesSlug: dto.speciesSlug ?? undefined,
      speciesChoices: sheetInput.speciesChoices,
      level,
      speciesCatalog,
      featFixedSpells,
      subclassGrantedSpells,
      classGrantedSpells,
      extraGrantedSpellSlugs,
    },
  );
}
