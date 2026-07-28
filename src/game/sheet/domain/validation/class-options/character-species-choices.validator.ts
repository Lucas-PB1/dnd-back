import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { assertUnique } from '../../../../../common/assert';
import { VPhbSpeciesTraitChoices } from '../../../../../entities/views/v-phb-species-trait-choices.entity';
import { CharacterSheetInput } from '../../character-sheet.types';

const OPTIONAL_KINDS = new Set(['high_elf_cantrip']);

@Injectable()
export class CharacterSpeciesChoicesValidator {
  constructor(
    @InjectRepository(VPhbSpeciesTraitChoices)
    private readonly speciesTraitChoicesRepo: Repository<VPhbSpeciesTraitChoices>,
    private readonly dataSource: DataSource,
  ) {}

  async validateSpeciesChoices(
    speciesSlug: string,
    choices: CharacterSheetInput['speciesChoices'],
  ): Promise<void> {
    if (!choices) return;

    const rows = await this.speciesTraitChoicesRepo.find({ where: { speciesSlug } });
    const optionalChoices = choices.filter((c) => OPTIONAL_KINDS.has(c.choiceKind));
    const requiredChoices = choices.filter((c) => !OPTIONAL_KINDS.has(c.choiceKind));

    if (rows.length === 0 && requiredChoices.length > 0) {
      throw new BadRequestException(`Species '${speciesSlug}' has no trait choices`);
    }

    const requiredKinds = [...new Set(rows.map((row) => row.choiceKind))];
    const providedKinds = requiredChoices.map((choice) => choice.choiceKind);
    const allProvidedKinds = choices.map((choice) => choice.choiceKind);

    assertUnique(allProvidedKinds, 'Duplicate species choice kinds are not allowed');

    for (const kind of requiredKinds) {
      if (!providedKinds.includes(kind)) {
        throw new BadRequestException(`Missing species choice for kind '${kind}'`);
      }
    }

    for (const choice of requiredChoices) {
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

    await this.validateOptionalHighElfCantrip(speciesSlug, choices, optionalChoices);
  }

  private async validateOptionalHighElfCantrip(
    speciesSlug: string,
    allChoices: NonNullable<CharacterSheetInput['speciesChoices']>,
    optionalChoices: NonNullable<CharacterSheetInput['speciesChoices']>,
  ): Promise<void> {
    const highElf = optionalChoices.find((c) => c.choiceKind === 'high_elf_cantrip');
    if (!highElf) return;

    if (speciesSlug !== 'elf') {
      throw new BadRequestException(
        `Species choice kind 'high_elf_cantrip' is not valid for '${speciesSlug}'`,
      );
    }
    const lineage = allChoices.find((c) => c.choiceKind === 'elf_lineage')?.choiceSlug;
    if (lineage !== 'high-elf') {
      throw new BadRequestException(
        `Species choice 'high_elf_cantrip' requires elf_lineage 'high-elf'`,
      );
    }

    const rows = await this.dataSource.query<{ ok: number }[]>(
      `SELECT 1 AS ok
       FROM rpg.v_spell_by_class
       WHERE class_slug = 'wizard' AND spell_level = 0 AND spell_slug = $1
       LIMIT 1`,
      [highElf.choiceSlug],
    );
    if (rows.length === 0) {
      throw new BadRequestException(
        `High Elf cantrip '${highElf.choiceSlug}' must be a Wizard cantrip`,
      );
    }
  }
}
