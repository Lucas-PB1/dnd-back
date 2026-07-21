-- Seed rpg.phb_feat_option_* — espelha migrations 050_data D002–D010
-- Regenerar: npm run db:sync:feat-option-seeds
-- Idempotente após db:migrate (ON CONFLICT / UPDATE seguros)

-- --- D002_elemental_adept_feat_options.sql ---
-- Adepto Elemental — +1 INT/SAB/CAR e tipo de dano (Domínio Elemental)

INSERT INTO rpg.phb_feat_option_def (feat_id, option_key, label, value_type, sort_order)
VALUES
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'elemental-adept'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'elemental-adept'), 'damageType', 'Domínio Elemental (tipo de dano)', 'catalog', 2)
ON CONFLICT (feat_id, option_key) DO NOTHING;

INSERT INTO rpg.phb_feat_option_value (feat_id, option_key, value_id, label, sort_order)
VALUES
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'elemental-adept'), 'abilityIncrease', 'inteligencia', 'Inteligência', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'elemental-adept'), 'abilityIncrease', 'sabedoria', 'Sabedoria', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'elemental-adept'), 'abilityIncrease', 'carisma', 'Carisma', 3),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'elemental-adept'), 'damageType', 'acid', 'Ácido', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'elemental-adept'), 'damageType', 'lightning', 'Elétrico', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'elemental-adept'), 'damageType', 'cold', 'Gélido', 3),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'elemental-adept'), 'damageType', 'fire', 'Ígneo', 4),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'elemental-adept'), 'damageType', 'thunder', 'Trovejante', 5)
ON CONFLICT (feat_id, option_key, value_id) DO NOTHING;

-- --- D003_feat_ability_increase_bulk.sql ---
-- Gerado por scripts/generate-feat-asi-options.mjs — 53 talentos

INSERT INTO rpg.phb_feat_option_def (feat_id, option_key, label, value_type, sort_order)
VALUES
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'charger'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'observant'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'spell-sniper'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'athlete'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'actor'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'chef'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'mounted-combatant'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'war-caster'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'ritual-caster'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-fortitude'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-combat-prowess'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-skill-proficiency'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-spell-recall'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-recovery'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-energy-resistance'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-speed'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-dimensional-travel'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-truesight'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-irresistible-offense'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-fate'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-the-night-spirit'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'defensive-duelist'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'poisoner'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'crusher'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'dual-wielder'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'lightly-armored'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'moderately-armored'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'heavily-armored'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'crossbow-expert'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'skill-expert'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'mage-slayer'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'grappler'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'inspiring-leader'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'keen-mind'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'weapon-master'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'medium-armor-master'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'heavy-armor-master'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'polearm-master'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'great-weapon-master'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'shield-master'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'sharpshooter'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'piercer'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'resilient'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'durable'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'sentinel'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'stealthy'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'slasher'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'telekinetic'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'telepathic'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'shadow-touched'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'fey-touched'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'martial-weapon-training'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'mobile'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1)
ON CONFLICT (feat_id, option_key) DO NOTHING;

