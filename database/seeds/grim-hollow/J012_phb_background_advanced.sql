-- Grim Hollow Cap. 3 — antecedentes avançados (catálogo)

INSERT INTO rpg.phb_background (
  slug, name, description, tagline, summary,
  feat_id, source_citation_id, equipment_gold_option,
  tool_proficiency_description, tool_proficiency_kind, tool_item_id, tool_category_id,
  language_choice_count
)
VALUES
(
  'gh-academic',
  'Acadêmico',
  'Antecedente avançado do Grim Hollow. Escolha uma profissão e avance em 4 patentes (dado de profissão d4→d10, propriedades e talentos).

Profissões:
• Antiquário
• Arquivista
• Médico

Recomenda-se que todo o grupo use antecedentes avançados ou nenhum.',
  'Antecedente avançado (GH)',
  'Patentes, propriedades e dado de profissão — ver Grim Hollow PG Cap. 3.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-3-backgrounds'),
  0,
  NULL,
  NULL,
  NULL,
  NULL,
  0
),
(
  'gh-aristocrat',
  'Aristocrata',
  'Antecedente avançado do Grim Hollow. Escolha uma profissão e avance em 4 patentes (dado de profissão d4→d10, propriedades e talentos).

Profissões:
• Cortesão
• Enviado
• Nobre

Recomenda-se que todo o grupo use antecedentes avançados ou nenhum.',
  'Antecedente avançado (GH)',
  'Patentes, propriedades e dado de profissão — ver Grim Hollow PG Cap. 3.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-3-backgrounds'),
  0,
  NULL,
  NULL,
  NULL,
  NULL,
  0
),
(
  'gh-clan-member',
  'Membro do clã',
  'Antecedente avançado do Grim Hollow. Escolha uma profissão e avance em 4 patentes (dado de profissão d4→d10, propriedades e talentos).

Profissões:
• Saqueador
• Xamã
• Membro da tribo

Recomenda-se que todo o grupo use antecedentes avançados ou nenhum.',
  'Antecedente avançado (GH)',
  'Patentes, propriedades e dado de profissão — ver Grim Hollow PG Cap. 3.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-3-backgrounds'),
  0,
  NULL,
  NULL,
  NULL,
  NULL,
  0
),
(
  'gh-clergy',
  'Clero',
  'Antecedente avançado do Grim Hollow. Escolha uma profissão e avance em 4 patentes (dado de profissão d4→d10, propriedades e talentos).

Profissões:
• Inquisidor
• Pregador
• Sacerdote

Recomenda-se que todo o grupo use antecedentes avançados ou nenhum.',
  'Antecedente avançado (GH)',
  'Patentes, propriedades e dado de profissão — ver Grim Hollow PG Cap. 3.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-3-backgrounds'),
  0,
  NULL,
  NULL,
  NULL,
  NULL,
  0
),
(
  'gh-common-folk',
  'Povo comum',
  'Antecedente avançado do Grim Hollow. Escolha uma profissão e avance em 4 patentes (dado de profissão d4→d10, propriedades e talentos).

Profissões:
• Aldeão
• Artista
• Mercador

Recomenda-se que todo o grupo use antecedentes avançados ou nenhum.',
  'Antecedente avançado (GH)',
  'Patentes, propriedades e dado de profissão — ver Grim Hollow PG Cap. 3.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-3-backgrounds'),
  0,
  NULL,
  NULL,
  NULL,
  NULL,
  0
),
(
  'gh-criminal',
  'Criminoso',
  'Antecedente avançado do Grim Hollow. Escolha uma profissão e avance em 4 patentes (dado de profissão d4→d10, propriedades e talentos).

Profissões:
• Charlatão
• Assassino
• Ladrão

Recomenda-se que todo o grupo use antecedentes avançados ou nenhum.',
  'Antecedente avançado (GH)',
  'Patentes, propriedades e dado de profissão — ver Grim Hollow PG Cap. 3.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-3-backgrounds'),
  0,
  NULL,
  NULL,
  NULL,
  NULL,
  0
),
(
  'gh-militarist',
  'Militarista',
  'Antecedente avançado do Grim Hollow. Escolha uma profissão e avance em 4 patentes (dado de profissão d4→d10, propriedades e talentos).

Profissões:
• Espadachim livre
• Guarda
• Soldado

Recomenda-se que todo o grupo use antecedentes avançados ou nenhum.',
  'Antecedente avançado (GH)',
  'Patentes, propriedades e dado de profissão — ver Grim Hollow PG Cap. 3.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-3-backgrounds'),
  0,
  NULL,
  NULL,
  NULL,
  NULL,
  0
),
(
  'gh-outlander',
  'Forasteiro',
  'Antecedente avançado do Grim Hollow. Escolha uma profissão e avance em 4 patentes (dado de profissão d4→d10, propriedades e talentos).

Profissões:
• Caçador de feras
• Pioneiro
• Explorador

Recomenda-se que todo o grupo use antecedentes avançados ou nenhum.',
  'Antecedente avançado (GH)',
  'Patentes, propriedades e dado de profissão — ver Grim Hollow PG Cap. 3.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-3-backgrounds'),
  0,
  NULL,
  NULL,
  NULL,
  NULL,
  0
),
(
  'gh-pauper',
  'Pobre',
  'Antecedente avançado do Grim Hollow. Escolha uma profissão e avance em 4 patentes (dado de profissão d4→d10, propriedades e talentos).

Profissões:
• Mendigo
• Vagabundo
• Lutador de fosso

Recomenda-se que todo o grupo use antecedentes avançados ou nenhum.',
  'Antecedente avançado (GH)',
  'Patentes, propriedades e dado de profissão — ver Grim Hollow PG Cap. 3.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-3-backgrounds'),
  0,
  NULL,
  NULL,
  NULL,
  NULL,
  0
),
(
  'gh-seafarer',
  'Marinheiro',
  'Antecedente avançado do Grim Hollow. Escolha uma profissão e avance em 4 patentes (dado de profissão d4→d10, propriedades e talentos).

Profissões:
• Marinheiro
• Estivador
• Coletor do mar

Recomenda-se que todo o grupo use antecedentes avançados ou nenhum.',
  'Antecedente avançado (GH)',
  'Patentes, propriedades e dado de profissão — ver Grim Hollow PG Cap. 3.',
  NULL,
  (SELECT id FROM rpg.phb_source_citation WHERE slug = 'grim-hollow-players-guide-2024-en:chapter-3-backgrounds'),
  0,
  NULL,
  NULL,
  NULL,
  NULL,
  0
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description,
  tagline = EXCLUDED.tagline,
  summary = EXCLUDED.summary,
  source_citation_id = EXCLUDED.source_citation_id;
