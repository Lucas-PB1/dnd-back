import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { VPhbBackgroundToolOption } from '@entities/views/v-phb-background-tool-option.entity';
import {
  assertBackgroundBoostSlugsAllowed,
  resolveBackgroundAbilityBoostInput,
} from '@game/sheet/domain/origin/background-ability-boost';
import { CharacterFeatDto } from '@game/sheet/dto/character-sheet.dto';
import { isPickableLanguageChoice } from './language-choice-rules';
import {
  loadBackgroundLanguageSlugs,
  loadBackgroundSkillSlugs,
} from '@game/sheet/infrastructure/queries/background-origin.queries';

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

  async assertClassSkillsDoNotOverlapBackground(
    backgroundSlug: string,
    classSkillSlugs: string[],
  ): Promise<void> {
    if (!classSkillSlugs.length) return;
    const rows = await loadBackgroundSkillSlugs(this.dataSource, backgroundSlug);
    const backgroundSkills = new Set(rows);
    const overlap = classSkillSlugs.filter((slug) => backgroundSkills.has(slug));
    if (overlap.length > 0) {
      throw new BadRequestException(
        `Skill(s) already granted by background '${backgroundSlug}': ${overlap.join(', ')}. Choose a different class skill.`,
      );
    }
  }

  async validateBackgroundOriginFeat(
    background: {
      backgroundSlug?: string;
      featSlug: string | null;
      originFeatChoiceSlugs?: string[] | null;
    },
    characterFeats: CharacterFeatDto[],
  ): Promise<void> {
    const origin = background.featSlug?.trim();
    if (origin) {
      if (!characterFeats.some((feat) => feat.featSlug === origin)) {
        throw new BadRequestException(
          `Background origin feat '${origin}' must be included in characterFeats`,
        );
      }
      return;
    }

    const choices = background.originFeatChoiceSlugs ?? [];
    if (choices.length === 0) return;

    const picked = characterFeats.filter((feat) => choices.includes(feat.featSlug));
    const uniquePicked = [...new Set(picked.map((feat) => feat.featSlug))];
    if (uniquePicked.length !== 1) {
      const label = background.backgroundSlug ?? 'background';
      throw new BadRequestException(
        `Background '${label}' requires exactly one origin feat from: ${choices.join(', ')}`,
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


  async validateBackgroundLanguages(
    backgroundSlug: string,
    languageSlugs: string[] | undefined,
    options?: {
      required?: boolean;
      extra?: { grantedSlugs?: string[]; choiceCount?: number };
    },
  ): Promise<void> {
    const background = await this.catalogLookup.findBackgroundOrFail(backgroundSlug);
    const extraGranted = [...new Set(options?.extra?.grantedSlugs ?? [])];
    const extraChoice = options?.extra?.choiceCount ?? 0;
    const choiceCount = (background.languageChoiceCount ?? 0) + extraChoice;
    const fixedRows = await loadBackgroundLanguageSlugs(
      this.dataSource,
      backgroundSlug,
    );
    const fixed = [...new Set([...fixedRows, ...extraGranted])];
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
      const language = await this.catalogLookup.assertLanguageInCatalog(slug);
      if (!isPickableLanguageChoice(slug, language)) {
        throw new BadRequestException(
          `Language '${slug}' is not available as a language choice (standard languages only)`,
        );
      }
    }
  }
}
