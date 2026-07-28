import { BadRequestException } from '@nestjs/common';
import { Repository } from 'typeorm';
import { VSpellByClass } from '../../../../../entities/views/v-spell-by-class.entity';
import { VPhbSubclassPreparedSpell } from '../../../../../entities/views/v-phb-subclass-prepared-spell.entity';
import { CharacterSheetContext } from '../../character-sheet.types';
import { CharacterSheetInput } from '../../character-sheet.types';

export async function validateSpellListAccess(
  classSpellsRepo: Repository<VSpellByClass>,
  subclassSpellsRepo: Repository<VPhbSubclassPreparedSpell>,
  spells: NonNullable<CharacterSheetInput['characterSpells']>,
  ctx: CharacterSheetContext,
  featGranted: ReadonlySet<string>,
  speciesGranted: ReadonlySet<string>,
  spellListClassSlug: string,
  maxSpellLevel: number,
): Promise<void> {
  for (const spell of spells) {
    if (featGranted.has(spell.spellSlug)) continue;
    if (speciesGranted.has(spell.spellSlug)) continue;

    const inListClass = await classSpellsRepo.findOne({
      where: {
        classSlug: spellListClassSlug,
        spellSlug: spell.spellSlug,
      },
    });

    const inClass =
      spellListClassSlug === ctx.classSlug
        ? inListClass
        : await classSpellsRepo.findOne({
            where: {
              classSlug: ctx.classSlug,
              spellSlug: spell.spellSlug,
            },
          });

    const inSubclass =
      ctx.subclassSlug &&
      (await subclassSpellsRepo.findOne({
        where: {
          subclassSlug: ctx.subclassSlug,
          spellSlug: spell.spellSlug,
        },
      }));

    if (!inListClass && !inClass && !inSubclass) {
      throw new BadRequestException(
        `Spell '${spell.spellSlug}' is not available for this character's class/subclass/feats/species`,
      );
    }

    const listMeta = inListClass ?? inClass;
    if (listMeta && !inSubclass && listMeta.spellLevel > maxSpellLevel) {
      throw new BadRequestException(
        `Spell '${spell.spellSlug}' (circle ${listMeta.spellLevel}) exceeds max circle ${maxSpellLevel} for ${ctx.classSlug} level ${ctx.level}`,
      );
    }
  }
}
