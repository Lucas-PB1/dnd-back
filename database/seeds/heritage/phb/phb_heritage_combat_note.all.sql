-- Heritage combat notes (GH traços com impacto de ficha/combate).

INSERT INTO rpg.phb_heritage_combat_note (trait_id, min_trait_takes, note)
SELECT ht.id, v.min_trait_takes, v.note
FROM rpg.phb_heritage_trait ht
JOIN (
  VALUES
    ('improved-darkvision', 1, 'Visão no Escuro 18 m.'),
    ('improved-darkvision', 2, 'Visão no Escuro 36 m.'),
    ('damage-immunity', 1, 'Resistência a um tipo de dano (escolha do traço).'),
    ('damage-immunity', 2, 'Resistência a um tipo de dano; reação → imunidade temporária (1×/SR).'),
    ('extra-tough', 1, '+{takes} PV máx. por nível (Robustez).'),
    ('weapon-specialist', 1, 'Proficiência em armas (escolha do traço).'),
    ('helpful-tactics', 1, 'Vantagem em testes para ajudar aliados.'),
    ('magical-savant', 1, 'Truques adicionais (escolha do traço).'),
    ('stand-fast', 1, 'Bônus em salvaguardas contra ser movido.'),
    ('artisanal-expertise', 1, 'Proficiência em ferramentas (escolha do traço).'),
    ('restorative-rest', 1, 'Descanso curto: gasta Dados de Vida adicionais.')
) AS v(trait_slug, min_trait_takes, note)
  ON ht.slug = v.trait_slug
ON CONFLICT (trait_id, min_trait_takes) DO UPDATE SET
  note = EXCLUDED.note;
