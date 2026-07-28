import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { assertUnique } from '../../../../../common/assert';
import { VPhbSpeciesTraitChoices } from '../../../../../entities/views/v-phb-species-trait-choices.entity';
import { CharacterSheetInput } from '../../character-sheet.types';

@Injectable()
export class CharacterSpeciesChoicesValidator {
  constructor(
    @InjectRepository(VPhbSpeciesTraitChoices)
    private readonly speciesTraitChoicesRepo: Repository<VPhbSpeciesTraitChoices>,
  ) {}

  async validateSpeciesChoices(
    speciesSlug: string,
    choices: CharacterSheetInput['speciesChoices'],
  ): Promise<void> {
    if (!choices) return;

    const rows = await this.speciesTraitChoicesRepo.find({ where: { speciesSlug } });
    if (rows.length === 0 && choices.length > 0) {
      throw new BadRequestException(`Species '${speciesSlug}' has no trait choices`);
    }

    const requiredKinds = [...new Set(rows.map((row) => row.choiceKind))];
    const providedKinds = choices.map((choice) => choice.choiceKind);

    assertUnique(providedKinds, 'Duplicate species choice kinds are not allowed');

    for (const kind of requiredKinds) {
      if (!providedKinds.includes(kind)) {
        throw new BadRequestException(`Missing species choice for kind '${kind}'`);
      }
    }

    for (const choice of choices) {
      const valid = rows.some(
        (row) => row.choiceKind === choice.choiceKind && row.choiceSlug === choice.choiceSlug,
      );
      if (!valid) {
        throw new BadRequestException(
          `Species choice '${choice.choiceKind}/${choice.choiceSlug}' is invalid for '${speciesSlug}'`,
        );
      }
    }

    for (const kind of providedKinds) {
      if (!requiredKinds.includes(kind)) {
        throw new BadRequestException(
          `Species choice kind '${kind}' is not valid for '${speciesSlug}'`,
        );
      }
    }
  }
}
