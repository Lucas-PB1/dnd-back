import { BadRequestException } from '@nestjs/common';
import { DataSource } from 'typeorm';
import { PhbOptionDef } from '@entities/phb-option.entity';
import { SubclassOptionDto } from '@game/sheet/dto/character-sheet.dto';
import {
  BLADE_HOLY_CANTRIP_KEYS,
  LORE_MAGICAL_DISCOVERY_KEYS,
  WIZARD_VERSATILITY_OPTION_KEYS,
} from '../subclass-option-effects';
import {
  SANGROMANCY_SAVANT_OPTION_KEYS,
  SANGROMANCY_SCHOOL_FILTER_SLUG,
  isSangromancySavantOptionKey,
} from '@game/spellcasting/domain/sangromancy/sangromancy-spells';
import {
  sangromancySpellMatches,
  spellOnAnyClassListUpToLevel,
  spellOnClassList,
  wizardSchoolSpellMatches,
} from '@game/sheet/infrastructure/queries/spell-catalog.queries';
import { MAGICAL_SECRETS_LIST_SLUGS } from '@game/sheet/domain/validation/spells/magical-secrets';
import { assertDistinctAcrossKeys } from './assert-distinct-choices';

export async function validateSubclassOptionSpell(
  dataSource: DataSource,
  def: PhbOptionDef,
  option: SubclassOptionDto,
  level: number,
  options: SubclassOptionDto[],
): Promise<void> {
  if (LORE_MAGICAL_DISCOVERY_KEYS.has(def.optionKey)) {
    await validateLoreMagicalDiscovery(dataSource, option, level);
    assertDistinctAcrossKeys(options, [...LORE_MAGICAL_DISCOVERY_KEYS]);
    return;
  }

  if (BLADE_HOLY_CANTRIP_KEYS.has(def.optionKey)) {
    await validateClericCantrip(dataSource, option);
    assertDistinctAcrossKeys(options, [...BLADE_HOLY_CANTRIP_KEYS]);
    return;
  }

  if (WIZARD_VERSATILITY_OPTION_KEYS.has(def.optionKey)) {
    await validateWizardVersatility(dataSource, def, option);
    const prefix = def.optionKey.replace(/\d+$/, '');
    assertDistinctAcrossKeys(options, [`${prefix}1`, `${prefix}2`]);
    return;
  }

  if (isSangromancySavantOptionKey(def.optionKey)) {
    await validateSangromancySavant(dataSource, def, option);
    assertDistinctAcrossKeys(options, [...SANGROMANCY_SAVANT_OPTION_KEYS]);
  }
}

async function validateClericCantrip(
  dataSource: DataSource,
  option: SubclassOptionDto,
): Promise<void> {
  const valid = await spellOnClassList(dataSource, {
    classSlug: 'cleric',
    spellSlug: option.valueId,
    spellLevel: 0,
  });
  if (!valid) {
    throw new BadRequestException(
      `Spell '${option.valueId}' is not a Cleric cantrip`,
    );
  }
}

async function validateLoreMagicalDiscovery(
  dataSource: DataSource,
  option: SubclassOptionDto,
  level: number,
): Promise<void> {
  const maxLevel = Math.min(3, Math.ceil(level / 2));
  const valid = await spellOnAnyClassListUpToLevel(
    dataSource,
    MAGICAL_SECRETS_LIST_SLUGS,
    option.valueId,
    maxLevel,
  );
  if (!valid) {
    throw new BadRequestException(
      `Spell '${option.valueId}' is not a valid Lore magical discovery`,
    );
  }
}

async function validateSangromancySavant(
  dataSource: DataSource,
  def: PhbOptionDef,
  option: SubclassOptionDto,
): Promise<void> {
  const maxLevel = def.spellMaxLevel ?? 2;
  const schoolSlugs = def.spellSchoolSlugs ?? [];
  if (!schoolSlugs.includes(SANGROMANCY_SCHOOL_FILTER_SLUG)) {
    throw new BadRequestException(
      `Subclass option '${def.optionKey}' is misconfigured for Sangromancy`,
    );
  }

  if (!(await sangromancySpellMatches(dataSource, option.valueId, maxLevel))) {
    throw new BadRequestException(
      `Spell '${option.valueId}' is not a valid Sangromancy choice for '${def.optionKey}'`,
    );
  }
}

async function validateWizardVersatility(
  dataSource: DataSource,
  def: PhbOptionDef,
  option: SubclassOptionDto,
): Promise<void> {
  const maxLevel = def.spellMaxLevel ?? 2;
  const schoolSlugs = def.spellSchoolSlugs ?? [];
  if (
    !(await wizardSchoolSpellMatches(
      dataSource,
      option.valueId,
      maxLevel,
      schoolSlugs,
    ))
  ) {
    throw new BadRequestException(
      `Spell '${option.valueId}' is not a valid wizard school choice for '${def.optionKey}'`,
    );
  }
}
