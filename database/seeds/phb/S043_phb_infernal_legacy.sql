-- Seed rpg.phb_infernal_legacy
-- Gerado automaticamente — não editar à mão

INSERT INTO rpg.phb_infernal_legacy (slug, name, level1_benefit, spell_level3_id, spell_level5_id)
VALUES
  ('abyssal', 'Abissal', 'Você tem Resistência a dano Venenoso. Você também conhece o truque Rajada de Veneno.', (SELECT id FROM rpg.phb_spell WHERE slug = 'raio-nauseante'), (SELECT id FROM rpg.phb_spell WHERE slug = 'paralisar-pessoa')),
  ('chthonic', 'Ctônico', 'Você tem Resistência a dano Necrótico. Você também conhece o truque Toque Necrótico.', (SELECT id FROM rpg.phb_spell WHERE slug = 'vitalidade-vazia'), (SELECT id FROM rpg.phb_spell WHERE slug = 'raio-do-enfraquecimento')),
  ('infernal', 'Infernal', 'Você tem Resistência a dano Ígneo. Você também conhece o truque Raio de Fogo.', (SELECT id FROM rpg.phb_spell WHERE slug = 'repreensao-diabolica'), (SELECT id FROM rpg.phb_spell WHERE slug = 'escuridao'));
