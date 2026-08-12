import { BadRequestException, Injectable } from '@nestjs/common';
import { DataSource } from 'typeorm';
import { assertUnique } from '@common/assert';
import {
  isMysticArcanumOptionKey,
  isWarlockClass,
  mysticArcanumSlotsAtLevel,
  mysticArcanumSpellLevelForKey,
} from '@game/combat/domain/warlock';
import {
  CharacterSheetContext,
  CharacterSheetInput,
} from '@game/sheet/domain/character-sheet.types';

@Injectable()
export class CharacterMysticArcanumValidator {
  constructor(private readonly dataSource: DataSource) {}

  async validateMysticArcanumOptions(
    ctx: CharacterSheetContext,
    options: NonNullable<CharacterSheetInput['classOptions']>,
  ): Promise<void> {
    const arcanum = options.filter((option) =>
      isMysticArcanumOptionKey(option.optionKey),
    );
    if (arcanum.length === 0) return;

    if (!isWarlockClass(ctx.classSlug)) {
      throw new BadRequestException(
        'Arcana Mística só está disponível para Bruxos.',
      );
    }

    const unlocked = mysticArcanumSlotsAtLevel(ctx.level);
    const unlockedKeys = new Set<string>(unlocked.map((slot) => slot.optionKey));
    assertUnique(
      arcanum.map((option) => option.optionKey),
      'Opções de Arcana Mística duplicadas não são permitidas.',
    );
    assertUnique(
      arcanum.map((option) => option.valueId),
      'As magias de Arcana Mística devem ser distintas.',
    );

    for (const option of arcanum) {
      if (!unlockedKeys.has(option.optionKey)) {
        throw new BadRequestException(
          `Arcana Mística '${option.optionKey}' desbloqueia depois do nível ${ctx.level}.`,
        );
      }
      const spellLevel = mysticArcanumSpellLevelForKey(option.optionKey);
      const rows = await this.dataSource.query<{ ok: number }[]>(
        `SELECT 1 AS ok
         FROM rpg.v_spell_by_class
         WHERE class_slug = 'warlock'
           AND spell_slug = $1
           AND spell_level = $2
         LIMIT 1`,
        [option.valueId, spellLevel],
      );
      if (rows.length === 0) {
        throw new BadRequestException(
          `Arcana Mística '${option.optionKey}' exige magia de Bruxo de ${spellLevel}º círculo.`,
        );
      }
    }
  }
}
