import { Injectable } from '@nestjs/common';
import { LoadGrantedSpellCatalog } from '../../spellcasting/application/load-granted-spell-catalog';
import { mergeGrantedSpells } from '../../spellcasting/application/merge-granted-spells';
import { annotateSpellSources } from '../../spellcasting/application/annotate-spell-sources';
import {
  collectFeatGrantedSpellSlugs,
  collectSpeciesGrantedSpellSlugs,
} from '../../spellcasting/domain/granted-spells';
import {
  PreviewGrantedSpellsDto,
  PreviewGrantedSpellsResponseDto,
} from '../dto/preview-granted-spells.dto';

@Injectable()
export class PreviewGrantedSpellsHandler {
  constructor(private readonly grantedSpellCatalog: LoadGrantedSpellCatalog) {}

  async execute(
    dto: PreviewGrantedSpellsDto,
  ): Promise<PreviewGrantedSpellsResponseDto> {
    const level = dto.level ?? 1;
    const characterFeats = dto.characterFeats ?? [];
    const featSlugs = characterFeats.map((f) => f.featSlug);
    const { speciesCatalog, featFixedSpells, subclassGrantedSpells } =
      await this.grantedSpellCatalog.loadMergeCatalog({
        speciesSlugs: [dto.speciesSlug],
        featSlugs,
        subclassSlug: dto.subclassSlug,
      });

    const merged = mergeGrantedSpells(dto.characterSpells ?? [], {
      featOptions: dto.featOptions,
      characterFeats,
      speciesSlug: dto.speciesSlug,
      speciesChoices: dto.speciesChoices,
      level,
      speciesCatalog,
      featFixedSpells,
      subclassGrantedSpells,
    });

    const featGrantedSlugs = collectFeatGrantedSpellSlugs(
      dto.featOptions,
      characterFeats,
      featFixedSpells,
    );
    const speciesGrantedSlugs = collectSpeciesGrantedSpellSlugs(
      dto.speciesSlug,
      dto.speciesChoices,
      level,
      speciesCatalog,
    );
    const subclassSpellSlugs = new Set(
      subclassGrantedSpells
        .filter((row) => row.unlockLevel <= level)
        .map((row) => row.spellSlug),
    );

    const characterSpells = annotateSpellSources(merged, {
      featGrantedSlugs,
      speciesGrantedSlugs,
      subclassSpellSlugs,
    });

    const grantedOnly = characterSpells.filter(
      (spell) =>
        spell.listType === 'always_prepared' &&
        (spell.source === 'feat' ||
          spell.source === 'species' ||
          spell.source === 'subclass'),
    );

    return { characterSpells, grantedOnly };
  }
}
