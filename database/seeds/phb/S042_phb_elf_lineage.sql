-- Seed rpg.phb_elf_lineage
-- Gerado automaticamente — não editar à mão

INSERT INTO rpg.phb_elf_lineage (slug, name, level1_benefit, spell_level3_id, spell_level5_id)
VALUES
  ('high-elf', 'Alto Elfo', 'Você conhece o truque Prestidigitação Arcana. Sempre que completar um Descanso Longo, você pode substituir este truque por um truque diferente da lista de magias de Mago.', (SELECT id FROM rpg.phb_spell WHERE slug = 'detectar-magia'), (SELECT id FROM rpg.phb_spell WHERE slug = 'passo-nebuloso')),
  ('drow', 'Drow', 'O alcance da sua Visão no Escuro aumenta para 36 metros. Você também conhece o truque Luzes Dançantes.', (SELECT id FROM rpg.phb_spell WHERE slug = 'fogo-das-fadas'), (SELECT id FROM rpg.phb_spell WHERE slug = 'escuridao')),
  ('wood-elf', 'Elfo Silvestre', 'Seu Deslocamento aumenta para 10,5 metros. Você também conhece o truque Arte Druídica.', (SELECT id FROM rpg.phb_spell WHERE slug = 'passos-largos'), (SELECT id FROM rpg.phb_spell WHERE slug = 'passo-sem-rastro'));
