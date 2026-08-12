import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { assertUnique } from '@common/assert';
import { VSpellByClass } from '@entities/views/v-spell-by-class.entity';
import { VPhbSubclassPreparedSpell } from '@entities/views/v-phb-subclass-prepared-spell.entity';
import { CharacterFeatDto, SpeciesChoiceDto } from '@game/sheet/dto/character-sheet.dto';
import { CharacterSheetContext, CharacterSheetInput } from '@game/sheet/domain/character-sheet.types';
import {
  collectFeatGrantedSpellSlugs,
  collectSpeciesGrantedSpellSlugs,
} from '@game/spellcasting/domain/granted-spells';
import { LoadGrantedSpellCatalog } from '@game/spellcasting/application/load-granted-spell-catalog';
import { ResolveSubclassOptionGrantedSpells } from '@game/spellcasting/application/resolve-subclass-option-granted-spells';
import { resolveEldritchGrantedSpellSlugs } from '@game/sheet/application/eldritch-granted-spells';
import { assertSpellQuotas } from './assert-spell-quotas';
import {
  loadSubclassSpellcasting,
  maxSpellLevelForCharacter,
  SubclassSpellcastingInfo,
} from './spell-progression-queries';
import { magicalSecretsListSlugs } from './magical-secrets';
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
    private readonly resolveSubclassOptionGrants: ResolveSubclassOptionGrantedSpells,
  ) {}

  async validateCharacterSpells(
    spells: NonNullable<CharacterSheetInput['characterSpells']>,
    ctx: CharacterSheetContext,
    featOptions?: CharacterSheetInput['featOptions'],
    characterFeats?: CharacterFeatDto[],
    speciesChoices?: SpeciesChoiceDto[],
    classOptions?: CharacterSheetInput['classOptions'],
    subclassOptions?: CharacterSheetInput['subclassOptions'],
  ): Promise<void> {
    assertUnique(
      spells.map((s) => s.spellSlug),
      'A mesma magia não pode aparecer mais de uma vez na ficha.',
    );

    const feats = characterFeats ?? [];
    const featSlugs = [
      ...feats.map((f) => f.featSlug),
      ...(featOptions ?? []).map((o) => o.featSlug),
    ];
    const { speciesCatalog, featFixedSpells } =
      await this.grantedSpellCatalog.loadMergeCatalog({
        speciesSlugs: [ctx.speciesSlug],
        featSlugs,
        classSlug: ctx.classSlug,
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
    const eldritchGranted = await resolveEldritchGrantedSpellSlugs(
      this.dataSource,
      classOptions,
    );
    const loreGranted = await this.resolveSubclassOptionGrants.resolveExtraGrantedSlugs(
      ctx.subclassSlug,
      ctx.level,
      subclassOptions,
    );
    const extraGranted = new Set([...eldritchGranted, ...loreGranted]);
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
      extraGranted,
      magicalSecretsListSlugs(ctx.classSlug, ctx.level),
      subclassOptions,
    );

    await assertSpellQuotas(
      this.dataSource,
      this.classSpellsRepo,
      spells,
      ctx,
      subclassCasting,
      classOptions,
      subclassOptions,
    );
  }

  loadSubclassSpellcasting(
    subclassSlug: string | null,
  ): Promise<SubclassSpellcastingInfo | null> {
    return loadSubclassSpellcasting(this.dataSource, subclassSlug);
  }
}
