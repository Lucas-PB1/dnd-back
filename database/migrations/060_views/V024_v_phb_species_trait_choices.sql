-- View rpg.v_phb_species_trait_choices

CREATE OR REPLACE VIEW rpg.v_phb_species_trait_choices AS
SELECT
  sp.slug AS species_slug,
  t.name AS trait_name,
  t.choice_kind,
  el.slug AS choice_slug,
  el.name AS choice_name,
  el.level1_benefit,
  s3.slug AS spell_level3_slug,
  s5.slug AS spell_level5_slug,
  NULL::text AS damage_type
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_elf_lineage el ON t.choice_kind = 'elf_lineage'
LEFT JOIN rpg.phb_spell s3 ON s3.id = el.spell_level3_id
LEFT JOIN rpg.phb_spell s5 ON s5.id = el.spell_level5_id
UNION ALL
SELECT
  sp.slug,
  t.name,
  t.choice_kind,
  il.slug,
  il.name,
  il.level1_benefit,
  s3.slug,
  s5.slug,
  NULL::text
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_infernal_legacy il ON t.choice_kind = 'infernal_legacy'
LEFT JOIN rpg.phb_spell s3 ON s3.id = il.spell_level3_id
LEFT JOIN rpg.phb_spell s5 ON s5.id = il.spell_level5_id
UNION ALL
SELECT
  sp.slug,
  t.name,
  t.choice_kind,
  da.slug,
  da.name,
  NULL::text,
  NULL::text,
  NULL::text,
  da.damage_type
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_dragon_ancestry da ON t.choice_kind = 'dragon_ancestry';
