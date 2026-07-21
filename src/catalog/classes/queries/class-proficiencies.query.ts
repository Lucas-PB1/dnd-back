import { Injectable } from '@nestjs/common';
import { DataSource } from 'typeorm';

export type ClassProficiencies = {
  savingThrowSlugs: string[];
  savingThrowNames: string[];
  armorTrainingSlugs: string[];
  armorTrainingNames: string[];
  weaponProficiencySlugs: string[];
  weaponProficiencyNames: string[];
  fightingStyleSlugs: string[];
  fightingStyleNames: string[];
};

const EMPTY: ClassProficiencies = {
  savingThrowSlugs: [],
  savingThrowNames: [],
  armorTrainingSlugs: [],
  armorTrainingNames: [],
  weaponProficiencySlugs: [],
  weaponProficiencyNames: [],
  fightingStyleSlugs: [],
  fightingStyleNames: [],
};

@Injectable()
export class ClassProficienciesQuery {
  constructor(private readonly dataSource: DataSource) {}

  async forClassSlug(classSlug: string): Promise<ClassProficiencies> {
    const [savingThrows, armor, weapons, fightingStyles] = await Promise.all([
      this.dataSource.query<{ slug: string; name: string }[]>(
        `SELECT a.slug, a.name
         FROM rpg.phb_class c
         JOIN rpg.phb_class_saving_throw cst ON cst.class_id = c.id
         JOIN rpg.phb_ability a ON a.id = cst.ability_id
         WHERE c.slug = $1
         ORDER BY a.id`,
        [classSlug],
      ),
      this.dataSource.query<{ slug: string; name: string }[]>(
        `SELECT ac.slug, ac.name
         FROM rpg.phb_class c
         JOIN rpg.phb_class_armor_training cat ON cat.class_id = c.id
         JOIN rpg.phb_armor_category ac ON ac.id = cat.category_id
         WHERE c.slug = $1
         ORDER BY ac.sort_order, ac.id`,
        [classSlug],
      ),
      this.dataSource.query<{ slug: string; label: string }[]>(
        `SELECT wp.slug, wp.label
         FROM rpg.phb_class c
         JOIN rpg.phb_class_weapon_proficiency cwp ON cwp.class_id = c.id
         JOIN rpg.phb_weapon_proficiency wp ON wp.id = cwp.proficiency_id
         WHERE c.slug = $1
         ORDER BY wp.id`,
        [classSlug],
      ),
      this.dataSource.query<{ slug: string; name: string }[]>(
        `SELECT fs.slug, fs.name
         FROM rpg.phb_class c
         JOIN rpg.phb_class_fighting_style cfs ON cfs.class_id = c.id
         JOIN rpg.phb_fighting_style fs ON fs.id = cfs.fighting_style_id
         WHERE c.slug = $1
         ORDER BY fs.slug`,
        [classSlug],
      ),
    ]);

    if (!savingThrows.length && !armor.length && !weapons.length && !fightingStyles.length) {
      return { ...EMPTY };
    }

    return {
      savingThrowSlugs: savingThrows.map((r) => r.slug),
      savingThrowNames: savingThrows.map((r) => r.name),
      armorTrainingSlugs: armor.map((r) => r.slug),
      armorTrainingNames: armor.map((r) => r.name),
      weaponProficiencySlugs: weapons.map((r) => r.slug),
      weaponProficiencyNames: weapons.map((r) => r.label),
      fightingStyleSlugs: fightingStyles.map((r) => r.slug),
      fightingStyleNames: fightingStyles.map((r) => r.name),
    };
  }
}
