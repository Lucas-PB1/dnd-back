-- Antecedentes Eldritch Hunt Player Pack

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
    'beast-hunter',
    'Caçador de Bestas',
    'Crescendo, a ameaça do Flagelo pairava sobre a sua vida na cidade. As bestas aterrorizavam você, destruíam lares e tiravam pessoas que amava. Impelido por vingança, medo ou desejo de justiça, você se tornou caçador. A Igreja, um mentor ou a Ordem Radiante ensinou-lhe os caminhos da caça, dando conhecimento e perícia para defender a cidade e a si mesmo. Seja um cidadão comum tornado protetor ou um veterano da Primeira Guerra endurecido por inúmeras batalhas, você é uma linha essencial de defesa contra a escuridão.',
    (SELECT id FROM rpg.phb_feat WHERE slug = 'grizzled'),
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'steinhardt-eldritch-hunt-2024-en:player-pack'),
    50,
    'Kit de Herbalismo',
    'fixed',
    (SELECT id FROM rpg.phb_item WHERE slug = 'kit-de-herbalismo'),
    NULL
  ),
  (
    'inquisitor',
    'Inquisidor',
    'Você é um discípulo firme da Igreja Radiante, cheio de fé inabalável e zelo sagrado que o impulsiona a extirpar qualquer ameaça à Igreja e aos seus ensinamentos. O dever pode incluir interrogar heréticos em potencial, investigar sinais de corrupção dentro da Igreja ou combater os inimigos da fé. Você anda numa linha tênue, aplicando as leis da Igreja e assegurando a pureza dos seus seguidores.',
    (SELECT id FROM rpg.phb_feat WHERE slug = 'faithful'),
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'steinhardt-eldritch-hunt-2024-en:player-pack'),
    50,
    'Ferramentas de Tortura',
    'fixed',
    (SELECT id FROM rpg.phb_item WHERE slug = 'torture-tools'),
    NULL
  ),
  (
    'marked-for-death',
    'Marcado para a Morte',
    'Você já esteve morto, mas a misteriosa Lua de Sangue do Renascimento devolveu-lhe a vida, deixando um Entalhe Eldritch indelével no corpo — a Marca Sacrificial. A marca na carne é temida por muitos, pois acredita-se que atrai as criaturas terríveis que assolam o mundo. Para você, representa o peso da vida passada e a promessa de que esta vida terminará de novo com violência. Abraçando a nova vida como símbolo de renascimento e sacrifício, resolveu aproveitar a oportunidade, mesmo que isso leve a inúmeras lutas brutais.',
    (SELECT id FROM rpg.phb_feat WHERE slug = 'grizzled'),
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'steinhardt-eldritch-hunt-2024-en:player-pack'),
    NULL,
    NULL,
    NULL,
    NULL,
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
