-- Panel actions — Northlands Heroes of the Sagas (declarativo)

INSERT INTO rpg.phb_class_panel_action (
  panel_key, class_id, subclass_id, slug, name, title, unlock_level,
  resource_slug, section, spends_focus, sort_order
) VALUES
('bard|skald|bragi-rune', (SELECT id FROM rpg.phb_class WHERE slug = 'bard'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'skald'), 'bragi-rune', 'Runa da Fala de Bragi', 'AB: gasta Inspiração — Escárnio / Eloquência / Vitalidade', 6, 'bardicInspiration', 'subclass'::rpg.panel_action_section, false, 50),
('bard|skald|battle-sagas', (SELECT id FROM rpg.phb_class WHERE slug = 'bard'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'skald'), 'battle-sagas', 'Sagas de Batalha', '1 min: sagas 1 h (1× / DC ou DL)', 14, 'battle-sagas', 'subclass'::rpg.panel_action_section, false, 51),

('cleric|nornbound|adjust-the-skein', (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'nornbound'), 'adjust-the-skein', 'Ajustar a Teia', 'Reação: ±1 Fio em rolagem', 3, 'norn-skeins', 'subclass'::rpg.panel_action_section, false, 50),
('cleric|nornbound|pluck-the-threads', (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'nornbound'), 'pluck-the-threads', 'Puxar os Fios', 'Canalizar: Vantagem a aliados', 3, 'channelDivinity', 'subclass'::rpg.panel_action_section, false, 51),
('cleric|nornbound|intertwined-fate', (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'nornbound'), 'intertwined-fate', 'Destino Entrelaçado', 'Ação Mágica: dano + cura (espaço)', 6, NULL, 'subclass'::rpg.panel_action_section, false, 52),

('druid|circle-of-fenris|wolf-mantle', (SELECT id FROM rpg.phb_class WHERE slug = 'druid'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'circle-of-fenris'), 'wolf-mantle', 'Manto do Lobo', 'Gasta Forma Selvagem → manto 10 min', 3, 'wildShape', 'subclass'::rpg.panel_action_section, false, 50),
('druid|circle-of-fenris|defend-the-pack', (SELECT id FROM rpg.phb_class WHERE slug = 'druid'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'circle-of-fenris'), 'defend-the-pack', 'Defender a Alcateia', 'Reação: lobo fantasma (gasta Forma)', 10, 'wildShape', 'subclass'::rpg.panel_action_section, false, 51),
('druid|circle-of-fenris|children-of-great-wolf', (SELECT id FROM rpg.phb_class WHERE slug = 'druid'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'circle-of-fenris'), 'children-of-great-wolf', 'Filhos do Grande Lobo', 'Ao assumir Manto: fenrikyn (1×/dia)', 14, 'children-of-great-wolf', 'subclass'::rpg.panel_action_section, false, 52),

('fighter|viking|marauders-reprisal', (SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'viking'), 'marauders-reprisal', 'Represália do Saqueador', 'Reação: crítico + PV temp.', 15, 'marauders-reprisal', 'subclass'::rpg.panel_action_section, false, 50),
('fighter|viking|unstoppable-assault', (SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'viking'), 'unstoppable-assault', 'Assalto Imparável', 'Ação: ataques extras críticos (1×/DL)', 18, 'unstoppable-assault', 'subclass'::rpg.panel_action_section, false, 51),

('paladin|oath-of-valhalla|encouraging-smite', (SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-valhalla'), 'encouraging-smite', 'Destruição Encorajadora', 'Após Destruição: Canalizar — buff', 3, 'channelDivinity', 'subclass'::rpg.panel_action_section, false, 50),
('paladin|oath-of-valhalla|guardian-of-the-dead', (SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-valhalla'), 'guardian-of-the-dead', 'Guardião dos Mortos', 'Canalizar: vigília 1 h', 3, 'channelDivinity', 'subclass'::rpg.panel_action_section, false, 51),
('paladin|oath-of-valhalla|spirit-of-the-valkyrie', (SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-valhalla'), 'spirit-of-the-valkyrie', 'Espírito da Valquíria', 'Forma de valquíria 10 min (1×/DL)', 20, 'spirit-of-the-valkyrie', 'subclass'::rpg.panel_action_section, false, 52),

('sorcerer|spirit-caller|spirit-guidance', (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'spirit-caller'), 'spirit-guidance', 'Orientação Espiritual', 'AB: Vantagem em perícia', 3, 'spirit-guidance', 'subclass'::rpg.panel_action_section, false, 50),
('sorcerer|spirit-caller|spirit-aura', (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'spirit-caller'), 'spirit-aura', 'Aura Espiritual', 'AB: aura 3 m 1 min (2×/DL)', 6, 'spirit-aura', 'subclass'::rpg.panel_action_section, false, 51),
('sorcerer|spirit-caller|spirit-secrets', (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'spirit-caller'), 'spirit-secrets', 'Segredos Espirituais', 'Ao falhar: rerrolar', 14, 'spirit-secrets', 'subclass'::rpg.panel_action_section, false, 52),

('warlock|trickster|context-switch', (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'trickster'), 'context-switch', 'Troca de Contexto', 'Reação: troca de lugar com alvo', 3, 'context-switch', 'subclass'::rpg.panel_action_section, false, 50),
('warlock|trickster|harbinger-of-chaos', (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'trickster'), 'harbinger-of-chaos', 'Arauto do Caos', 'AB: anuncia mudanças (1× / DC)', 14, 'harbinger-of-chaos', 'subclass'::rpg.panel_action_section, false, 51),

('barbarian|path-of-the-titan|giants-fury', (SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-titan'), 'giants-fury', 'Fúria dos Gigantes', 'Ao ativar Fúria: tornar-se Grande', 3, NULL, 'subclass'::rpg.panel_action_section, false, 50),
('barbarian|path-of-the-titan|crushing-steps', (SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-titan'), 'crushing-steps', 'Passos Esmagadores', 'Movimento: atravessar espaço menor', 6, NULL, 'subclass'::rpg.panel_action_section, false, 51),
('barbarian|path-of-the-titan|titanic-strikes', (SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-titan'), 'titanic-strikes', 'Golpes Titânicos', 'Com Golpe Brutal: empurrão ×2 / Vel. 0', 10, NULL, 'subclass'::rpg.panel_action_section, false, 52),
('barbarian|path-of-the-titan|titans-fury', (SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), (SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-titan'), 'titans-fury', 'Fúria dos Titãs', 'Ao ativar Fúria: tornar-se Enorme', 14, NULL, 'subclass'::rpg.panel_action_section, false, 53)
ON CONFLICT (panel_key) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  subclass_id = EXCLUDED.subclass_id,
  slug = EXCLUDED.slug,
  name = EXCLUDED.name,
  title = EXCLUDED.title,
  unlock_level = EXCLUDED.unlock_level,
  resource_slug = EXCLUDED.resource_slug,
  section = EXCLUDED.section,
  spends_focus = EXCLUDED.spends_focus,
  sort_order = EXCLUDED.sort_order;
