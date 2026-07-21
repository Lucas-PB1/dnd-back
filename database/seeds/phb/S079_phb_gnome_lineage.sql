-- Seed rpg.phb_gnome_lineage

INSERT INTO rpg.phb_gnome_lineage (slug, name, level1_benefit)
VALUES
  (
    'rock-gnome',
    'Gnomo das Rochas',
    'Você conhece os truques Prestidigitação Arcana e Reparar. Além disso, pode fabricar dispositivos mecânicos minúsculos com Prestidigitação Arcana.'
  ),
  (
    'forest-gnome',
    'Gnomo do Bosque',
    'Você conhece o truque Ilusão Menor. Você também sempre tem a magia Falar com Animais preparada.'
  )
ON CONFLICT (slug) DO UPDATE
SET
  name = EXCLUDED.name,
  level1_benefit = EXCLUDED.level1_benefit;
