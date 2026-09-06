-- Traços Feathren — Griffon's Saddlebag Part II

INSERT INTO rpg.phb_species_trait (species_id, name, description, choice_kind)
VALUES
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'feathren'),
    'Visão no Escuro',
    'Você tem Visão no Escuro com alcance de 18 metros.',
    NULL
  ),
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'feathren'),
    'Ancestria Feathren',
    $t$Escolha uma opção Aviária e uma Felina nas tabelas de Ancestria Feathren.

Você conhece o truque da opção aviária e a magia Identificar. No 3º nível de personagem, aprende a magia da opção felina. No 5º, aprende Aprimorar Atributo. Sempre tem essas magias preparadas; cada uma 1× sem espaço ou componente material / Descanso Longo (também pode usar espaços).

Inteligência, Sabedoria ou Carisma é seu atributo de conjuração para essas magias (escolha ao definir as ancestrias).$t$,
    'feathren_avian_ancestry'::rpg.species_choice_kind
  ),
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'feathren'),
    'Ancestria Felina',
    'Escolha uma linhagem felina na tabela de Ancestria Feathren (par de escolhas com a opção aviária).',
    'feathren_feline_ancestry'::rpg.species_choice_kind
  ),
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'feathren'),
    'Atributo de Conjuração Feathren',
    'Escolha Inteligência, Sabedoria ou Carisma como atributo de conjuração das magias concedidas pela Ancestria Feathren.',
    'feathren_casting_ability'::rpg.species_choice_kind
  ),
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'feathren'),
    'Fala Fraterna',
    'Comunica ideias simples a aves e felinos Grandes ou menores, incluindo grifos. Eles entendem suas palavras, mas você não os entende automaticamente. Você tem Vantagem em testes de Sabedoria (Lidar com Animais) e de Carisma para influenciá-los.',
    NULL
  ),
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'feathren'),
    'Criador Natural',
    'Imbuído com essência criativa do grifo astral: proficiência em duas Ferramentas de Artesão à escolha; aprende nova ferramenta em metade do tempo normal.',
    NULL
  ),
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'feathren'),
    'Garras',
    'Ataques Desarmados com garras causam 1d6 Perfurante em vez de Contundente.',
    NULL
  )
ON CONFLICT (species_id, name) DO UPDATE SET
  description = EXCLUDED.description,
  choice_kind = EXCLUDED.choice_kind;
