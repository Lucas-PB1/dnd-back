import { BadRequestException, Injectable } from '@nestjs/common';
import { assertUnique } from '../../../../../common/assert';
import { CatalogLookupService } from '../../../../../catalog/catalog-lookup.service';
import { FeatOptionDto, CharacterFeatDto } from '../../../dto/character-sheet.dto';
import { featInstanceKey } from './character-feat';
import { CharacterFeatOptionsValidator } from './character-feat-options.validator';

@Injectable()
export class CharacterFeatsValidator {
  constructor(
    private readonly catalogLookup: CatalogLookupService,
    private readonly featOptionsValidator: CharacterFeatOptionsValidator,
  ) {}

  async validateCharacterFeats(feats: CharacterFeatDto[]): Promise<void> {
    const keys = feats.map((feat) => featInstanceKey(feat.featSlug, feat.instanceIndex));
    assertUnique(keys, 'Duplicate feat instances are not allowed');

    const bySlug = new Map<string, CharacterFeatDto[]>();
    for (const feat of feats) {
      const list = bySlug.get(feat.featSlug) ?? [];
      list.push(feat);
      bySlug.set(feat.featSlug, list);
    }

    for (const [slug, instances] of bySlug) {
      const feat = await this.catalogLookup.assertFeatInCatalog(slug);

      if (!feat.repeatable && instances.length > 1) {
        throw new BadRequestException(`Feat '${slug}' is not repeatable`);
      }

      const indices = [...instances.map((item) => item.instanceIndex)].sort((a, b) => a - b);
      for (let i = 0; i < indices.length; i += 1) {
        if (indices[i] !== i) {
          throw new BadRequestException(
            `Feat '${slug}' instance indices must be contiguous starting at 0`,
          );
        }
      }
    }
  }

  /** Facade estável — delega para CharacterFeatOptionsValidator. */
  async validateFeatOptions(
    characterFeats: CharacterFeatDto[],
    options: FeatOptionDto[],
    characterLevel = 1,
    classSlug?: string,
  ): Promise<void> {
    return this.featOptionsValidator.validateFeatOptions(
      characterFeats,
      options,
      characterLevel,
      classSlug,
    );
  }
}
