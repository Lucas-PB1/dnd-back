#!/usr/bin/env node
/**
 * Recupera seeds do domínio subclass apagados (nome de pack = domínio).
 * Lê do git HEAD e grava em seeds/subclass/{source}/…
 */
import { execSync } from 'child_process';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
const seeds = path.join(root, 'database/seeds');

const FILES = [
  ['phb/S026_phb_subclass.sql', 'subclass/phb/phb_subclass.all.sql'],
  ['phb/S027_phb_subclass_feature.sql', 'subclass/phb/phb_subclass_feature.all.sql'],
  ['phb/S028_phb_subclass_prepared_spell.sql', 'subclass/phb/phb_subclass_prepared_spell.all.sql'],
  ['phb/S078_phb_subclass_granted_spell_supplement.sql', 'subclass/phb/phb_subclass.granted-spell-supplement.sql'],
  ['subclass/S001_phb_subclass_feature.sql', 'subclass/phb/phb_subclass_feature.phb-pack.sql'],
  ['subclass/S002_phb_resource_definition.sql', 'economy/phb/phb_resource_definition.subclass-pack.sql'],
  ['subclass/S003_phb_subclass_resource.sql', 'subclass/phb/phb_subclass.resource.sql'],
  ['subclass/S004_phb_subclass_option_def.sql', 'subclass/phb/phb_subclass.option-def.sql'],
  ['subclass/S005_phb_subclass_option_value.sql', 'subclass/phb/phb_subclass.option-value.sql'],
  ['subclass/S006_phb_spell_source.sql', 'spell/phb/phb_spell_source.subclass-pack.sql'],
  ['subclass/S007_phb_subclass_prepared_spell.sql', 'subclass/phb/phb_subclass_prepared_spell.phb-pack.sql'],
  ['subclass/S008_eldritch_knight_spellcasting.sql', 'subclass/phb/phb_subclass.eldritch-knight-spellcasting.sql'],
  ['subclass/S009_psi_warrior_table_resources.sql', 'subclass/phb/phb_subclass.psi-warrior-table-resources.sql'],
  ['subclass/S010_arcane_trickster_spellcasting.sql', 'subclass/phb/phb_subclass.arcane-trickster-spellcasting.sql'],
  ['subclass/S011_phb_subclass_option_land_lore_bm_wizard.sql', 'subclass/phb/phb_subclass.option-land-lore-bm-wizard.sql'],
  ['subclass/S012_phb_subclass_option_benefit_hunter.sql', 'subclass/phb/phb_subclass.option-benefit-hunter.sql'],
  ['valdas/V002_phb_subclass.sql', 'subclass/valdas/phb_subclass.all.sql'],
  ['valdas/V003_phb_subclass_feature.sql', 'subclass/valdas/phb_subclass_feature.all.sql'],
  ['valdas-gunslinger/G010_phb_subclass.sql', 'subclass/valdas/phb_subclass.gunslinger.sql'],
  ['valdas-gunslinger/G011_phb_subclass_feature.sql', 'subclass/valdas/phb_subclass_feature.gunslinger.sql'],
  ['valdas-gunslinger/G024_phb_subclass_spellcasting.sql', 'subclass/valdas/phb_subclass_spellcasting.gunslinger.sql'],
  ['valdas-gunslinger/G025_phb_subclass_progression.sql', 'subclass/valdas/phb_subclass_progression.gunslinger.sql'],
  ['valdas-gunslinger/G026_phb_subclass_prepared_spell.sql', 'subclass/valdas/phb_subclass_prepared_spell.gunslinger.sql'],
  ['valdas-player-pack-2/P002_phb_subclass.sql', 'subclass/valdas/phb_subclass.player-pack-2.sql'],
  ['valdas-player-pack-2/P003_phb_subclass_feature.sql', 'subclass/valdas/phb_subclass_feature.player-pack-2.sql'],
  ['valdas-player-pack-2/P012_phb_subclass_prepared_spell.sql', 'subclass/valdas/phb_subclass_prepared_spell.player-pack-2.sql'],
  ['steinhardt-eldritch-hunt/H002_phb_subclass.sql', 'subclass/steinhardt/phb_subclass.all.sql'],
  ['steinhardt-eldritch-hunt/H003_phb_subclass_feature.sql', 'subclass/steinhardt/phb_subclass_feature.all.sql'],
  ['steinhardt-eldritch-hunt/H005_phb_subclass_prepared_spell.sql', 'subclass/steinhardt/phb_subclass_prepared_spell.all.sql'],
  ['steinhardt-eldritch-hunt/H007_phb_subclass_option.sql', 'subclass/steinhardt/phb_subclass.option.sql'],
  ['northlands-heroes/N002_phb_subclass.sql', 'subclass/northlands/phb_subclass.all.sql'],
  ['northlands-heroes/N003_phb_subclass_feature.sql', 'subclass/northlands/phb_subclass_feature.all.sql'],
  ['northlands-heroes/N004_phb_subclass_prepared_spell.sql', 'subclass/northlands/phb_subclass_prepared_spell.all.sql'],
  ['griffons-saddlebag/R002_phb_subclass.sql', 'subclass/griffons-saddlebag/phb_subclass.all.sql'],
  ['griffons-saddlebag/R003_phb_subclass_feature.sql', 'subclass/griffons-saddlebag/phb_subclass_feature.all.sql'],
  ['griffons-saddlebag/R004_phb_subclass_prepared_spell.sql', 'subclass/griffons-saddlebag/phb_subclass_prepared_spell.all.sql'],
  ['griffons-saddlebag/R010_phb_subclass_resource_glacier.sql', 'subclass/griffons-saddlebag/phb_subclass.resource-glacier.sql'],
  ['griffons-saddlebag/R011_phb_subclass_resource_gsb.sql', 'subclass/griffons-saddlebag/phb_subclass.resource-gsb.sql'],
  ['grim-hollow/J027_phb_subclass.sql', 'subclass/grim-hollow/phb_subclass.all.sql'],
  ['grim-hollow/J028_phb_subclass_feature.sql', 'subclass/grim-hollow/phb_subclass_feature.all.sql'],
  ['grim-hollow/J029_phb_subclass_prepared_spell.sql', 'subclass/grim-hollow/phb_subclass_prepared_spell.all.sql'],
  ['grim-hollow/J034_catalog_subclass_images.sql', 'subclass/grim-hollow/phb_subclass.images.sql'],
  ['grim-hollow/J035_phb_subclass_option_ghpg_cap2.sql', 'subclass/grim-hollow/phb_subclass.option-ghpg-cap2.sql'],
  ['grim-hollow/J045_phb_subclass_option_sangromancer.sql', 'subclass/grim-hollow/phb_subclass.option-sangromancer.sql'],
  ['grim-hollow/J046_phb_subclass_spellcasting_sanguine_thief.sql', 'subclass/grim-hollow/phb_subclass_spellcasting.sanguine-thief.sql'],
  ['combat/C004_phb_subclass_table_action.sql', 'economy/phb/phb_subclass_table_action.all.sql'],
  ['combat/C008_phb_subclass_precaution_spell.sql', 'economy/phb/phb_subclass_precaution_spell.all.sql'],
  ['combat/C014_wizard_subclass_resources.sql', 'economy/phb/phb_subclass.wizard-resources.sql'],
  ['combat/C046_phb_subclass_table_action_eldritch_hunt.sql', 'economy/steinhardt/phb_subclass_table_action.eldritch-hunt.sql'],
  ['combat/C052_phb_subclass_table_action_northlands.sql', 'economy/northlands/phb_subclass_table_action.northlands.sql'],
  ['combat/C058_phb_subclass_table_action_griffons_saddlebag_glacier.sql', 'economy/griffons-saddlebag/phb_subclass_table_action.glacier.sql'],
  ['combat/C061_phb_subclass_table_action_griffons_saddlebag.sql', 'economy/griffons-saddlebag/phb_subclass_table_action.gsb.sql'],
  ['combat/C064_phb_subclass_table_action_grim_hollow_cap2.sql', 'economy/grim-hollow/phb_subclass_table_action.cap2.sql'],
  ['combat/C067_phb_subclass_table_action_grim_hollow_cap2_bulk.sql', 'economy/grim-hollow/phb_subclass_table_action.cap2-bulk.sql'],
  ['effects/E012_subclass.sql', 'effect/phb/phb_effect.subclass.sql'],
];

for (const [from, to] of FILES) {
  const content = execSync(`git show HEAD:database/seeds/${from}`, {
    cwd: root,
    encoding: 'utf8',
    maxBuffer: 20 * 1024 * 1024,
  });
  const dest = path.join(seeds, to);
  fs.mkdirSync(path.dirname(dest), { recursive: true });
  // skip overwrite if already good (effect.subclass may exist)
  if (fs.existsSync(dest) && to.includes('phb_effect.subclass')) {
    console.log('skip existing', to);
    continue;
  }
  fs.writeFileSync(dest, content, 'utf8');
  console.log('restored', to);
}

// remove flat legacy files left in seeds/subclass/*.sql
for (const name of fs.readdirSync(path.join(seeds, 'subclass'))) {
  const p = path.join(seeds, 'subclass', name);
  if (fs.statSync(p).isFile() && name.endsWith('.sql')) {
    fs.unlinkSync(p);
    console.log('removed flat', name);
  }
}

console.log('done');
