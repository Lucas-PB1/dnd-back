import { Injectable } from '@nestjs/common';
import { LoadGrantedSpellCatalog } from '@game/spellcasting/application/load-granted-spell-catalog';
import { ResolveSubclassOptionGrantedSpells } from '@game/spellcasting/application/resolve-subclass-option-granted-spells';
import { mergeGrantedSpells } from '@game/spellcasting/application/merge-granted-spells';
import { annotateSpellSources } from '@game/spellcasting/application/annotate-spell-sources';
import {
  collectFeatGrantedSpellSlugs,
  collectGrantedSpellSlugsAtLevel,
  collectSpeciesGrantedSpellSlugs,
} from '@game/spellcasting/domain/granted-spells';
import {
  PreviewGrantedSpellsDto,
  PreviewGrantedSpellsResponseDto,
} from '../dto/preview-granted-spells.dto';

@Injectable()
export class PreviewGrantedSpellsHandler {
  constructor(
    private readonly grantedSpellCatalog: LoadGrantedSpellCatalog,
    private readonly resolveSubclassOptionGrants: ResolveSubclassOptionGrantedSpells,
  ) {}

  async execute(
    dto: PreviewGrantedSpellsDto,
  ): Promise<PreviewGrantedSpellsResponseDto> {
    const level = dto.level ?? 1;
    const characterFeats = dto.characterFeats ?? [];
    const featSlugs = characterFeats.map((f) => f.featSlug);
    const {
      speciesCatalog,
      featFixedSpells,
      subclassGrantedSpells,
      classGrantedSpells,
    } = await this.grantedSpellCatalog.loadMergeCatalog({
      speciesSlugs: [dto.speciesSlug],
      featSlugs,
      subclassSlug: dto.subclassSlug,
      classSlug: dto.classSlug,
      subclassOptions: dto.subclassOptions,
    });

    const loreGranted = await this.resolveSubclassOptionGrants.resolveExtraGrantedSlugs(
      dto.subclassSlug,
      level,
      dto.subclassOptions,
    );

    const merged = mergeGrantedSpells(dto.characterSpells ?? [], {
      featOptions: dto.featOptions,
      characterFeats,
      speciesSlug: dto.speciesSlug,
      speciesChoices: dto.speciesChoices,
      level,
      speciesCatalog,
      featFixedSpells,
      subclassGrantedSpells,
      classGrantedSpells,
      extraGrantedSpellSlugs: loreGranted,
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
    const subclassSpellSlugs = collectGrantedSpellSlugsAtLevel(
      level,
      subclassGrantedSpells,
    );
    const classSpellSlugs = collectGrantedSpellSlugsAtLevel(
      level,
      classGrantedSpells,
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
          spell.source === 'subclass' ||
          classSpellSlugs.has(spell.spellSlug)),
    );

    return { characterSpells, grantedOnly };
  }
}
