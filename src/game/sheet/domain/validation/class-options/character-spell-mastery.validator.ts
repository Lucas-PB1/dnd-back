import { BadRequestException, Injectable } from '@nestjs/common';
import { DataSource } from 'typeorm';
import {
  SPELL_MASTERY_UNLOCK_LEVEL,
  isSpellMasteryOptionKey,
  isWizardClass,
  spellMasteryRequiredLevelForKey,
} from '@game/combat/domain/wizard';
import {
  CharacterSheetContext,
  CharacterSheetInput,
} from '@game/sheet/domain/character-sheet.types';
import { loadSpellLevel } from '@game/sheet/infrastructure/queries/spell-catalog.queries';

const PREPARED_LIST_TYPES = new Set(['prepared', 'always_prepared']);

@Injectable()
export class CharacterSpellMasteryValidator {
  constructor(private readonly dataSource: DataSource) {}

  async validateSpellMasteryOptions(
    ctx: CharacterSheetContext,
    options: NonNullable<CharacterSheetInput['classOptions']>,
    characterSpells: CharacterSheetInput['characterSpells'],
  ): Promise<void> {
    const masteryOptions = options.filter((option) =>
      isSpellMasteryOptionKey(option.optionKey),
    );
    if (masteryOptions.length === 0) return;

    if (!isWizardClass(ctx.classSlug)) {
      throw new BadRequestException(
        'Spell Mastery options are only available for wizards',
      );
    }
    if (ctx.level < SPELL_MASTERY_UNLOCK_LEVEL) {
      throw new BadRequestException(
        `Spell Mastery requires wizard level ${SPELL_MASTERY_UNLOCK_LEVEL}+`,
      );
    }

    const spells = characterSpells ?? [];
    const preparedSlugs = new Set(
      spells
        .filter((spell) => PREPARED_LIST_TYPES.has(spell.listType))
        .map((spell) => spell.spellSlug),
    );

    const chosen = masteryOptions.map((option) => option.valueId);
    if (new Set(chosen).size !== chosen.length) {
      throw new BadRequestException(
        'Spell Mastery picks must be two different spells',
      );
    }

    for (const option of masteryOptions) {
      const requiredLevel = spellMasteryRequiredLevelForKey(option.optionKey);
      if (requiredLevel == null) continue;

      if (!preparedSlugs.has(option.valueId)) {
        throw new BadRequestException(
          `Spell Mastery '${option.valueId}' must be prepared or always prepared`,
        );
      }

      const level = await loadSpellLevel(this.dataSource, option.valueId);
      if (level == null) {
        throw new BadRequestException(
          `Unknown spell '${option.valueId}' for Spell Mastery`,
        );
      }
      if (level !== requiredLevel) {
        throw new BadRequestException(
          `Spell Mastery '${option.optionKey}' requires a level ${requiredLevel} spell (got '${option.valueId}' level ${level})`,
        );
      }
    }
  }
}
