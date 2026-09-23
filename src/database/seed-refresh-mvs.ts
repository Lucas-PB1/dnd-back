import { DataSource } from 'typeorm';

const MATERIALIZED_VIEWS = [
  'mv_spell_by_class',
  'mv_phb_feat',
  'mv_phb_background',
  'mv_phb_species_trait_choices',
  'mv_phb_class_economy_action',
  'mv_phb_creature_template_bundle',
  'mv_phb_vehicle_template_bundle',
  'mv_phb_character_thread_bundle',
  'mv_phb_hp_bonus_source',
  'mv_phb_unarmored_defense',
  'mv_class_spell_slots',
  'mv_subclass_spell_slots',
  'mv_phb_class_ability_boost',
  'mv_phb_feat_granted_spell',
  'mv_phb_class_granted_spell',
  'mv_phb_heritage_trait_choices',
] as const;

export async function refreshCatalogMaterializedViews(
  ds: DataSource,
): Promise<void> {
  for (const name of MATERIALIZED_VIEWS) {
    process.stdout.write(`  refresh rpg.${name}... `);
    await ds.query(`REFRESH MATERIALIZED VIEW CONCURRENTLY rpg.${name}`);
    console.log('ok');
  }
}