INSERT INTO rpg.phb_feat_option_value (feat_id, option_key, value_id, label, sort_order)
VALUES
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'charger'), 'abilityIncrease', 'forca', 'Força', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'charger'), 'abilityIncrease', 'destreza', 'Destreza', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'observant'), 'abilityIncrease', 'inteligencia', 'Inteligência', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'observant'), 'abilityIncrease', 'sabedoria', 'Sabedoria', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'spell-sniper'), 'abilityIncrease', 'inteligencia', 'Inteligência', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'spell-sniper'), 'abilityIncrease', 'sabedoria', 'Sabedoria', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'spell-sniper'), 'abilityIncrease', 'carisma', 'Carisma', 3),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'athlete'), 'abilityIncrease', 'forca', 'Força', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'athlete'), 'abilityIncrease', 'destreza', 'Destreza', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'actor'), 'abilityIncrease', 'carisma', 'Carisma', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'chef'), 'abilityIncrease', 'constituicao', 'Constituição', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'chef'), 'abilityIncrease', 'sabedoria', 'Sabedoria', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'mounted-combatant'), 'abilityIncrease', 'forca', 'Força', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'mounted-combatant'), 'abilityIncrease', 'destreza', 'Destreza', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'mounted-combatant'), 'abilityIncrease', 'sabedoria', 'Sabedoria', 3),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'war-caster'), 'abilityIncrease', 'inteligencia', 'Inteligência', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'war-caster'), 'abilityIncrease', 'sabedoria', 'Sabedoria', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'war-caster'), 'abilityIncrease', 'carisma', 'Carisma', 3),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'ritual-caster'), 'abilityIncrease', 'inteligencia', 'Inteligência', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'ritual-caster'), 'abilityIncrease', 'sabedoria', 'Sabedoria', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'ritual-caster'), 'abilityIncrease', 'carisma', 'Carisma', 3),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-fortitude'), 'abilityIncrease', 'forca', 'Força', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-fortitude'), 'abilityIncrease', 'destreza', 'Destreza', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-fortitude'), 'abilityIncrease', 'constituicao', 'Constituição', 3),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-fortitude'), 'abilityIncrease', 'inteligencia', 'Inteligência', 4),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-fortitude'), 'abilityIncrease', 'sabedoria', 'Sabedoria', 5),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-fortitude'), 'abilityIncrease', 'carisma', 'Carisma', 6),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-combat-prowess'), 'abilityIncrease', 'forca', 'Força', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-combat-prowess'), 'abilityIncrease', 'destreza', 'Destreza', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-combat-prowess'), 'abilityIncrease', 'constituicao', 'Constituição', 3),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-combat-prowess'), 'abilityIncrease', 'inteligencia', 'Inteligência', 4),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-combat-prowess'), 'abilityIncrease', 'sabedoria', 'Sabedoria', 5),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-combat-prowess'), 'abilityIncrease', 'carisma', 'Carisma', 6),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-skill-proficiency'), 'abilityIncrease', 'forca', 'Força', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-skill-proficiency'), 'abilityIncrease', 'destreza', 'Destreza', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-skill-proficiency'), 'abilityIncrease', 'constituicao', 'Constituição', 3),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-skill-proficiency'), 'abilityIncrease', 'inteligencia', 'Inteligência', 4),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-skill-proficiency'), 'abilityIncrease', 'sabedoria', 'Sabedoria', 5),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-skill-proficiency'), 'abilityIncrease', 'carisma', 'Carisma', 6),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-spell-recall'), 'abilityIncrease', 'inteligencia', 'Inteligência', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-spell-recall'), 'abilityIncrease', 'sabedoria', 'Sabedoria', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-spell-recall'), 'abilityIncrease', 'carisma', 'Carisma', 3),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-recovery'), 'abilityIncrease', 'forca', 'Força', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-recovery'), 'abilityIncrease', 'destreza', 'Destreza', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-recovery'), 'abilityIncrease', 'constituicao', 'Constituição', 3),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-recovery'), 'abilityIncrease', 'inteligencia', 'Inteligência', 4),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-recovery'), 'abilityIncrease', 'sabedoria', 'Sabedoria', 5),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-recovery'), 'abilityIncrease', 'carisma', 'Carisma', 6),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-energy-resistance'), 'abilityIncrease', 'forca', 'Força', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-energy-resistance'), 'abilityIncrease', 'destreza', 'Destreza', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-energy-resistance'), 'abilityIncrease', 'constituicao', 'Constituição', 3),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-energy-resistance'), 'abilityIncrease', 'inteligencia', 'Inteligência', 4),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-energy-resistance'), 'abilityIncrease', 'sabedoria', 'Sabedoria', 5),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-energy-resistance'), 'abilityIncrease', 'carisma', 'Carisma', 6),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-speed'), 'abilityIncrease', 'forca', 'Força', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-speed'), 'abilityIncrease', 'destreza', 'Destreza', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-speed'), 'abilityIncrease', 'constituicao', 'Constituição', 3),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-speed'), 'abilityIncrease', 'inteligencia', 'Inteligência', 4),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-speed'), 'abilityIncrease', 'sabedoria', 'Sabedoria', 5),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-speed'), 'abilityIncrease', 'carisma', 'Carisma', 6),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-dimensional-travel'), 'abilityIncrease', 'forca', 'Força', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-dimensional-travel'), 'abilityIncrease', 'destreza', 'Destreza', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-dimensional-travel'), 'abilityIncrease', 'constituicao', 'Constituição', 3),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-dimensional-travel'), 'abilityIncrease', 'inteligencia', 'Inteligência', 4),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-dimensional-travel'), 'abilityIncrease', 'sabedoria', 'Sabedoria', 5),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-dimensional-travel'), 'abilityIncrease', 'carisma', 'Carisma', 6),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-truesight'), 'abilityIncrease', 'forca', 'Força', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-truesight'), 'abilityIncrease', 'destreza', 'Destreza', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-truesight'), 'abilityIncrease', 'constituicao', 'Constituição', 3),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-truesight'), 'abilityIncrease', 'inteligencia', 'Inteligência', 4),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-truesight'), 'abilityIncrease', 'sabedoria', 'Sabedoria', 5),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-truesight'), 'abilityIncrease', 'carisma', 'Carisma', 6),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-irresistible-offense'), 'abilityIncrease', 'forca', 'Força', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-irresistible-offense'), 'abilityIncrease', 'destreza', 'Destreza', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-fate'), 'abilityIncrease', 'forca', 'Força', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-fate'), 'abilityIncrease', 'destreza', 'Destreza', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-fate'), 'abilityIncrease', 'constituicao', 'Constituição', 3),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-fate'), 'abilityIncrease', 'inteligencia', 'Inteligência', 4),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-fate'), 'abilityIncrease', 'sabedoria', 'Sabedoria', 5),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-fate'), 'abilityIncrease', 'carisma', 'Carisma', 6),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-the-night-spirit'), 'abilityIncrease', 'forca', 'Força', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-the-night-spirit'), 'abilityIncrease', 'destreza', 'Destreza', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-the-night-spirit'), 'abilityIncrease', 'constituicao', 'Constituição', 3),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-the-night-spirit'), 'abilityIncrease', 'inteligencia', 'Inteligência', 4),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-the-night-spirit'), 'abilityIncrease', 'sabedoria', 'Sabedoria', 5),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-the-night-spirit'), 'abilityIncrease', 'carisma', 'Carisma', 6),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'defensive-duelist'), 'abilityIncrease', 'destreza', 'Destreza', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'poisoner'), 'abilityIncrease', 'destreza', 'Destreza', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'poisoner'), 'abilityIncrease', 'inteligencia', 'Inteligência', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'crusher'), 'abilityIncrease', 'forca', 'Força', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'crusher'), 'abilityIncrease', 'constituicao', 'Constituição', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'dual-wielder'), 'abilityIncrease', 'forca', 'Força', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'dual-wielder'), 'abilityIncrease', 'destreza', 'Destreza', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'lightly-armored'), 'abilityIncrease', 'forca', 'Força', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'lightly-armored'), 'abilityIncrease', 'destreza', 'Destreza', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'moderately-armored'), 'abilityIncrease', 'forca', 'Força', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'moderately-armored'), 'abilityIncrease', 'destreza', 'Destreza', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'heavily-armored'), 'abilityIncrease', 'forca', 'Força', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'heavily-armored'), 'abilityIncrease', 'constituicao', 'Constituição', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'crossbow-expert'), 'abilityIncrease', 'destreza', 'Destreza', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'skill-expert'), 'abilityIncrease', 'forca', 'Força', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'skill-expert'), 'abilityIncrease', 'destreza', 'Destreza', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'skill-expert'), 'abilityIncrease', 'constituicao', 'Constituição', 3),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'skill-expert'), 'abilityIncrease', 'inteligencia', 'Inteligência', 4),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'skill-expert'), 'abilityIncrease', 'sabedoria', 'Sabedoria', 5),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'skill-expert'), 'abilityIncrease', 'carisma', 'Carisma', 6),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'mage-slayer'), 'abilityIncrease', 'forca', 'Força', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'mage-slayer'), 'abilityIncrease', 'destreza', 'Destreza', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'grappler'), 'abilityIncrease', 'forca', 'Força', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'grappler'), 'abilityIncrease', 'destreza', 'Destreza', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'inspiring-leader'), 'abilityIncrease', 'sabedoria', 'Sabedoria', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'inspiring-leader'), 'abilityIncrease', 'carisma', 'Carisma', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'keen-mind'), 'abilityIncrease', 'inteligencia', 'Inteligência', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'weapon-master'), 'abilityIncrease', 'forca', 'Força', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'weapon-master'), 'abilityIncrease', 'destreza', 'Destreza', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'medium-armor-master'), 'abilityIncrease', 'forca', 'Força', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'medium-armor-master'), 'abilityIncrease', 'destreza', 'Destreza', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'heavy-armor-master'), 'abilityIncrease', 'forca', 'Força', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'heavy-armor-master'), 'abilityIncrease', 'constituicao', 'Constituição', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'polearm-master'), 'abilityIncrease', 'forca', 'Força', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'polearm-master'), 'abilityIncrease', 'destreza', 'Destreza', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'great-weapon-master'), 'abilityIncrease', 'forca', 'Força', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'shield-master'), 'abilityIncrease', 'forca', 'Força', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'sharpshooter'), 'abilityIncrease', 'destreza', 'Destreza', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'piercer'), 'abilityIncrease', 'forca', 'Força', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'piercer'), 'abilityIncrease', 'destreza', 'Destreza', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'resilient'), 'abilityIncrease', 'forca', 'Força', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'resilient'), 'abilityIncrease', 'destreza', 'Destreza', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'resilient'), 'abilityIncrease', 'constituicao', 'Constituição', 3),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'resilient'), 'abilityIncrease', 'inteligencia', 'Inteligência', 4),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'resilient'), 'abilityIncrease', 'sabedoria', 'Sabedoria', 5),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'resilient'), 'abilityIncrease', 'carisma', 'Carisma', 6),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'durable'), 'abilityIncrease', 'constituicao', 'Constituição', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'sentinel'), 'abilityIncrease', 'forca', 'Força', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'sentinel'), 'abilityIncrease', 'destreza', 'Destreza', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'stealthy'), 'abilityIncrease', 'destreza', 'Destreza', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'slasher'), 'abilityIncrease', 'forca', 'Força', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'slasher'), 'abilityIncrease', 'destreza', 'Destreza', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'telekinetic'), 'abilityIncrease', 'inteligencia', 'Inteligência', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'telekinetic'), 'abilityIncrease', 'sabedoria', 'Sabedoria', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'telekinetic'), 'abilityIncrease', 'carisma', 'Carisma', 3),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'telepathic'), 'abilityIncrease', 'inteligencia', 'Inteligência', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'telepathic'), 'abilityIncrease', 'sabedoria', 'Sabedoria', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'telepathic'), 'abilityIncrease', 'carisma', 'Carisma', 3),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'shadow-touched'), 'abilityIncrease', 'inteligencia', 'Inteligência', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'shadow-touched'), 'abilityIncrease', 'sabedoria', 'Sabedoria', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'shadow-touched'), 'abilityIncrease', 'carisma', 'Carisma', 3),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'fey-touched'), 'abilityIncrease', 'inteligencia', 'Inteligência', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'fey-touched'), 'abilityIncrease', 'sabedoria', 'Sabedoria', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'fey-touched'), 'abilityIncrease', 'carisma', 'Carisma', 3),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'martial-weapon-training'), 'abilityIncrease', 'forca', 'Força', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'martial-weapon-training'), 'abilityIncrease', 'destreza', 'Destreza', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'mobile'), 'abilityIncrease', 'destreza', 'Destreza', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'mobile'), 'abilityIncrease', 'constituicao', 'Constituição', 2)
ON CONFLICT (feat_id, option_key, value_id) DO NOTHING;

