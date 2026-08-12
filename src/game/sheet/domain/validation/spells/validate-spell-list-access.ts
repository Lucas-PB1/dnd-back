import { BadRequestException } from '@nestjs/common';
import { Repository } from 'typeorm';
import { VSpellByClass } from '@entities/views/v-spell-by-class.entity';
import { VPhbSubclassPreparedSpell } from '@entities/views/v-phb-subclass-prepared-spell.entity';
import { CharacterSheetContext } from '@game/sheet/domain/character-sheet.types';
import { CharacterSheetInput } from '@game/sheet/domain/character-sheet.types';
import { resolveLandTerrainSlug } from '@game/sheet/domain/validation/class-options/subclass-option-effects';

export async function validateSpellListAccess(
  classSpellsRepo: Repository<VSpellByClass>,
  subclassSpellsRepo: Repository<VPhbSubclassPreparedSpell>,
  spells: NonNullable<CharacterSheetInput['characterSpells']>,
  ctx: CharacterSheetContext,
  featGranted: ReadonlySet<string>,
  speciesGranted: ReadonlySet<string>,
  spellListClassSlug: string,
  maxSpellLevel: number,
  extraGranted: ReadonlySet<string> = new Set(),
  extraListClassSlugs: readonly string[] = [],
  subclassOptions?: CharacterSheetInput['subclassOptions'],
): Promise<void> {
  const landTerrain = resolveLandTerrainSlug(ctx.subclassSlug, subclassOptions);
  for (const spell of spells) {
    if (featGranted.has(spell.spellSlug)) continue;
    if (speciesGranted.has(spell.spellSlug)) continue;
    if (extraGranted.has(spell.spellSlug)) continue;

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

    const landSubclassMatch =
      inSubclass &&
      ctx.subclassSlug === 'land' &&
      inSubclass.terrainSlug != null &&
      inSubclass.terrainSlug !== landTerrain;

    const subclassAllowed = inSubclass && !landSubclassMatch;

    let extraListMeta: { spellLevel: number } | null = null;
    if (!inListClass && !inClass && !inSubclass) {
      for (const extraSlug of extraListClassSlugs) {
        extraListMeta = await classSpellsRepo.findOne({
          where: { classSlug: extraSlug, spellSlug: spell.spellSlug },
        });
        if (extraListMeta) break;
      }
    }

    if (!inListClass && !inClass && !subclassAllowed && !extraListMeta) {
      throw new BadRequestException(
        `Spell '${spell.spellSlug}' is not available for this character's class/subclass/feats/species`,
      );
    }

    const listMeta = inListClass ?? inClass ?? extraListMeta;
    if (listMeta && !subclassAllowed && listMeta.spellLevel > maxSpellLevel) {
      throw new BadRequestException(
        `Spell '${spell.spellSlug}' (circle ${listMeta.spellLevel}) exceeds max circle ${maxSpellLevel} for ${ctx.classSlug} level ${ctx.level}`,
      );
    }
  }
}
