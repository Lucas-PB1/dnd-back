-- Mecânicas de subclasse — gerado por npm run generate:seed-subclass-mechanics
BEGIN;
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'world-tree') AND level = 3 AND name = 'Vitalidade da Árvore';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'world-tree') AND level = 6 AND name = 'Ramos da Árvore';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'world-tree') AND level = 10 AND name = 'Raízes Devastadoras';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'world-tree') AND level = 14 AND name = 'Percorrer a Árvore';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'berserker') AND level = 3 AND name = 'Frenesi';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'berserker') AND level = 6 AND name = 'Fúria Irracional';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'berserker') AND level = 10 AND name = 'Retaliação';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'berserker') AND level = 14 AND name = 'Presença Intimidante';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-heart') AND level = 3 AND name = 'Arauto da Fauna';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-heart') AND level = 3 AND name = 'Fúria dos Selvagens';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-heart') AND level = 6 AND name = 'Aspecto dos Selvagens';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-heart') AND level = 10 AND name = 'Arauto da Natureza';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-heart') AND level = 14 AND name = 'Poder dos Selvagens';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'zealot') AND level = 3 AND name = 'Campeão dos Deuses';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'zealot') AND level = 3 AND name = 'Fúria Divina';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'zealot') AND level = 6 AND name = 'Concentração Fanática';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'zealot') AND level = 10 AND name = 'Presença Zelosa';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'zealot') AND level = 14 AND name = 'Fúria dos Deuses';
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
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'archfey') AND level = 3 AND name = 'Passos Feéricos';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'archfey') AND level = 6 AND name = 'Fuga em Névoa';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'archfey') AND level = 10 AND name = 'Defesas Sedutoras';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'archfey') AND level = 14 AND name = 'Magia Sedutora';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'celestial') AND level = 3 AND name = 'Luz Medicinal';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'celestial') AND level = 3 AND name = 'Magia de Pacto do Celestial';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'celestial') AND level = 6 AND name = 'Alma Radiante';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'celestial') AND level = 10 AND name = 'Resiliência Celestial';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'celestial') AND level = 14 AND name = 'Vingança Calcinante';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'always_prepared'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'great-old-one') AND level = 3 AND name = 'Magias de Pacto do Grande Antigo';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'always_prepared'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'great-old-one') AND level = 3 AND name = 'Magias Psíquicas';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'great-old-one') AND level = 3 AND name = 'Mente Desperta';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'great-old-one') AND level = 6 AND name = 'Combatente Clarividente';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'great-old-one') AND level = 10 AND name = 'Danação Mística';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'great-old-one') AND level = 10 AND name = 'Escudo Mental';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'great-old-one') AND level = 14 AND name = 'Criar Servo';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend') AND level = 3 AND name = 'Bênção do Tenebroso';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'always_prepared'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend') AND level = 3 AND name = 'Magias de Pacto do Ínfero';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend') AND level = 6 AND name = 'A Sorte do Próprio Tenebroso';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend') AND level = 10 AND name = 'Resistência Ínfera';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend') AND level = 14 AND name = 'Lançar no Inferno';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'life') AND level = 3 AND name = 'Magias de Domínio da Vida';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'life') AND level = 3 AND name = 'Discípulo da Vida';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'life') AND level = 3 AND name = 'Preservar a Vida';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'life') AND level = 6 AND name = 'Curandeiro Abençoado';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'life') AND level = 17 AND name = 'Cura Suprema';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'light') AND level = 3 AND name = 'Brilho do Amanhecer';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'light') AND level = 3 AND name = 'Labareda Protetora';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'always_prepared'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'light') AND level = 3 AND name = 'Magias de Domínio da Luz';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'light') AND level = 6 AND name = 'Labareda Protetora Aprimorada';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'light') AND level = 17 AND name = 'Coroa de Luz';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'always_prepared'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'trickery') AND level = 3 AND name = 'Magias de Domínio da Trapaça';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'trickery') AND level = 3 AND name = 'Bênção do Trapaceiro';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'trickery') AND level = 3 AND name = 'Invocar Duplicidade';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'trickery') AND level = 6 AND name = 'Transposição do Trapaceiro';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'trickery') AND level = 17 AND name = 'Duplicidade Aprimorada';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'always_prepared'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'war') AND level = 3 AND name = 'Magias de Domínio da Guerra';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'war') AND level = 3 AND name = 'Ataque Direcionado';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'war') AND level = 3 AND name = 'Sacerdote da Guerra';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'war') AND level = 6 AND name = 'Bênção do Deus da Guerra';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'war') AND level = 17 AND name = 'Avatar da Guerra';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'land') AND level = 3 AND name = 'Auxílio da Terra';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'always_prepared'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'land') AND level = 3 AND name = 'Magias do Círculo da Terra';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'land') AND level = 6 AND name = 'Recuperação Natural';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'land') AND level = 10 AND name = 'Proteção Natural';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'land') AND level = 14 AND name = 'Santuário Natural';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'moon') AND level = 3 AND name = 'Formas Animais dos Círculos Druídicos';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'always_prepared'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'moon') AND level = 3 AND name = 'Magias do Círculo da Lua';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'moon') AND level = 6 AND name = 'Formas Animais dos Círculos Druídicos Aprimorada';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'moon') AND level = 10 AND name = 'Passo Lunar';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'moon') AND level = 14 AND name = 'Forma Lunar';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'stars') AND level = 3 AND name = 'Forma Estrelada';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'stars') AND level = 3 AND name = 'Mapa Estelar';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'stars') AND level = 6 AND name = 'Presságio Cósmico';
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
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'aberrant') AND level = 18 AND name = 'Implosão de Distorção';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'always_prepared'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'draconic') AND level = 3 AND name = 'Magias Dracônicas';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'draconic') AND level = 3 AND name = 'Resiliência Dracônica';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'choice'::rpg.subclass_feature_kind, option_key = 'elementalAffinity' WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'draconic') AND level = 6 AND name = 'Afinidade Elemental';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'resource'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'draconic') AND level = 14 AND name = 'Asas de Dragão';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'draconic') AND level = 18 AND name = 'Companheiro Dracônico';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'always_prepared'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'clockwork') AND level = 3 AND name = 'Magias Mecânicas';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'resource'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'clockwork') AND level = 3 AND name = 'Restaurar Equilíbrio';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'clockwork') AND level = 6 AND name = 'Bastião da Lei';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'clockwork') AND level = 14 AND name = 'Transe da Ordem';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'clockwork') AND level = 18 AND name = 'Cavalgada Mecânica';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'resource'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-magic') AND level = 3 AND name = 'Marés do Caos';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-magic') AND level = 3 AND name = 'Surto de Magia Selvagem';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-magic') AND level = 6 AND name = 'Distorcer a Sorte';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-magic') AND level = 14 AND name = 'Caos Controlado';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-magic') AND level = 18 AND name = 'Surto Controlado';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer') AND level = 3 AND name = 'Glamour Transcendental';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer') AND level = 3 AND name = 'Golpes Terríveis';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'always_prepared'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer') AND level = 3 AND name = 'Magias do Andarilho Feérico';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer') AND level = 7 AND name = 'Detalhe Sedutor';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer') AND level = 11 AND name = 'Reforços Feéricos';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer') AND level = 15 AND name = 'Andarilho Nebuloso';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'hunter') AND level = 3 AND name = 'Conhecimento do Caçador';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'hunter') AND level = 3 AND name = 'Presa do Caçador';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'hunter') AND level = 7 AND name = 'Táticas Defensivas';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'hunter') AND level = 11 AND name = 'Presa do Caçador Superior';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'hunter') AND level = 15 AND name = 'Defesa do Caçador';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'beast-master') AND level = 3 AND name = 'Companheiro Primal';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'beast-master') AND level = 7 AND name = 'Treinamento Excepcional';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'beast-master') AND level = 11 AND name = 'Fúria Bestial';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'beast-master') AND level = 15 AND name = 'Compartilhar Magias';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'gloom-stalker') AND level = 3 AND name = 'Emboscador das Sombras';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'always_prepared'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'gloom-stalker') AND level = 3 AND name = 'Magias do Vigilante das Sombras';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'gloom-stalker') AND level = 3 AND name = 'Visão Umbrosa';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'gloom-stalker') AND level = 7 AND name = 'Mente de Ferro';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'gloom-stalker') AND level = 11 AND name = 'Torrente do Vigilante';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'gloom-stalker') AND level = 15 AND name = 'Esquiva Sombria';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'champion') AND level = 3 AND name = 'Atleta Extraordinário';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'champion') AND level = 3 AND name = 'Crítico Aprimorado';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'champion') AND level = 7 AND name = 'Estilo de Luta Adicional';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'champion') AND level = 10 AND name = 'Combatente Heroico';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'champion') AND level = 15 AND name = 'Crítico Superior';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'champion') AND level = 18 AND name = 'Sobrevivente';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'spellcasting'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'eldritch-knight') AND level = 3 AND name = 'Conjuração';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'eldritch-knight') AND level = 3 AND name = 'Vínculo com Arma';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'eldritch-knight') AND level = 7 AND name = 'Magia de Guerra';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'eldritch-knight') AND level = 10 AND name = 'Golpe Místico';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'eldritch-knight') AND level = 15 AND name = 'Investida Mística';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'eldritch-knight') AND level = 18 AND name = 'Magia de Guerra Aprimorada';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'psi-warrior') AND level = 3 AND name = 'Poder Psiônico';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'psi-warrior') AND level = 7 AND name = 'Adepto Telecinético';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'psi-warrior') AND level = 10 AND name = 'Resguardo Mental';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'psi-warrior') AND level = 15 AND name = 'Baluarte de Energia';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'psi-warrior') AND level = 18 AND name = 'Mestre Telecinético';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master') AND level = 3 AND name = 'Estudioso da Guerra';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master') AND level = 3 AND name = 'Superioridade em Combate';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master') AND level = 7 AND name = 'Conheça Seu Inimigo';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master') AND level = 10 AND name = 'Superioridade em Combate Aprimorada';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master') AND level = 15 AND name = 'Implacável';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'battle-master') AND level = 18 AND name = 'Superioridade em Combate Suprema';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'soulknife') AND level = 3 AND name = 'Lâminas Psíquicas';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'soulknife') AND level = 3 AND name = 'Poder Psiônico';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'soulknife') AND level = 9 AND name = 'Lâminas da Alma';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'soulknife') AND level = 13 AND name = 'Véu Psíquico';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'soulknife') AND level = 17 AND name = 'Rasgar Mente';
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
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'arcane-trickster') AND level = 17 AND name = 'Ladrão de Magias';
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
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'elements') AND level = 17 AND name = 'Ápice Elemental';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'open-hand') AND level = 3 AND name = 'Técnica da Mão Espalmada';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'open-hand') AND level = 6 AND name = 'Integridade Corporal';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'open-hand') AND level = 11 AND name = 'Passo Veloz';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'open-hand') AND level = 17 AND name = 'Palma Vibrante';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'mercy') AND level = 3 AND name = 'Implementos de Misericórdia';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'mercy') AND level = 3 AND name = 'Mão de Cura';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'mercy') AND level = 3 AND name = 'Mão de Dolo';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'mercy') AND level = 6 AND name = 'Toque de Médico';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'mercy') AND level = 11 AND name = 'Torrente de Cura e Dolo';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'mercy') AND level = 17 AND name = 'Mão da Misericórdia Final';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'shadow') AND level = 3 AND name = 'Artes das Sombras';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'shadow') AND level = 6 AND name = 'Passo da Sombra';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'shadow') AND level = 11 AND name = 'Passo da Sombra Aprimorado';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'shadow') AND level = 17 AND name = 'Manto da Sombra';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'ancients') AND level = 3 AND name = 'A Ira da Natureza';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'always_prepared'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'ancients') AND level = 3 AND name = 'Magias do Juramento dos Anciões';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'ancients') AND level = 7 AND name = 'Aura de Resistência';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'ancients') AND level = 15 AND name = 'Sentinela Imortal';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'ancients') AND level = 20 AND name = 'Campeão Ancestral';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'devotion') AND level = 3 AND name = 'Arma Sagrada';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'devotion') AND level = 7 AND name = 'Aura de Devoção';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'devotion') AND level = 15 AND name = 'Destruição Protetora';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'devotion') AND level = 20 AND name = 'Resplendor Sagrado';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'glory') AND level = 3 AND name = 'Atleta Inigualável';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'glory') AND level = 3 AND name = 'Destruição Inspiradora';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'always_prepared'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'glory') AND level = 3 AND name = 'Magias do Juramento da Glória';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'glory') AND level = 7 AND name = 'Aura de Vivacidade';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'glory') AND level = 15 AND name = 'Defesa Gloriosa';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'glory') AND level = 20 AND name = 'Lenda Viva';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'always_prepared'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'vengeance') AND level = 3 AND name = 'Magias do Juramento da Vingança';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'vengeance') AND level = 3 AND name = 'Voto de Inimizade';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'vengeance') AND level = 7 AND name = 'Vingador Implacável';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'vengeance') AND level = 15 AND name = 'Alma Vingativa';
UPDATE rpg.phb_subclass_feature SET feature_kind = 'passive'::rpg.subclass_feature_kind WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'vengeance') AND level = 20 AND name = 'Anjo Vingador';
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