-- --- D004_feat_extra_options.sql ---
-- Opções extras de talentos (além de abilityIncrease em D003)

-- Analítico — perícia do Observador Atento
INSERT INTO rpg.phb_feat_option_def (feat_id, option_key, label, value_type, sort_order)
VALUES
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'observant'), 'attentiveSkill', 'Observador Atento (perícia)', 'catalog', 2)
ON CONFLICT (feat_id, option_key) DO NOTHING;

INSERT INTO rpg.phb_feat_option_value (feat_id, option_key, value_id, label, sort_order)
VALUES
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'observant'), 'attentiveSkill', 'insight', 'Intuição', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'observant'), 'attentiveSkill', 'investigation', 'Investigação', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'observant'), 'attentiveSkill', 'perception', 'Percepção', 3)
ON CONFLICT (feat_id, option_key, value_id) DO NOTHING;

-- Mente Aguçada — Conhecimento Vasto
INSERT INTO rpg.phb_feat_option_def (feat_id, option_key, label, value_type, sort_order)
VALUES
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'keen-mind'), 'vastKnowledgeSkill', 'Conhecimento Vasto (perícia)', 'catalog', 2)
ON CONFLICT (feat_id, option_key) DO NOTHING;

INSERT INTO rpg.phb_feat_option_value (feat_id, option_key, value_id, label, sort_order)
VALUES
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'keen-mind'), 'vastKnowledgeSkill', 'arcana', 'Arcanismo', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'keen-mind'), 'vastKnowledgeSkill', 'history', 'História', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'keen-mind'), 'vastKnowledgeSkill', 'investigation', 'Investigação', 3),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'keen-mind'), 'vastKnowledgeSkill', 'nature', 'Natureza', 4),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'keen-mind'), 'vastKnowledgeSkill', 'religion', 'Religião', 5)
ON CONFLICT (feat_id, option_key, value_id) DO NOTHING;

