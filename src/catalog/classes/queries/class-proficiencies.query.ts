import { Injectable } from '@nestjs/common';
import { DataSource } from 'typeorm';

export type ClassProficiencies = {
  savingThrowSlugs: string[];
  savingThrowNames: string[];
  armorTrainingSlugs: string[];
  armorTrainingNames: string[];
  weaponProficiencySlugs: string[];
  weaponProficiencyNames: string[];
};

const EMPTY: ClassProficiencies = {
  savingThrowSlugs: [],
  savingThrowNames: [],
  armorTrainingSlugs: [],
  armorTrainingNames: [],
  weaponProficiencySlugs: [],
  weaponProficiencyNames: [],
};

@Injectable()
export class ClassProficienciesQuery {
  constructor(private readonly dataSource: DataSource) {}

  async forClassSlug(classSlug: string): Promise<ClassProficiencies> {
    const [savingThrows, armor, weapons] = await Promise.all([
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
    ]);

    if (!savingThrows.length && !armor.length && !weapons.length) {
      return { ...EMPTY };
    }

    return {
      savingThrowSlugs: savingThrows.map((r) => r.slug),
      savingThrowNames: savingThrows.map((r) => r.name),
      armorTrainingSlugs: armor.map((r) => r.slug),
      armorTrainingNames: armor.map((r) => r.name),
      weaponProficiencySlugs: weapons.map((r) => r.slug),
      weaponProficiencyNames: weapons.map((r) => r.label),
    };
  }
}
