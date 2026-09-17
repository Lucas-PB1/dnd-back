import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { PhbHeritageTrait } from '@entities/heritage/phb-heritage-trait.entity';
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

    const traditionalTraitSlugs = new Set(
      rows
        .filter(
          (row) =>
            row.isTraditional && row.choiceKind.startsWith('heritage_trait_'),
        )
        .map((row) => row.traitSlug),
    );

    const catalogRows = rows
      .filter((row) => {
        if (!row.choiceKind.startsWith('heritage_trait_')) return true;
        return traditionalTraitSlugs.has(row.traitSlug) && row.isTraditional;
      })
      .filter((row) => {
        if (row.choiceKind === 'heritage_trait_9') return false;
        if (
          row.choiceKind === 'heritage_speed_trade' &&
          row.traitSlug === 'yes'
        ) {
          return false;
        }
        return true;
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

    const traitOptions =
      traitSlugs.length === 0
        ? []
        : await this.loadHeritageTraitOptions(traitSlugs);

    validateHeritageChoices({
      heritageSlug,
      choices,
      catalogRows: catalogRows.map((row) => ({
        choiceKind: row.choiceKind,
        traitSlug: row.traitSlug,
      })),
      traitLimits: traitLimits.map((row) => ({
        slug: row.slug,
        maxTakes: row.maxTakes,
      })),
      traitOptions,
      rules: {
        allowsSpeedTrade: false,
        allowsSizeChoice: heritage.allowsSizeChoice,
      },
    });
  }

  private async loadHeritageTraitOptions(
    traitSlugs: string[],
  ): Promise<{ traitSlug: string; optionKey: string; valueIds: string[] }[]> {
    const rows = await this.heritageTraitChoicesRepo.manager.query<
      { traitSlug: string; optionKey: string; valueId: string }[]
    >(
      `SELECT ht.slug AS "traitSlug",
              def.option_key AS "optionKey",
              val.value_id AS "valueId"
       FROM rpg.phb_option_def def
       JOIN rpg.phb_heritage_trait ht ON ht.id = def.owner_id
       JOIN rpg.phb_option_value val
         ON val.scope = def.scope
        AND val.owner_id = def.owner_id
        AND val.option_key = def.option_key
       WHERE def.scope = 'heritage'::rpg.option_scope
         AND ht.slug = ANY($1::text[])
       ORDER BY ht.slug, def.sort_order, def.option_key, val.sort_order`,
      [traitSlugs],
    );
    const grouped = new Map<
      string,
      { traitSlug: string; optionKey: string; valueIds: string[] }
    >();
    for (const row of rows) {
      const key = `${row.traitSlug}:${row.optionKey}`;
      const group = grouped.get(key) ?? {
        traitSlug: row.traitSlug,
        optionKey: row.optionKey,
        valueIds: [],
      };
      group.valueIds.push(row.valueId);
      grouped.set(key, group);
    }
    return [...grouped.values()];
  }
}
