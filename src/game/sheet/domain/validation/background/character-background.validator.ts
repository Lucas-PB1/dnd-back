import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { CatalogLookupService } from '../../../../../catalog/catalog-lookup.service';
import { VPhbBackgroundToolOption } from '../../../../../entities/views/v-phb-background-tool-option.entity';
import {
  assertBackgroundBoostSlugsAllowed,
  resolveBackgroundAbilityBoostInput,
} from '../../origin/background-ability-boost';
import { CharacterFeatDto } from '../../../dto/character-sheet.dto';

@Injectable()
export class CharacterBackgroundValidator {
  constructor(
    private readonly dataSource: DataSource,
    private readonly catalogLookup: CatalogLookupService,
    @InjectRepository(VPhbBackgroundToolOption)
    private readonly backgroundToolOptionsRepo: Repository<VPhbBackgroundToolOption>,
  ) {}

  async validateBackgroundAbilityBoosts(
    backgroundSlug: string,
    boosts: {
      mode?: string | null;
      plus2Slug?: string | null;
      plus1Slug?: string | null;
      plus1Slugs?: string[] | null;
    },
  ): Promise<void> {
    const background = await this.catalogLookup.findBackgroundOrFail(backgroundSlug);
    const allowed = background.abilityOptionSlugs ?? [];
    if (allowed.length === 0) return;

    assertBackgroundBoostSlugsAllowed(
      allowed,
      resolveBackgroundAbilityBoostInput(boosts),
    );
  }

  /** PHB: se já tem a perícia do antecedente, escolha outra na classe. */
  async assertClassSkillsDoNotOverlapBackground(
    backgroundSlug: string,
    classSkillSlugs: string[],
  ): Promise<void> {
    if (!classSkillSlugs.length) return;
    const rows = await this.dataSource.query<{ slug: string }[]>(
      `SELECT sk.slug
       FROM rpg.phb_background_skill bs
       JOIN rpg.phb_background b ON b.id = bs.background_id
       JOIN rpg.phb_skill sk ON sk.id = bs.skill_id
       WHERE b.slug = $1`,
      [backgroundSlug],
    );
    const backgroundSkills = new Set(rows.map((row) => row.slug));
    const overlap = classSkillSlugs.filter((slug) => backgroundSkills.has(slug));
    if (overlap.length > 0) {
      throw new BadRequestException(
        `Skill(s) already granted by background '${backgroundSlug}': ${overlap.join(', ')}. Choose a different class skill.`,
      );
    }
  }

  async validateBackgroundOriginFeat(
    background: { featSlug: string | null },
    characterFeats: CharacterFeatDto[],
  ): Promise<void> {
    const origin = background.featSlug?.trim();
    if (!origin) return;
    if (!characterFeats.some((feat) => feat.featSlug === origin)) {
      throw new BadRequestException(
        `Background origin feat '${origin}' must be included in characterFeats`,
      );
    }
  }

  async validateBackgroundToolChoice(
    background: {
      backgroundSlug: string;
      toolProficiencyKind: string | null;
      toolItemSlug: string | null;
    },
    toolItemSlug: string | null,
  ): Promise<void> {
    if (background.toolProficiencyKind === 'choice') {
      if (!toolItemSlug) {
        throw new BadRequestException(
          `Background '${background.backgroundSlug}' requires a tool proficiency choice`,
        );
      }
      const allowed = await this.backgroundToolOptionsRepo.find({
        where: { backgroundSlug: background.backgroundSlug, itemSlug: toolItemSlug },
      });
      if (allowed.length === 0) {
        throw new BadRequestException(
          `Tool '${toolItemSlug}' is not a valid choice for background '${background.backgroundSlug}'`,
        );
      }
      return;
    }

    if (background.toolProficiencyKind === 'fixed') {
      const expected = background.toolItemSlug;
      if (expected && toolItemSlug && toolItemSlug !== expected) {
        throw new BadRequestException(
          `Background '${background.backgroundSlug}' grants fixed tool '${expected}'`,
        );
      }
    }
  }

  /**
   * PHB 2024: idiomas fixos do antecedente + exatamente `languageChoiceCount` escolhas.
   * Escolhas = qualquer idioma do catálogo que não seja já concedido.
   */
  async validateBackgroundLanguages(
    backgroundSlug: string,
    languageSlugs: string[] | undefined,
    options?: { required?: boolean },
  ): Promise<void> {
    const background = await this.catalogLookup.findBackgroundOrFail(backgroundSlug);
    const choiceCount = background.languageChoiceCount ?? 0;
    const fixedRows = await this.dataSource.query<{ slug: string }[]>(
      `SELECT l.slug
       FROM rpg.phb_background_language bl
       JOIN rpg.phb_background b ON b.id = bl.background_id
       JOIN rpg.phb_language l ON l.id = bl.language_id
       WHERE b.slug = $1
       ORDER BY l.slug`,
      [backgroundSlug],
    );
    const fixed = fixedRows.map((row) => row.slug);
    const requiredTotal = fixed.length + choiceCount;

    if (requiredTotal === 0) {
      return;
    }

    if (languageSlugs === undefined) {
      if (options?.required) {
        throw new BadRequestException(
          `Background '${backgroundSlug}' requires ${requiredTotal} language(s) (fixed + choices)`,
        );
      }
      return;
    }

    const unique = [...new Set(languageSlugs)];
    if (unique.length !== languageSlugs.length) {
      throw new BadRequestException('Duplicate language slugs are not allowed');
    }

    if (unique.length !== requiredTotal) {
      throw new BadRequestException(
        `Background '${backgroundSlug}' requires exactly ${requiredTotal} language(s) ` +
          `(${fixed.length} fixed + ${choiceCount} choice)`,
      );
    }

    for (const slug of fixed) {
      if (!unique.includes(slug)) {
        throw new BadRequestException(
          `Background '${backgroundSlug}' grants fixed language '${slug}'`,
        );
      }
    }

    const choices = unique.filter((slug) => !fixed.includes(slug));
    if (choices.length !== choiceCount) {
      throw new BadRequestException(
        `Background '${backgroundSlug}' requires exactly ${choiceCount} language choice(s)`,
      );
    }

    for (const slug of choices) {
      await this.catalogLookup.assertLanguageSlug(slug);
    }
  }
}
