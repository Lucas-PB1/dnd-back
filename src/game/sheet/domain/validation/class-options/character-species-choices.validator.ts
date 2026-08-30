import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { assertUnique } from '@common/assert';
import { VPhbSpeciesTraitChoices } from '@entities/views/v-phb-species-trait-choices.entity';
import { CharacterSheetInput } from '@game/sheet/domain/character-sheet.types';

const OPTIONAL_KINDS = new Set(['high_elf_cantrip', 'andari_druid_cantrip']);
const GH_HERITAGE_TRAIT_SLOTS = [
  'gh_heritage_trait_1',
  'gh_heritage_trait_2',
  'gh_heritage_trait_3',
  'gh_heritage_trait_4',
  'gh_heritage_trait_5',
  'gh_heritage_trait_6',
  'gh_heritage_trait_7',
  'gh_heritage_trait_8',
] as const;
const GH_HERITAGE_INDEX_SLUG = 'gh-heritage-traits';

function isGrimHollowHeritageSlug(speciesSlug: string): boolean {
  return speciesSlug.startsWith('gh-') && speciesSlug !== GH_HERITAGE_INDEX_SLUG;
}

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

    if (isGrimHollowHeritageSlug(speciesSlug)) {
      await this.validateGrimHollowHeritageChoices(speciesSlug, choices);
      return;
    }

    const rows = await this.speciesTraitChoicesRepo.find({ where: { speciesSlug } });
    const optionalChoices = choices.filter((c) => OPTIONAL_KINDS.has(c.choiceKind));
    const requiredChoices = choices.filter((c) => !OPTIONAL_KINDS.has(c.choiceKind));

    if (rows.length === 0 && requiredChoices.length > 0) {
      throw new BadRequestException(`Species '${speciesSlug}' has no trait choices`);
    }

    const requiredKinds = [...new Set(rows.map((row) => row.choiceKind))].filter(
      (kind) => !OPTIONAL_KINDS.has(kind),
    );
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
    await this.validateAndariDruidCantrip(speciesSlug, choices, optionalChoices);
    this.validateGeppettinSizeRequiresMarionette(speciesSlug, choices);
  }

  private async validateGrimHollowHeritageChoices(
    speciesSlug: string,
    choices: NonNullable<CharacterSheetInput['speciesChoices']>,
  ): Promise<void> {
    const rows = await this.speciesTraitChoicesRepo.find({ where: { speciesSlug } });
    const ghChoices = choices.filter((c) => c.choiceKind.startsWith('gh_heritage_'));

    for (const kind of GH_HERITAGE_TRAIT_SLOTS) {
      if (!ghChoices.some((c) => c.choiceKind === kind && c.choiceSlug?.trim())) {
        throw new BadRequestException(`Missing heritage trait choice for '${kind}'`);
      }
    }

    const speedTrade = ghChoices.find(
      (c) => c.choiceKind === 'gh_heritage_speed_trade',
    )?.choiceSlug;
    const hasSpeedTradeRow = rows.some((r) => r.choiceKind === 'gh_heritage_speed_trade');
    if (hasSpeedTradeRow && !speedTrade) {
      throw new BadRequestException(
        `Missing heritage choice for 'gh_heritage_speed_trade'`,
      );
    }
    if (speedTrade === 'yes') {
      const ninth = ghChoices.find((c) => c.choiceKind === 'gh_heritage_trait_9');
      if (!ninth?.choiceSlug?.trim()) {
        throw new BadRequestException(
          `Heritage speed trade requires 'gh_heritage_trait_9'`,
        );
      }
    }

    const hasSizeRow = rows.some((r) => r.choiceKind === 'gh_heritage_size');
    if (hasSizeRow) {
      const size = ghChoices.find((c) => c.choiceKind === 'gh_heritage_size')?.choiceSlug;
      if (!size) {
        throw new BadRequestException(`Missing heritage choice for 'gh_heritage_size'`);
      }
    }

    const allowedKinds = new Set(rows.map((r) => r.choiceKind));
    for (const choice of ghChoices) {
      if (!allowedKinds.has(choice.choiceKind)) {
        throw new BadRequestException(
          `Species choice kind '${choice.choiceKind}' is not valid for '${speciesSlug}'`,
        );
      }
      const valid = rows.some(
        (row) => row.choiceKind === choice.choiceKind && row.choiceSlug === choice.choiceSlug,
      );
      if (!valid) {
        throw new BadRequestException(
          `Species choice '${choice.choiceKind}/${choice.choiceSlug}' is invalid for '${speciesSlug}'`,
        );
      }
    }

    const kinds = ghChoices.map((c) => c.choiceKind);
    assertUnique(kinds, 'Duplicate heritage choice slots are not allowed');
  }

  private validateGeppettinSizeRequiresMarionette(
    speciesSlug: string,
    choices: NonNullable<CharacterSheetInput['speciesChoices']>,
  ): void {
    if (speciesSlug !== 'geppettin') return;
    const size = choices.find((c) => c.choiceKind === 'geppettin_size')?.choiceSlug;
    if (size !== 'medium') return;
    const construction = choices.find(
      (c) => c.choiceKind === 'geppettin_construction',
    )?.choiceSlug;
    if (construction !== 'marionette') {
      throw new BadRequestException(
        `Geppettin size 'medium' requires construction 'marionette'`,
      );
    }
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

  private async validateAndariDruidCantrip(
    speciesSlug: string,
    allChoices: NonNullable<CharacterSheetInput['speciesChoices']>,
    optionalChoices: NonNullable<CharacterSheetInput['speciesChoices']>,
  ): Promise<void> {
    const andariCantrip = optionalChoices.find(
      (c) => c.choiceKind === 'andari_druid_cantrip',
    );
    const lineage = allChoices.find(
      (c) => c.choiceKind === 'bearfolk_lineage',
    )?.choiceSlug;
    const isAndari = speciesSlug === 'bearfolk' && lineage === 'andari';

    if (!andariCantrip) {
      if (isAndari) {
        throw new BadRequestException(
          `Species choice 'andari_druid_cantrip' is required for bearfolk_lineage 'andari'`,
        );
      }
      return;
    }

    if (!isAndari) {
      throw new BadRequestException(
        `Species choice 'andari_druid_cantrip' requires bearfolk_lineage 'andari'`,
      );
    }

    const rows = await this.dataSource.query<{ ok: number }[]>(
      `SELECT 1 AS ok
       FROM rpg.v_spell_by_class
       WHERE class_slug = 'druid' AND spell_level = 0 AND spell_slug = $1
       LIMIT 1`,
      [andariCantrip.choiceSlug],
    );
    if (rows.length === 0) {
      throw new BadRequestException(
        `Andari cantrip '${andariCantrip.choiceSlug}' must be a Druid cantrip`,
      );
    }
  }
}
