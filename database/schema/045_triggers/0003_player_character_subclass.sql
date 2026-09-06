CREATE TRIGGER tr_player_character_subclass_class
  BEFORE INSERT OR UPDATE OF class_slug, subclass_slug
  ON rpg.player_character
  FOR EACH ROW EXECUTE FUNCTION rpg.enforce_pc_subclass_belongs_to_class();
