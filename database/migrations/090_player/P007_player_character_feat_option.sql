-- Lote C: views de compatibilidade runtime (nomes legados → player_character_option)
-- TypeORM entities antigas continuam apontando estes nomes.

CREATE OR REPLACE VIEW rpg.player_character_subclass_option AS
SELECT character_id, option_key, value_id
FROM rpg.player_character_option
WHERE scope = 'subclass'::rpg.option_scope;

CREATE OR REPLACE FUNCTION rpg.pc_subclass_option_ins()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
  INSERT INTO rpg.player_character_option (character_id, scope, owner_slug, option_key, value_id, instance_index)
  VALUES (NEW.character_id, 'subclass', '', NEW.option_key, NEW.value_id, 0)
  ON CONFLICT (character_id, scope, owner_slug, instance_index, option_key)
  DO UPDATE SET value_id = EXCLUDED.value_id;
  RETURN NEW;
END;
$$;

CREATE OR REPLACE FUNCTION rpg.pc_subclass_option_upd()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
  UPDATE rpg.player_character_option
  SET value_id = NEW.value_id
  WHERE character_id = OLD.character_id
    AND scope = 'subclass'::rpg.option_scope
    AND option_key = OLD.option_key;
  RETURN NEW;
END;
$$;

CREATE OR REPLACE FUNCTION rpg.pc_subclass_option_del()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
  DELETE FROM rpg.player_character_option
  WHERE character_id = OLD.character_id
    AND scope = 'subclass'::rpg.option_scope
    AND option_key = OLD.option_key;
  RETURN OLD;
END;
$$;

CREATE TRIGGER tr_pc_subclass_option_ins
  INSTEAD OF INSERT ON rpg.player_character_subclass_option
  FOR EACH ROW EXECUTE FUNCTION rpg.pc_subclass_option_ins();
CREATE TRIGGER tr_pc_subclass_option_upd
  INSTEAD OF UPDATE ON rpg.player_character_subclass_option
  FOR EACH ROW EXECUTE FUNCTION rpg.pc_subclass_option_upd();
CREATE TRIGGER tr_pc_subclass_option_del
  INSTEAD OF DELETE ON rpg.player_character_subclass_option
  FOR EACH ROW EXECUTE FUNCTION rpg.pc_subclass_option_del();

-- feat options
CREATE OR REPLACE VIEW rpg.player_character_feat_option AS
SELECT character_id, owner_slug AS feat_slug, instance_index, option_key, value_id
FROM rpg.player_character_option
WHERE scope = 'feat'::rpg.option_scope;

CREATE OR REPLACE FUNCTION rpg.pc_feat_option_ins()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
  INSERT INTO rpg.player_character_option (character_id, scope, owner_slug, option_key, value_id, instance_index)
  VALUES (NEW.character_id, 'feat', NEW.feat_slug, NEW.option_key, NEW.value_id, NEW.instance_index)
  ON CONFLICT (character_id, scope, owner_slug, instance_index, option_key)
  DO UPDATE SET value_id = EXCLUDED.value_id;
  RETURN NEW;
END;
$$;

CREATE OR REPLACE FUNCTION rpg.pc_feat_option_upd()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
  UPDATE rpg.player_character_option
  SET value_id = NEW.value_id
  WHERE character_id = OLD.character_id
    AND scope = 'feat'::rpg.option_scope
    AND owner_slug = OLD.feat_slug
    AND instance_index = OLD.instance_index
    AND option_key = OLD.option_key;
  RETURN NEW;
END;
$$;

CREATE OR REPLACE FUNCTION rpg.pc_feat_option_del()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
  DELETE FROM rpg.player_character_option
  WHERE character_id = OLD.character_id
    AND scope = 'feat'::rpg.option_scope
    AND owner_slug = OLD.feat_slug
    AND instance_index = OLD.instance_index
    AND option_key = OLD.option_key;
  RETURN OLD;
END;
$$;

CREATE TRIGGER tr_pc_feat_option_ins
  INSTEAD OF INSERT ON rpg.player_character_feat_option
  FOR EACH ROW EXECUTE FUNCTION rpg.pc_feat_option_ins();
CREATE TRIGGER tr_pc_feat_option_upd
  INSTEAD OF UPDATE ON rpg.player_character_feat_option
  FOR EACH ROW EXECUTE FUNCTION rpg.pc_feat_option_upd();
CREATE TRIGGER tr_pc_feat_option_del
  INSTEAD OF DELETE ON rpg.player_character_feat_option
  FOR EACH ROW EXECUTE FUNCTION rpg.pc_feat_option_del();

-- class options
CREATE OR REPLACE VIEW rpg.player_character_class_option AS
SELECT character_id, option_key, value_id
FROM rpg.player_character_option
WHERE scope = 'class'::rpg.option_scope;

CREATE OR REPLACE FUNCTION rpg.pc_class_option_ins()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
  INSERT INTO rpg.player_character_option (character_id, scope, owner_slug, option_key, value_id, instance_index)
  VALUES (NEW.character_id, 'class', '', NEW.option_key, NEW.value_id, 0)
  ON CONFLICT (character_id, scope, owner_slug, instance_index, option_key)
  DO UPDATE SET value_id = EXCLUDED.value_id;
  RETURN NEW;
END;
$$;

CREATE OR REPLACE FUNCTION rpg.pc_class_option_upd()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
  UPDATE rpg.player_character_option
  SET value_id = NEW.value_id
  WHERE character_id = OLD.character_id
    AND scope = 'class'::rpg.option_scope
    AND option_key = OLD.option_key;
  RETURN NEW;
END;
$$;

CREATE OR REPLACE FUNCTION rpg.pc_class_option_del()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
  DELETE FROM rpg.player_character_option
  WHERE character_id = OLD.character_id
    AND scope = 'class'::rpg.option_scope
    AND option_key = OLD.option_key;
  RETURN OLD;
END;
$$;

CREATE TRIGGER tr_pc_class_option_ins
  INSTEAD OF INSERT ON rpg.player_character_class_option
  FOR EACH ROW EXECUTE FUNCTION rpg.pc_class_option_ins();
CREATE TRIGGER tr_pc_class_option_upd
  INSTEAD OF UPDATE ON rpg.player_character_class_option
  FOR EACH ROW EXECUTE FUNCTION rpg.pc_class_option_upd();
CREATE TRIGGER tr_pc_class_option_del
  INSTEAD OF DELETE ON rpg.player_character_class_option
  FOR EACH ROW EXECUTE FUNCTION rpg.pc_class_option_del();
