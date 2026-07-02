-- Mecânicas de subclasse — gerado por npm run generate:seed-subclass-mechanics
BEGIN;
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
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('tides-of-chaos', 'Marés do Caos', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-magic'),
         3)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;
INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 3, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'tides-of-chaos'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Marés do Caos'
       WHERE s.slug = 'wild-magic'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('controlled-surge', 'Surto Controlado', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-magic'),
         18)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;
INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 18, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'controlled-surge'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Surto Controlado'
       WHERE s.slug = 'wild-magic'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('warp-implosion', 'Implosão de Distorção', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'aberrant'),
         18)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;
INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 18, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'warp-implosion'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Implosão de Distorção'
       WHERE s.slug = 'aberrant'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('dragon-wings', 'Asas de Dragão', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'draconic'),
         14)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;
INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 14, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'dragon-wings'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Asas de Dragão'
       WHERE s.slug = 'draconic'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('dragon-companion', 'Companheiro Dracônico', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'draconic'),
         18)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;
INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 18, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'dragon-companion'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Companheiro Dracônico'
       WHERE s.slug = 'draconic'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('restore-balance', 'Restaurar Equilíbrio', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'clockwork'),
         3)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;
INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 3, 'charisma_mod'::rpg.resource_max_formula,
         NULL,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'restore-balance'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Restaurar Equilíbrio'
       WHERE s.slug = 'clockwork'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('order-trance', 'Transe da Ordem', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'clockwork'),
         14)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;
INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 14, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'order-trance'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Transe da Ordem'
       WHERE s.slug = 'clockwork'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('clockwork-cavalcade', 'Cavalgada Mecânica', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'clockwork'),
         18)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;
INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 18, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'clockwork-cavalcade'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Cavalgada Mecânica'
       WHERE s.slug = 'clockwork'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('healing-light', 'Luz Medicinal', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'celestial'),
         3)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;
INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 3, 'level_plus_one'::rpg.resource_max_formula,
         NULL,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'healing-light'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Luz Medicinal'
       WHERE s.slug = 'celestial'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('searing-vengeance', 'Vingança Calcinante', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'celestial'),
         14)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;
INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 14, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'searing-vengeance'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Vingança Calcinante'
       WHERE s.slug = 'celestial'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('dark-ones-luck', 'A Sorte do Próprio Tenebroso', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend'),
         6)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;
INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 6, 'charisma_mod'::rpg.resource_max_formula,
         NULL,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'dark-ones-luck'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'A Sorte do Próprio Tenebroso'
       WHERE s.slug = 'fiend'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('hurl-through-hell', 'Lançar no Inferno', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend'),
         14)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;
INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 14, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'hurl-through-hell'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Lançar no Inferno'
       WHERE s.slug = 'fiend'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('fey-steps', 'Passos Feéricos', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'archfey'),
         3)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;
INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 3, 'charisma_mod'::rpg.resource_max_formula,
         NULL,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'fey-steps'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Passos Feéricos'
       WHERE s.slug = 'archfey'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('beguiling-defenses', 'Defesas Sedutoras', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'archfey'),
         10)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;
INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 10, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'beguiling-defenses'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Defesas Sedutoras'
       WHERE s.slug = 'archfey'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('clairvoyant-competitor', 'Combatente Clarividente', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'great-old-one'),
         6)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;
INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 6, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'clairvoyant-competitor'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Combatente Clarividente'
       WHERE s.slug = 'great-old-one'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('corona-of-light', 'Coroa de Luz', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'light'),
         17)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;
INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 17, 'wisdom_mod'::rpg.resource_max_formula,
         NULL,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'corona-of-light'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Coroa de Luz'
       WHERE s.slug = 'light'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('tricksters-blessing', 'Bênção do Trapaceiro', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'trickery'),
         3)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;
INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 3, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'tricksters-blessing'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Bênção do Trapaceiro'
       WHERE s.slug = 'trickery'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('war-priest', 'Sacerdote da Guerra', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'war'),
         3)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;
INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 3, 'wisdom_mod'::rpg.resource_max_formula,
         NULL,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'war-priest'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Sacerdote da Guerra'
       WHERE s.slug = 'war'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('lunar-step', 'Passo Lunar', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'moon'),
         10)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;
INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 10, 'wisdom_mod'::rpg.resource_max_formula,
         NULL,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'lunar-step'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Passo Lunar'
       WHERE s.slug = 'moon'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('natural-recovery', 'Recuperação Natural', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'land'),
         6)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;
INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 6, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'natural-recovery'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Recuperação Natural'
       WHERE s.slug = 'land'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('stellar-guidance', 'Mapa Estelar', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'stars'),
         3)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;
INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 3, 'wisdom_mod'::rpg.resource_max_formula,
         NULL,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'stellar-guidance'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Mapa Estelar'
       WHERE s.slug = 'stars'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('cosmic-omen', 'Presságio Cósmico', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'stars'),
         6)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;
INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 6, 'wisdom_mod'::rpg.resource_max_formula,
         NULL,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'cosmic-omen'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Presságio Cósmico'
       WHERE s.slug = 'stars'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('holy-nimbus', 'Resplendor Sagrado', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'devotion'),
         20)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;
INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 20, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'holy-nimbus'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Resplendor Sagrado'
       WHERE s.slug = 'devotion'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('undying-sentinel', 'Sentinela Imortal', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'ancients'),
         15)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;
INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 15, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'undying-sentinel'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Sentinela Imortal'
       WHERE s.slug = 'ancients'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('elder-champion', 'Campeão Ancestral', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'ancients'),
         20)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;
INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 20, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'elder-champion'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Campeão Ancestral'
       WHERE s.slug = 'ancients'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('glorious-defense', 'Defesa Gloriosa', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'glory'),
         15)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;
INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 15, 'charisma_mod'::rpg.resource_max_formula,
         NULL,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'glorious-defense'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Defesa Gloriosa'
       WHERE s.slug = 'glory'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('living-legend', 'Lenda Viva', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'glory'),
         20)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;
INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 20, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'living-legend'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Lenda Viva'
       WHERE s.slug = 'glory'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('avenging-angel', 'Anjo Vingador', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'vengeance'),
         20)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;
INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 20, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'avenging-angel'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Anjo Vingador'
       WHERE s.slug = 'vengeance'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('dread-strike', 'Emboscador das Sombras', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'gloom-stalker'),
         3)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;
INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 3, 'wisdom_mod'::rpg.resource_max_formula,
         NULL,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'dread-strike'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Emboscador das Sombras'
       WHERE s.slug = 'gloom-stalker'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('fey-reinforcements', 'Reforços Feéricos', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer'),
         11)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;
INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 11, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'fey-reinforcements'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Reforços Feéricos'
       WHERE s.slug = 'fey-wanderer'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('misty-wanderer', 'Andarilho Nebuloso', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer'),
         15)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;
INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 15, 'wisdom_mod'::rpg.resource_max_formula,
         NULL,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'misty-wanderer'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Andarilho Nebuloso'
       WHERE s.slug = 'fey-wanderer'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('superiority-dice', 'Superioridade em Combate', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'),
         3)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;
INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 3, 'superiority_dice_count'::rpg.resource_max_formula,
         NULL,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'superiority-dice'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Superioridade em Combate'
       WHERE s.slug = 'battle-master'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('know-your-enemy', 'Conheça Seu Inimigo', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'),
         7)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;
INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 7, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'know-your-enemy'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Conheça Seu Inimigo'
       WHERE s.slug = 'battle-master'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('psi-energy-dice', 'Poder Psiônico', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'psi-warrior'),
         3)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;
INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 3, 'psi_energy_dice_count'::rpg.resource_max_formula,
         NULL,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'psi-energy-dice'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Poder Psiônico'
       WHERE s.slug = 'psi-warrior'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('psychic-leap', 'Salto com Impulsão Psíquica', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'psi-warrior'),
         7)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;
INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 7, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'psychic-leap'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Adepto Telecinético'
       WHERE s.slug = 'psi-warrior'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('energy-bulwark', 'Baluarte de Energia', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'psi-warrior'),
         15)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;
INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 15, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'energy-bulwark'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Baluarte de Energia'
       WHERE s.slug = 'psi-warrior'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('telekinetic-master', 'Mestre Telecinético', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'psi-warrior'),
         18)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;
INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 18, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'telekinetic-master'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Mestre Telecinético'
       WHERE s.slug = 'psi-warrior'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('intimidating-presence', 'Presença Intimidante', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'berserker'),
         14)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;
INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 14, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'intimidating-presence'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Presença Intimidante'
       WHERE s.slug = 'berserker'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('divine-fury-dice', 'Campeão dos Deuses', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'zealot'),
         3)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;
INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 3, 'zealot_healing_dice_count'::rpg.resource_max_formula,
         NULL,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'divine-fury-dice'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Campeão dos Deuses'
       WHERE s.slug = 'zealot'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('zealous-presence', 'Presença Zelosa', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'zealot'),
         10)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;
INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 10, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'zealous-presence'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Presença Zelosa'
       WHERE s.slug = 'zealot'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('rage-of-the-gods', 'Fúria dos Deuses', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'zealot'),
         14)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;
INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 14, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'rage-of-the-gods'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Fúria dos Deuses'
       WHERE s.slug = 'zealot'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('wholeness-of-body', 'Integridade Corporal', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'open-hand'),
         6)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;
INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 6, 'wisdom_mod'::rpg.resource_max_formula,
         NULL,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'wholeness-of-body'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Integridade Corporal'
       WHERE s.slug = 'open-hand'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('hand-of-harm-flurry', 'Torrente de Cura e Dolo', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'mercy'),
         11)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;
INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 11, 'wisdom_mod'::rpg.resource_max_formula,
         NULL,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'hand-of-harm-flurry'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Torrente de Cura e Dolo'
       WHERE s.slug = 'mercy'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('hand-of-ultimate-mercy', 'Mão da Misericórdia Final', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'mercy'),
         17)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;
INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 17, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'hand-of-ultimate-mercy'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Mão da Misericórdia Final'
       WHERE s.slug = 'mercy'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('soulknife-psi-dice', 'Poder Psiônico', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'soulknife'),
         3)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;
INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 3, 'psi_energy_dice_count'::rpg.resource_max_formula,
         NULL,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'soulknife-psi-dice'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Poder Psiônico'
       WHERE s.slug = 'soulknife'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('psychic-veil', 'Véu Psíquico', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'soulknife'),
         13)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;
INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 13, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'psychic-veil'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Véu Psíquico'
       WHERE s.slug = 'soulknife'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('rend-mind', 'Rasgar Mente', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'soulknife'),
         17)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;
INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 17, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'rend-mind'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Rasgar Mente'
       WHERE s.slug = 'soulknife'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
       VALUES ('spell-thief', 'Ladrão de Magias', 'subclass'::rpg.resource_scope,
         (SELECT id FROM rpg.phb_subclass WHERE slug = 'arcane-trickster'),
         17)
       ON CONFLICT (slug) DO UPDATE SET
         name = EXCLUDED.name,
         scope = EXCLUDED.scope,
         subclass_id = EXCLUDED.subclass_id,
         min_level = EXCLUDED.min_level;
INSERT INTO rpg.phb_subclass_resource (subclass_id, resource_id, unlock_level, max_formula, fixed_max, feature_id)
       SELECT s.id, rd.id, 17, 'fixed'::rpg.resource_max_formula,
         1,
         sf.id
       FROM rpg.phb_subclass s
       JOIN rpg.phb_resource_definition rd ON rd.slug = 'spell-thief'
       LEFT JOIN rpg.phb_subclass_feature sf ON sf.subclass_id = s.id
         AND sf.name = 'Ladrão de Magias'
       WHERE s.slug = 'arcane-trickster'
       ON CONFLICT (subclass_id, resource_id, unlock_level) DO UPDATE SET
         max_formula = EXCLUDED.max_formula,
         fixed_max = EXCLUDED.fixed_max,
         feature_id = EXCLUDED.feature_id;
INSERT INTO rpg.phb_subclass_option_def (subclass_id, option_key, label, unlock_level, value_type)
       VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'draconic'),
         'elementalAffinity', 'Afinidade Elemental', 6, 'catalog'::rpg.option_value_type)
       ON CONFLICT (subclass_id, option_key) DO UPDATE SET
         label = EXCLUDED.label,
         unlock_level = EXCLUDED.unlock_level;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'draconic'),
           'elementalAffinity', 'acid', 'Ácido', 1)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'draconic'),
           'elementalAffinity', 'cold', 'Gélido', 2)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'draconic'),
           'elementalAffinity', 'fire', 'Ígneo', 3)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'draconic'),
           'elementalAffinity', 'lightning', 'Elétrico', 4)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'draconic'),
           'elementalAffinity', 'poison', 'Venenoso', 5)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
UPDATE rpg.phb_subclass_feature SET feature_kind = 'choice'::rpg.subclass_feature_kind,
           option_key = 'elementalAffinity'
         WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'draconic')
           AND name = 'Afinidade Elemental';
INSERT INTO rpg.phb_subclass_option_def (subclass_id, option_key, label, unlock_level, value_type)
       VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'clockwork'),
         'orderManifestation', 'Manifestação da Ordem', 3, 'catalog'::rpg.option_value_type)
       ON CONFLICT (subclass_id, option_key) DO UPDATE SET
         label = EXCLUDED.label,
         unlock_level = EXCLUDED.unlock_level;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'clockwork'),
           'orderManifestation', '1', 'Engrenagens espectrais', 1)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'clockwork'),
           'orderManifestation', '2', 'Ponteiros de relógio nos olhos', 2)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'clockwork'),
           'orderManifestation', '3', 'Pele acobreada brilhante', 3)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'clockwork'),
           'orderManifestation', '4', 'Equações geométricas', 4)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'clockwork'),
           'orderManifestation', '5', 'Foco em forma de mecanismo', 5)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'clockwork'),
           'orderManifestation', '6', 'Tique-taque de engrenagens', 6)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
UPDATE rpg.phb_subclass_feature SET feature_kind = 'choice'::rpg.subclass_feature_kind,
           option_key = 'orderManifestation'
         WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'clockwork')
           AND name = 'Magias Mecânicas';
INSERT INTO rpg.phb_subclass_option_def (subclass_id, option_key, label, unlock_level, value_type)
       VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend'),
         'infernalResilience', 'Resistência Ínfera', 10, 'catalog'::rpg.option_value_type)
       ON CONFLICT (subclass_id, option_key) DO UPDATE SET
         label = EXCLUDED.label,
         unlock_level = EXCLUDED.unlock_level;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend'),
           'infernalResilience', 'acid', 'Ácido', 1)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend'),
           'infernalResilience', 'cold', 'Gélido', 2)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend'),
           'infernalResilience', 'fire', 'Ígneo', 3)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend'),
           'infernalResilience', 'lightning', 'Elétrico', 4)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend'),
           'infernalResilience', 'necrotic', 'Necrótico', 5)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend'),
           'infernalResilience', 'poison', 'Venenoso', 6)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend'),
           'infernalResilience', 'psychic', 'Psíquico', 7)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend'),
           'infernalResilience', 'radiant', 'Radiante', 8)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend'),
           'infernalResilience', 'thunder', 'Trovejante', 9)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
UPDATE rpg.phb_subclass_feature SET feature_kind = 'choice'::rpg.subclass_feature_kind,
           option_key = 'infernalResilience'
         WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend')
           AND name = 'Resistência Ínfera';
