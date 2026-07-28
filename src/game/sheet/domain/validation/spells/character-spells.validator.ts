import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { assertUnique } from '../../../../../common/assert';
import { VSpellByClass } from '../../../../../entities/views/v-spell-by-class.entity';
import { VPhbSubclassPreparedSpell } from '../../../../../entities/views/v-phb-subclass-prepared-spell.entity';
import { CharacterFeatDto, SpeciesChoiceDto } from '../../../dto/character-sheet.dto';
import { CharacterSheetContext, CharacterSheetInput } from '../../character-sheet.types';
import {
  collectFeatGrantedSpellSlugs,
  collectSpeciesGrantedSpellSlugs,
} from '../../../../spellcasting/domain/granted-spells';
import { LoadGrantedSpellCatalog } from '../../../../spellcasting/application/load-granted-spell-catalog';
import { assertSpellQuotas } from './assert-spell-quotas';
import {
  loadSubclassSpellcasting,
  maxSpellLevelForCharacter,
  SubclassSpellcastingInfo,
} from './spell-progression-queries';
import { validateSpellListAccess } from './validate-spell-list-access';

@Injectable()
export class CharacterSpellsValidator {
  constructor(
    private readonly dataSource: DataSource,
    @InjectRepository(VSpellByClass)
    private readonly classSpellsRepo: Repository<VSpellByClass>,
    @InjectRepository(VPhbSubclassPreparedSpell)
    private readonly subclassSpellsRepo: Repository<VPhbSubclassPreparedSpell>,
    private readonly grantedSpellCatalog: LoadGrantedSpellCatalog,
  ) {}

  async validateCharacterSpells(
    spells: NonNullable<CharacterSheetInput['characterSpells']>,
    ctx: CharacterSheetContext,
    featOptions?: CharacterSheetInput['featOptions'],
    characterFeats?: CharacterFeatDto[],
    speciesChoices?: SpeciesChoiceDto[],
  ): Promise<void> {
    const keys = spells.map((s) => `${s.spellSlug}:${s.listType}`);
    assertUnique(keys, 'Duplicate character spell entries are not allowed');

    const feats = characterFeats ?? [];
    const featSlugs = [
      ...feats.map((f) => f.featSlug),
      ...(featOptions ?? []).map((o) => o.featSlug),
    ];
    const { speciesCatalog, featFixedSpells } =
      await this.grantedSpellCatalog.loadMergeCatalog({
        speciesSlugs: [ctx.speciesSlug],
        featSlugs,
      });

    const featGranted = collectFeatGrantedSpellSlugs(
      featOptions,
      feats,
      featFixedSpells,
    );
    const speciesGranted = collectSpeciesGrantedSpellSlugs(
      ctx.speciesSlug,
      speciesChoices,
      ctx.level,
      speciesCatalog,
    );
    const subclassCasting = await this.loadSubclassSpellcasting(ctx.subclassSlug);
    const spellListClassSlug =
      subclassCasting?.spellListClassSlug ?? ctx.classSlug;
    const maxSpellLevel = await maxSpellLevelForCharacter(
      this.dataSource,
      ctx.classSlug,
      ctx.level,
      ctx.subclassSlug,
    );

    await validateSpellListAccess(
      this.classSpellsRepo,
      this.subclassSpellsRepo,
      spells,
      ctx,
      featGranted,
      speciesGranted,
      spellListClassSlug,
      maxSpellLevel,
    );

    await assertSpellQuotas(
      this.dataSource,
      this.classSpellsRepo,
      spells,
      ctx,
      subclassCasting,
    );
  }

  loadSubclassSpellcasting(
    subclassSlug: string | null,
  ): Promise<SubclassSpellcastingInfo | null> {
    return loadSubclassSpellcasting(this.dataSource, subclassSlug);
  }
}