-- Especialista em Perícia
INSERT INTO rpg.phb_feat_option_def (feat_id, option_key, label, value_type, sort_order)
VALUES
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'skill-expert'), 'newSkill', 'Proficiência em perícia', 'proficiency', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'skill-expert'), 'expertiseSkill', 'Especialização (perícia proficiente)', 'proficiency', 3)
ON CONFLICT (feat_id, option_key) DO NOTHING;

-- Feérico / Sombrio — +1 atributo (D003) + magia bônus já em S077; ordenar ASI antes
UPDATE rpg.phb_feat_option_def
SET sort_order = 3
WHERE feat_id = (SELECT id FROM rpg.phb_feat WHERE slug = 'fey-touched')
  AND option_key = 'bonusSpell';

UPDATE rpg.phb_feat_option_def
SET sort_order = 4
WHERE feat_id = (SELECT id FROM rpg.phb_feat WHERE slug = 'fey-touched')
  AND option_key = 'castingAbility';

UPDATE rpg.phb_feat_option_def
SET sort_order = 3
WHERE feat_id = (SELECT id FROM rpg.phb_feat WHERE slug = 'shadow-touched')
  AND option_key = 'bonusSpell';

UPDATE rpg.phb_feat_option_def
SET sort_order = 4
WHERE feat_id = (SELECT id FROM rpg.phb_feat WHERE slug = 'shadow-touched')
  AND option_key = 'castingAbility';