INSERT INTO rpg.phb_subclass_option_def (subclass_id, option_key, label, unlock_level, value_type)
       VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'stars'),
         'starMapForm', 'Forma do Mapa Estelar', 3, 'catalog'::rpg.option_value_type)
       ON CONFLICT (subclass_id, option_key) DO UPDATE SET
         label = EXCLUDED.label,
         unlock_level = EXCLUDED.unlock_level;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'stars'),
           'starMapForm', 'scroll', 'Rolo de pergaminho', 1)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'stars'),
           'starMapForm', 'stone', 'Placa de pedra', 2)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'stars'),
           'starMapForm', 'palm', 'Palma da mão', 3)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'stars'),
           'starMapForm', 'crystal', 'Orrery de cristal', 4)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'stars'),
           'starMapForm', 'tattoo', 'Tatuagem minuciosa', 5)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'stars'),
           'starMapForm', 'carving', 'Entalhe enrunado', 6)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
UPDATE rpg.phb_subclass_feature SET feature_kind = 'choice'::rpg.subclass_feature_kind,
           option_key = 'starMapForm'
         WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'stars')
           AND name = 'Mapa Estelar';
INSERT INTO rpg.phb_subclass_option_def (subclass_id, option_key, label, unlock_level, value_type)
       VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'stars'),
         'stellarConstellation', 'Constelação da Forma Estrelada', 3, 'catalog'::rpg.option_value_type)
       ON CONFLICT (subclass_id, option_key) DO UPDATE SET
         label = EXCLUDED.label,
         unlock_level = EXCLUDED.unlock_level;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'stars'),
           'stellarConstellation', 'archer', 'Arqueiro', 1)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'stars'),
           'stellarConstellation', 'dragon', 'Dragão', 2)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'stars'),
           'stellarConstellation', 'chalice', 'Taça', 3)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
UPDATE rpg.phb_subclass_feature SET feature_kind = 'choice'::rpg.subclass_feature_kind,
           option_key = 'stellarConstellation'
         WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'stars')
           AND name = 'Forma Estrelada';
INSERT INTO rpg.phb_subclass_option_def (subclass_id, option_key, label, unlock_level, value_type)
       VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'hunter'),
         'huntersPrey', 'Presa do Caçador', 3, 'catalog'::rpg.option_value_type)
       ON CONFLICT (subclass_id, option_key) DO UPDATE SET
         label = EXCLUDED.label,
         unlock_level = EXCLUDED.unlock_level;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'hunter'),
           'huntersPrey', 'colossus-slayer', 'Assassino de Colossos', 1)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'hunter'),
           'huntersPrey', 'horde-breaker', 'Destruidor de Hordas', 2)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
UPDATE rpg.phb_subclass_feature SET feature_kind = 'choice'::rpg.subclass_feature_kind,
           option_key = 'huntersPrey'
         WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'hunter')
           AND name = 'Presa do Caçador';
INSERT INTO rpg.phb_subclass_option_def (subclass_id, option_key, label, unlock_level, value_type)
       VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'hunter'),
         'defensiveTactics', 'Táticas Defensivas', 7, 'catalog'::rpg.option_value_type)
       ON CONFLICT (subclass_id, option_key) DO UPDATE SET
         label = EXCLUDED.label,
         unlock_level = EXCLUDED.unlock_level;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'hunter'),
           'defensiveTactics', 'multiattack-defense', 'Defesa Contra Ataques Múltiplos', 1)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'hunter'),
           'defensiveTactics', 'escape-the-horde', 'Escapar de Hordas', 2)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
UPDATE rpg.phb_subclass_feature SET feature_kind = 'choice'::rpg.subclass_feature_kind,
           option_key = 'defensiveTactics'
         WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'hunter')
           AND name = 'Táticas Defensivas';
INSERT INTO rpg.phb_subclass_option_def (subclass_id, option_key, label, unlock_level, value_type)
       VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'beast-master'),
         'primalCompanion', 'Companheiro Primal', 3, 'catalog'::rpg.option_value_type)
       ON CONFLICT (subclass_id, option_key) DO UPDATE SET
         label = EXCLUDED.label,
         unlock_level = EXCLUDED.unlock_level;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'beast-master'),
           'primalCompanion', 'earth', 'Fera da Terra', 1)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'beast-master'),
           'primalCompanion', 'sky', 'Fera do Céu', 2)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'beast-master'),
           'primalCompanion', 'sea', 'Fera do Mar', 3)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
UPDATE rpg.phb_subclass_feature SET feature_kind = 'choice'::rpg.subclass_feature_kind,
           option_key = 'primalCompanion'
         WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'beast-master')
           AND name = 'Companheiro Primal';
INSERT INTO rpg.phb_subclass_option_def (subclass_id, option_key, label, unlock_level, value_type)
       VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer'),
         'feyGift', 'Dádiva de Faéria', 3, 'catalog'::rpg.option_value_type)
       ON CONFLICT (subclass_id, option_key) DO UPDATE SET
         label = EXCLUDED.label,
         unlock_level = EXCLUDED.unlock_level;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer'),
           'feyGift', '1', 'Borboletas ilusórias', 1)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer'),
           'feyGift', '2', 'Flores no cabelo', 2)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer'),
           'feyGift', '3', 'Fragrância natural', 3)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer'),
           'feyGift', '4', 'Sombra dançante', 4)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer'),
           'feyGift', '5', 'Chifres ou galhadas', 5)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer'),
           'feyGift', '6', 'Pele e cabelo mutáveis', 6)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
UPDATE rpg.phb_subclass_feature SET feature_kind = 'choice'::rpg.subclass_feature_kind,
           option_key = 'feyGift'
         WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer')
           AND name = 'Magias do Andarilho Feérico';
INSERT INTO rpg.phb_subclass_option_def (subclass_id, option_key, label, unlock_level, value_type)
       VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer'),
         'glamourSkill', 'Perícia do Glamour Transcendental', 3, 'catalog'::rpg.option_value_type)
       ON CONFLICT (subclass_id, option_key) DO UPDATE SET
         label = EXCLUDED.label,
         unlock_level = EXCLUDED.unlock_level;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer'),
           'glamourSkill', 'atuacao', 'Atuação', 1)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer'),
           'glamourSkill', 'enganacao', 'Enganação', 2)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer'),
           'glamourSkill', 'persuasao', 'Persuasão', 3)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
UPDATE rpg.phb_subclass_feature SET feature_kind = 'choice'::rpg.subclass_feature_kind,
           option_key = 'glamourSkill'
         WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer')
           AND name = 'Glamour Transcendental';
INSERT INTO rpg.phb_subclass_option_def (subclass_id, option_key, label, unlock_level, value_type)
       VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'gloom-stalker'),
         'ironMindSave', 'Salvaguarda da Mente de Ferro', 7, 'catalog'::rpg.option_value_type)
       ON CONFLICT (subclass_id, option_key) DO UPDATE SET
         label = EXCLUDED.label,
         unlock_level = EXCLUDED.unlock_level;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'gloom-stalker'),
           'ironMindSave', 'carisma', 'Carisma', 1)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'gloom-stalker'),
           'ironMindSave', 'inteligencia', 'Inteligência', 2)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
UPDATE rpg.phb_subclass_feature SET feature_kind = 'choice'::rpg.subclass_feature_kind,
           option_key = 'ironMindSave'
         WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'gloom-stalker')
           AND name = 'Mente de Ferro';
