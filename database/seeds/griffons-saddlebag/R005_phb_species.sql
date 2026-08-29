-- Espécie Feathren — Griffon's Saddlebag Book One Part II

INSERT INTO rpg.phb_species (
  slug, name, creature_type, size, speed, description, source_meta
)
VALUES (
  'feathren',
  'Feathren',
  'Humanoide',
  'Médio (cerca de 1,50–1,80 m)',
  '9 metros',
  'Feathren são algo novo feito de algo antigo — um passo além da herança grifo, celebrando individualidade entre vaias do povo comum. Nascidos originalmente no Plano Astral, onde tudo pode se perder, ser encontrado e refeito, agora caminham o Plano Material em busca de ideias, materiais e direção. Curiosos, muitos viram aventureiros e artesãos.

Herança Variada. Feathren unem aspectos marcantes de criaturas díspares: pernas felinas, tórax, braços e cabeça aviários. Poucos se parecem; plumagem, pelagem e porte variam (águia/leão, coruja/tigre, etc.). Adoram joias e enfeites — anéis em garras, orelhas emplumadas e cauda. Muitos não resistem a arrumar penas e adornos ao ver o reflexo.

Confiantes e Curiosos. Dotados de confiança compartilhada, passam a vida aprendendo ofícios novos, preferindo resolver enigmas sozinhos. Encontram camaradagem entre pares de paixões comuns e gostam de trocar histórias sobre interesses.',
  '{"editionSlug":"griffons-saddlebag-book-one-2024-en","book":"The Griffon''s Saddlebag: Book One","language":"pt","citationSlug":"griffons-saddlebag-book-one-2024-en:part-ii-character-options","source":"griffons-saddlebag"}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  creature_type = EXCLUDED.creature_type,
  size = EXCLUDED.size,
  speed = EXCLUDED.speed,
  description = EXCLUDED.description,
  source_meta = EXCLUDED.source_meta;
