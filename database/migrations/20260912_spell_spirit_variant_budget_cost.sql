-- Custo de orçamento por variante (Animar Objetos: Médio=1, Grande=2, Enorme=3).
ALTER TABLE rpg.phb_spell_spirit_variant
  ADD COLUMN IF NOT EXISTS budget_cost INT NOT NULL DEFAULT 1
    CHECK (budget_cost >= 1);
