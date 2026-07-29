-- Seed rpg.phb_gnome_lineage

INSERT INTO rpg.phb_gnome_lineage (slug, name, level1_benefit, spell_1_id, spell_2_id)
VALUES
  (
    'rock-gnome',
    'Gnomo das Rochas',
    'Você conhece os truques Prestidigitação Arcana e Reparar. Além disso, pode fabricar dispositivos mecânicos minúsculos com Prestidigitação Arcana.',
    (SELECT id FROM rpg.phb_spell WHERE slug = 'prestidigitacao-arcana'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'reparar')
  ),
  (
    'forest-gnome',
    'Gnomo do Bosque',
    'Você conhece o truque Ilusão Menor. Você também sempre tem a magia Falar com Animais preparada.',
    (SELECT id FROM rpg.phb_spell WHERE slug = 'ilusao-menor'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'falar-com-animais')
  )
ON CONFLICT (slug) DO UPDATE
SET
  name = EXCLUDED.name,
  level1_benefit = EXCLUDED.level1_benefit,
  spell_1_id = EXCLUDED.spell_1_id,
  spell_2_id = EXCLUDED.spell_2_id;
