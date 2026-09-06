CREATE TRIGGER tr_player_character_updated_at
  BEFORE UPDATE ON rpg.player_character
  FOR EACH ROW EXECUTE FUNCTION rpg.set_updated_at();

CREATE TRIGGER tr_campaign_updated_at
  BEFORE UPDATE ON rpg.campaign
  FOR EACH ROW EXECUTE FUNCTION rpg.set_updated_at();

CREATE TRIGGER tr_campaign_encounter_updated_at
  BEFORE UPDATE ON rpg.campaign_encounter
  FOR EACH ROW EXECUTE FUNCTION rpg.set_updated_at();

CREATE TRIGGER tr_game_actor_updated_at
  BEFORE UPDATE ON rpg.game_actor
  FOR EACH ROW EXECUTE FUNCTION rpg.set_updated_at();

CREATE TRIGGER tr_game_actor_state_updated_at
  BEFORE UPDATE ON rpg.game_actor_state
  FOR EACH ROW EXECUTE FUNCTION rpg.set_updated_at();
