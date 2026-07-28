-- Opções de truque para Alto Elfo (lista de cantrips de Mago).
-- Kind opcional: não entra nos requiredKinds da validação padrão;
-- validado no application quando presente.

CREATE OR REPLACE VIEW rpg.v_phb_high_elf_cantrip_options AS
SELECT
  'elf'::text AS species_slug,
  'high_elf_cantrip'::rpg.species_choice_kind AS choice_kind,
  s.spell_slug AS choice_slug,
  s.spell_name AS choice_name
FROM rpg.v_spell_by_class s
WHERE s.class_slug = 'wizard'
  AND s.spell_level = 0
ORDER BY s.spell_name;