-- Dádiva da Resistência à Energia — dois tipos de dano
INSERT INTO rpg.phb_feat_option_def (feat_id, option_key, label, value_type, sort_order)
VALUES
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-energy-resistance'), 'resistanceType1', 'Resistência 1 (tipo de dano)', 'catalog', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-energy-resistance'), 'resistanceType2', 'Resistência 2 (tipo de dano)', 'catalog', 3)
ON CONFLICT (feat_id, option_key) DO NOTHING;

INSERT INTO rpg.phb_feat_option_value (feat_id, option_key, value_id, label, sort_order)
SELECT f.id, v.option_key, v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (
  VALUES
    ('resistanceType1', 'acid', 'Ácido', 1),
    ('resistanceType1', 'lightning', 'Elétrico', 2),
    ('resistanceType1', 'cold', 'Gélido', 3),
    ('resistanceType1', 'fire', 'Ígneo', 4),
    ('resistanceType1', 'necrotic', 'Necrótico', 5),
    ('resistanceType1', 'psychic', 'Psíquico', 6),
    ('resistanceType1', 'radiant', 'Radiante', 7),
    ('resistanceType1', 'thunder', 'Trovejante', 8),
    ('resistanceType1', 'poison', 'Venenoso', 9),
    ('resistanceType2', 'acid', 'Ácido', 1),
    ('resistanceType2', 'lightning', 'Elétrico', 2),
    ('resistanceType2', 'cold', 'Gélido', 3),
    ('resistanceType2', 'fire', 'Ígneo', 4),
    ('resistanceType2', 'necrotic', 'Necrótico', 5),
    ('resistanceType2', 'psychic', 'Psíquico', 6),
    ('resistanceType2', 'radiant', 'Radiante', 7),
    ('resistanceType2', 'thunder', 'Trovejante', 8),
    ('resistanceType2', 'poison', 'Venenoso', 9)
) AS v(option_key, value_id, label, sort_order)
WHERE f.slug = 'boon-of-energy-resistance'
ON CONFLICT (feat_id, option_key, value_id) DO NOTHING;

-- Dádiva da Proficiência em Perícia — especialização
INSERT INTO rpg.phb_feat_option_def (feat_id, option_key, label, value_type, sort_order)
VALUES
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-skill-proficiency'), 'expertiseSkill', 'Especialização', 'proficiency', 3)
ON CONFLICT (feat_id, option_key) DO NOTHING;

-- --- D005_feat_artisan_musician_weapon_master.sql ---
-- Artifista, Músico, Mestre das Armas — opções de origem / nível 4

