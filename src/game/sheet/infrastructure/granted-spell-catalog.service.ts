import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbSpeciesGrantedSpell } from '../../../entities/views/v-phb-species-granted-spell.entity';
import { VPhbFeatGrantedSpell } from '../../../entities/views/v-phb-feat-granted-spell.entity';
import {
  FeatGrantedSpellRow,
  SpeciesGrantedSpellRow,
} from '../domain/granted-spells';

@Injectable()
export class GrantedSpellCatalogService {
  constructor(
    @InjectRepository(VPhbSpeciesGrantedSpell)
    private readonly speciesGrants: Repository<VPhbSpeciesGrantedSpell>,
    @InjectRepository(VPhbFeatGrantedSpell)
    private readonly featGrants: Repository<VPhbFeatGrantedSpell>,
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
    const rows = await this.featGrants.find();
    if (!featSlugs) {
      return rows.map((row) => ({
        featSlug: row.featSlug,
        spellSlug: row.spellSlug,
      }));
    }
    const wanted = new Set(featSlugs);
    return rows
      .filter((row) => wanted.has(row.featSlug))
      .map((row) => ({
        featSlug: row.featSlug,
        spellSlug: row.spellSlug,
      }));
  }

  /** Catálogo completo usado no merge (espécie atual + anterior + talentos). */
  async loadMergeCatalog(input: {
    speciesSlugs: string[];
    featSlugs: string[];
  }): Promise<{
    speciesCatalog: SpeciesGrantedSpellRow[];
    featFixedSpells: FeatGrantedSpellRow[];
  }> {
    const uniqueSpecies = [...new Set(input.speciesSlugs.filter(Boolean))];
    const speciesCatalog =
      uniqueSpecies.length === 0
        ? []
        : (
            await Promise.all(
              uniqueSpecies.map((slug) => this.loadSpeciesCatalog(slug)),
            )
          ).flat();

    const featFixedSpells = await this.loadFeatFixedSpells(input.featSlugs);

    return { speciesCatalog, featFixedSpells };
  }
}
