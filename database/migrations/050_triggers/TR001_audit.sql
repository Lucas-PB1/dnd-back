-- Triggers updated_at em tabelas PHB

CREATE TRIGGER tr_phb_spell_updated_at BEFORE UPDATE ON rpg.phb_spell FOR EACH ROW EXECUTE FUNCTION rpg.set_updated_at();

CREATE TRIGGER tr_phb_class_updated_at BEFORE UPDATE ON rpg.phb_class FOR EACH ROW EXECUTE FUNCTION rpg.set_updated_at();

CREATE TRIGGER tr_phb_subclass_updated_at BEFORE UPDATE ON rpg.phb_subclass FOR EACH ROW EXECUTE FUNCTION rpg.set_updated_at();

CREATE TRIGGER tr_phb_species_updated_at BEFORE UPDATE ON rpg.phb_species FOR EACH ROW EXECUTE FUNCTION rpg.set_updated_at();

CREATE TRIGGER tr_phb_background_updated_at BEFORE UPDATE ON rpg.phb_background FOR EACH ROW EXECUTE FUNCTION rpg.set_updated_at();

CREATE TRIGGER tr_phb_feat_updated_at BEFORE UPDATE ON rpg.phb_feat FOR EACH ROW EXECUTE FUNCTION rpg.set_updated_at();

CREATE TRIGGER tr_phb_item_updated_at BEFORE UPDATE ON rpg.phb_item FOR EACH ROW EXECUTE FUNCTION rpg.set_updated_at();
