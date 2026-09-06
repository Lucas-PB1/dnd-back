-- Features de subclasse — Northlands Heroes of the Sagas

-- —— Path of the Titan ——
INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description)
VALUES
((SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-titan'), 3, 'Fúria dos Gigantes',
'Sua Fúria canaliza o poder primal dos gigantes. Sempre que ativar a Fúria, se for menor que Grande, pode tornar-se Grande. Seu equipamento cresce. Se não houver espaço, você não cresce.

Enquanto Grande: capacidade de carga dobra; Vantagem em testes e salvaguardas de Força; ataques com armas ou Desarmados causam um dado extra de dano (ex.: espada larga 3d6, machado grande 2d12).'),
((SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-titan'), 6, 'Passos Esmagadores',
'Como parte do movimento, pode atravessar o espaço de qualquer criatura menor que você. Um inimigo cujo espaço você atravessar deve ser bem-sucedido numa salvaguarda de Força (CD 8 + mod. Força + PB) ou fica Caído e perde Reações até o início do próximo turno dele.'),
((SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-titan'), 10, 'Golpes Titânicos',
'Ao usar Golpe Brutal: a distância empurrada pelo Golpe Forçoso dobra; a Velocidade de um alvo atingido pelo Golpe no Tendão cai a 0 até o início do seu próximo turno.'),
((SELECT id FROM rpg.phb_subclass WHERE slug = 'path-of-the-titan'), 14, 'Fúria dos Titãs',
'Ao ativar a Fúria, se for menor que Enorme, pode tornar-se Enorme (equipamento cresce). Sem espaço para Enorme → Grande; sem espaço para Grande → não cresce.

Enquanto Enorme: carga triplica; alcance +1,5 m; Vantagem em Força; ataques com armas/Desarmados causam dois dados extras de dano.')
ON CONFLICT (subclass_id, level, name) DO UPDATE SET description = EXCLUDED.description;

-- —— Skald ——
INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description)
VALUES
((SELECT id FROM rpg.phb_subclass WHERE slug = 'skald'), 3, 'Provocação Poética',
'Truque Vicioso. Você sempre tem Zombaria Perversa preparada. Se já a conhecia, aprende outro truque. Criatura que falhar na salvaguarda tem Desvantagem na próxima salvaguarda de Sabedoria, Inteligência ou Carisma até o fim do seu próximo turno, além dos efeitos normais.

Mestre do Flyting. Pode usar Carisma (Atuação) no lugar de Intimidação ou Persuasão para antagonizar, ameaçar, agitar ou acalmar multidões quando a narrativa/insulto couber.'),
((SELECT id FROM rpg.phb_subclass WHERE slug = 'skald'), 3, 'Treino Marcial',
'Proficiência com armas Marciais e treinamento com armadura Média e Escudos. Pode usar arma Simples ou Marcial como Foco de Conjuração de Bardo.

Além disso, usa a maestria de uma arma Simples ou Marcial à escolha; ao terminar Descanso Longo, pode trocar a escolha.'),
((SELECT id FROM rpg.phb_subclass WHERE slug = 'skald'), 6, 'Runa da Fala de Bragi',
'Ação Bônus: gaste 1 Inspiração Bárdica e escolha um efeito (só um ativo por vez):

Escárnio. Uma criatura a 9 m faz salvaguarda de Sabedoria; em falha, Desvantagem em ataques contra você por 1 minuto.

Eloquência. Role o dado de Inspiração e some ao primeiro teste ou salvaguarda de Carisma na próxima hora.

Vitalidade. Role o dado; você e até 3 aliados a 9 m ganham PV temp. iguais ao resultado.'),
((SELECT id FROM rpg.phb_subclass WHERE slug = 'skald'), 14, 'Sagas de Batalha',
'Gaste 1 minuto recitando as Eddas. Criaturas à sua escolha (exceto você) a 18 m que o ouçam, por 1 hora: Resistência a Veneno; Imunidade a Amedrontado e Envenenado; máximo de PV +2d10 (e ganham esses PV); 1×/turno +1d4 em ataque ou salvaguarda.

Nesse período, Reação: ao ver aliado sob a saga falhar em salvaguarda/ataque/teste, gaste Inspiração Bárdica — ele soma o dado ao resultado falho.

1× / Descanso Curto ou Longo.')
ON CONFLICT (subclass_id, level, name) DO UPDATE SET description = EXCLUDED.description;

-- —— Nornbound ——
INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description)
VALUES
((SELECT id FROM rpg.phb_subclass WHERE slug = 'nornbound'), 3, 'Magias de Domínio',
'Sempre tem preparadas as magias da tabela Atado às Nornas: L3 Augúrio, Perdição, Bênção, Vínculo de Proteção; L5 Rogar Maldição, Contramagia; L7 Proteção Contra a Morte, Presságio; L9 Comunhão, Modificar Memória.'),
((SELECT id FROM rpg.phb_subclass WHERE slug = 'nornbound'), 3, 'Ajustar a Teia',
'Ao terminar Descanso Longo, role 2d6 e anote (Fios). Como Reação, após ver o resultado de ataque, dano, salvaguarda ou teste de criatura a 18 m, some ou subtraia um Fio (pode mudar sucesso/falha ou sobrevivência).

Dado sobe: L7 d8; L11 d10; L15 d12. Cada Fio 1×; recupera todos no Descanso Longo.'),
((SELECT id FROM rpg.phb_subclass WHERE slug = 'nornbound'), 3, 'Puxar os Fios',
'Ação Bônus: apresente o símbolo sagrado e gaste Canalizar Divindade. Aliados a 9 m têm Vantagem em ataques e salvaguardas até o fim do seu próximo turno.'),
((SELECT id FROM rpg.phb_subclass WHERE slug = 'nornbound'), 6, 'Destino Entrelaçado',
'Ação Mágica: gaste um espaço. Dois alvos a 9 m (primário e secundário). Primário faz salvaguarda de Constituição: 1d8 Força por círculo do espaço em falha (metade em sucesso); pode falhar de propósito. Secundário recebe PV iguais ao dano (cura se ferido, senão PV temp.).'),
((SELECT id FROM rpg.phb_subclass WHERE slug = 'nornbound'), 17, 'Tecelão da Teia',
'Ao usar Puxar os Fios, inimigos a 9 m fazem salvaguarda de Carisma (CD de magia). Em falha, Desvantagem em ataques e salvaguardas por 1 minuto (repete no fim do turno). Em sucesso, imune por 24 h.')
ON CONFLICT (subclass_id, level, name) DO UPDATE SET description = EXCLUDED.description;

-- —— Circle of Fenris ——
INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description)
VALUES
((SELECT id FROM rpg.phb_subclass WHERE slug = 'circle-of-fenris'), 3, 'Manto do Lobo',
'Ação: gaste 1 Forma Selvagem. Cabeça espectral de lobo paira sobre você por 10 min (encerra cedo se dispensar, usar de novo ou ficar Incapacitado).

Bônus em Força (Atletismo) e salvaguardas de Força = mod. Sabedoria (mín. 1). Pode trocar um ataque corpo a corpo por mordida espectral (mod. Sabedoria no ataque; 1d8 + mod. Sabedoria Força no acerto).'),
((SELECT id FROM rpg.phb_subclass WHERE slug = 'circle-of-fenris'), 3, 'Magias do Círculo de Fenris',
'Sempre preparadas: L3 Sentido Feral, Aprimorar Atributo, Golpe Constritor, Marca do Predador; L5 Invocar Animais, Medo; L7 Dominar Fera; L9 Comunhão com a Natureza.'),
((SELECT id FROM rpg.phb_subclass WHERE slug = 'circle-of-fenris'), 6, 'Manto Aprimorado',
'Com o Manto: Quebrar a Corrente — mordidas causam dano dobrado a objetos/estruturas (ignoram limiar); Visão no Escuro 18 m (ou +9 m); Velocidade +3 m.'),
((SELECT id FROM rpg.phb_subclass WHERE slug = 'circle-of-fenris'), 10, 'Defender a Alcateia',
'Reação: quando criatura atacar aliado a 9 m, gaste 1 Forma Selvagem — lobo fantasma causa 4d8 Força e Caído (sem ataque/salvaguarda). L14: 6d8.'),
((SELECT id FROM rpg.phb_subclass WHERE slug = 'circle-of-fenris'), 14, 'Filhos do Grande Lobo',
'1×/dia, ao assumir o Manto, convoque um fenrikyn (ver Cap. 8 da fonte). Comandos telepáticos. Dura com o Manto ou até dispensar/destruir/outro plano/você cair/ficar a >36 m.')
ON CONFLICT (subclass_id, level, name) DO UPDATE SET description = EXCLUDED.description;

-- —— Viking ——
INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description)
VALUES
((SELECT id FROM rpg.phb_subclass WHERE slug = 'viking'), 3, 'Nascido no Mar',
'Vantagem em salvaguardas e testes de Força/Destreza para evitar ser empurrado, Caído ou movido contra a vontade. Vantagem em testes para pilotar/controlar veículo aquático.'),
((SELECT id FROM rpg.phb_subclass WHERE slug = 'viking'), 3, 'Maestria de Arma Viking',
'Se tiver Maestria com Machado de Batalha, Espada Longa ou Lança: 1×/turno, some o PB a uma rolagem de dano com essa arma.'),
((SELECT id FROM rpg.phb_subclass WHERE slug = 'viking'), 7, 'Investida Selvagem',
'Como ação Atacar: mova até sua Velocidade e faça um ataque corpo a corpo. No acerto, Ação Bônus para Disparar; nesse Disparo pode atravessar o espaço do alvo sem provocar AO.'),
((SELECT id FROM rpg.phb_subclass WHERE slug = 'viking'), 10, 'Chamado das Terras Nórdicas',
'Ao terminar Descanso Longo, escolha um benefício (substitui o do dia anterior): Matador de Dragões (Vantagem vs Dragões); Nadador Resistente (Natação = Velocidade); Acostumado ao Frio (Resistência a Gélido); Matador de Trolls (Vantagem vs Gigantes).'),
((SELECT id FROM rpg.phb_subclass WHERE slug = 'viking'), 15, 'Represália do Saqueador',
'Ao ficar Ensanguentado ou sofrer crítico: Reação para atacar inimigo no alcance. No acerto é crítico e você ganha PV temp. = metade do nível. Usos = PB / Descanso Longo.'),
((SELECT id FROM rpg.phb_subclass WHERE slug = 'viking'), 18, 'Assalto Imparável',
'Ação: ataques extras = metade do PB além dos normais. Acertos são críticos; alvo faz salvaguarda de Força (CD 8+PB+Força) ou é empurrado 3 m. 1× / Descanso Longo.')
ON CONFLICT (subclass_id, level, name) DO UPDATE SET description = EXCLUDED.description;

-- —— Oath of Valhalla ——
INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description)
VALUES
((SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-valhalla'), 3, 'Destruição Encorajadora',
'Imediatamente após Destruição Divina, gaste Canalizar Divindade: criaturas à escolha a 9 m têm Vantagem em ataques e salvaguardas contra o alvo da Destruição até o início do seu próximo turno, e causam +1d4 Trovão nesses ataques.'),
((SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-valhalla'), 3, 'Guardião dos Mortos',
'Ação Bônus: gaste Canalizar Divindade (1 h). A 3 m de criatura a 0 PV: Vantagem em ataques e em salvaguardas vs Enfeitiçado/Amedrontado. Com Aura de Coragem: Imunidade a Enfeitiçado nesse efeito.

No período: Reação ao ver conjuração que cria Morto-vivo ou restaura vida — mova metade da Velocidade e ataque o conjurador.'),
((SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-valhalla'), 3, 'Magias do Juramento de Valhalla',
'L3 Heroísmo, Destruição Cauterizante; L5 Repouso Tranquilo, Destruição Radiante; L9 Sinal de Esperança, Glifo de Proteção; L13 Aura de Pureza, Defensor da Fé; L17 Coluna de Chamas, Consagrar.'),
((SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-valhalla'), 7, 'Aura Trovejante',
'Você e aliados têm Imunidade a Trovão na Aura de Proteção. Em Convocar Montaria, ataques da montaria podem causar Trovão.'),
((SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-valhalla'), 15, 'Alma Valorosa',
'Ao reduzir inimigo a 0 PV com ataque corpo a corpo, aliados a 18 m (à escolha) têm Vantagem em ataques e salvaguardas por 1 minuto.

Se você morrer: corpo como sob Repouso Tranquilo; pode recusar Retornar à Vida e similares.'),
((SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-valhalla'), 20, 'Espírito da Valquíria',
'Ação Bônus (10 min): Voo 18 m; Vantagem vs magias; criatura na aura que tentar criar/invocar Morto-vivo faz salvaguarda de Carisma ou falha; Destruições gastam qualquer espaço mas contam como 5º; inimigo que inicia turno na aura sofre Trovão = mod. Carisma + PB e salvaguarda de Constituição ou Atordoado até o fim do próximo turno.

1× / DL; restaure gastando espaço de 5º (sem ação).')
ON CONFLICT (subclass_id, level, name) DO UPDATE SET description = EXCLUDED.description;

-- —— Spirit Caller ——
INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description)
VALUES
((SELECT id FROM rpg.phb_subclass WHERE slug = 'spirit-caller'), 3, 'Forma Animal Espiritual',
'Escolha (ou role d12) a forma simbólica dos espíritos: raposa-ártica, morcego, falcão, peixe, lebre, lince, coruja, corvo, serpente, esquilo, sapo, doninha.'),
((SELECT id FROM rpg.phb_subclass WHERE slug = 'spirit-caller'), 3, 'Magias do Chamador de Espíritos',
'L3 Perdição, Bênção, Heroísmo, Proteção Contra o Bem e o Mal; L5 Augúrio, Espírito Curador (XGE 2014); L7 Falar com Mortos, Guardiões Espirituais; L9 Aura de Vida, Proteção Contra a Morte.'),
((SELECT id FROM rpg.phb_subclass WHERE slug = 'spirit-caller'), 3, 'Expertise Oculta',
'Proficiência em Arcanismo e Religião (se já não tiver). Pode usar mod. Carisma nesses testes se for maior que Inteligência.'),
((SELECT id FROM rpg.phb_subclass WHERE slug = 'spirit-caller'), 3, 'Orientação Espiritual',
'Ação Bônus: Vantagem num teste de perícia. Usos = mod. Carisma (mín. 1) / Descanso Longo.'),
((SELECT id FROM rpg.phb_subclass WHERE slug = 'spirit-caller'), 6, 'Aura Espiritual',
'Ação Bônus: aura 3 m em você ou aliado voluntário por 1 min (ou até Incapacitado/dispensar). Escolha: Sussurros Enlouquecedores (inimigo que entra/inicia: salvaguarda de Sabedoria ou Desvantagem em testes e ataques até fim do próximo turno) ou Sussurros Fortalecedores (aliado: Vantagem em testes e ataques até fim do próximo turno).

2× / DL; ou gaste 3 Pontos de Feitiçaria para usar de novo.'),
((SELECT id FROM rpg.phb_subclass WHERE slug = 'spirit-caller'), 14, 'Segredos Espirituais',
'Ao falhar em teste, ataque ou salvaguarda, pode rerrolar (fica com o segundo). Usos = mod. Carisma (mín. 1) / DL; sem usos, gaste 3 Pontos de Feitiçaria para 1 uso.'),
((SELECT id FROM rpg.phb_subclass WHERE slug = 'spirit-caller'), 18, 'Tempestade Espiritual',
'Aura Espiritual passa a 4,5 m. Inimigo que entra/inicia na aura sofre 2d8 Psíquico (máx. 1×/turno).')
ON CONFLICT (subclass_id, level, name) DO UPDATE SET description = EXCLUDED.description;

-- —— Trickster ——
INSERT INTO rpg.phb_subclass_feature (subclass_id, level, name, description)
VALUES
((SELECT id FROM rpg.phb_subclass WHERE slug = 'trickster'), 3, 'Troca de Contexto',
'Reação ao ser alvo de ataque corpo a corpo: escolha criatura a 1,5 m. Involuntária faz salvaguarda de Sabedoria (CD magia). Em falha (ou se voluntária), troca de lugar e torna-se o alvo. No acerto, o dano vai para ela; se for inimigo, Desvantagem em ataques até o início do seu próximo turno.

Usos = mod. Carisma (mín. 1) / Descanso Longo.'),
((SELECT id FROM rpg.phb_subclass WHERE slug = 'trickster'), 3, 'Magias do Trapaceiro',
'L3 Detectar Pensamentos, Disfarçar-se, Aumentar/Reduzir, Boca Encantada, Imagem Silenciosa; L5 Indetectável, Lentidão; L7 Compulsão, Confusão; L9 Animar Objetos, Modificar Memória.'),
((SELECT id FROM rpg.phb_subclass WHERE slug = 'trickster'), 3, 'Trapaça Ágil',
'Proficiência em Prestidigitação. Vantagem ao trocar item por outro de dimensões semelhantes.

L6: pode trocar com objeto desatendido a até 9 m (teste). L14: pode substituir por ilusão (1 min); 1× / DL ou gaste espaço de Magia do Pacto para restaurar.'),
((SELECT id FROM rpg.phb_subclass WHERE slug = 'trickster'), 6, 'Troca Distante',
'Em Troca de Contexto, alcance 9 m. Se não estender o alcance, pode impor Desvantagem na salvaguarda. Em falha do alvo, pode ficar Invisível até o fim do próximo turno ou até atacar/causar dano/conjurar.'),
((SELECT id FROM rpg.phb_subclass WHERE slug = 'trickster'), 10, 'Irrealidade Dolorosa',
'Sucesso automático em Inteligência (Investigação) ao Analisar ilusões. Quando criatura interage com sua Ilusão e falha em discerni-la: pode forçar salvaguarda de Sabedoria; falha 4d10 Psíquico + Atordoado até fim do próximo turno (sucesso: metade do dano).'),
((SELECT id FROM rpg.phb_subclass WHERE slug = 'trickster'), 14, 'Arauto do Caos',
'Ação Bônus: anuncie mudanças na realidade. Inimigos que veem e ouvem fazem salvaguarda de Inteligência; falha: acreditam e têm Desvantagem em testes d20 até fim do próximo turno; você e aliados têm Vantagem em ataques e testes d20 contra eles.

1× / Descanso Curto.')
ON CONFLICT (subclass_id, level, name) DO UPDATE SET description = EXCLUDED.description;
