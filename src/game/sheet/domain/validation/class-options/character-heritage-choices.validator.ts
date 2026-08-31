import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { PhbHeritageTrait } from '@entities/phb-heritage-trait.entity';
import { VPhbHeritageTraitChoices } from '@entities/views/v-phb-heritage-trait-choices.entity';
import { SpeciesChoiceDto } from '@game/sheet/dto/character-sheet.dto';
import { validateHeritageChoices } from '../../heritage/heritage-choices.validator';

@Injectable()
export class CharacterHeritageChoicesValidator {
  constructor(
    @InjectRepository(VPhbHeritageTraitChoices)
    private readonly heritageTraitChoicesRepo: Repository<VPhbHeritageTraitChoices>,
    @InjectRepository(PhbHeritageTrait)
    private readonly heritageTraitRepo: Repository<PhbHeritageTrait>,
    private readonly catalogLookup: CatalogLookupService,
  ) {}

  async validateHeritageChoices(
    heritageSlug: string,
    choices: SpeciesChoiceDto[] | undefined,
  ): Promise<void> {
    if (!choices) return;

    const heritage = await this.catalogLookup.findHeritageOrFail(heritageSlug);
    const rows = await this.heritageTraitChoicesRepo.find({
      where: { heritageSlug },
    });

    const traitSlugs = [
      ...new Set(
        choices
          .filter((choice) => choice.choiceKind.startsWith('heritage_trait_'))
          .map((choice) => choice.choiceSlug.trim())
          .filter(Boolean),
      ),
    ];
    const traitLimits =
      traitSlugs.length === 0
        ? []
        : await this.heritageTraitRepo
            .createQueryBuilder('trait')
            .where('trait.slug IN (:...traitSlugs)', { traitSlugs })
            .getMany();

    validateHeritageChoices({
      heritageSlug,
      choices,
      catalogRows: rows.map((row) => ({
        choiceKind: row.choiceKind,
        traitSlug: row.traitSlug,
      })),
      traitLimits: traitLimits.map((row) => ({
        slug: row.slug,
        maxTakes: row.maxTakes,
      })),
      rules: {
        allowsSpeedTrade: heritage.allowsSpeedTrade,
        allowsSizeChoice: heritage.allowsSizeChoice,
      },
    });
  }
}
