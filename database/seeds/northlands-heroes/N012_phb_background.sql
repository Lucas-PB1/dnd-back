-- Antecedentes Northlands (Heroes of the Sagas)
-- preordained-hero / seafarer: feat_id NULL — escolha de talento de origem (polish create).

INSERT INTO rpg.phb_background (
  slug,
  name,
  description,
  feat_id,
  source_citation_id,
  equipment_gold_option,
  tool_proficiency_description,
  tool_proficiency_kind,
  tool_item_id,
  tool_category_id
)
VALUES
  (
    'dancing-bear-guide',
    'Guia do Urso Dançante',
    'Você passou os anos formativos nas casas da Lodge of the Dancing Bear, organização solta e espalhada pelas Terras do Norte. Os membros — guias — são gente rude e afeita ao mato. Como guia do Urso Dançante, você está em casa nos ermos do Norte, mas visita a civilização para mostrar aos citadinos a liberdade do selvagem. Você lhes mostrará o que esqueceram — e, quando virem, compreenderão.',
    (SELECT id FROM rpg.phb_feat WHERE slug = 'alert'),
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas'),
    50,
    'Veículos (terrestres)',
    NULL,
    NULL,
    NULL
  ),
  (
    'doomed',
    'Condenado',
    'Disseram-lhe que nunca será bem-vindo em Valhala, mas você acredita que o destino pode ser outro se provar seu valor aos deuses. Quer a condenação venha de desonra ou crime seu, ou de algo imposto, você busca redenção pela façanha — e o Norte é o campo onde lendas nascem ou morrem.',
    (SELECT id FROM rpg.phb_feat WHERE slug = 'alert'),
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas'),
    50,
    'Escolha um tipo de Ferramentas de Artesão',
    'choice',
    NULL,
    (SELECT id FROM rpg.phb_tool_category WHERE slug = 'artisan')
  ),
  (
    'former-captive',
    'Ex-Cativo',
    'Capturado após uma batalha ou vítima de um raid, você foi feito cativo e obrigado a trabalhar para os captores. Aprendeu a ler intenções, negociar migalhas de liberdade e sobreviver a correntes — físicas ou sociais. Agora livre, carrega cicatrizes e o jeito de quem já foi propriedade de outro.',
    (SELECT id FROM rpg.phb_feat WHERE slug = 'skilled'),
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas'),
    50,
    'Ferramentas de Funileiro',
    'fixed',
    (SELECT id FROM rpg.phb_item WHERE slug = 'ferramentas-de-funileiro'),
    NULL
  ),
  (
    'ice-nomad',
    'Nômade do Gelo',
    'Enquanto outros buscam conquista e grande aventura nas Terras do Norte, você se dedicou à alegria da caçada e à vitória da sobrevivência no gelo. A neve é seu caminho, o frio seu professor, e o horizonte branco sua casa.',
    (SELECT id FROM rpg.phb_feat WHERE slug = 'snowrunner'),
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas'),
    50,
    'Ferramentas de Cartógrafo',
    'fixed',
    (SELECT id FROM rpg.phb_item WHERE slug = 'ferramentas-de-cartografo'),
    NULL
  ),
  (
    'northlands-reaver',
    'Saqueador das Terras do Norte',
    'Os invernos brutais do Norte forjam gente dura; talvez ninguém mais do que os saqueadores. Sua vida foi uma sequência de raids, fugas e sobrevivência — e a violência tornou-se ofício tanto quanto necessidade.',
    (SELECT id FROM rpg.phb_feat WHERE slug = 'savage-attacker'),
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas'),
    50,
    'Ferramentas de Navegador',
    'fixed',
    (SELECT id FROM rpg.phb_item WHERE slug = 'ferramentas-de-navegador'),
    NULL
  ),
  (
    'preordained-hero',
    'Herói Predestinado',
    'Sua vinda foi predita em lenda e anunciada em canção. Quer desça das Nornas, das Valquírias ou de outro poder, o destino marcou você. Escolha um talento de origem que conceda a bênção de uma divindade.',
    NULL,
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas'),
    50,
    'Escolha um tipo de Kit de Jogos',
    'choice',
    NULL,
    (SELECT id FROM rpg.phb_tool_category WHERE slug = 'kit')
  ),
  (
    'seafarer',
    'Navegante',
    'Você passou grande parte dos anos formativos no mar em vez da terra, vivendo da fartura das águas mutáveis e adiante das correntes. Navegar essas águas trouxe-lhe reputação — e a escolha entre a vida de pescador ou de saqueador do Norte.',
    NULL,
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas'),
    50,
    'Ferramentas de Navegador',
    'fixed',
    (SELECT id FROM rpg.phb_item WHERE slug = 'ferramentas-de-navegador'),
    NULL
  ),
  (
    'seer',
    'Vidente',
    'Desde criança você vê o que outros não veem. Pode ter sonhado com o jarl local caindo do cavalo, ou visto presságios no fogo e na neve. As Nornas tocaram seu destino — e o peso dessa visão molda cada passo.',
    (SELECT id FROM rpg.phb_feat WHERE slug = 'norn-touched'),
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas'),
    50,
    'Suprimentos de Alquimista',
    'fixed',
    (SELECT id FROM rpg.phb_item WHERE slug = 'suprimentos-de-alquimista'),
    NULL
  ),
  (
    'shipwright',
    'Construtor de Navios',
    'Nem todos sabem construir um navio para as águas geladas do Norte. Você dominou o ofício, enfrentando o frio com madeira, corda e mão firme — e aprendeu a abordar e a lutar como quem vive no convés.',
    (SELECT id FROM rpg.phb_feat WHERE slug = 'sea-wolf'),
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas'),
    50,
    'Ferramentas de Carpinteiro',
    'fixed',
    (SELECT id FROM rpg.phb_item WHERE slug = 'ferramentas-de-carpinteiro'),
    NULL
  )
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description,
  feat_id = EXCLUDED.feat_id,
  source_citation_id = EXCLUDED.source_citation_id,
  equipment_gold_option = EXCLUDED.equipment_gold_option,
  tool_proficiency_description = EXCLUDED.tool_proficiency_description,
  tool_proficiency_kind = EXCLUDED.tool_proficiency_kind,
  tool_item_id = EXCLUDED.tool_item_id,
  tool_category_id = EXCLUDED.tool_category_id;
