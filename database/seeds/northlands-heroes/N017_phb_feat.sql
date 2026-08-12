-- Talentos gerais + estilos de luta Northlands (Heroes of the Sagas)

INSERT INTO rpg.phb_feat (
  slug, name, category, repeatable, prerequisite, source_citation_id
)
VALUES
  (
    'axe-fighter',
    'Especialista em Machado',
    'general',
    FALSE,
    'Nível 4+, Força 13+, Proficiência com Armas Marciais',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'axe-thrower',
    'Arremessador de Machado',
    'general',
    FALSE,
    'Nível 4+, Proficiência com Machadinhas',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'battle-cry',
    'Grito de Guerra',
    'general',
    FALSE,
    'Nível 4+',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'blessing-of-angrboda-and-bergelmir',
    'Bênção de Angrboda e Bergelmir',
    'general',
    FALSE,
    'Nível 4+, Giganteide ou Trollide, ou com permissão do Mestre',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'blessing-of-bragi',
    'Bênção de Bragi',
    'general',
    FALSE,
    'Nível 4+',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'blessing-of-heimdall',
    'Bênção de Heimdall',
    'general',
    FALSE,
    'Nível 4+',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'blessing-of-hel',
    'Bênção de Hel',
    'general',
    FALSE,
    'Nível 4+',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'blessing-of-njord',
    'Bênção de Njord',
    'general',
    FALSE,
    'Nível 4+',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'blessing-of-skadi',
    'Bênção de Skadi',
    'general',
    FALSE,
    'Nível 4+',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'blessing-of-the-snow-queen',
    'Bênção da Rainha da Neve',
    'general',
    FALSE,
    'Nível 4+',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'blessing-of-tyr',
    'Bênção de Tyr',
    'general',
    FALSE,
    'Nível 4+',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'blood-of-the-berserker',
    'Sangue do Berserker',
    'general',
    FALSE,
    'Nível 4+',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'bloodied-resilience',
    'Resiliência Ensanguentada',
    'general',
    FALSE,
    'Nível 4+',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'bloody-resolve',
    'Resolução Sangrenta',
    'general',
    FALSE,
    'Constituição 13+',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'boisterous-roar',
    'Rugido Estrondoso',
    'general',
    FALSE,
    'Carisma 13+',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'brazen-courage',
    'Coragem Insolente',
    'general',
    FALSE,
    'Nível 4+',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'chosen-by-fate',
    'Escolhido pelo Destino',
    'general',
    FALSE,
    'Nível 4+',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'clout',
    'Prestígio',
    'general',
    FALSE,
    'Nível 4+, Força 13+, talento Líder Inspirador',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'cold-water-warrior',
    'Guerreiro das Águas Frias',
    'general',
    FALSE,
    'Nível 4+, Força ou Destreza 13+',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'combat-flyting',
    'Flyting de Combate',
    'general',
    FALSE,
    'Carisma 13+, Proficiência em Enganação',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'cut-down-the-nithingr',
    'Abater o Nithingr',
    'general',
    FALSE,
    'Nível 4+',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'endurance-conditioning',
    'Condicionamento de Resistência',
    'general',
    FALSE,
    'Constituição 13+, Proficiência em Atletismo',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'faster-crafting',
    'Criação Mais Rápida',
    'general',
    FALSE,
    'Nível 4+, talento de origem Artesão',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'fjord-jumper',
    'Saltador de Fiorde',
    'general',
    FALSE,
    'Nível 4+, Força 13+',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'frost-eyed',
    'Olhos de Geada',
    'general',
    FALSE,
    'Nível 4+',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'frost-touched',
    'Tocado pela Geada',
    'general',
    FALSE,
    'Nível 4+',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'giant-slayer',
    'Matador de Gigantes',
    'general',
    FALSE,
    'Nível 4+, característica de classe Maestria em Arma',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'greater-blessing-of-baldur',
    'Bênção Maior de Baldur',
    'general',
    FALSE,
    'Nível 4+, talento Bênção de Baldur',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'greater-blessing-of-boreas',
    'Bênção Maior de Boreas',
    'general',
    FALSE,
    'Nível 4+, talento Bênção de Boreas',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'greater-blessing-of-freyr-and-freyja',
    'Bênção Maior de Freyr e Freyja',
    'general',
    FALSE,
    'Nível 4+, talento Bênção de Freyr e Freyja',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'greater-blessing-of-jormungandr',
    'Bênção Maior de Jormungandr',
    'general',
    FALSE,
    'Nível 4+, talento Bênção de Jormungandr',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'greater-blessing-of-loki',
    'Bênção Maior de Loki',
    'general',
    FALSE,
    'Nível 4+, talento Bênção de Loki',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'greater-blessing-of-sif',
    'Bênção Maior de Sif',
    'general',
    FALSE,
    'Nível 4+, talento Bênção de Sif',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'greater-blessing-of-thor',
    'Bênção Maior de Thor',
    'general',
    FALSE,
    'Nível 4+, talento Bênção de Thor',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'greater-blessing-of-wotan',
    'Bênção Maior de Wotan',
    'general',
    FALSE,
    'Nível 4+, talento Bênção de Wotan',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'heroic-rush',
    'Investida Heroica',
    'general',
    FALSE,
    'Nível 4+',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'holmganga-master',
    'Mestre de Holmgang',
    'general',
    FALSE,
    'Nível 4+, talento Duelismo',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'hunter',
    'Caçador',
    'general',
    FALSE,
    'Nível 4+',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'ice-mastery',
    'Maestria do Gelo',
    'general',
    FALSE,
    'Nível 4+, talento Adepto Elemental com Magias Gélidas',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'lightning-mastery',
    'Maestria do Relâmpago',
    'general',
    FALSE,
    'Nível 4+, Adepto Elemental com Magias Elétricas',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'living-off-the-land',
    'Vivendo da Terra',
    'general',
    FALSE,
    'Nível 4+',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'long-haft-strike',
    'Golpe de Cabo Longo',
    'general',
    FALSE,
    'Nível 4+',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'moon-touched',
    'Tocado pela Lua',
    'general',
    FALSE,
    'Nível 4+',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'mounted-leap',
    'Salto Montado',
    'general',
    FALSE,
    'Nível 4+, Força ou Destreza 13+, Proficiência em Lidar com Animais',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'northlands-hardiness',
    'Resistência das Terras do Norte',
    'general',
    FALSE,
    'Nível 4+',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'primal',
    'Primordial',
    'general',
    FALSE,
    'Nível 4+',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'ravens-friend',
    'Amigo dos Corvos',
    'general',
    FALSE,
    'Nível 4+',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'spear-expert',
    'Especialista em Lança',
    'general',
    FALSE,
    'Nível 4+, Força ou Destreza 13+, característica de classe Maestria em Arma',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'surtrs-touch',
    'Toque de Surtr',
    'general',
    FALSE,
    'Nível 4+',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'tricksters-toolbox',
    'Caixa de Ferramentas do Trapaceiro',
    'general',
    FALSE,
    'Nível 4+',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'wild-lore',
    'Saber Selvagem',
    'general',
    FALSE,
    'Nível 4+',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'glima',
    'Glima',
    'fighting-style',
    FALSE,
    'Característica de Estilo de Luta',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'raiders-rush',
    'Investida do Saqueador',
    'fighting-style',
    FALSE,
    'Característica de Estilo de Luta',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'savagery',
    'Selvageria',
    'fighting-style',
    FALSE,
    'Característica de Estilo de Luta',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'shield-wall',
    'Muralha de Escudos',
    'fighting-style',
    FALSE,
    'Característica de Estilo de Luta, Proficiência com Escudo',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'skirmisher',
    'Escaramuçador',
    'fighting-style',
    FALSE,
    'Característica de Estilo de Luta',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  ),
  (
    'underfoot',
    'Pelos Pés',
    'fighting-style',
    FALSE,
    'Característica de Estilo de Luta',
    (SELECT id FROM rpg.phb_source_citation WHERE slug = 'northlands-heroes-2024-en:heroes-of-the-sagas')
  )
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  repeatable = EXCLUDED.repeatable,
  prerequisite = EXCLUDED.prerequisite,
  source_citation_id = EXCLUDED.source_citation_id;
