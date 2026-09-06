-- Recursos tipados — Grim Hollow Cap. 2 (Fase B, 17 subclasses resource-prose-only)
-- Gerado por scripts/generate-gh-cap2-phase-b-resources.mjs
-- Padrão: J030 / R011. feature_id via nome exato J028.
-- Grants: SSOT em effects/E007 (species) / E012 (subclass) / E013 (item) / E00* feats

INSERT INTO rpg.phb_resource_definition (slug, name, scope, class_id, subclass_id, min_level)
VALUES
  (
    'beast-kinship',
    'Parentesco a Feras',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit'),
    6
  ),
  (
    'skinrider-trance',
    'Transe do Cavaleiro da Pele',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit'),
    10
  ),
  (
    'shape-of-the-wild',
    'Forma do Selvagem',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'pathofthe-primal-spirit'),
    14
  ),
  (
    'gallows-humor',
    'Humor da Forca',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-fools'),
    6
  ),
  (
    'last-laugh',
    'Última Risada',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-fools'),
    14
  ),
  (
    'dual-death',
    'Dupla Morte',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'collegeof-requiems'),
    14
  ),
  (
    'witch-hunters-strike',
    'Golpe do Caçador de Bruxas',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'inquisition-domain'),
    3
  ),
  (
    'rebuke-invoker',
    'Repreender Invocador',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'inquisition-domain'),
    6
  ),
  (
    'purify-with-fire',
    'Purificar com Fogo',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'purification-domain'),
    3
  ),
  (
    'blood-boon',
    'Dádiva de Sangue',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'circleof-blood'),
    6
  ),
  (
    'exsanguinate',
    'Exsanguinar',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'circleof-blood'),
    14
  ),
  (
    'shake-the-earth',
    'Sacudir a Terra',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'circleof-entropy'),
    10
  ),
  (
    'plaguebringer',
    'Portador da Peste',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'oathof-pestilence'),
    20
  ),
  (
    'blood-knight',
    'Cavaleiro de Sangue',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'oathof-slaughter'),
    20
  ),
  (
    'apocalyptic-revelation',
    'Revelação Apocalíptica',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'oathof-zeal'),
    20
  ),
  (
    'envenomed-attack',
    'Ataque Envenenado',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'green-reaper'),
    3
  ),
  (
    'poison-control',
    'Controle de Veneno',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'green-reaper'),
    7
  ),
  (
    'elemental-arrows',
    'Flechas Elementais',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'primordial-archer'),
    3
  ),
  (
    'herbal-lore',
    'Conhecimento Herbal',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'primordial-archer'),
    3
  ),
  (
    'primordial-magic',
    'Magia Primordial',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'primordial-archer'),
    15
  ),
  (
    'verminkin',
    'Verminata',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'vermin-lord'),
    3
  ),
  (
    'swarming-strikes',
    'Golpes do Enxame',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'vermin-lord'),
    3
  ),
  (
    'steal-blood',
    'Roubar Sangue',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'sanguine-thief'),
    3
  ),
  (
    'bloodstitch',
    'Costura Sangrenta',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'sanguine-thief'),
    13
  ),
  (
    'bloody-exit',
    'Saída Sanguinária',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'sanguine-thief'),
    17
  ),
  (
    'hags-eye',
    'Olho da Bruxa',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-coven'),
    3
  ),
  (
    'hags-guile',
    'Astúcia da Bruxa',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-coven'),
    6
  ),
  (
    'hags-visage',
    'Semblante da Bruxa',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-coven'),
    10
  ),
  (
    'hags-craft',
    'Ofício da Bruxa',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-coven'),
    14
  ),
  (
    'creature-of-the-night',
    'Criatura da Noite',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-first-vampire-patron'),
    6
  ),
  (
    'eldritch-appetite',
    'Apetite Eldritch',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-first-vampire-patron'),
    10
  ),
  (
    'eternal-night',
    'Eterna Noite',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'the-first-vampire-patron'),
    14
  ),
  (
    'stolen-power',
    'Poder Roubado (Dados de Sangromancia)',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'sanguine-thief'),
    3
  )
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  subclass_id = EXCLUDED.subclass_id,
  min_level = EXCLUDED.min_level;




































































-- Roubado Poder: máx. = dados de Furtivo (faixas fixed; sem enum sneak_attack)


















