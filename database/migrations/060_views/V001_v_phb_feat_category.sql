DROP VIEW IF EXISTS rpg.v_phb_feat_category;

-- VALUES view for feat category metadata
-- Lote A: replaces dropped phb_feat_category table

CREATE VIEW rpg.v_phb_feat_category AS
SELECT slug, name, type_label, sort_order FROM (VALUES
  ('origin'::rpg.feat_category, 'Origem', 'Talento de Origem', 1),
  ('general'::rpg.feat_category, 'Geral', 'Talento Geral', 2),
  ('fighting-style'::rpg.feat_category, 'Estilo de Luta', 'Talento de Estilo de Luta', 3),
  ('epic-boon'::rpg.feat_category, 'Dádiva Épica', 'Talento de Dádiva Épica', 4)
) AS t(slug, name, type_label, sort_order);
