CREATE TABLE rpg.phb_class_panel_action (
  id              BIGSERIAL PRIMARY KEY,
  panel_key       TEXT UNIQUE NOT NULL,
  class_id        BIGINT NOT NULL REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  subclass_id     BIGINT NULL REFERENCES rpg.phb_subclass(id) ON DELETE CASCADE,
  slug            TEXT NOT NULL,
  name            TEXT NOT NULL,
  title           TEXT NULL,
  unlock_level    INT NOT NULL CHECK (unlock_level BETWEEN 1 AND 20),
  resource_slug   TEXT NULL,
  section         rpg.panel_action_section NOT NULL,
  spends_focus    BOOLEAN NOT NULL DEFAULT false,
  sort_order      INT NOT NULL DEFAULT 0
);

CREATE INDEX idx_class_panel_action_class ON rpg.phb_class_panel_action(class_id);
CREATE INDEX idx_class_panel_action_subclass ON rpg.phb_class_panel_action(subclass_id);

-- Economy actions: class XOR species; filtro opcional por escolha de espécie.









CREATE INDEX idx_class_economy_action_species
  ON rpg.phb_class_economy_action(species_id);

-- Recursos com dono talento (scope = feat).







CREATE UNIQUE INDEX uq_resource_feat
  ON rpg.phb_resource_definition (feat_id, slug)
  WHERE scope = 'feat';

-- Economy actions: class XOR species XOR feat.







CREATE INDEX idx_class_economy_action_feat
  ON rpg.phb_class_economy_action(feat_id);

-- Recursos com dono item (scope = item).







CREATE UNIQUE INDEX uq_resource_item
  ON rpg.phb_resource_definition (item_id, slug)
  WHERE scope = 'item';

-- Economy actions: class XOR species XOR feat XOR item.







CREATE INDEX idx_class_economy_action_item
  ON rpg.phb_class_economy_action(item_id);

-- Tipos + tabela de Invocações Místicas (Bruxo PHB 2024)
