-- Função de auditoria updated_at

CREATE OR REPLACE FUNCTION rpg.set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
