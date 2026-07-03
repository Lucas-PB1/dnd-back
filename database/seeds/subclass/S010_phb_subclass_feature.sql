-- Seed rpg.phb_subclass_feature
-- Gerado automaticamente — não editar à mão

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'world-tree') AND level = 3 AND name = 'Vitalidade da Árvore';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'world-tree') AND level = 6 AND name = 'Ramos da Árvore';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'world-tree') AND level = 10 AND name = 'Raízes Devastadoras';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'world-tree') AND level = 14 AND name = 'Percorrer a Árvore';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'berserker') AND level = 3 AND name = 'Frenesi';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'berserker') AND level = 6 AND name = 'Fúria Irracional';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'berserker') AND level = 10 AND name = 'Retaliação';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'resource'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'berserker') AND level = 14 AND name = 'Presença Intimidante';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-heart') AND level = 3 AND name = 'Arauto da Fauna';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'choice'::rpg.subclass_feature_kind, option_key = 'wildRageAspect' WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-heart') AND level = 3 AND name = 'Fúria dos Selvagens';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'choice'::rpg.subclass_feature_kind, option_key = 'wildAspect' WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-heart') AND level = 6 AND name = 'Aspecto dos Selvagens';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-heart') AND level = 10 AND name = 'Arauto da Natureza';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'choice'::rpg.subclass_feature_kind, option_key = 'wildPower' WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-heart') AND level = 14 AND name = 'Poder dos Selvagens';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'resource'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'zealot') AND level = 3 AND name = 'Campeão dos Deuses';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'choice'::rpg.subclass_feature_kind, option_key = 'divineFuryDamage' WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'zealot') AND level = 3 AND name = 'Fúria Divina';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'zealot') AND level = 6 AND name = 'Concentração Fanática';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'resource'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'zealot') AND level = 10 AND name = 'Presença Zelosa';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'resource'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'zealot') AND level = 14 AND name = 'Fúria dos Deuses';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'valor') AND level = 3 AND name = 'Inspiração em Combate';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'valor') AND level = 3 AND name = 'Treinamento Marcial';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'valor') AND level = 6 AND name = 'Ataque Extra';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'valor') AND level = 14 AND name = 'Magia de Batalha';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'dance') AND level = 3 AND name = 'Ginga Fascinante';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'dance') AND level = 6 AND name = 'Gingado Coordenado';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'dance') AND level = 6 AND name = 'Movimento Inspirador';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'dance') AND level = 14 AND name = 'Evasão Liderada';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'lore') AND level = 3 AND name = 'Palavras de Interrupção';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'lore') AND level = 3 AND name = 'Proficiências Bônus';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'lore') AND level = 6 AND name = 'Descobertas Mágicas';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'lore') AND level = 14 AND name = 'Perícia Inigualável';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'glamour') AND level = 3 AND name = 'Magia Fascinante';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'glamour') AND level = 3 AND name = 'Manto de Inspiração';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'glamour') AND level = 6 AND name = 'Manto de Majestade';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'glamour') AND level = 14 AND name = 'Majestade Inquebrável';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'always_prepared'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'archfey') AND level = 3 AND name = 'Magias de Pacto da Arquifada';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'resource'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'archfey') AND level = 3 AND name = 'Passos Feéricos';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'archfey') AND level = 6 AND name = 'Fuga em Névoa';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'resource'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'archfey') AND level = 10 AND name = 'Defesas Sedutoras';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'archfey') AND level = 14 AND name = 'Magia Sedutora';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'resource'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'celestial') AND level = 3 AND name = 'Luz Medicinal';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'always_prepared'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'celestial') AND level = 3 AND name = 'Magia de Pacto do Celestial';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'celestial') AND level = 6 AND name = 'Alma Radiante';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'celestial') AND level = 10 AND name = 'Resiliência Celestial';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'resource'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'celestial') AND level = 14 AND name = 'Vingança Calcinante';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'always_prepared'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'great-old-one') AND level = 3 AND name = 'Magias de Pacto do Grande Antigo';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'always_prepared'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'great-old-one') AND level = 3 AND name = 'Magias Psíquicas';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'great-old-one') AND level = 3 AND name = 'Mente Desperta';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'resource'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'great-old-one') AND level = 6 AND name = 'Combatente Clarividente';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'great-old-one') AND level = 10 AND name = 'Danação Mística';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'great-old-one') AND level = 10 AND name = 'Escudo Mental';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'great-old-one') AND level = 14 AND name = 'Criar Servo';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend') AND level = 3 AND name = 'Bênção do Tenebroso';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'always_prepared'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend') AND level = 3 AND name = 'Magias de Pacto do Ínfero';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'resource'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend') AND level = 6 AND name = 'A Sorte do Próprio Tenebroso';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend') AND level = 10 AND name = 'Resistência Ínfera';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'resource'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend') AND level = 14 AND name = 'Lançar no Inferno';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'always_prepared'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'life') AND level = 3 AND name = 'Magias de Domínio da Vida';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'life') AND level = 3 AND name = 'Discípulo da Vida';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'life') AND level = 3 AND name = 'Preservar a Vida';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'life') AND level = 6 AND name = 'Curandeiro Abençoado';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'life') AND level = 17 AND name = 'Cura Suprema';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'light') AND level = 3 AND name = 'Brilho do Amanhecer';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'light') AND level = 3 AND name = 'Labareda Protetora';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'always_prepared'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'light') AND level = 3 AND name = 'Magias de Domínio da Luz';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'light') AND level = 6 AND name = 'Labareda Protetora Aprimorada';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'resource'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'light') AND level = 17 AND name = 'Coroa de Luz';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'always_prepared'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'trickery') AND level = 3 AND name = 'Magias de Domínio da Trapaça';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'resource'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'trickery') AND level = 3 AND name = 'Bênção do Trapaceiro';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'trickery') AND level = 3 AND name = 'Invocar Duplicidade';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'trickery') AND level = 6 AND name = 'Transposição do Trapaceiro';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'trickery') AND level = 17 AND name = 'Duplicidade Aprimorada';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'always_prepared'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'war') AND level = 3 AND name = 'Magias de Domínio da Guerra';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'war') AND level = 3 AND name = 'Ataque Direcionado';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'resource'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'war') AND level = 3 AND name = 'Sacerdote da Guerra';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'war') AND level = 6 AND name = 'Bênção do Deus da Guerra';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'war') AND level = 17 AND name = 'Avatar da Guerra';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'land') AND level = 3 AND name = 'Auxílio da Terra';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'always_prepared'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'land') AND level = 3 AND name = 'Magias do Círculo da Terra';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'resource'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'land') AND level = 6 AND name = 'Recuperação Natural';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'land') AND level = 10 AND name = 'Proteção Natural';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'land') AND level = 14 AND name = 'Santuário Natural';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'moon') AND level = 3 AND name = 'Formas Animais dos Círculos Druídicos';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'always_prepared'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'moon') AND level = 3 AND name = 'Magias do Círculo da Lua';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'moon') AND level = 6 AND name = 'Formas Animais dos Círculos Druídicos Aprimorada';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'resource'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'moon') AND level = 10 AND name = 'Passo Lunar';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'moon') AND level = 14 AND name = 'Forma Lunar';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'choice'::rpg.subclass_feature_kind, option_key = 'stellarConstellation' WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'stars') AND level = 3 AND name = 'Forma Estrelada';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'choice'::rpg.subclass_feature_kind, option_key = 'starMapForm' WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'stars') AND level = 3 AND name = 'Mapa Estelar';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'resource'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'stars') AND level = 6 AND name = 'Presságio Cósmico';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'stars') AND level = 10 AND name = 'Constelações Cintilantes';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'stars') AND level = 14 AND name = 'Repleto de Estrelas';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'sea') AND level = 3 AND name = 'Ira do Mar';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'always_prepared'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'sea') AND level = 3 AND name = 'Magias do Círculo do Mar';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'sea') AND level = 6 AND name = 'Afinidade Aquática';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'sea') AND level = 10 AND name = 'Filho da Tempestade';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'sea') AND level = 14 AND name = 'Manifestação Oceânica';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'aberrant') AND level = 3 AND name = 'Fala Telepática';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'always_prepared'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'aberrant') AND level = 3 AND name = 'Magias Psiônicas';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'aberrant') AND level = 6 AND name = 'Defesas Psíquicas';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'aberrant') AND level = 6 AND name = 'Feitiçaria Psiônica';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'aberrant') AND level = 14 AND name = 'Revelação em Carne';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'resource'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'aberrant') AND level = 18 AND name = 'Implosão de Distorção';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'always_prepared'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'draconic') AND level = 3 AND name = 'Magias Dracônicas';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'draconic') AND level = 3 AND name = 'Resiliência Dracônica';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'choice'::rpg.subclass_feature_kind, option_key = 'elementalAffinity' WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'draconic') AND level = 6 AND name = 'Afinidade Elemental';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'resource'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'draconic') AND level = 14 AND name = 'Asas de Dragão';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'resource'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'draconic') AND level = 18 AND name = 'Companheiro Dracônico';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'always_prepared'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'clockwork') AND level = 3 AND name = 'Magias Mecânicas';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'resource'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'clockwork') AND level = 3 AND name = 'Restaurar Equilíbrio';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'clockwork') AND level = 6 AND name = 'Bastião da Lei';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'resource'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'clockwork') AND level = 14 AND name = 'Transe da Ordem';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'resource'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'clockwork') AND level = 18 AND name = 'Cavalgada Mecânica';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'resource'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-magic') AND level = 3 AND name = 'Marés do Caos';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-magic') AND level = 3 AND name = 'Surto de Magia Selvagem';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-magic') AND level = 6 AND name = 'Distorcer a Sorte';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-magic') AND level = 14 AND name = 'Caos Controlado';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'resource'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-magic') AND level = 18 AND name = 'Surto Controlado';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'choice'::rpg.subclass_feature_kind, option_key = 'glamourSkill' WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer') AND level = 3 AND name = 'Glamour Transcendental';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer') AND level = 3 AND name = 'Golpes Terríveis';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'always_prepared'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer') AND level = 3 AND name = 'Magias do Andarilho Feérico';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer') AND level = 7 AND name = 'Detalhe Sedutor';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'resource'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer') AND level = 11 AND name = 'Reforços Feéricos';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'resource'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer') AND level = 15 AND name = 'Andarilho Nebuloso';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'hunter') AND level = 3 AND name = 'Conhecimento do Caçador';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'choice'::rpg.subclass_feature_kind, option_key = 'huntersPrey' WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'hunter') AND level = 3 AND name = 'Presa do Caçador';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'choice'::rpg.subclass_feature_kind, option_key = 'defensiveTactics' WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'hunter') AND level = 7 AND name = 'Táticas Defensivas';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'hunter') AND level = 11 AND name = 'Presa do Caçador Superior';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'hunter') AND level = 15 AND name = 'Defesa do Caçador';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'choice'::rpg.subclass_feature_kind, option_key = 'primalCompanion' WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'beast-master') AND level = 3 AND name = 'Companheiro Primal';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'beast-master') AND level = 7 AND name = 'Treinamento Excepcional';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'beast-master') AND level = 11 AND name = 'Fúria Bestial';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'beast-master') AND level = 15 AND name = 'Compartilhar Magias';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'resource'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'gloom-stalker') AND level = 3 AND name = 'Emboscador das Sombras';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'always_prepared'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'gloom-stalker') AND level = 3 AND name = 'Magias do Vigilante das Sombras';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'gloom-stalker') AND level = 3 AND name = 'Visão Umbrosa';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'choice'::rpg.subclass_feature_kind, option_key = 'ironMindSave' WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'gloom-stalker') AND level = 7 AND name = 'Mente de Ferro';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'gloom-stalker') AND level = 11 AND name = 'Torrente do Vigilante';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'gloom-stalker') AND level = 15 AND name = 'Esquiva Sombria';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'champion') AND level = 3 AND name = 'Atleta Extraordinário';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'champion') AND level = 3 AND name = 'Crítico Aprimorado';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'choice'::rpg.subclass_feature_kind, option_key = 'additionalFightingStyle' WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'champion') AND level = 7 AND name = 'Estilo de Luta Adicional';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'champion') AND level = 10 AND name = 'Combatente Heroico';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'champion') AND level = 15 AND name = 'Crítico Superior';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'champion') AND level = 18 AND name = 'Sobrevivente';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'spellcasting'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'eldritch-knight') AND level = 3 AND name = 'Conjuração';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'eldritch-knight') AND level = 3 AND name = 'Vínculo com Arma';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'eldritch-knight') AND level = 7 AND name = 'Magia de Guerra';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'eldritch-knight') AND level = 10 AND name = 'Golpe Místico';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'eldritch-knight') AND level = 15 AND name = 'Investida Mística';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'eldritch-knight') AND level = 18 AND name = 'Magia de Guerra Aprimorada';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'resource'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'psi-warrior') AND level = 3 AND name = 'Poder Psiônico';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'resource'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'psi-warrior') AND level = 7 AND name = 'Adepto Telecinético';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'psi-warrior') AND level = 10 AND name = 'Resguardo Mental';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'resource'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'psi-warrior') AND level = 15 AND name = 'Baluarte de Energia';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'resource'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'psi-warrior') AND level = 18 AND name = 'Mestre Telecinético';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master') AND level = 3 AND name = 'Estudioso da Guerra';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'resource'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master') AND level = 3 AND name = 'Superioridade em Combate';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'resource'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master') AND level = 7 AND name = 'Conheça Seu Inimigo';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master') AND level = 10 AND name = 'Superioridade em Combate Aprimorada';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master') AND level = 15 AND name = 'Implacável';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master') AND level = 18 AND name = 'Superioridade em Combate Suprema';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'soulknife') AND level = 3 AND name = 'Lâminas Psíquicas';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'resource'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'soulknife') AND level = 3 AND name = 'Poder Psiônico';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'soulknife') AND level = 9 AND name = 'Lâminas da Alma';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'resource'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'soulknife') AND level = 13 AND name = 'Véu Psíquico';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'resource'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'soulknife') AND level = 17 AND name = 'Rasgar Mente';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'assassin') AND level = 3 AND name = 'Assassinar';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'assassin') AND level = 3 AND name = 'Ferramentas de Assassino';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'assassin') AND level = 9 AND name = 'Especialista em Infiltração';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'assassin') AND level = 13 AND name = 'Armas Venenosas';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'assassin') AND level = 17 AND name = 'Golpe Mortal';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'thief') AND level = 3 AND name = 'Andarilho de Telhados';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'thief') AND level = 3 AND name = 'Mão Leve';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'thief') AND level = 9 AND name = 'Furtividade Suprema';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'thief') AND level = 13 AND name = 'Usar Dispositivo Mágico';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'thief') AND level = 17 AND name = 'Reflexos de Ladrão';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'spellcasting'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'arcane-trickster') AND level = 3 AND name = 'Conjuração';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'arcane-trickster') AND level = 3 AND name = 'Mãos Mágicas Ligeiras';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'arcane-trickster') AND level = 9 AND name = 'Emboscada Mágica';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'arcane-trickster') AND level = 13 AND name = 'Trapaceiro Versátil';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'resource'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'arcane-trickster') AND level = 17 AND name = 'Ladrão de Magias';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'abjurer') AND level = 3 AND name = 'Proteção Arcana';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'spellbook_bonus'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'abjurer') AND level = 3 AND name = 'Versado em Abjuração';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'abjurer') AND level = 6 AND name = 'Proteção Projetada';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'abjurer') AND level = 10 AND name = 'Rompe-Magia';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'abjurer') AND level = 14 AND name = 'Resistência à Magia';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'diviner') AND level = 3 AND name = 'Prodígio';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'spellbook_bonus'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'diviner') AND level = 3 AND name = 'Versado em Adivinhação';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'diviner') AND level = 6 AND name = 'Perito em Adivinhação';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'diviner') AND level = 10 AND name = 'O Terceiro Olho';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'diviner') AND level = 14 AND name = 'Prodígio Maior';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'evoker') AND level = 3 AND name = 'Truque Potente';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'spellbook_bonus'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'evoker') AND level = 3 AND name = 'Versado em Evocação';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'evoker') AND level = 6 AND name = 'Esculpir Magias';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'evoker') AND level = 10 AND name = 'Evocação Potencializada';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'evoker') AND level = 14 AND name = 'Sobrecarga';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'illusionist') AND level = 3 AND name = 'Ilusões Aprimoradas';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'spellbook_bonus'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'illusionist') AND level = 3 AND name = 'Versado em Ilusão';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'illusionist') AND level = 6 AND name = 'Criaturas Espectrais';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'illusionist') AND level = 10 AND name = 'Autoimagem Ilusória';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'illusionist') AND level = 14 AND name = 'Realidade Ilusória';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'elements') AND level = 3 AND name = 'Manipular Elementos';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'elements') AND level = 3 AND name = 'Sintonia Elemental';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'elements') AND level = 6 AND name = 'Explosão Elemental';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'elements') AND level = 11 AND name = 'Passo dos Elementos';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'choice'::rpg.subclass_feature_kind, option_key = 'elementalResistance' WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'elements') AND level = 17 AND name = 'Ápice Elemental';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'open-hand') AND level = 3 AND name = 'Técnica da Mão Espalmada';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'resource'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'open-hand') AND level = 6 AND name = 'Integridade Corporal';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'open-hand') AND level = 11 AND name = 'Passo Veloz';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'open-hand') AND level = 17 AND name = 'Palma Vibrante';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'mercy') AND level = 3 AND name = 'Implementos de Misericórdia';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'mercy') AND level = 3 AND name = 'Mão de Cura';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'mercy') AND level = 3 AND name = 'Mão de Dolo';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'mercy') AND level = 6 AND name = 'Toque de Médico';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'resource'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'mercy') AND level = 11 AND name = 'Torrente de Cura e Dolo';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'resource'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'mercy') AND level = 17 AND name = 'Mão da Misericórdia Final';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'shadow') AND level = 3 AND name = 'Artes das Sombras';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'shadow') AND level = 6 AND name = 'Passo da Sombra';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'shadow') AND level = 11 AND name = 'Passo da Sombra Aprimorado';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'shadow') AND level = 17 AND name = 'Manto da Sombra';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'ancients') AND level = 3 AND name = 'A Ira da Natureza';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'always_prepared'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'ancients') AND level = 3 AND name = 'Magias do Juramento dos Anciões';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'ancients') AND level = 7 AND name = 'Aura de Resistência';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'resource'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'ancients') AND level = 15 AND name = 'Sentinela Imortal';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'resource'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'ancients') AND level = 20 AND name = 'Campeão Ancestral';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'devotion') AND level = 3 AND name = 'Arma Sagrada';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'devotion') AND level = 7 AND name = 'Aura de Devoção';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'devotion') AND level = 15 AND name = 'Destruição Protetora';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'resource'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'devotion') AND level = 20 AND name = 'Resplendor Sagrado';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'glory') AND level = 3 AND name = 'Atleta Inigualável';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'glory') AND level = 3 AND name = 'Destruição Inspiradora';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'always_prepared'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'glory') AND level = 3 AND name = 'Magias do Juramento da Glória';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'glory') AND level = 7 AND name = 'Aura de Vivacidade';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'resource'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'glory') AND level = 15 AND name = 'Defesa Gloriosa';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'resource'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'glory') AND level = 20 AND name = 'Lenda Viva';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'always_prepared'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'vengeance') AND level = 3 AND name = 'Magias do Juramento da Vingança';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'vengeance') AND level = 3 AND name = 'Voto de Inimizade';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'vengeance') AND level = 7 AND name = 'Vingador Implacável';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'vengeance') AND level = 15 AND name = 'Alma Vingativa';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'resource'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'vengeance') AND level = 20 AND name = 'Anjo Vingador';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'choice'::rpg.subclass_feature_kind,
           option_key = 'elementalAffinity'
         WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'draconic')
           AND name = 'Afinidade Elemental';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'choice'::rpg.subclass_feature_kind,
           option_key = 'orderManifestation'
         WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'clockwork')
           AND name = 'Magias Mecânicas';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'choice'::rpg.subclass_feature_kind,
           option_key = 'infernalResilience'
         WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend')
           AND name = 'Resistência Ínfera';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'choice'::rpg.subclass_feature_kind,
           option_key = 'starMapForm'
         WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'stars')
           AND name = 'Mapa Estelar';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'choice'::rpg.subclass_feature_kind,
           option_key = 'stellarConstellation'
         WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'stars')
           AND name = 'Forma Estrelada';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'choice'::rpg.subclass_feature_kind,
           option_key = 'huntersPrey'
         WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'hunter')
           AND name = 'Presa do Caçador';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'choice'::rpg.subclass_feature_kind,
           option_key = 'defensiveTactics'
         WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'hunter')
           AND name = 'Táticas Defensivas';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'choice'::rpg.subclass_feature_kind,
           option_key = 'primalCompanion'
         WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'beast-master')
           AND name = 'Companheiro Primal';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'choice'::rpg.subclass_feature_kind,
           option_key = 'feyGift'
         WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer')
           AND name = 'Magias do Andarilho Feérico';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'choice'::rpg.subclass_feature_kind,
           option_key = 'glamourSkill'
         WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer')
           AND name = 'Glamour Transcendental';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'choice'::rpg.subclass_feature_kind,
           option_key = 'ironMindSave'
         WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'gloom-stalker')
           AND name = 'Mente de Ferro';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'choice'::rpg.subclass_feature_kind,
           option_key = 'additionalFightingStyle'
         WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'champion')
           AND name = 'Estilo de Luta Adicional';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'choice'::rpg.subclass_feature_kind,
           option_key = 'wildRageAspect'
         WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-heart')
           AND name = 'Fúria dos Selvagens';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'choice'::rpg.subclass_feature_kind,
           option_key = 'wildAspect'
         WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-heart')
           AND name = 'Aspecto dos Selvagens';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'choice'::rpg.subclass_feature_kind,
           option_key = 'wildPower'
         WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-heart')
           AND name = 'Poder dos Selvagens';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'choice'::rpg.subclass_feature_kind,
           option_key = 'divineFuryDamage'
         WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'zealot')
           AND name = 'Fúria Divina';

UPDATE rpg.phb_subclass_feature SET feature_kind = 'choice'::rpg.subclass_feature_kind,
           option_key = 'elementalResistance'
         WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'elements')
           AND name = 'Ápice Elemental';
