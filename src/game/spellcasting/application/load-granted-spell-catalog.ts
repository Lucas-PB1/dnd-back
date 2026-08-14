import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { In, Repository } from 'typeorm';
import { VPhbSpeciesGrantedSpell } from '@entities/views/v-phb-species-granted-spell.entity';
import { VPhbFeatGrantedSpell } from '@entities/views/v-phb-feat-granted-spell.entity';
import { VPhbSubclassPreparedSpell } from '@entities/views/v-phb-subclass-prepared-spell.entity';
import { VPhbClassGrantedSpell } from '@entities/views/v-phb-class-granted-spell.entity';
import {
  ClassGrantedSpellRow,
  FeatGrantedSpellRow,
  SpeciesGrantedSpellRow,
  SubclassGrantedSpellRow,
} from '../domain/granted-spells';
import { filterSubclassGrantedSpellRows } from '../domain/granted-spells/filter-subclass-granted-spells';

export type SubclassOptionPick = {
  optionKey: string;
  valueId: string;
};

export type GrantedSpellMergeCatalog = {
  speciesCatalog: SpeciesGrantedSpellRow[];
  featFixedSpells: FeatGrantedSpellRow[];
  subclassGrantedSpells: SubclassGrantedSpellRow[];
  classGrantedSpells: ClassGrantedSpellRow[];
};

@Injectable()
export class LoadGrantedSpellCatalog {
  constructor(
    @InjectRepository(VPhbSpeciesGrantedSpell)
    private readonly speciesGrants: Repository<VPhbSpeciesGrantedSpell>,
    @InjectRepository(VPhbFeatGrantedSpell)
    private readonly featGrants: Repository<VPhbFeatGrantedSpell>,
    @InjectRepository(VPhbSubclassPreparedSpell)
    private readonly subclassSpells: Repository<VPhbSubclassPreparedSpell>,
    @InjectRepository(VPhbClassGrantedSpell)
    private readonly classSpells: Repository<VPhbClassGrantedSpell>,
  ) {}

  async loadSpeciesCatalog(
    speciesSlug?: string,
  ): Promise<SpeciesGrantedSpellRow[]> {
    const rows = speciesSlug
      ? await this.speciesGrants.find({ where: { speciesSlug } })
      : await this.speciesGrants.find();
    return rows.map((row) => ({
      speciesSlug: row.speciesSlug,
      choiceKind: row.choiceKind,
      choiceSlug: row.choiceSlug,
      unlockLevel: Number(row.unlockLevel),
      spellSlug: row.spellSlug,
    }));
  }

  async loadFeatFixedSpells(
    featSlugs?: readonly string[],
  ): Promise<FeatGrantedSpellRow[]> {
    if (featSlugs && featSlugs.length === 0) return [];
    const rows = featSlugs
      ? await this.featGrants.find({ where: { featSlug: In([...featSlugs]) } })
      : await this.featGrants.find();
    return rows.map((row) => ({
      featSlug: row.featSlug,
      spellSlug: row.spellSlug,
    }));
  }

  async loadSubclassGrantedSpells(
    subclassSlug: string | null | undefined,
    subclassOptions?: readonly SubclassOptionPick[],
  ): Promise<SubclassGrantedSpellRow[]> {
    if (!subclassSlug) return [];
    const rows = await this.subclassSpells.find({ where: { subclassSlug } });
    const mapped = mapSubclassUnlockRows(rows);
    return filterSubclassGrantedSpellRows(
      mapped,
      subclassSlug,
      subclassOptions,
    );
  }

  async loadClassGrantedSpells(
    classSlug: string | null | undefined,
  ): Promise<ClassGrantedSpellRow[]> {
    if (!classSlug) return [];
    const rows = await this.classSpells.find({ where: { classSlug } });
    return mapUnlockRows(rows);
  }

  /** Catálogo completo usado no merge (espécie atual + anterior + talentos). */
  async loadMergeCatalog(input: {
    speciesSlugs: string[];
    featSlugs: string[];
    subclassSlug?: string | null;
    classSlug?: string | null;
    subclassOptions?: readonly SubclassOptionPick[];
  }): Promise<GrantedSpellMergeCatalog> {
    const uniqueSpecies = [...new Set(input.speciesSlugs.filter(Boolean))];

    const [speciesParts, featFixedSpells, subclassGrantedSpells, classGrantedSpells] =
      await Promise.all([
        uniqueSpecies.length === 0
          ? Promise.resolve([] as SpeciesGrantedSpellRow[])
          : Promise.all(
              uniqueSpecies.map((slug) => this.loadSpeciesCatalog(slug)),
            ).then((parts) => parts.flat()),
        this.loadFeatFixedSpells(input.featSlugs),
        this.loadSubclassGrantedSpells(input.subclassSlug, input.subclassOptions),
        this.loadClassGrantedSpells(input.classSlug),
      ]);

    return {
      speciesCatalog: speciesParts,
      featFixedSpells,
      subclassGrantedSpells,
      classGrantedSpells,
    };
  }
}

function mapSubclassUnlockRows(
  rows: readonly {
    unlockLevel: number;
    spellSlug: string;
    terrainSlug?: string | null;
  }[],
): SubclassGrantedSpellRow[] {
  return rows.map((row) => ({
    unlockLevel: Number(row.unlockLevel),
    spellSlug: row.spellSlug,
    terrainSlug: row.terrainSlug ?? null,
  }));
}

function mapUnlockRows(
  rows: readonly { unlockLevel: number; spellSlug: string }[],
): { unlockLevel: number; spellSlug: string }[] {
  return rows.map((row) => ({
    unlockLevel: Number(row.unlockLevel),
    spellSlug: row.spellSlug,
  }));
}
