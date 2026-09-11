import { Repository } from 'typeorm';
import { requireCatalog } from '../common/assert';
import { requireFound } from '../common/require-found';
import { PhbAbilityGenerationMethod } from '../entities/reference/phb-ability-generation-method.entity';
import { PhbItem } from '../entities/equipment/phb-item.entity';
import { PhbLanguage } from '../entities/reference/phb-language.entity';
import { PhbSkill } from '../entities/reference/phb-skill.entity';
import { VPhbSpell } from '../entities/views/v-phb-spell.entity';

export async function findSpellOrFail(
  spellsRepo: Repository<VPhbSpell>,
  spellSlug: string,
): Promise<VPhbSpell> {
  return requireFound(
    await spellsRepo.findOne({ where: { slug: spellSlug } }),
    `Spell '${spellSlug}' not found in catalog`,
  );
}

export async function assertSpellInCatalog(
  spellsRepo: Repository<VPhbSpell>,
  spellSlug: string,
): Promise<VPhbSpell> {
  return requireCatalog(
    await spellsRepo.findOne({ where: { slug: spellSlug } }),
    `Spell '${spellSlug}' not found in catalog`,
  );
}

export async function findItemOrFail(
  itemsRepo: Repository<PhbItem>,
  itemSlug: string,
): Promise<PhbItem> {
  return requireFound(
    await itemsRepo.findOne({ where: { slug: itemSlug } }),
    `Item '${itemSlug}' not found`,
  );
}

export async function assertItemInCatalog(
  itemsRepo: Repository<PhbItem>,
  itemSlug: string,
): Promise<PhbItem> {
  return requireCatalog(
    await itemsRepo.findOne({ where: { slug: itemSlug } }),
    `Item '${itemSlug}' not found in catalog`,
  );
}

export async function findLanguageOrFail(
  languagesRepo: Repository<PhbLanguage>,
  slug: string,
): Promise<PhbLanguage> {
  return requireFound(
    await languagesRepo.findOne({ where: { slug } }),
    `Language '${slug}' not found`,
  );
}

export async function assertLanguageInCatalog(
  languagesRepo: Repository<PhbLanguage>,
  slug: string,
): Promise<PhbLanguage> {
  return requireCatalog(
    await languagesRepo.findOne({ where: { slug } }),
    `Language '${slug}' not found in catalog`,
  );
}

export async function findSkillOrFail(
  skillsRepo: Repository<PhbSkill>,
  slug: string,
): Promise<PhbSkill> {
  return requireFound(
    await skillsRepo.findOne({ where: { slug } }),
    `Skill '${slug}' not found`,
  );
}

export async function assertAbilityGenerationMethodSlug(
  abilityMethodsRepo: Repository<PhbAbilityGenerationMethod>,
  slug: string,
): Promise<void> {
  requireCatalog(
    await abilityMethodsRepo.findOne({ where: { slug } }),
    `Ability generation method '${slug}' not found in catalog`,
  );
}
