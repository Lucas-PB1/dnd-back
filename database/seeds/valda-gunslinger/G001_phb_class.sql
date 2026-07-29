-- Seed Valda Pistoleiro class
-- Gerado de docs/sources/valda-gunslinger/extracted.json

INSERT INTO rpg.phb_class (
  slug, name, tagline, summary, description,
  primary_ability_label, primary_ability_operator,
  hit_die_id, hp_level1_die_value, hp_fixed_per_level,
  hp_minimum_gain_per_level, hp_constitution_mod_applies,
  subclass_unlock_level, subclass_label,
  skill_choice_count, skill_choice_from,
  source_citation_id, spell_slot_pattern_id
)
VALUES (
  'gunslinger',
  'Pistoleiro',
  '## Tripas e Pólvora',
  'O risco está no sangue de um Pistoleiro. Eles são renegados ousados, contrariando a tradição e abrindo um novo caminho com armas de fogo perigosas e deselegantes. Os pistoleiros são famosos por sobreviverem com sua inteligência e por dependerem de uma fração de segundo e de uma quantidade considerável de sorte para sobreviver.',
  'O risco está no sangue de um Pistoleiro. Eles são renegados ousados, contrariando a tradição e abrindo um novo caminho com armas de fogo perigosas e deselegantes. Os pistoleiros são famosos por sobreviverem com sua inteligência e por dependerem de uma fração de segundo e de uma quantidade considerável de sorte para sobreviver.

## Tripas e Pólvora

A pólvora negra não é para os fracos de coração. Seus aplausos estrondosos são voláteis e imprecisos – uma explosão mal controlada dirigida a um inimigo. Somente os verdadeiramente destemidos procuram dominá-lo. Mas os Pistoleiros têm nervos de aço, lançando a morte com suas armas em uma cacofonia estrondosa. Adaptados para tiroteios, os pistoleiros são móveis e ousados, sabendo que a vida ou a morte depende da tomada de decisões instantâneas e da própria coragem.

## Forasteiros Perigosos

O estilo de vida explosivo de um Pistoleiro é propício para perambulações e aventuras. Os pistoleiros muitas vezes atiram primeiro e perguntam depois, uma atitude que lhes rende poucos amigos e numerosos inimigos. Em suas viagens, a maioria dos pistoleiros são reservados e fazem de tudo para passar despercebidos, para não serem avistados por velhos inimigos com contas a acertar.

## Características principais

Destreza

Dado de Vida
D8 por nível de Pistoleiro

Proficiências em salvaguardas
Destreza e Carisma

Escolha 2: Acrobacia, Manejo de Animais, Atletismo, Enganação, Intuição, Intimidação, Percepção, Persuasão, Prestidigitação e Furtividade

Armas simples e armas marciais de longo alcance

Armadura leve

Escolha A ou B: (A) Armadura de Couro, 2 Adagas, Revólver, 50 Balas, Kit de Aventureiro e 11 PO; ou (B) 175 PO',
  'Destreza',
  NULL,
  (SELECT id FROM rpg.phb_hit_die WHERE slug = 'd8'),
  8,
  5,
  1,
  TRUE,
  3,
  'Credo',
  2,
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'valda-spire-2024-en:gunslinger'),
  NULL
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  primary_ability_label = EXCLUDED.primary_ability_label,
  hit_die_id = EXCLUDED.hit_die_id,
  hp_level1_die_value = EXCLUDED.hp_level1_die_value,
  hp_fixed_per_level = EXCLUDED.hp_fixed_per_level,
  subclass_unlock_level = EXCLUDED.subclass_unlock_level,
  subclass_label = EXCLUDED.subclass_label,
  skill_choice_count = EXCLUDED.skill_choice_count,
  source_citation_id = EXCLUDED.source_citation_id;
