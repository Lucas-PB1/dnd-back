import { BadRequestException } from '@nestjs/common';
import { In, Repository } from 'typeorm';
import { VSpellByClass } from '@entities/views/v-spell-by-class.entity';
import { VPhbSubclassPreparedSpell } from '@entities/views/v-phb-subclass-prepared-spell.entity';
import { CharacterSheetContext } from '@game/sheet/domain/character-sheet.types';
import { CharacterSheetInput } from '@game/sheet/domain/character-sheet.types';
import { resolveLandTerrainSlug } from '@game/sheet/domain/validation/class-options/subclass-option-effects';

type SpellListMeta = { spellLevel: number };

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
  sangromancyAllowedSlugs: ReadonlySet<string> = new Set(),
): Promise<void> {
  const pending = spells.filter(
    (spell) =>
      !featGranted.has(spell.spellSlug) &&
      !speciesGranted.has(spell.spellSlug) &&
      !extraGranted.has(spell.spellSlug),
  );
  if (pending.length === 0) return;

  const spellSlugs = [...new Set(pending.map((spell) => spell.spellSlug))];
  const classSlugs = [
    ...new Set(
      [spellListClassSlug, ctx.classSlug, ...extraListClassSlugs].filter(Boolean),
    ),
  ];

  const [classRows, subclassRows] = await Promise.all([
    classSpellsRepo.find({
      where: {
        classSlug: In(classSlugs),
        spellSlug: In(spellSlugs),
      },
    }),
    ctx.subclassSlug
      ? subclassSpellsRepo.find({
          where: {
            subclassSlug: ctx.subclassSlug,
            spellSlug: In(spellSlugs),
          },
        })
      : Promise.resolve([]),
  ]);

  const classByKey = new Map(
    classRows.map((row) => [`${row.classSlug}:${row.spellSlug}`, row] as const),
  );
  const subclassBySpell = new Map(
    subclassRows.map((row) => [row.spellSlug, row] as const),
  );
  const landTerrain = resolveLandTerrainSlug(ctx.subclassSlug, subclassOptions);

  const sangromancyOnlySlugs = spellSlugs.filter(
    (slug) =>
      sangromancyAllowedSlugs.has(slug) &&
      !classByKey.has(`${spellListClassSlug}:${slug}`) &&
      !classByKey.has(`${ctx.classSlug}:${slug}`) &&
      !subclassBySpell.has(slug),
  );
  const sangromancyLevelBySlug = new Map<string, number>();
  if (sangromancyOnlySlugs.length > 0) {
    const rows = await classSpellsRepo.manager.query<
      { slug: string; level: number }[]
    >(
      `SELECT slug, level
       FROM rpg.phb_spell
       WHERE slug = ANY($1::text[])`,
      [sangromancyOnlySlugs],
    );
    for (const row of rows) {
      sangromancyLevelBySlug.set(row.slug, Number(row.level));
    }
  }

  for (const spell of pending) {
    const inListClass = classByKey.get(`${spellListClassSlug}:${spell.spellSlug}`);
    const inClass =
      spellListClassSlug === ctx.classSlug
        ? inListClass
        : classByKey.get(`${ctx.classSlug}:${spell.spellSlug}`);
    const inSubclass = subclassBySpell.get(spell.spellSlug);

    const landSubclassMatch =
      inSubclass &&
      ctx.subclassSlug === 'land' &&
      inSubclass.terrainSlug != null &&
      inSubclass.terrainSlug !== landTerrain;

    const subclassAllowed = Boolean(inSubclass && !landSubclassMatch);

    let extraListMeta: SpellListMeta | null = null;
    if (!inListClass && !inClass && !inSubclass) {
      for (const extraSlug of extraListClassSlugs) {
        const hit = classByKey.get(`${extraSlug}:${spell.spellSlug}`);
        if (hit) {
          extraListMeta = hit;
          break;
        }
      }
    }

    if (!inListClass && !inClass && !subclassAllowed && !extraListMeta) {
      if (!sangromancyAllowedSlugs.has(spell.spellSlug)) {
        throw new BadRequestException(
          `Spell '${spell.spellSlug}' is not available for this character's class/subclass/feats/species`,
        );
      }
    }

    const listMeta = inListClass ?? inClass ?? extraListMeta;
    const sangromancyOnly =
      !listMeta && sangromancyAllowedSlugs.has(spell.spellSlug);
    if (
      listMeta &&
      !subclassAllowed &&
      listMeta.spellLevel > maxSpellLevel
    ) {
      throw new BadRequestException(
        `Spell '${spell.spellSlug}' (circle ${listMeta.spellLevel}) exceeds max circle ${maxSpellLevel} for ${ctx.classSlug} level ${ctx.level}`,
      );
    }
    if (sangromancyOnly) {
      const sangLevel = sangromancyLevelBySlug.get(spell.spellSlug) ?? 0;
      if (sangLevel > maxSpellLevel) {
        throw new BadRequestException(
          `Spell '${spell.spellSlug}' (circle ${sangLevel}) exceeds max circle ${maxSpellLevel} for ${ctx.classSlug} level ${ctx.level}`,
        );
      }
    }
  }
}
