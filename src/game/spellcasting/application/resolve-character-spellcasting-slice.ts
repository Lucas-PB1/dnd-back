import { DataSource, Repository } from 'typeorm';
import type { AbilityKey } from '../../build/domain/ability-generation';
import type { AbilityModifiers } from '../../sheet/domain/stats/character-derived-stats';
import type { CharacterSheetData } from '../../sheet/domain/character-sheet.types';
import {
  collectFeatGrantedSpellSlugs,
  collectSpeciesGrantedSpellSlugs,
} from '../domain/granted-spells';
import { enrichSpellsWithSpellcastingStats } from '../domain/enrich-spells-with-spellcasting-stats';
import { VPhbSubclassPreparedSpell } from '../../../entities/views/v-phb-subclass-prepared-spell.entity';
import { annotateSpellSources } from './annotate-spell-sources';
import { LoadGrantedSpellCatalog } from './load-granted-spell-catalog';
import { resolveSpellcastingStats } from './resolve-spellcasting-stats';
import type { CharacterSpellDto } from '../../sheet/dto/character-sheet.dto';

const ABILITY_SLUGS = new Set<AbilityKey>([
  'forca',
  'destreza',
  'constituicao',
  'inteligencia',
  'sabedoria',
  'carisma',
]);

export type MappedSpellcastingSlice = {
  characterSpells: CharacterSpellDto[];
  spellcastingAbilitySlug: AbilityKey | null;
  spellSaveDc: number | null;
  spellAttackBonus: number | null;
};

export async function loadSpellcastingAbilitySlug(
  dataSource: DataSource,
  classSlug: string,
): Promise<AbilityKey | null> {
  const rows = await dataSource.query<{ ability_slug: string }[]>(
    `SELECT a.slug AS ability_slug
     FROM rpg.phb_class_spellcasting cs
     JOIN rpg.phb_class c ON c.id = cs.class_id
     JOIN rpg.phb_ability a ON a.id = cs.ability_id
     WHERE c.slug = $1
     LIMIT 1`,
    [classSlug],
  );
  const slug = rows[0]?.ability_slug;
  if (!slug || !ABILITY_SLUGS.has(slug as AbilityKey)) return null;
  return slug as AbilityKey;
}

async function loadSubclassSpellSlugs(
  subclassSpellsRepo: Repository<VPhbSubclassPreparedSpell>,
  subclassSlug: string | null,
): Promise<Set<string>> {
  if (!subclassSlug) return new Set();
  const rows = await subclassSpellsRepo.find({
    where: { subclassSlug },
    select: ['spellSlug'],
  });
  return new Set(rows.map((row) => row.spellSlug));
}

export async function resolveCharacterSpellcastingSlice(input: {
  dataSource: DataSource;
  subclassSpellsRepo: Repository<VPhbSubclassPreparedSpell>;
  grantedSpellCatalog: LoadGrantedSpellCatalog;
  sheet: CharacterSheetData;
  speciesSlug: string;
  subclassSlug: string | null;
  level: number;
  classSlug: string;
  proficiencyBonus: number;
  abilityModifiers: AbilityModifiers;
  featSlugs: string[];
}): Promise<MappedSpellcastingSlice> {
  const {
    dataSource,
    subclassSpellsRepo,
    grantedSpellCatalog,
    sheet,
    speciesSlug,
    subclassSlug,
    level,
    classSlug,
    proficiencyBonus,
    abilityModifiers,
    featSlugs,
  } = input;

  const spellcastingAbilitySlug = await loadSpellcastingAbilitySlug(
    dataSource,
    classSlug,
  );
  const spellcasting = resolveSpellcastingStats({
    spellcastingAbilitySlug,
    proficiencyBonus,
    abilityModifiers,
  });

  const { speciesCatalog, featFixedSpells } =
    await grantedSpellCatalog.loadMergeCatalog({
      speciesSlugs: [speciesSlug],
      featSlugs,
    });
  const featGrantedSlugs = collectFeatGrantedSpellSlugs(
    sheet.featOptions,
    sheet.characterFeats,
    featFixedSpells,
  );
  const speciesGrantedSlugs = collectSpeciesGrantedSpellSlugs(
    speciesSlug,
    sheet.speciesChoices,
    level,
    speciesCatalog,
  );
  const subclassSpellSlugs = await loadSubclassSpellSlugs(
    subclassSpellsRepo,
    subclassSlug,
  );
  const annotated = annotateSpellSources(sheet.characterSpells, {
    featGrantedSlugs,
    speciesGrantedSlugs,
    subclassSpellSlugs,
  });
  const characterSpells = enrichSpellsWithSpellcastingStats(annotated, {
    classAbilitySlug: spellcasting.spellcastingAbilitySlug,
    proficiencyBonus,
    abilityModifiers,
    featOptions: sheet.featOptions,
    speciesChoices: sheet.speciesChoices,
    featFixedSpells,
    speciesSlug,
    speciesCatalog,
  });

  return {
    characterSpells,
    spellcastingAbilitySlug: spellcasting.spellcastingAbilitySlug,
    spellSaveDc: spellcasting.spellSaveDc,
    spellAttackBonus: spellcasting.spellAttackBonus,
  };
}