INSERT INTO rpg.phb_subclass_option_def (subclass_id, option_key, label, unlock_level, value_type)
       VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'champion'),
         'additionalFightingStyle', 'Estilo de Luta Adicional', 7, 'catalog'::rpg.option_value_type)
       ON CONFLICT (subclass_id, option_key) DO UPDATE SET
         label = EXCLUDED.label,
         unlock_level = EXCLUDED.unlock_level;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'champion'),
           'additionalFightingStyle', 'archery', 'Arqueria', 1)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'champion'),
           'additionalFightingStyle', 'blind-fighting', 'Combate Cego', 2)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'champion'),
           'additionalFightingStyle', 'defense', 'Defesa', 3)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'champion'),
           'additionalFightingStyle', 'dueling', 'Duelo', 4)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'champion'),
           'additionalFightingStyle', 'great-weapon-fighting', 'Combate com Arma Grande', 5)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'champion'),
           'additionalFightingStyle', 'interception', 'Interceptação', 6)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'champion'),
           'additionalFightingStyle', 'protection', 'Proteção', 7)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'champion'),
           'additionalFightingStyle', 'thrown-weapon-fighting', 'Combate com Arma Arremessável', 8)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'champion'),
           'additionalFightingStyle', 'two-weapon-fighting', 'Combate com Duas Armas', 9)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'champion'),
           'additionalFightingStyle', 'unarmed-fighting', 'Combate Desarmado', 10)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
UPDATE rpg.phb_subclass_feature SET feature_kind = 'choice'::rpg.subclass_feature_kind,
           option_key = 'additionalFightingStyle'
         WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'champion')
           AND name = 'Estilo de Luta Adicional';
INSERT INTO rpg.phb_subclass_option_def (subclass_id, option_key, label, unlock_level, value_type)
       VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'),
         'maneuver1', 'Manobra 1', 3, 'catalog'::rpg.option_value_type)
       ON CONFLICT (subclass_id, option_key) DO UPDATE SET
         label = EXCLUDED.label,
         unlock_level = EXCLUDED.unlock_level;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'),
           'maneuver1', 'parry', 'Aparar', 1)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'),
           'maneuver1', 'menacing-attack', 'Ataque Ameaçador', 2)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'),
           'maneuver1', 'sweeping-attack', 'Ataque de Varredura', 3)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'),
           'maneuver1', 'lunging-attack', 'Ataque Estendido', 4)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'),
           'maneuver1', 'distracting-attack', 'Ataque para Distrair', 5)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'),
           'maneuver1', 'precision-attack', 'Ataque Preciso', 6)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_def (subclass_id, option_key, label, unlock_level, value_type)
       VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'),
         'maneuver2', 'Manobra 2', 3, 'catalog'::rpg.option_value_type)
       ON CONFLICT (subclass_id, option_key) DO UPDATE SET
         label = EXCLUDED.label,
         unlock_level = EXCLUDED.unlock_level;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'),
           'maneuver2', 'parry', 'Aparar', 1)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'),
           'maneuver2', 'menacing-attack', 'Ataque Ameaçador', 2)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'),
           'maneuver2', 'sweeping-attack', 'Ataque de Varredura', 3)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'),
           'maneuver2', 'lunging-attack', 'Ataque Estendido', 4)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'),
           'maneuver2', 'distracting-attack', 'Ataque para Distrair', 5)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'),
           'maneuver2', 'precision-attack', 'Ataque Preciso', 6)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_def (subclass_id, option_key, label, unlock_level, value_type)
       VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'),
         'maneuver3', 'Manobra 3', 3, 'catalog'::rpg.option_value_type)
       ON CONFLICT (subclass_id, option_key) DO UPDATE SET
         label = EXCLUDED.label,
         unlock_level = EXCLUDED.unlock_level;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'),
           'maneuver3', 'parry', 'Aparar', 1)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'),
           'maneuver3', 'menacing-attack', 'Ataque Ameaçador', 2)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'),
           'maneuver3', 'sweeping-attack', 'Ataque de Varredura', 3)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'),
           'maneuver3', 'lunging-attack', 'Ataque Estendido', 4)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'),
           'maneuver3', 'distracting-attack', 'Ataque para Distrair', 5)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master'),
           'maneuver3', 'precision-attack', 'Ataque Preciso', 6)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_def (subclass_id, option_key, label, unlock_level, value_type)
       VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-heart'),
         'wildRageAspect', 'Aspecto da Fúria dos Selvagens', 3, 'catalog'::rpg.option_value_type)
       ON CONFLICT (subclass_id, option_key) DO UPDATE SET
         label = EXCLUDED.label,
         unlock_level = EXCLUDED.unlock_level;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-heart'),
           'wildRageAspect', 'eagle', 'Águia', 1)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-heart'),
           'wildRageAspect', 'wolf', 'Lobo', 2)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-heart'),
           'wildRageAspect', 'bear', 'Urso', 3)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
UPDATE rpg.phb_subclass_feature SET feature_kind = 'choice'::rpg.subclass_feature_kind,
           option_key = 'wildRageAspect'
         WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-heart')
           AND name = 'Fúria dos Selvagens';
INSERT INTO rpg.phb_subclass_option_def (subclass_id, option_key, label, unlock_level, value_type)
       VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-heart'),
         'wildAspect', 'Aspecto dos Selvagens', 6, 'catalog'::rpg.option_value_type)
       ON CONFLICT (subclass_id, option_key) DO UPDATE SET
         label = EXCLUDED.label,
         unlock_level = EXCLUDED.unlock_level;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-heart'),
           'wildAspect', 'owl', 'Coruja', 1)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-heart'),
           'wildAspect', 'panther', 'Pantera', 2)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-heart'),
           'wildAspect', 'salmon', 'Salmão', 3)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
UPDATE rpg.phb_subclass_feature SET feature_kind = 'choice'::rpg.subclass_feature_kind,
           option_key = 'wildAspect'
         WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-heart')
           AND name = 'Aspecto dos Selvagens';
INSERT INTO rpg.phb_subclass_option_def (subclass_id, option_key, label, unlock_level, value_type)
       VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-heart'),
         'wildPower', 'Poder dos Selvagens', 14, 'catalog'::rpg.option_value_type)
       ON CONFLICT (subclass_id, option_key) DO UPDATE SET
         label = EXCLUDED.label,
         unlock_level = EXCLUDED.unlock_level;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-heart'),
           'wildPower', 'ram', 'Carneiro', 1)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-heart'),
           'wildPower', 'hawk', 'Falcão', 2)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-heart'),
           'wildPower', 'lion', 'Leão', 3)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
UPDATE rpg.phb_subclass_feature SET feature_kind = 'choice'::rpg.subclass_feature_kind,
           option_key = 'wildPower'
         WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-heart')
           AND name = 'Poder dos Selvagens';
INSERT INTO rpg.phb_subclass_option_def (subclass_id, option_key, label, unlock_level, value_type)
       VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'zealot'),
         'divineFuryDamage', 'Tipo de Dano da Fúria Divina', 3, 'catalog'::rpg.option_value_type)
       ON CONFLICT (subclass_id, option_key) DO UPDATE SET
         label = EXCLUDED.label,
         unlock_level = EXCLUDED.unlock_level;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'zealot'),
           'divineFuryDamage', 'necrotic', 'Necrótico', 1)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'zealot'),
           'divineFuryDamage', 'radiant', 'Radiante', 2)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
UPDATE rpg.phb_subclass_feature SET feature_kind = 'choice'::rpg.subclass_feature_kind,
           option_key = 'divineFuryDamage'
         WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'zealot')
           AND name = 'Fúria Divina';
INSERT INTO rpg.phb_subclass_option_def (subclass_id, option_key, label, unlock_level, value_type)
       VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'elements'),
         'elementalResistance', 'Resistência do Ápice Elemental', 17, 'catalog'::rpg.option_value_type)
       ON CONFLICT (subclass_id, option_key) DO UPDATE SET
         label = EXCLUDED.label,
         unlock_level = EXCLUDED.unlock_level;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'elements'),
           'elementalResistance', 'acid', 'Ácido', 1)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'elements'),
           'elementalResistance', 'cold', 'Gélido', 2)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'elements'),
           'elementalResistance', 'fire', 'Ígneo', 3)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'elements'),
           'elementalResistance', 'lightning', 'Elétrico', 4)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
