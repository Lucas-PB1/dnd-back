-- Seed rpg.phb_subclass_prepared_spell
-- Gerado automaticamente — não editar à mão

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