INSERT INTO rpg.phb_feat_option_def (feat_id, option_key, label, value_type, sort_order)
VALUES
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'artisan'), 'artisanTool1', 'Ferramenta de artesão 1', 'proficiency', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'artisan'), 'artisanTool2', 'Ferramenta de artesão 2', 'proficiency', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'artisan'), 'artisanTool3', 'Ferramenta de artesão 3', 'proficiency', 3),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'musician'), 'musicalInstrument1', 'Instrumento musical 1', 'proficiency', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'musician'), 'musicalInstrument2', 'Instrumento musical 2', 'proficiency', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'musician'), 'musicalInstrument3', 'Instrumento musical 3', 'proficiency', 3),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'weapon-master'), 'masteryWeapon', 'Arma (propriedade de maestria)', 'catalog', 2)
ON CONFLICT (feat_id, option_key) DO NOTHING;

-- Mestre das Armas — armas com masteryId no catálogo
INSERT INTO rpg.phb_feat_option_value (feat_id, option_key, value_id, label, sort_order)
SELECT
  (SELECT id FROM rpg.phb_feat WHERE slug = 'weapon-master'),
  'masteryWeapon',
  i.slug,
  i.name,
  ROW_NUMBER() OVER (ORDER BY i.name)::int
FROM rpg.phb_item i
WHERE i.item_type = 'weapon'::rpg.item_type
  AND COALESCE(i.properties->>'masteryId', '') <> ''
ON CONFLICT (feat_id, option_key, value_id) DO NOTHING;

INSERT INTO rpg.phb_feat_option_value (feat_id, option_key, value_id, label, sort_order)
SELECT
  (SELECT id FROM rpg.phb_feat WHERE slug = 'artisan'),
  v.option_key,
  i.slug,
  i.name,
  ROW_NUMBER() OVER (PARTITION BY v.option_key ORDER BY i.name)::int
FROM rpg.phb_item i
JOIN rpg.phb_tool t ON t.item_id = i.id
JOIN rpg.phb_tool_category c ON c.id = t.category_id
CROSS JOIN (
  VALUES ('artisanTool1'), ('artisanTool2'), ('artisanTool3')
) AS v(option_key)
WHERE c.slug = 'artisan'
ON CONFLICT (feat_id, option_key, value_id) DO NOTHING;

INSERT INTO rpg.phb_feat_option_value (feat_id, option_key, value_id, label, sort_order)
SELECT
  (SELECT id FROM rpg.phb_feat WHERE slug = 'musician'),
  v.option_key,
  i.slug,
  i.name,
  ROW_NUMBER() OVER (PARTITION BY v.option_key ORDER BY i.name)::int
FROM rpg.phb_item i
JOIN rpg.phb_tool t ON t.item_id = i.id
JOIN rpg.phb_tool_category c ON c.id = t.category_id
CROSS JOIN (
  VALUES
    ('musicalInstrument1'),
    ('musicalInstrument2'),
    ('musicalInstrument3')
) AS v(option_key)
WHERE c.slug = 'instrument'
ON CONFLICT (feat_id, option_key, value_id) DO NOTHING;

-- --- D006_ritual_caster_feat_options.sql ---
-- Conjurador Ritualista — magias ritual de 1º círculo (quantidade = BP no nível do personagem)

INSERT INTO rpg.phb_feat_option_def (
  feat_id,
  option_key,
  label,
  value_type,
  sort_order,
  spell_max_level,
  spell_ritual_only
)
SELECT
  f.id,
  v.option_key,
  v.label,
  'spell'::rpg.option_value_type,
  v.sort_order,
  1,
  TRUE
FROM rpg.phb_feat f
CROSS JOIN (
  VALUES
    ('ritualSpell1', 'Magia ritual 1', 2),
    ('ritualSpell2', 'Magia ritual 2', 3),
    ('ritualSpell3', 'Magia ritual 3', 4),
    ('ritualSpell4', 'Magia ritual 4', 5),
    ('ritualSpell5', 'Magia ritual 5', 6),
    ('ritualSpell6', 'Magia ritual 6', 7)
) AS v(option_key, label, sort_order)
WHERE f.slug = 'ritual-caster'
ON CONFLICT (feat_id, option_key) DO NOTHING;

-- --- D007_telekinetic_casting_ability.sql ---
-- Telecinético — atributo de conjuração explícito (deve coincidir com abilityIncrease / +1)

