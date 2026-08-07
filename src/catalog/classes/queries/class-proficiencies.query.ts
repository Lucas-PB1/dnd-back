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
         JOIN rpg.phb_class_proficiency cp
           ON cp.class_id = c.id AND cp.kind = 'saving_throw'::rpg.class_proficiency_kind
         JOIN rpg.phb_ability a ON a.id = cp.ref_id
         WHERE c.slug = $1
         ORDER BY a.id`,
        [classSlug],
      ),
      this.dataSource.query<{ slug: string; name: string }[]>(
        `SELECT ac.slug, ac.name
         FROM rpg.phb_class c
         JOIN rpg.phb_class_proficiency cp
           ON cp.class_id = c.id AND cp.kind = 'armor_training'::rpg.class_proficiency_kind
         JOIN rpg.phb_armor_category ac ON ac.id = cp.ref_id
         WHERE c.slug = $1
         ORDER BY ac.sort_order, ac.id`,
        [classSlug],
      ),
      this.dataSource.query<{ slug: string; label: string }[]>(
        `SELECT cp.ref_slug AS slug, wp.label
         FROM rpg.phb_class c
         JOIN rpg.phb_class_proficiency cp
           ON cp.class_id = c.id AND cp.kind = 'weapon'::rpg.class_proficiency_kind
         JOIN rpg.v_phb_weapon_proficiency wp ON wp.slug = cp.ref_slug
         WHERE c.slug = $1
         ORDER BY cp.ref_slug`,
        [classSlug],
      ),
      this.dataSource.query<{ slug: string; name: string }[]>(
        `SELECT fs.slug, fs.name
         FROM rpg.phb_class c
         JOIN rpg.phb_class_proficiency cp
           ON cp.class_id = c.id AND cp.kind = 'fighting_style'::rpg.class_proficiency_kind
         JOIN rpg.phb_fighting_style fs ON fs.id = cp.ref_id
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
