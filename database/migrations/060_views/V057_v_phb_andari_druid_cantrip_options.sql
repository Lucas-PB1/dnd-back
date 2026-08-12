-- Opções de truque para Andari (lista de cantrips de Druida).
-- Kind opcional na validação padrão; exigido quando bearfolk_lineage = andari.

CREATE OR REPLACE VIEW rpg.v_phb_andari_druid_cantrip_options AS
SELECT
  'bearfolk'::text AS species_slug,
  'andari_druid_cantrip'::rpg.species_choice_kind AS choice_kind,
  s.spell_slug AS choice_slug,
  s.spell_name AS choice_name
FROM rpg.v_spell_by_class s
WHERE s.class_slug = 'druid'
  AND s.spell_level = 0
ORDER BY s.spell_name;
