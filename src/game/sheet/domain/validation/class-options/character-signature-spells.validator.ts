import { BadRequestException, Injectable } from '@nestjs/common';
import { DataSource } from 'typeorm';
import { assertUnique } from '@common/assert';
import { isWizardClass } from '@game/combat/domain/wizard';
import {
  SIGNATURE_SPELL_LEVEL,
  SIGNATURE_SPELL_UNLOCK_LEVEL,
  isSignatureSpellOptionKey,
} from '@game/combat/domain/wizard/signature-spells';
import {
  CharacterSheetContext,
  CharacterSheetInput,
} from '@game/sheet/domain/character-sheet.types';

const BOOK_LIST_TYPES = new Set(['known', 'prepared', 'always_prepared']);

@Injectable()
export class CharacterSignatureSpellsValidator {
  constructor(private readonly dataSource: DataSource) {}

  async validateSignatureSpellOptions(
    ctx: CharacterSheetContext,
    options: NonNullable<CharacterSheetInput['classOptions']>,
    characterSpells: CharacterSheetInput['characterSpells'],
  ): Promise<void> {
    const signature = options.filter((option) =>
      isSignatureSpellOptionKey(option.optionKey),
    );
    if (signature.length === 0) return;

    if (!isWizardClass(ctx.classSlug)) {
      throw new BadRequestException(
        'Assinatura Mágica só está disponível para Magos.',
      );
    }
    if (ctx.level < SIGNATURE_SPELL_UNLOCK_LEVEL) {
      throw new BadRequestException(
        `Assinatura Mágica exige Mago nível ${SIGNATURE_SPELL_UNLOCK_LEVEL}+.`,
      );
    }

    assertUnique(
      signature.map((option) => option.optionKey),
      'Opções de Assinatura Mágica duplicadas não são permitidas.',
    );
    const chosen = signature.map((option) => option.valueId);
    if (new Set(chosen).size !== chosen.length) {
      throw new BadRequestException(
        'Assinatura Mágica exige duas magias diferentes.',
      );
    }

    const inBook = new Set(
      (characterSpells ?? [])
        .filter((spell) => BOOK_LIST_TYPES.has(spell.listType))
        .map((spell) => spell.spellSlug),
    );

    for (const option of signature) {
      if (!inBook.has(option.valueId)) {
        throw new BadRequestException(
          `Assinatura Mágica '${option.valueId}' precisa estar no livro de magias.`,
        );
      }
      const rows = await this.dataSource.query<{ level: number }[]>(
        `SELECT level FROM rpg.phb_spell WHERE slug = $1 LIMIT 1`,
        [option.valueId],
      );
      if (rows.length === 0 || rows[0].level !== SIGNATURE_SPELL_LEVEL) {
        throw new BadRequestException(
          `Assinatura Mágica exige magia de ${SIGNATURE_SPELL_LEVEL}º círculo.`,
        );
      }
    }
  }
}
