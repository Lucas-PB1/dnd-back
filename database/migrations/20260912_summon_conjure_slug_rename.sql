-- Summon vs Conjure: slugs canônicos (idempotente).
-- Conjure → conjurar-*; Summon que era convocar-* → invocar-*.
-- Trata duplicatas criadas por seed parcial (ambos from e to presentes).

CREATE OR REPLACE FUNCTION rpg._spell_slug_retarget(p_from text, p_to text)
RETURNS void
LANGUAGE plpgsql
AS $$
BEGIN
  UPDATE rpg.player_character_spell SET spell_slug = p_to WHERE spell_slug = p_from;
  UPDATE rpg.player_character_item
    SET attached_coverage_spell_slug = p_to
    WHERE attached_coverage_spell_slug = p_from;
  UPDATE rpg.player_character_item
    SET bound_spell_slug = p_to
    WHERE bound_spell_slug = p_from;
  UPDATE rpg.phb_class_economy_action SET spell_slug = p_to WHERE spell_slug = p_from;
  UPDATE rpg.phb_eldritch_invocation
    SET granted_spell_slug = p_to
    WHERE granted_spell_slug = p_from;
  UPDATE rpg.game_actor_spell SET spell_slug = p_to WHERE spell_slug = p_from;
  UPDATE rpg.phb_creature_template_spell SET spell_slug = p_to WHERE spell_slug = p_from;
END;
$$;

CREATE OR REPLACE FUNCTION rpg._rename_spell_slug(p_from text, p_to text, p_name text)
RETURNS void
LANGUAGE plpgsql
AS $$
DECLARE
  v_from_exists boolean;
  v_to_exists boolean;
BEGIN
  SELECT EXISTS(SELECT 1 FROM rpg.phb_spell WHERE slug = p_from) INTO v_from_exists;
  SELECT EXISTS(SELECT 1 FROM rpg.phb_spell WHERE slug = p_to) INTO v_to_exists;

  IF NOT v_from_exists AND v_to_exists THEN
    UPDATE rpg.phb_spell SET name = p_name WHERE slug = p_to AND name IS DISTINCT FROM p_name;
    RETURN;
  END IF;

  IF NOT v_from_exists THEN
    RETURN;
  END IF;

  IF v_to_exists THEN
    -- Ambos existem: no seed canônico Summon (invocar-*) e Conjure (conjurar-*)
    -- são magias distintas — não apagar o from.
    -- (Upgrade antigo: to ainda não existe e cai no rename abaixo.)
    UPDATE rpg.phb_spell SET name = p_name WHERE slug = p_to AND name IS DISTINCT FROM p_name;
    RETURN;
  END IF;

  PERFORM rpg._spell_slug_retarget(p_from, p_to);
  UPDATE rpg.phb_spell
    SET slug = p_to,
        name = p_name
    WHERE slug = p_from;
END;
$$;

-- 1) Conjure (efeito) → conjurar-*
SELECT rpg._rename_spell_slug('invocar-animais', 'conjurar-animais', 'Conjurar Animais');
SELECT rpg._rename_spell_slug('invocar-barragem', 'conjurar-barragem', 'Conjurar Barragem');
SELECT rpg._rename_spell_slug('invocar-celestial', 'conjurar-celestial', 'Conjurar Celestial');
SELECT rpg._rename_spell_slug(
  'invocar-elementais-menores',
  'conjurar-elementais-menores',
  'Conjurar Elementais Menores'
);
SELECT rpg._rename_spell_slug('invocar-elemental', 'conjurar-elemental', 'Conjurar Elemental');
SELECT rpg._rename_spell_slug('invocar-feerico', 'conjurar-feerico', 'Conjurar Feérico');
SELECT rpg._rename_spell_slug('invocar-saraivada', 'conjurar-saraivada', 'Conjurar Saraivada');
SELECT rpg._rename_spell_slug(
  'invocar-seres-da-floresta',
  'conjurar-seres-da-floresta',
  'Conjurar Seres da Floresta'
);

-- 2) Summon que usava convocar-* → invocar-*
SELECT rpg._rename_spell_slug('convocar-celestial', 'invocar-celestial', 'Invocar Celestial');
SELECT rpg._rename_spell_slug('convocar-elemental', 'invocar-elemental', 'Invocar Elemental');
SELECT rpg._rename_spell_slug('convocar-feerico', 'invocar-feerico', 'Invocar Feérico');

UPDATE rpg.phb_spell SET name = 'Invocar Fera' WHERE slug = 'invocar-fera' AND name IS DISTINCT FROM 'Invocar Fera';

DROP FUNCTION rpg._rename_spell_slug(text, text, text);
DROP FUNCTION rpg._spell_slug_retarget(text, text);
