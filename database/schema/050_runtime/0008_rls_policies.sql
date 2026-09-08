DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.schemata WHERE schema_name = 'auth') THEN
    RAISE NOTICE 'Skipping campaign encounter RLS — auth schema not present (local Postgres)';
    RETURN;
  END IF;

  ALTER TABLE rpg.campaign_encounter ENABLE ROW LEVEL SECURITY;
  ALTER TABLE rpg.campaign_encounter_combatant ENABLE ROW LEVEL SECURITY;

  DROP POLICY IF EXISTS campaign_encounter_member_select ON rpg.campaign_encounter;
  CREATE POLICY campaign_encounter_member_select ON rpg.campaign_encounter
    FOR SELECT USING (
      campaign_id IN (
        SELECT campaign_id FROM rpg.campaign_member WHERE user_id = auth.uid()
      )
    );

  DROP POLICY IF EXISTS campaign_encounter_staff_write ON rpg.campaign_encounter;
  CREATE POLICY campaign_encounter_staff_write ON rpg.campaign_encounter
    FOR ALL USING (
      campaign_id IN (
        SELECT campaign_id FROM rpg.campaign_member
        WHERE user_id = auth.uid() AND role IN ('dm', 'assistant')
      )
    )
    WITH CHECK (
      campaign_id IN (
        SELECT campaign_id FROM rpg.campaign_member
        WHERE user_id = auth.uid() AND role IN ('dm', 'assistant')
      )
    );

  DROP POLICY IF EXISTS campaign_encounter_combatant_member_select
    ON rpg.campaign_encounter_combatant;
  CREATE POLICY campaign_encounter_combatant_member_select
    ON rpg.campaign_encounter_combatant
    FOR SELECT USING (
      encounter_id IN (
        SELECT e.id
        FROM rpg.campaign_encounter e
        JOIN rpg.campaign_member m ON m.campaign_id = e.campaign_id
        WHERE m.user_id = auth.uid()
      )
    );

  DROP POLICY IF EXISTS campaign_encounter_combatant_staff_write
    ON rpg.campaign_encounter_combatant;
  CREATE POLICY campaign_encounter_combatant_staff_write
    ON rpg.campaign_encounter_combatant
    FOR ALL USING (
      encounter_id IN (
        SELECT e.id
        FROM rpg.campaign_encounter e
        JOIN rpg.campaign_member m ON m.campaign_id = e.campaign_id
        WHERE m.user_id = auth.uid() AND m.role IN ('dm', 'assistant')
      )
    )
    WITH CHECK (
      encounter_id IN (
        SELECT e.id
        FROM rpg.campaign_encounter e
        JOIN rpg.campaign_member m ON m.campaign_id = e.campaign_id
        WHERE m.user_id = auth.uid() AND m.role IN ('dm', 'assistant')
      )
    );
END $$;

-- Slots não exclusivos para itens mágicos vestíveis / carregados.




-- Câmara de armas de fogo por personagem (estado de sessão).

-- Estado de combate do Bárbaro (Fúria / Ataque Imprudente).



-- Encanto de arma preso a um item do inventário (slug do phb_item do encanto).




-- Soft check: null ou slug de encanto; sem FK (catálogo pode atrasar).

-- Trackers de sessão Pack 2: Colégio das Máscaras / Beastborne.



-- Trackers de sessão: Mago dos Mísseis (Escudo / Giga armados para o próximo cast).



-- Arma de Pacto (Bruxo · Pacto da Lâmina): no máximo uma por personagem.


CREATE UNIQUE INDEX uq_player_character_item_one_pact_weapon
  ON rpg.player_character_item (character_id)
  WHERE is_pact_weapon = TRUE;

-- Overlay DMG §3.1: cobertura presa à peça base (estilo Valdas charm).













-- Arma Magificada: magia vinculada na cobertura anexada.





-- Magia vinculada em item único (ex.: Cajado Magificado).

-- Wealth: 5 moedas D&D no personagem (PC / PP prata / PE / PO / PL platina)

-- Campanha: players podem optar por não pagar ao pegar item

-- Bucket público de avatares (perfil do usuário).
-- Rode no SQL Editor do Supabase se o pipeline de migrations não cobre storage.

INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES (
  'avatars',
  'avatars',
  true,
  2097152,
  ARRAY['image/jpeg', 'image/png', 'image/webp']
)
ON CONFLICT (id) DO UPDATE
SET
  public = EXCLUDED.public,
  file_size_limit = EXCLUDED.file_size_limit,
  allowed_mime_types = EXCLUDED.allowed_mime_types;

DROP POLICY IF EXISTS "avatars_public_read" ON storage.objects;
CREATE POLICY "avatars_public_read"
  ON storage.objects
  FOR SELECT
  USING (bucket_id = 'avatars');

DROP POLICY IF EXISTS "avatars_owner_insert" ON storage.objects;
CREATE POLICY "avatars_owner_insert"
  ON storage.objects
  FOR INSERT
  TO authenticated
  WITH CHECK (
    bucket_id = 'avatars'
    AND (storage.foldername(name))[1] = auth.uid()::text
  );

DROP POLICY IF EXISTS "avatars_owner_update" ON storage.objects;
CREATE POLICY "avatars_owner_update"
  ON storage.objects
  FOR UPDATE
  TO authenticated
  USING (
    bucket_id = 'avatars'
    AND (storage.foldername(name))[1] = auth.uid()::text
  )
  WITH CHECK (
    bucket_id = 'avatars'
    AND (storage.foldername(name))[1] = auth.uid()::text
  );

DROP POLICY IF EXISTS "avatars_owner_delete" ON storage.objects;
CREATE POLICY "avatars_owner_delete"
  ON storage.objects
  FOR DELETE
  TO authenticated
  USING (
    bucket_id = 'avatars'
    AND (storage.foldername(name))[1] = auth.uid()::text
  );

-- Props de instância (artefato rolado na 1ª sintonia, senciência copiada, etc.)


COMMENT ON COLUMN rpg.player_character_item.instance_properties IS
  'Estado por instância: artifactRandom (1ª sintonia), sentience copiada do catálogo, etc.';

-- Compartimentos de inventário: item contido em outro (bolsa/saca/cesta).
-- Nullable = mochila raiz (compatível com inventário existente).


COMMENT ON COLUMN rpg.player_character_item.contained_in_item_slug IS
  'Slug do recipiente no mesmo personagem; NULL = raiz (Equipado/Mochila).';

CREATE INDEX idx_player_character_item_contained_in
  ON rpg.player_character_item (character_id, contained_in_item_slug)
  WHERE contained_in_item_slug IS NOT NULL;

-- Forma Estrelada (Círculo das Estrelas): constelação ativa na sessão



-- RPC de leitura: ficha do jogador em 1 round-trip (JSONB).
-- Substitui N finds TypeORM em player_character_* + skills do antecedente.

-- RPC de leitura: inventário + catálogo de combate em 1 round-trip.