INSERT INTO rpg.phb_subclass_option_value (subclass_id, option_key, value_id, label, sort_order)
         VALUES ((SELECT id FROM rpg.phb_subclass WHERE slug = 'elements'),
           'elementalResistance', 'thunder', 'Trovejante', 5)
         ON CONFLICT (subclass_id, option_key, value_id) DO UPDATE SET label = EXCLUDED.label;
UPDATE rpg.phb_subclass_feature SET feature_kind = 'choice'::rpg.subclass_feature_kind,
           option_key = 'elementalResistance'
         WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'elements')
           AND name = 'Ápice Elemental';
INSERT INTO rpg.phb_spell_source (slug, label, origin_type, class_id, subclass_id)
     VALUES ('life-domain', (SELECT name FROM rpg.phb_subclass WHERE slug = 'life'),
       'subclass'::rpg.spell_source_origin,
       (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'),
       (SELECT id FROM rpg.phb_subclass WHERE slug = 'life'))
     ON CONFLICT (slug) DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'life' AND sp.slug = 'auxilio'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'life' AND sp.slug = 'bencao'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'life' AND sp.slug = 'curar-ferimentos'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'life' AND sp.slug = 'restauracao-menor'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 5, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'life' AND sp.slug = 'palavra-curativa-em-massa'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 5, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'life' AND sp.slug = 'revivificar'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 7, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'life' AND sp.slug = 'aura-de-vida'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 7, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'life' AND sp.slug = 'protecao-contra-a-morte'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 9, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'life' AND sp.slug = 'curar-ferimentos-em-massa'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 9, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'life' AND sp.slug = 'restauracao-maior'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_spell_source (slug, label, origin_type, class_id, subclass_id)
     VALUES ('light-domain', (SELECT name FROM rpg.phb_subclass WHERE slug = 'light'),
       'subclass'::rpg.spell_source_origin,
       (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'),
       (SELECT id FROM rpg.phb_subclass WHERE slug = 'light'))
     ON CONFLICT (slug) DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'light' AND sp.slug = 'fogo-das-fadas'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'light' AND sp.slug = 'maos-flamejantes'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'light' AND sp.slug = 'raio-ardente'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'light' AND sp.slug = 'ver-o-invisivel'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 5, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'light' AND sp.slug = 'bola-de-fogo'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 5, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'light' AND sp.slug = 'luz-do-dia'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 7, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'light' AND sp.slug = 'muralha-de-fogo'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 7, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'light' AND sp.slug = 'olho-arcano'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 9, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'light' AND sp.slug = 'coluna-de-chamas'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 9, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'light' AND sp.slug = 'videncia'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_spell_source (slug, label, origin_type, class_id, subclass_id)
     VALUES ('trickery-domain', (SELECT name FROM rpg.phb_subclass WHERE slug = 'trickery'),
       'subclass'::rpg.spell_source_origin,
       (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'),
       (SELECT id FROM rpg.phb_subclass WHERE slug = 'trickery'))
     ON CONFLICT (slug) DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'trickery' AND sp.slug = 'disfarcar-se'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'trickery' AND sp.slug = 'enfeiticar-pessoa'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'trickery' AND sp.slug = 'invisibilidade'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'trickery' AND sp.slug = 'passo-sem-rastro'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 5, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'trickery' AND sp.slug = 'indetectavel'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 5, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'trickery' AND sp.slug = 'padrao-hipnotico'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 7, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'trickery' AND sp.slug = 'confusao'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 7, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'trickery' AND sp.slug = 'porta-dimensional'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 9, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'trickery' AND sp.slug = 'dominar-pessoa'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 9, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'trickery' AND sp.slug = 'modificar-memoria'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_spell_source (slug, label, origin_type, class_id, subclass_id)
     VALUES ('war-domain', (SELECT name FROM rpg.phb_subclass WHERE slug = 'war'),
       'subclass'::rpg.spell_source_origin,
       (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'),
       (SELECT id FROM rpg.phb_subclass WHERE slug = 'war'))
     ON CONFLICT (slug) DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'war' AND sp.slug = 'arma-espiritual'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'war' AND sp.slug = 'arma-magica'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'war' AND sp.slug = 'escudo-da-fe'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'war' AND sp.slug = 'raio-guia'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 5, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'war' AND sp.slug = 'guardioes-espirituais'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 5, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'war' AND sp.slug = 'manto-do-cruzado'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 7, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'war' AND sp.slug = 'escudo-ardente'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 7, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'war' AND sp.slug = 'movimentacao-livre'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 9, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'war' AND sp.slug = 'golpe-de-arco'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 9, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'war' AND sp.slug = 'paralisar-monstro'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_spell_source (slug, label, origin_type, class_id, subclass_id)
     VALUES ('moon-circle', (SELECT name FROM rpg.phb_subclass WHERE slug = 'moon'),
       'subclass'::rpg.spell_source_origin,
       (SELECT id FROM rpg.phb_class WHERE slug = 'druid'),
       (SELECT id FROM rpg.phb_subclass WHERE slug = 'moon'))
     ON CONFLICT (slug) DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'moon' AND sp.slug = 'curar-ferimentos'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'moon' AND sp.slug = 'fagulha-estelar'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'moon' AND sp.slug = 'raio-lunar'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 5, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'moon' AND sp.slug = 'invocar-animais'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 7, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'moon' AND sp.slug = 'fonte-do-luar'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 9, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'moon' AND sp.slug = 'curar-ferimentos-em-massa'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_spell_source (slug, label, origin_type, class_id, subclass_id)
     VALUES ('sea-circle', (SELECT name FROM rpg.phb_subclass WHERE slug = 'sea'),
       'subclass'::rpg.spell_source_origin,
       (SELECT id FROM rpg.phb_class WHERE slug = 'druid'),
       (SELECT id FROM rpg.phb_subclass WHERE slug = 'sea'))
     ON CONFLICT (slug) DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'sea' AND sp.slug = 'despedacar'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'sea' AND sp.slug = 'lufada-de-vento'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'sea' AND sp.slug = 'nevoa-obscurecente'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'sea' AND sp.slug = 'onda-trovejante'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'sea' AND sp.slug = 'raio-de-gelo'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 5, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'sea' AND sp.slug = 'relampago'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 5, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'sea' AND sp.slug = 'respirar-na-agua'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 7, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'sea' AND sp.slug = 'controlar-agua'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 7, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'sea' AND sp.slug = 'tempestade-glacial'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 9, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'sea' AND sp.slug = 'invocar-elemental'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 9, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'sea' AND sp.slug = 'paralisar-monstro'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_spell_source (slug, label, origin_type, class_id, subclass_id)
     VALUES ('land-circle', (SELECT name FROM rpg.phb_subclass WHERE slug = 'land'),
       'subclass'::rpg.spell_source_origin,
       (SELECT id FROM rpg.phb_class WHERE slug = 'druid'),
       (SELECT id FROM rpg.phb_subclass WHERE slug = 'land'))
     ON CONFLICT (slug) DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
             SELECT s.id, 3, sp.id, t.id
             FROM rpg.phb_subclass s, rpg.phb_spell sp, rpg.phb_druid_land_terrain t
             WHERE s.slug = 'land' AND sp.slug = 'maos-flamejantes' AND t.slug = 'arid'
             ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
             SELECT s.id, 3, sp.id, t.id
             FROM rpg.phb_subclass s, rpg.phb_spell sp, rpg.phb_druid_land_terrain t
             WHERE s.slug = 'land' AND sp.slug = 'turvar' AND t.slug = 'arid'
             ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
             SELECT s.id, 3, sp.id, t.id
             FROM rpg.phb_subclass s, rpg.phb_spell sp, rpg.phb_druid_land_terrain t
             WHERE s.slug = 'land' AND sp.slug = 'raio-de-fogo' AND t.slug = 'arid'
             ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
             SELECT s.id, 5, sp.id, t.id
             FROM rpg.phb_subclass s, rpg.phb_spell sp, rpg.phb_druid_land_terrain t
             WHERE s.slug = 'land' AND sp.slug = 'bola-de-fogo' AND t.slug = 'arid'
             ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
             SELECT s.id, 5, sp.id, t.id
             FROM rpg.phb_subclass s, rpg.phb_spell sp, rpg.phb_druid_land_terrain t
             WHERE s.slug = 'land' AND sp.slug = 'muralha-de-fogo' AND t.slug = 'arid'
             ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
             SELECT s.id, 7, sp.id, t.id
             FROM rpg.phb_subclass s, rpg.phb_spell sp, rpg.phb_druid_land_terrain t
             WHERE s.slug = 'land' AND sp.slug = 'malogro' AND t.slug = 'arid'
             ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
             SELECT s.id, 7, sp.id, t.id
             FROM rpg.phb_subclass s, rpg.phb_spell sp, rpg.phb_druid_land_terrain t
             WHERE s.slug = 'land' AND sp.slug = 'muralha-de-pedra' AND t.slug = 'arid'
             ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
             SELECT s.id, 9, sp.id, t.id
             FROM rpg.phb_subclass s, rpg.phb_spell sp, rpg.phb_druid_land_terrain t
             WHERE s.slug = 'land' AND sp.slug = 'coluna-de-chamas' AND t.slug = 'arid'
             ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
             SELECT s.id, 9, sp.id, t.id
             FROM rpg.phb_subclass s, rpg.phb_spell sp, rpg.phb_druid_land_terrain t
             WHERE s.slug = 'land' AND sp.slug = 'videncia' AND t.slug = 'arid'
             ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
             SELECT s.id, 3, sp.id, t.id
             FROM rpg.phb_subclass s, rpg.phb_spell sp, rpg.phb_druid_land_terrain t
             WHERE s.slug = 'land' AND sp.slug = 'nevoa-obscurecente' AND t.slug = 'polar'
             ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
             SELECT s.id, 3, sp.id, t.id
             FROM rpg.phb_subclass s, rpg.phb_spell sp, rpg.phb_druid_land_terrain t
             WHERE s.slug = 'land' AND sp.slug = 'paralisar-pessoa' AND t.slug = 'polar'
             ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
             SELECT s.id, 3, sp.id, t.id
             FROM rpg.phb_subclass s, rpg.phb_spell sp, rpg.phb_druid_land_terrain t
             WHERE s.slug = 'land' AND sp.slug = 'raio-de-gelo' AND t.slug = 'polar'
             ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
             SELECT s.id, 5, sp.id, t.id
             FROM rpg.phb_subclass s, rpg.phb_spell sp, rpg.phb_druid_land_terrain t
             WHERE s.slug = 'land' AND sp.slug = 'nevasca' AND t.slug = 'polar'
             ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
             SELECT s.id, 5, sp.id, t.id
             FROM rpg.phb_subclass s, rpg.phb_spell sp, rpg.phb_druid_land_terrain t
             WHERE s.slug = 'land' AND sp.slug = 'lentidao' AND t.slug = 'polar'
             ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
             SELECT s.id, 7, sp.id, t.id
             FROM rpg.phb_subclass s, rpg.phb_spell sp, rpg.phb_druid_land_terrain t
             WHERE s.slug = 'land' AND sp.slug = 'cone-de-frio' AND t.slug = 'polar'
             ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
             SELECT s.id, 7, sp.id, t.id
             FROM rpg.phb_subclass s, rpg.phb_spell sp, rpg.phb_druid_land_terrain t
             WHERE s.slug = 'land' AND sp.slug = 'tempestade-glacial' AND t.slug = 'polar'
             ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
             SELECT s.id, 9, sp.id, t.id
             FROM rpg.phb_subclass s, rpg.phb_spell sp, rpg.phb_druid_land_terrain t
             WHERE s.slug = 'land' AND sp.slug = 'comunhao-com-a-natureza' AND t.slug = 'polar'
             ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
             SELECT s.id, 9, sp.id, t.id
             FROM rpg.phb_subclass s, rpg.phb_spell sp, rpg.phb_druid_land_terrain t
             WHERE s.slug = 'land' AND sp.slug = 'passo-arboreo' AND t.slug = 'polar'
             ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
             SELECT s.id, 3, sp.id, t.id
             FROM rpg.phb_subclass s, rpg.phb_spell sp, rpg.phb_druid_land_terrain t
             WHERE s.slug = 'land' AND sp.slug = 'passo-nebuloso' AND t.slug = 'temperate'
             ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
             SELECT s.id, 3, sp.id, t.id
             FROM rpg.phb_subclass s, rpg.phb_spell sp, rpg.phb_druid_land_terrain t
             WHERE s.slug = 'land' AND sp.slug = 'toque-chocante' AND t.slug = 'temperate'
             ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
             SELECT s.id, 3, sp.id, t.id
             FROM rpg.phb_subclass s, rpg.phb_spell sp, rpg.phb_druid_land_terrain t
             WHERE s.slug = 'land' AND sp.slug = 'sono' AND t.slug = 'temperate'
             ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
             SELECT s.id, 5, sp.id, t.id
             FROM rpg.phb_subclass s, rpg.phb_spell sp, rpg.phb_druid_land_terrain t
             WHERE s.slug = 'land' AND sp.slug = 'relampago' AND t.slug = 'temperate'
             ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
             SELECT s.id, 5, sp.id, t.id
             FROM rpg.phb_subclass s, rpg.phb_spell sp, rpg.phb_druid_land_terrain t
             WHERE s.slug = 'land' AND sp.slug = 'crescimento-de-plantas' AND t.slug = 'temperate'
             ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
             SELECT s.id, 7, sp.id, t.id
             FROM rpg.phb_subclass s, rpg.phb_spell sp, rpg.phb_druid_land_terrain t
             WHERE s.slug = 'land' AND sp.slug = 'movimentacao-livre' AND t.slug = 'temperate'
             ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
             SELECT s.id, 7, sp.id, t.id
             FROM rpg.phb_subclass s, rpg.phb_spell sp, rpg.phb_druid_land_terrain t
             WHERE s.slug = 'land' AND sp.slug = 'moldar-rochas' AND t.slug = 'temperate'
             ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
             SELECT s.id, 9, sp.id, t.id
             FROM rpg.phb_subclass s, rpg.phb_spell sp, rpg.phb_druid_land_terrain t
             WHERE s.slug = 'land' AND sp.slug = 'comunhao-com-a-natureza' AND t.slug = 'temperate'
             ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
             SELECT s.id, 9, sp.id, t.id
             FROM rpg.phb_subclass s, rpg.phb_spell sp, rpg.phb_druid_land_terrain t
             WHERE s.slug = 'land' AND sp.slug = 'muralha-de-pedra' AND t.slug = 'temperate'
             ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
             SELECT s.id, 3, sp.id, t.id
             FROM rpg.phb_subclass s, rpg.phb_spell sp, rpg.phb_druid_land_terrain t
             WHERE s.slug = 'land' AND sp.slug = 'bolha-acida' AND t.slug = 'tropical'
             ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
             SELECT s.id, 3, sp.id, t.id
             FROM rpg.phb_subclass s, rpg.phb_spell sp, rpg.phb_druid_land_terrain t
             WHERE s.slug = 'land' AND sp.slug = 'rajada-de-veneno' AND t.slug = 'tropical'
             ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
             SELECT s.id, 3, sp.id, t.id
             FROM rpg.phb_subclass s, rpg.phb_spell sp, rpg.phb_druid_land_terrain t
             WHERE s.slug = 'land' AND sp.slug = 'teia' AND t.slug = 'tropical'
             ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
             SELECT s.id, 5, sp.id, t.id
             FROM rpg.phb_subclass s, rpg.phb_spell sp, rpg.phb_druid_land_terrain t
             WHERE s.slug = 'land' AND sp.slug = 'nuvem-fetida' AND t.slug = 'tropical'
             ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
             SELECT s.id, 5, sp.id, t.id
             FROM rpg.phb_subclass s, rpg.phb_spell sp, rpg.phb_druid_land_terrain t
             WHERE s.slug = 'land' AND sp.slug = 'polimorfia' AND t.slug = 'tropical'
             ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
             SELECT s.id, 7, sp.id, t.id
             FROM rpg.phb_subclass s, rpg.phb_spell sp, rpg.phb_druid_land_terrain t
             WHERE s.slug = 'land' AND sp.slug = 'praga-de-insetos' AND t.slug = 'tropical'
             ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
             SELECT s.id, 7, sp.id, t.id
             FROM rpg.phb_subclass s, rpg.phb_spell sp, rpg.phb_druid_land_terrain t
             WHERE s.slug = 'land' AND sp.slug = 'muralha-de-espinhos' AND t.slug = 'tropical'
             ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
             SELECT s.id, 9, sp.id, t.id
             FROM rpg.phb_subclass s, rpg.phb_spell sp, rpg.phb_druid_land_terrain t
             WHERE s.slug = 'land' AND sp.slug = 'nevoa-mortal' AND t.slug = 'tropical'
             ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
             SELECT s.id, 9, sp.id, t.id
             FROM rpg.phb_subclass s, rpg.phb_spell sp, rpg.phb_druid_land_terrain t
             WHERE s.slug = 'land' AND sp.slug = 'passo-arboreo' AND t.slug = 'tropical'
             ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_spell_source (slug, label, origin_type, class_id, subclass_id)
     VALUES ('devotion-oath', (SELECT name FROM rpg.phb_subclass WHERE slug = 'devotion'),
       'subclass'::rpg.spell_source_origin,
       (SELECT id FROM rpg.phb_class WHERE slug = 'paladin'),
       (SELECT id FROM rpg.phb_subclass WHERE slug = 'devotion'))
     ON CONFLICT (slug) DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'devotion' AND sp.slug = 'escudo-da-fe'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'devotion' AND sp.slug = 'protecao-contra-o-bem-e-o-mal'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 5, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'devotion' AND sp.slug = 'auxilio'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 5, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'devotion' AND sp.slug = 'zona-da-verdade'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 9, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'devotion' AND sp.slug = 'dissipar-magia'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 9, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'devotion' AND sp.slug = 'sinal-de-esperanca'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 13, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'devotion' AND sp.slug = 'defensor-da-fe'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 13, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'devotion' AND sp.slug = 'movimentacao-livre'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 17, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'devotion' AND sp.slug = 'coluna-de-chamas'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 17, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'devotion' AND sp.slug = 'comunhao'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_spell_source (slug, label, origin_type, class_id, subclass_id)
     VALUES ('ancients-oath', (SELECT name FROM rpg.phb_subclass WHERE slug = 'ancients'),
       'subclass'::rpg.spell_source_origin,
       (SELECT id FROM rpg.phb_class WHERE slug = 'paladin'),
       (SELECT id FROM rpg.phb_subclass WHERE slug = 'ancients'))
     ON CONFLICT (slug) DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'ancients' AND sp.slug = 'falar-com-animais'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'ancients' AND sp.slug = 'golpe-constritor'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 5, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'ancients' AND sp.slug = 'passo-nebuloso'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 5, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'ancients' AND sp.slug = 'raio-lunar'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 9, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'ancients' AND sp.slug = 'crescimento-de-plantas'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 9, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'ancients' AND sp.slug = 'protecao-contra-energia'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 13, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'ancients' AND sp.slug = 'pele-rocha'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 13, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'ancients' AND sp.slug = 'tempestade-glacial'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 17, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'ancients' AND sp.slug = 'comunhao-com-a-natureza'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 17, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'ancients' AND sp.slug = 'passo-arboreo'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_spell_source (slug, label, origin_type, class_id, subclass_id)
     VALUES ('glory-oath', (SELECT name FROM rpg.phb_subclass WHERE slug = 'glory'),
       'subclass'::rpg.spell_source_origin,
       (SELECT id FROM rpg.phb_class WHERE slug = 'paladin'),
       (SELECT id FROM rpg.phb_subclass WHERE slug = 'glory'))
     ON CONFLICT (slug) DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'glory' AND sp.slug = 'heroismo'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'glory' AND sp.slug = 'raio-guia'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 5, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'glory' AND sp.slug = 'aprimorar-atributo'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 5, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'glory' AND sp.slug = 'arma-magica'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 9, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'glory' AND sp.slug = 'celeridade'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 9, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'glory' AND sp.slug = 'protecao-contra-energia'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 13, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'glory' AND sp.slug = 'compulsao'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 13, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'glory' AND sp.slug = 'movimentacao-livre'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 17, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'glory' AND sp.slug = 'lendas-e-historias'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 17, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'glory' AND sp.slug = 'presenca-regia-de-yolande'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_spell_source (slug, label, origin_type, class_id, subclass_id)
     VALUES ('vengeance-oath', (SELECT name FROM rpg.phb_subclass WHERE slug = 'vengeance'),
       'subclass'::rpg.spell_source_origin,
       (SELECT id FROM rpg.phb_class WHERE slug = 'paladin'),
       (SELECT id FROM rpg.phb_subclass WHERE slug = 'vengeance'))
     ON CONFLICT (slug) DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'vengeance' AND sp.slug = 'marca-do-predador'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'vengeance' AND sp.slug = 'perdicao'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 5, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'vengeance' AND sp.slug = 'paralisar-pessoa'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 5, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'vengeance' AND sp.slug = 'passo-nebuloso'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 9, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'vengeance' AND sp.slug = 'celeridade'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 9, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'vengeance' AND sp.slug = 'protecao-contra-energia'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 13, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'vengeance' AND sp.slug = 'banimento'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 13, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'vengeance' AND sp.slug = 'porta-dimensional'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 17, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'vengeance' AND sp.slug = 'paralisar-monstro'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 17, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'vengeance' AND sp.slug = 'videncia'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_spell_source (slug, label, origin_type, class_id, subclass_id)
     VALUES ('archfey-pact', (SELECT name FROM rpg.phb_subclass WHERE slug = 'archfey'),
       'subclass'::rpg.spell_source_origin,
       (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'),
       (SELECT id FROM rpg.phb_subclass WHERE slug = 'archfey'))
     ON CONFLICT (slug) DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'archfey' AND sp.slug = 'acalmar-emocoes'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'archfey' AND sp.slug = 'fogo-das-fadas'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'archfey' AND sp.slug = 'forca-espectral'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'archfey' AND sp.slug = 'passo-nebuloso'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'archfey' AND sp.slug = 'sono'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 5, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'archfey' AND sp.slug = 'crescimento-de-plantas'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 5, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'archfey' AND sp.slug = 'piscar'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 7, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'archfey' AND sp.slug = 'dominar-fera'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 7, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'archfey' AND sp.slug = 'invisibilidade-maior'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 9, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'archfey' AND sp.slug = 'dominar-pessoa'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 9, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'archfey' AND sp.slug = 'similaridade'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_spell_source (slug, label, origin_type, class_id, subclass_id)
     VALUES ('fiend-pact', (SELECT name FROM rpg.phb_subclass WHERE slug = 'fiend'),
       'subclass'::rpg.spell_source_origin,
       (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'),
       (SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend'))
     ON CONFLICT (slug) DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'fiend' AND sp.slug = 'comando'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'fiend' AND sp.slug = 'maos-flamejantes'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'fiend' AND sp.slug = 'raio-ardente'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'fiend' AND sp.slug = 'sugestao'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 5, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'fiend' AND sp.slug = 'bola-de-fogo'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 5, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'fiend' AND sp.slug = 'nuvem-fetida'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 7, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'fiend' AND sp.slug = 'escudo-ardente'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 7, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'fiend' AND sp.slug = 'muralha-de-fogo'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 9, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'fiend' AND sp.slug = 'missao'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 9, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'fiend' AND sp.slug = 'praga-de-insetos'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_spell_source (slug, label, origin_type, class_id, subclass_id)
     VALUES ('celestial-pact', (SELECT name FROM rpg.phb_subclass WHERE slug = 'celestial'),
       'subclass'::rpg.spell_source_origin,
       (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'),
       (SELECT id FROM rpg.phb_subclass WHERE slug = 'celestial'))
     ON CONFLICT (slug) DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'celestial' AND sp.slug = 'auxilio'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'celestial' AND sp.slug = 'chama-sagrada'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'celestial' AND sp.slug = 'curar-ferimentos'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'celestial' AND sp.slug = 'luz'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'celestial' AND sp.slug = 'raio-guia'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'celestial' AND sp.slug = 'restauracao-menor'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 5, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'celestial' AND sp.slug = 'luz-do-dia'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 5, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'celestial' AND sp.slug = 'revivificar'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 7, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'celestial' AND sp.slug = 'defensor-da-fe'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 7, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'celestial' AND sp.slug = 'muralha-de-fogo'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 9, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'celestial' AND sp.slug = 'convocar-celestial'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 9, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'celestial' AND sp.slug = 'restauracao-maior'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_spell_source (slug, label, origin_type, class_id, subclass_id)
     VALUES ('great-old-one-pact', (SELECT name FROM rpg.phb_subclass WHERE slug = 'great-old-one'),
       'subclass'::rpg.spell_source_origin,
       (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'),
       (SELECT id FROM rpg.phb_subclass WHERE slug = 'great-old-one'))
     ON CONFLICT (slug) DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'great-old-one' AND sp.slug = 'detectar-pensamentos'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'great-old-one' AND sp.slug = 'forca-espectral'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'great-old-one' AND sp.slug = 'gargalhada-nefasta-de-tasha'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'great-old-one' AND sp.slug = 'sussurros-dissonantes'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 5, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'great-old-one' AND sp.slug = 'clarividencia'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 5, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'great-old-one' AND sp.slug = 'fome-de-hadar'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 7, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'great-old-one' AND sp.slug = 'confusao'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 7, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'great-old-one' AND sp.slug = 'invocar-aberracao'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 9, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'great-old-one' AND sp.slug = 'modificar-memoria'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 9, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'great-old-one' AND sp.slug = 'telecinese'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_spell_source (slug, label, origin_type, class_id, subclass_id)
     VALUES ('fey-wanderer-spells', (SELECT name FROM rpg.phb_subclass WHERE slug = 'fey-wanderer'),
       'subclass'::rpg.spell_source_origin,
       (SELECT id FROM rpg.phb_class WHERE slug = 'ranger'),
       (SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer'))
     ON CONFLICT (slug) DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'fey-wanderer' AND sp.slug = 'enfeiticar-pessoa'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 5, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'fey-wanderer' AND sp.slug = 'passo-nebuloso'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 9, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'fey-wanderer' AND sp.slug = 'convocar-feerico'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 13, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'fey-wanderer' AND sp.slug = 'porta-dimensional'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 17, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'fey-wanderer' AND sp.slug = 'despistar'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_spell_source (slug, label, origin_type, class_id, subclass_id)
     VALUES ('gloom-stalker-spells', (SELECT name FROM rpg.phb_subclass WHERE slug = 'gloom-stalker'),
       'subclass'::rpg.spell_source_origin,
       (SELECT id FROM rpg.phb_class WHERE slug = 'ranger'),
       (SELECT id FROM rpg.phb_subclass WHERE slug = 'gloom-stalker'))
     ON CONFLICT (slug) DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'gloom-stalker' AND sp.slug = 'disfarcar-se'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 5, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'gloom-stalker' AND sp.slug = 'corda-extradimensional'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 9, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'gloom-stalker' AND sp.slug = 'medo'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 13, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'gloom-stalker' AND sp.slug = 'invisibilidade-maior'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 17, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'gloom-stalker' AND sp.slug = 'similaridade'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_spell_source (slug, label, origin_type, class_id, subclass_id)
     VALUES ('draconic-sorcery', (SELECT name FROM rpg.phb_subclass WHERE slug = 'draconic'),
       'subclass'::rpg.spell_source_origin,
       (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'),
       (SELECT id FROM rpg.phb_subclass WHERE slug = 'draconic'))
     ON CONFLICT (slug) DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'draconic' AND sp.slug = 'alterar-se'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'draconic' AND sp.slug = 'comando'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'draconic' AND sp.slug = 'orbe-cromatico'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'draconic' AND sp.slug = 'sopro-de-dragao'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 5, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'draconic' AND sp.slug = 'medo'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 5, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'draconic' AND sp.slug = 'voo'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 7, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'draconic' AND sp.slug = 'enfeiticar-monstro'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 7, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'draconic' AND sp.slug = 'olho-arcano'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 9, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'draconic' AND sp.slug = 'invocar-dragao'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 9, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'draconic' AND sp.slug = 'lendas-e-historias'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_spell_source (slug, label, origin_type, class_id, subclass_id)
     VALUES ('aberrant-sorcery', (SELECT name FROM rpg.phb_subclass WHERE slug = 'aberrant'),
       'subclass'::rpg.spell_source_origin,
       (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'),
       (SELECT id FROM rpg.phb_subclass WHERE slug = 'aberrant'))
     ON CONFLICT (slug) DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'aberrant' AND sp.slug = 'acalmar-emocoes'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'aberrant' AND sp.slug = 'bracos-de-hadar'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'aberrant' AND sp.slug = 'detectar-pensamentos'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'aberrant' AND sp.slug = 'sussurros-dissonantes'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'aberrant' AND sp.slug = 'talho-mental'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 5, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'aberrant' AND sp.slug = 'fome-de-hadar'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 5, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'aberrant' AND sp.slug = 'remeter'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 7, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'aberrant' AND sp.slug = 'invocar-aberracao'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 7, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'aberrant' AND sp.slug = 'tentaculos-negros-de-evard'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 9, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'aberrant' AND sp.slug = 'ligacao-telepatica-de-rary'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 9, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'aberrant' AND sp.slug = 'telecinese'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_spell_source (slug, label, origin_type, class_id, subclass_id)
     VALUES ('clockwork-sorcery', (SELECT name FROM rpg.phb_subclass WHERE slug = 'clockwork'),
       'subclass'::rpg.spell_source_origin,
       (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'),
       (SELECT id FROM rpg.phb_subclass WHERE slug = 'clockwork'))
     ON CONFLICT (slug) DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'clockwork' AND sp.slug = 'alarme'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'clockwork' AND sp.slug = 'auxilio'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'clockwork' AND sp.slug = 'protecao-contra-o-bem-e-o-mal'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 3, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'clockwork' AND sp.slug = 'restauracao-menor'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 5, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'clockwork' AND sp.slug = 'dissipar-magia'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 5, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'clockwork' AND sp.slug = 'protecao-contra-energia'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 7, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'clockwork' AND sp.slug = 'invocar-constructo'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 7, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'clockwork' AND sp.slug = 'movimentacao-livre'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 9, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'clockwork' AND sp.slug = 'muralha-de-energia'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
           SELECT s.id, 9, sp.id, NULL
           FROM rpg.phb_subclass s, rpg.phb_spell sp
           WHERE s.slug = 'clockwork' AND sp.slug = 'restauracao-maior'
           ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
COMMIT;
