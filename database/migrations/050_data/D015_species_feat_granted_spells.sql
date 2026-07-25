-- Popula FKs de magia de espécie/linhagem/talento (catálogo estruturado)

UPDATE rpg.phb_elf_lineage el
SET spell_level1_id = s.id
FROM rpg.phb_spell s
WHERE el.slug = 'high-elf' AND s.slug = 'prestidigitacao-arcana';

UPDATE rpg.phb_elf_lineage el
SET spell_level1_id = s.id
FROM rpg.phb_spell s
WHERE el.slug = 'drow' AND s.slug = 'luzes-dancantes';

UPDATE rpg.phb_elf_lineage el
SET spell_level1_id = s.id
FROM rpg.phb_spell s
WHERE el.slug = 'wood-elf' AND s.slug = 'arte-druidica';

UPDATE rpg.phb_infernal_legacy il
SET spell_level1_id = s.id
FROM rpg.phb_spell s
WHERE il.slug = 'abyssal' AND s.slug = 'rajada-de-veneno';

UPDATE rpg.phb_infernal_legacy il
SET spell_level1_id = s.id
FROM rpg.phb_spell s
WHERE il.slug = 'chthonic' AND s.slug = 'toque-necrotico';

UPDATE rpg.phb_infernal_legacy il
SET spell_level1_id = s.id
FROM rpg.phb_spell s
WHERE il.slug = 'infernal' AND s.slug = 'raio-de-fogo';

UPDATE rpg.phb_gnome_lineage gl
SET
  spell_1_id = (SELECT id FROM rpg.phb_spell WHERE slug = 'prestidigitacao-arcana'),
  spell_2_id = (SELECT id FROM rpg.phb_spell WHERE slug = 'reparar')
WHERE slug = 'rock-gnome';

UPDATE rpg.phb_gnome_lineage gl
SET
  spell_1_id = (SELECT id FROM rpg.phb_spell WHERE slug = 'ilusao-menor'),
  spell_2_id = (SELECT id FROM rpg.phb_spell WHERE slug = 'falar-com-animais')
WHERE slug = 'forest-gnome';

UPDATE rpg.phb_species_trait t
SET spell_id = s.id
FROM rpg.phb_species sp, rpg.phb_spell s
WHERE t.species_id = sp.id
  AND sp.slug = 'aasimar'
  AND t.name = 'Portador da Luz'
  AND s.slug = 'luz';

UPDATE rpg.phb_species_trait t
SET spell_id = s.id
FROM rpg.phb_species sp, rpg.phb_spell s
WHERE t.species_id = sp.id
  AND sp.slug = 'tiefling'
  AND t.name = 'Presença Sobrenatural'
  AND s.slug = 'taumaturgia';

INSERT INTO rpg.phb_feat_granted_spell (feat_id, spell_id)
SELECT f.id, s.id
FROM rpg.phb_feat f
JOIN rpg.phb_spell s ON s.slug = 'passo-nebuloso'
WHERE f.slug = 'fey-touched'
ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_feat_granted_spell (feat_id, spell_id)
SELECT f.id, s.id
FROM rpg.phb_feat f
JOIN rpg.phb_spell s ON s.slug = 'invisibilidade'
WHERE f.slug = 'shadow-touched'
ON CONFLICT DO NOTHING;