UPDATE rpg.phb_feat_option_def
SET label = 'Aumento de atributo (+1)'
WHERE feat_id = (SELECT id FROM rpg.phb_feat WHERE slug = 'telekinetic')
  AND option_key = 'abilityIncrease';

INSERT INTO rpg.phb_feat_option_def (feat_id, option_key, label, value_type, sort_order)
VALUES
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'telekinetic'),
    'castingAbility',
    'Atributo de conjuração (Mãos Mágicas)',
    'catalog',
    2
  )
ON CONFLICT (feat_id, option_key) DO NOTHING;

INSERT INTO rpg.phb_feat_option_value (feat_id, option_key, value_id, label, sort_order)
SELECT feat_id, 'castingAbility', value_id, label, sort_order
FROM rpg.phb_feat_option_value
WHERE feat_id = (SELECT id FROM rpg.phb_feat WHERE slug = 'telekinetic')
  AND option_key = 'abilityIncrease'
ON CONFLICT (feat_id, option_key, value_id) DO NOTHING;

-- --- D008_telepathic_casting_ability.sql ---
-- Telepático — atributo de conjuração explícito (deve coincidir com abilityIncrease / +1)

UPDATE rpg.phb_feat_option_def
SET label = 'Aumento de atributo (+1)'
WHERE feat_id = (SELECT id FROM rpg.phb_feat WHERE slug = 'telepathic')
  AND option_key = 'abilityIncrease';

INSERT INTO rpg.phb_feat_option_def (feat_id, option_key, label, value_type, sort_order)
VALUES
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'telepathic'),
    'castingAbility',
    'Atributo de conjuração (Detectar Pensamentos)',
    'catalog',
    2
  )
ON CONFLICT (feat_id, option_key) DO NOTHING;

INSERT INTO rpg.phb_feat_option_value (feat_id, option_key, value_id, label, sort_order)
SELECT feat_id, 'castingAbility', value_id, label, sort_order
FROM rpg.phb_feat_option_value
WHERE feat_id = (SELECT id FROM rpg.phb_feat WHERE slug = 'telepathic')
  AND option_key = 'abilityIncrease'
ON CONFLICT (feat_id, option_key, value_id) DO NOTHING;

-- --- D009_ability_score_improvement_feat_options.sql ---
-- Aumento no Valor de Atributo (feat) — +2 em um ou +1 em dois atributos

INSERT INTO rpg.phb_feat_option_def (feat_id, option_key, label, value_type, sort_order)
VALUES
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'ability-score-improvement'),
    'distributionMode',
    'Distribuição',
    'catalog',
    1
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'ability-score-improvement'),
    'primaryAbility',
    'Atributo principal',
    'ability',
    2
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'ability-score-improvement'),
    'secondaryAbility',
    'Segundo atributo (+1)',
    'ability',
    3
  )
ON CONFLICT (feat_id, option_key) DO NOTHING;

INSERT INTO rpg.phb_feat_option_value (feat_id, option_key, value_id, label, sort_order)
VALUES
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'ability-score-improvement'),
    'distributionMode',
    'plus2',
    '+2 em um atributo',
    1
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'ability-score-improvement'),
    'distributionMode',
    'plus1plus1',
    '+1 em dois atributos',
    2
  )
ON CONFLICT (feat_id, option_key, value_id) DO NOTHING;

INSERT INTO rpg.phb_feat_option_value (feat_id, option_key, value_id, label, sort_order)
SELECT
  (SELECT id FROM rpg.phb_feat WHERE slug = 'ability-score-improvement'),
  v.option_key,
  a.slug,
  a.name,
  ROW_NUMBER() OVER (PARTITION BY v.option_key ORDER BY a.slug)::int
FROM rpg.phb_ability a
CROSS JOIN (VALUES ('primaryAbility'), ('secondaryAbility')) AS v(option_key)
ON CONFLICT (feat_id, option_key, value_id) DO NOTHING;

-- --- D010_resilient_feat_option_label.sql ---
-- Resiliente — rótulo da opção de atributo (regra: sem prof. em salvaguarda da classe)

UPDATE rpg.phb_feat_option_def
SET label = 'Atributo (+1, sem proficiência em salvaguarda)'
WHERE feat_id = (SELECT id FROM rpg.phb_feat WHERE slug = 'resilient')
  AND option_key = 'abilityIncrease';

