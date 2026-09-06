-- Grim Hollow — classe Caçador de Monstros

INSERT INTO rpg.phb_class (
  slug, name, tagline, summary, description,
  primary_ability_label, primary_ability_operator,
  hit_die, hp_level1_die_value, hp_fixed_per_level,
  hp_minimum_gain_per_level, hp_constitution_mod_applies,
  subclass_unlock_level, subclass_label,
  skill_choice_count, skill_choice_from,
  source_citation_id, spell_slot_pattern_id
)
VALUES (
  'monster-hunter',
  'Caçador de Monstros',
  'Profissional treinado para rastrear e abater ameaças monstruosas',
  'Caçadores de Monstros são profissionais habilidosos, especializados em identificar, rastrear e abater monstros que ameaçam a vida e o sustento do povo de Etharis.',
  'Caçadores de Monstros são profissionais habilidosos, especializados em identificar, rastrear e abater monstros que ameaçam a vida e o sustento do povo de Etharis.

Cada Caçador de Monstros treina em um método diferente para essas tarefas. Alguns vestem armaduras pesadas e carregam escudos contra mandíbulas esmagadoras e garras cortantes; outros usam armadilhas astutas para manter distância dos horrores que caçam; alguns assumem traços e poderes dos inimigos para abatê-los melhor; outros recorrem à magia para complementar a proeza marcial com ira arcana.',
  'Força ou Destreza e Inteligência',
  'and',
  'd10',
  10,
  6,
  1,
  TRUE,
  3,
  'Guilda de Caça',
  3,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-2-character-classes'),
  NULL
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  primary_ability_label = EXCLUDED.primary_ability_label,
  hit_die = EXCLUDED.hit_die,
  hp_level1_die_value = EXCLUDED.hp_level1_die_value,
  hp_fixed_per_level = EXCLUDED.hp_fixed_per_level,
  subclass_unlock_level = EXCLUDED.subclass_unlock_level,
  subclass_label = EXCLUDED.subclass_label,
  skill_choice_count = EXCLUDED.skill_choice_count,
  source_citation_id = EXCLUDED.source_citation_id;
