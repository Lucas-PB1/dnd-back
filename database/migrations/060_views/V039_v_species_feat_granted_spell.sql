-- View unificada: magias concedidas por espécie (fixas + linhagem/legado)

CREATE OR REPLACE VIEW rpg.v_phb_species_granted_spell AS
-- Traços fixos (ex.: aasimar Luz, tiferino Taumaturgia)
SELECT
  sp.slug AS species_slug,
  NULL::rpg.species_choice_kind AS choice_kind,
  NULL::text AS choice_slug,
  1 AS unlock_level,
  s.slug AS spell_slug
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_spell s ON s.id = t.spell_id
WHERE t.spell_id IS NOT NULL

UNION ALL

-- Linhagem élfica L1 / L3 / L5
SELECT sp.slug, t.choice_kind, el.slug, 1, s.slug
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_elf_lineage el ON t.choice_kind = 'elf_lineage'::rpg.species_choice_kind
JOIN rpg.phb_spell s ON s.id = el.spell_level1_id
WHERE el.spell_level1_id IS NOT NULL
UNION ALL
SELECT sp.slug, t.choice_kind, el.slug, 3, s.slug
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_elf_lineage el ON t.choice_kind = 'elf_lineage'::rpg.species_choice_kind
JOIN rpg.phb_spell s ON s.id = el.spell_level3_id
WHERE el.spell_level3_id IS NOT NULL
UNION ALL
SELECT sp.slug, t.choice_kind, el.slug, 5, s.slug
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_elf_lineage el ON t.choice_kind = 'elf_lineage'::rpg.species_choice_kind
JOIN rpg.phb_spell s ON s.id = el.spell_level5_id
WHERE el.spell_level5_id IS NOT NULL

UNION ALL

-- Legado ínfero L1 / L3 / L5
SELECT sp.slug, t.choice_kind, il.slug, 1, s.slug
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_infernal_legacy il ON t.choice_kind = 'infernal_legacy'::rpg.species_choice_kind
JOIN rpg.phb_spell s ON s.id = il.spell_level1_id
WHERE il.spell_level1_id IS NOT NULL
UNION ALL
SELECT sp.slug, t.choice_kind, il.slug, 3, s.slug
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_infernal_legacy il ON t.choice_kind = 'infernal_legacy'::rpg.species_choice_kind
JOIN rpg.phb_spell s ON s.id = il.spell_level3_id
WHERE il.spell_level3_id IS NOT NULL
UNION ALL
SELECT sp.slug, t.choice_kind, il.slug, 5, s.slug
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_infernal_legacy il ON t.choice_kind = 'infernal_legacy'::rpg.species_choice_kind
JOIN rpg.phb_spell s ON s.id = il.spell_level5_id
WHERE il.spell_level5_id IS NOT NULL

UNION ALL

-- Linhagem gnômica (spell_1 / spell_2 no 1º nível)
SELECT sp.slug, t.choice_kind, gl.slug, 1, s.slug
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_gnome_lineage gl ON t.choice_kind = 'gnome_lineage'::rpg.species_choice_kind
JOIN rpg.phb_spell s ON s.id = gl.spell_1_id
WHERE gl.spell_1_id IS NOT NULL
UNION ALL
SELECT sp.slug, t.choice_kind, gl.slug, 1, s.slug
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_gnome_lineage gl ON t.choice_kind = 'gnome_lineage'::rpg.species_choice_kind
JOIN rpg.phb_spell s ON s.id = gl.spell_2_id
WHERE gl.spell_2_id IS NOT NULL;

-- Magias fixas de talento (além de featOptions)
CREATE OR REPLACE VIEW rpg.v_phb_feat_granted_spell AS
SELECT
  f.slug AS feat_slug,
  s.slug AS spell_slug
FROM rpg.phb_feat_granted_spell g
JOIN rpg.phb_feat f ON f.id = g.feat_id
JOIN rpg.phb_spell s ON s.id = g.spell_id;
