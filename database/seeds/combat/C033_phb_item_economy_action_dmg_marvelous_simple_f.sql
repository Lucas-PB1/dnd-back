-- DMG §0 #9f: economy maravilhosos (lote 6)
-- Ver docs/source/dmg-item-mesa-taxonomy-marvelous-simple.yaml

INSERT INTO rpg.phb_class_economy_action (
  action_id, class_id, species_id, feat_id, item_id, subclass_id, name, economy, unlock_level,
  resource_slug, free_resource_slug, always_spends_resource,
  summary, description, table_action, spend_amount, sort_order,
  requires_option_key, requires_option_value
) VALUES
(
  'item-periapto-de-cicatrizacao-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'periapto-de-cicatrizacao'), NULL,
  'Periapto · Cicatrização', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Dobra cura de Dado de PV; salvaguarda contra morte 9→10',
  'Ao usar: dobre PV recuperados com Dado de PV. Em Salvaguarda Contra Morte, pode mudar 9 ou menos para 10 (sucesso).',
  NULL, NULL, 890, NULL, NULL
),
(
  'item-bola-de-cristal-da-leitura-de-mentes-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'bola-de-cristal-da-leitura-de-mentes'), NULL,
  'Bola · Vidência + Detectar Pensamentos', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Vidência CD 17; Detectar Pensamentos no sensor (sem Conc.)',
  'Toque: Vidência (CD 17). Também Detectar Pensamentos (CD 17) em criaturas à vista a 9 m do sensor; sem Concentração; encerra com a Vidência.',
  NULL, NULL, 891, NULL, NULL
),
(
  'item-capa-deslocadora-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'capa-deslocadora'), NULL,
  'Capa · Deslocamento', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Desvantagem em ataques vs você (pausa se tomar dano / Desloc. 0)',
  'Ilusão: Desvantagem em ataques contra você. Se sofrer dano, para até o início do seu próximo turno. Suprimida se Deslocamento = 0.',
  NULL, NULL, 892, NULL, NULL
),
(
  'item-unguento-de-keoghtom-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'unguento-de-keoghtom'), NULL,
  'Unguento · Curar Dose', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Dose: 2d8+2 PV e remove Envenenado (rastreie doses)',
  'Ampola com 1d4+1 doses. Usar Objeto: engolir ou aplicar a criatura a 1,5 m → 2d8+2 PV e sem Envenenado. Reduza doses; a 0 remova.',
  NULL, NULL, 893, NULL, NULL
),
(
  'item-solvente-universal-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'solvente-universal'), NULL,
  'Solvente · Dissolver Adesivo', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  '30 g: dissolve 30×30 cm de adesivo (incl. Cola Suprema)',
  'Tubo com 1d6+30 g. Usar Objeto: despeje ≥30 g; cada 30 g dissolve até 30×30 cm de adesivo. Rastreie gramas.',
  NULL, NULL, 894, NULL, NULL
),
(
  'item-manto-das-asas-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'manto-das-asas'), NULL,
  'Manto · Asas (Voo 18 m / 1 h)', 'action'::rpg.action_economy_bucket, 1,
  'mantoAsasUse', NULL, true,
  'Asas 1 h (MVP: 1×/Descanso Longo; texto 1d12 h)',
  'Usar Magia: asas 1 h ou até encerrar (Usar Magia); Voo 18 m; cai se acabar no ar. Texto: 1d12 h de espera (MVP: Descanso Longo).',
  'spend-resource', 1, 895, NULL, NULL
),
(
  'item-talisma-da-esfera-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'talisma-da-esfera'), NULL,
  'Talismã · Esfera da Aniquilação', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Vantagem Arcanismo vs Esfera; mover +3 m (+3×Int) no turno',
  'Vantagem em Int (Arcanismo) para controlar Esfera da Aniquilação. No turno controlando: Usar Magia move +3 m + 3×mod Int (não precisa linha reta).',
  NULL, NULL, 896, NULL, NULL
),
(
  'item-botas-de-velocidade-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'botas-de-velocidade'), NULL,
  'Botas · Dobrar Deslocamento', 'bonus'::rpg.action_economy_bucket, 1,
  'botasVelocidadeUse', NULL, true,
  'Ação Bônus: dobrar Desloc. (10 min total / DL — MVP 1 uso)',
  'Ação Bônus: bater calcanhares → Desloc. dobrado; Desvantagem em Ataques de Oportunidade vs você. Bater de novo encerra. Texto: 10 min totais até DL (MVP: 1 uso/DL).',
  'spend-resource', 1, 897, NULL, NULL
),
(
  'item-rubi-do-mago-de-batalha-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'rubi-do-mago-de-batalha'), NULL,
  'Rubi · Fixar em Arma', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  '10 min: arma vira Foco; Usar Magia para remover',
  'Pressione 10 min em arma Simples/Marcial → Foco de conjuração. Remova com Usar Magia, destruição da arma ou fim da Sintonização.',
  NULL, NULL, 898, NULL, NULL
),
(
  'item-tunica-do-arquimago-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'tunica-do-arquimago'), NULL,
  'Túnica · Arquimago', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'CA 15+DES sem armadura; +2 CD/ataque mágico; Vantagem vs magia',
  'Sem armadura: CA base 15+DES. CD e ataque mágico +2. Vantagem em salvaguardas vs magias e efeitos mágicos. Ajuste CA/ataque manualmente.',
  NULL, NULL, 899, NULL, NULL
),
(
  'item-colar-de-bolas-de-fogo-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'colar-de-bolas-de-fogo'), NULL,
  'Colar · Conta (Bola de Fogo)', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Soltar conta(s): Bola de Fogo 3º CD 15 (+1d6/conta extra)',
  '1d6+3 contas. Usar Magia: solte/arremesse a 18 m → Bola de Fogo 3º (CD 15). Várias contas: +1d6 dano cada após a 1ª (máx. 12d6). Rastreie contas.',
  NULL, NULL, 900, NULL, NULL
),
(
  'item-insignia-da-pena-de-quaal-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'insignia-da-pena-de-quaal'), NULL,
  'Insígnia · Ativar (1×)', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar tipo da pena (Âncora/Pássaro/…); consumir',
  'Uso único conforme tipo (tabela 1d100). Após usar, remova do inventário.',
  NULL, NULL, 901, NULL, NULL
),
(
  'item-boneca-conversadora-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'boneca-conversadora'), NULL,
  'Boneca · Programar Frases', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'No Descanso Curto: até 6 frases × 6 palavras + condições',
  'Durante Descanso Curto a 1,5 m: programe até 6 frases (≤6 palavras) com condições a 1,5 m. Substituíveis. Apagam ao fim da Sintonização.',
  NULL, NULL, 902, NULL, NULL
),
(
  'item-aljava-de-ehlonna-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'aljava-de-ehlonna'), NULL,
  'Aljava · Extradimensional', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  '3 compartimentos; peso ≤1 kg; sacar normalmente',
  'Curto: 60 flechas/virotes. Médio: 18 azagaias. Longo: 6 arcos/cajados/lanças. Peso total ≤1 kg. Sacar como aljava comum.',
  NULL, NULL, 903, NULL, NULL
),
(
  'item-po-de-desaparecimento-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'po-de-desaparecimento'), NULL,
  'Pó · Invisibilidade 3 m', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Emanação 3 m: Invisível 2d4 min (consumir)',
  'Usar Objeto: lance o pó → você e criaturas/objetos na Emanação 3 m ficam Invisíveis 2d4 min. Atacar/dano/conjurar encerra para aquele alvo. Remova do inventário.',
  NULL, NULL, 904, NULL, NULL
),
(
  'item-instrumento-musical-de-ilusoes-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'instrumento-musical-de-ilusoes'), NULL,
  'Instrumento · Ilusões Visuais', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Enquanto toca: ilusões inofensivas (1,5 m / Bardo 4,5 m)',
  'Usar Magia enquanto toca: efeitos visuais ilusórios na Emanação (1,5 m; Bardo 4,5 m). Sem matéria/som; óbvios. Encerram ao parar de tocar.',
  NULL, NULL, 905, NULL, NULL
),
(
  'item-escaravelho-de-protecao-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'escaravelho-de-protecao'), NULL,
  'Escaravelho · +1 CA / Resistência a Magia', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  '+1 CA (wired); Vantagem vs magias',
  '+1 CA via permanentEffects. Vantagem em salvaguardas contra magias.',
  NULL, NULL, 906, NULL, NULL
),
(
  'item-escaravelho-de-protecao-preservar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'escaravelho-de-protecao'), NULL,
  'Escaravelho · Preservação', 'reaction'::rpg.action_economy_bucket, 1,
  'escaravelhoProtecaoCharges', NULL, true,
  'Reação: falha vs Necromancia/Morto-vivo → sucesso (1 carga)',
  'Ao falhar salvaguarda vs Necromancia ou efeito nocivo de Morto-vivo: Reação gaste 1 carga → sucesso. Cargas: 12; última carga destrói o item.',
  'spend-resource', 1, 907, NULL, NULL
),
(
  'item-cinturao-de-forca-de-gigante-passivo', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'cinturao-de-forca-de-gigante'), NULL,
  'Cinturão · Força de Gigante', 'free'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Força = valor do tipo (21–29); ajuste manual',
  'Força torna-se a do tipo (colina 21 … tempestade 29) se a sua for menor. Sem efeito se já ≥. Ajuste na ficha.',
  NULL, NULL, 908, NULL, NULL
),
(
  'item-moeda-rival-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'moeda-rival'), NULL,
  'Moeda · Cara ou Coroa', 'action'::rpg.action_economy_bucket, 1,
  'moedaRivalUse', NULL, true,
  'Lançar: cara (dano psíquico alvo) / coroa (você 1d4)',
  'Usar Magia: gaste 1 carga; 1d2 cara/coroa. Cara: alvo a 18 m SAB CD 13; falha 2d4 Psíquico + Desv. próximo ataque; sucesso metade. Coroa: você 1d4 Psíquico. 1×/amanhecer (MVP: DL).',
  'spend-resource', 1, 909, NULL, NULL
),
(
  'item-olho-de-megera-ver-invisivel', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'olho-de-megera'), NULL,
  'Olho · Ver o Invisível', 'action'::rpg.action_economy_bucket, 1,
  'olhoMegeraCharges', NULL, true,
  'Gastar 1 carga: Ver o Invisível (em si)',
  'Gaste 1 carga: Ver o Invisível em si. Cargas: 3; recupera todas ao amanhecer (MVP: DL).',
  'spend-resource', 1, 910, NULL, NULL
),
(
  'item-olho-de-megera-visao-escuro', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'olho-de-megera'), NULL,
  'Olho · Visão no Escuro', 'action'::rpg.action_economy_bucket, 1,
  'olhoMegeraCharges', NULL, true,
  'Gastar 1 carga: Visão no Escuro (em si)',
  'Gaste 1 carga: Visão no Escuro em si. Cargas: 3; MVP recupera no DL.',
  'spend-resource', 1, 911, NULL, NULL
),
(
  'item-faixas-de-ferro-de-bilarro-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'faixas-de-ferro-de-bilarro'), NULL,
  'Faixas · Contido', 'action'::rpg.action_economy_bucket, 1,
  'faixasBilarroUse', NULL, true,
  'Arremessar: ataque à distância → Contido (1×/amanhecer)',
  'Usar Magia: arremesse a 18 m (Enorme ou menor); ataque = DES+PB. Acerto: Contido até Ação Bônus liberar. Força (Atletismo) CD 20 pode romper (destrói). MVP: 1×/DL.',
  'spend-resource', 1, 912, NULL, NULL
),
(
  'item-faixas-de-ferro-de-bilarro-liberar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'faixas-de-ferro-de-bilarro'), NULL,
  'Faixas · Liberar', 'bonus'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Ação Bônus: comando libera Contido; faixas viram esfera',
  'Ação Bônus: emita comando para liberar; faixas contraem em esfera.',
  NULL, NULL, 913, NULL, NULL
),
(
  'item-caldeirao-do-renascimento-pocao', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'caldeirao-do-renascimento'), NULL,
  'Caldeirão · Preparar Poção', 'action'::rpg.action_economy_bucket, 1,
  'caldeiraoPocaoUse', NULL, true,
  'Após DL: Poção de Cura (maior) 1 min (dura 24 h)',
  'Foco/componente de Vidência. Após Descanso Longo: prepare Poção de Cura (maior) em 1 min (dura 24 h). 1×/DL.',
  'spend-resource', 1, 914, NULL, NULL
),
(
  'item-caldeirao-do-renascimento-crescer', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'caldeirao-do-renascimento'), NULL,
  'Caldeirão · Crescer / Encolher', 'action'::rpg.action_economy_bucket, 1,
  NULL, NULL, false,
  'Usar Magia: tamanho p/ criatura Média / reverter',
  'Usar Magia: cresça o suficiente para Humanoide Médio agachar; reverter realoca o que não cabe.',
  NULL, NULL, 915, NULL, NULL
),
(
  'item-caldeirao-do-renascimento-reviver', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'caldeirao-do-renascimento'), NULL,
  'Caldeirão · Reviver os Mortos', 'action'::rpg.action_economy_bucket, 1,
  'caldeiraoReviverUse', NULL, true,
  'Cadáver + 90 kg sal / 8 h → Reviver no amanhecer (MVP 1×/DL; texto 7 dias)',
  'Cubra cadáver Humanoide com 90 kg de sal (10 PO) ≥8 h; no próximo amanhecer = Reviver os Mortos. Texto: 7 dias (MVP: Descanso Longo).',
  'spend-resource', 1, 916, NULL, NULL
),
(
  'item-tomo-das-palavras-tranquilizantes-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'tomo-das-palavras-tranquilizantes'), NULL,
  'Tomo · Conjurar Magia Escrita', 'bonus'::rpg.action_economy_bucket, 1,
  'tomoPalavrasUse', NULL, true,
  'Ação Bônus: conjurar magia do tomo sem espaço (1×/amanhecer)',
  'Livro de Magias + Foco. Ação Bônus: conjure magia escrita nele sem espaço/V/S. 1× até amanhecer (MVP: DL). Remover a língua apaga as magias.',
  'spend-resource', 1, 917, NULL, NULL
),
(
  'item-talisma-do-mal-universal-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'talisma-do-mal-universal'), NULL,
  'Talismã · Fim Supremo', 'action'::rpg.action_economy_bucket, 1,
  'talismaMalCharges', NULL, true,
  'Gastar 1 carga: fissura DES CD 20 (destrói / 4d6 Psíquico)',
  'Não Ínfero/Morto-vivo: 8d6 Necrótico ao tocar (lembrete). Usar Magia: 1 carga; alvo no chão a 36 m DES CD 20 (Celestial Desv.); falha destruído; sucesso 4d6 Psíquico. Cargas: 6; última destrói. Símbolo Sagrado; +2 ataque mágico (lembrete).',
  'spend-resource', 1, 918, NULL, NULL
),
(
  'item-talisma-do-bem-sem-ver-a-quem-usar', NULL, NULL, NULL,
  (SELECT id FROM rpg.phb_item WHERE slug = 'talisma-do-bem-sem-ver-a-quem'), NULL,
  'Talismã · Repreensão Pura', 'action'::rpg.action_economy_bucket, 1,
  'talismaBemCharges', NULL, true,
  'Gastar 1 carga: fissura DES CD 20 (destrói / 4d6 Psíquico)',
  'Ínfero/Morto-vivo: 8d6 Radiante ao tocar (lembrete). Usar Magia: 1 carga; alvo no chão a 36 m DES CD 20 (Ínfero/MV Desv.); falha destruído; sucesso 4d6 Psíquico. Cargas: 7; última destrói. Símbolo Sagrado; +2 ataque mágico (lembrete).',
  'spend-resource', 1, 919, NULL, NULL
)
ON CONFLICT (action_id) DO UPDATE SET
  class_id = EXCLUDED.class_id,
  species_id = EXCLUDED.species_id,
  feat_id = EXCLUDED.feat_id,
  item_id = EXCLUDED.item_id,
  subclass_id = EXCLUDED.subclass_id,
  name = EXCLUDED.name,
  economy = EXCLUDED.economy,
  unlock_level = EXCLUDED.unlock_level,
  resource_slug = EXCLUDED.resource_slug,
  free_resource_slug = EXCLUDED.free_resource_slug,
  always_spends_resource = EXCLUDED.always_spends_resource,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  table_action = EXCLUDED.table_action,
  spend_amount = EXCLUDED.spend_amount,
  sort_order = EXCLUDED.sort_order,
  requires_option_key = EXCLUDED.requires_option_key,
  requires_option_value = EXCLUDED.requires_option_value;
