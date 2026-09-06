-- Magias fixas concedidas pelas Bênçãos de origem Northlands

INSERT INTO rpg.phb_spell_grant (origin_type, origin_id, spell_id, unlock_level)
VALUES
  (
    'feat'::rpg.spell_grant_origin,
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-baldur'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'chama-sagrada'),
    1
  ),
  (
    'feat'::rpg.spell_grant_origin,
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-boreas'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'raio-de-gelo'),
    1
  ),
  (
    'feat'::rpg.spell_grant_origin,
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-freyr-and-freyja'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'arte-druidica'),
    1
  ),
  (
    'feat'::rpg.spell_grant_origin,
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-freyr-and-freyja'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'chicote-de-espinhos'),
    1
  ),
  (
    'feat'::rpg.spell_grant_origin,
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-jormungandr'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'amizade-animal'),
    1
  ),
  (
    'feat'::rpg.spell_grant_origin,
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-jormungandr'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'falar-com-animais'),
    1
  ),
  (
    'feat'::rpg.spell_grant_origin,
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-loki'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'ilusao-menor'),
    1
  ),
  (
    'feat'::rpg.spell_grant_origin,
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-loki'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'zombaria-perversa'),
    1
  ),
  (
    'feat'::rpg.spell_grant_origin,
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-sif'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'golpe-certeiro'),
    1
  ),
  (
    'feat'::rpg.spell_grant_origin,
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-thor'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'destruicao-estrondosa'),
    1
  ),
  (
    'feat'::rpg.spell_grant_origin,
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-volund'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'elementalismo'),
    1
  ),
  (
    'feat'::rpg.spell_grant_origin,
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-volund'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'reparar'),
    1
  ),
  (
    'feat'::rpg.spell_grant_origin,
    (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-wotan'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'orientacao'),
    1
  )
ON CONFLICT (origin_type, origin_id, spell_id, unlock_level) DO NOTHING;
