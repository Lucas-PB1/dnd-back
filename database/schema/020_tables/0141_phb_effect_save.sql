-- Save tipado ligado a um effect (ex.: Topple CON vs CD 8+mod+PB).
CREATE TABLE rpg.phb_effect_save (
  effect_id BIGINT PRIMARY KEY
    REFERENCES rpg.phb_effect(id) ON DELETE CASCADE,
  save_ability rpg.save_ability NOT NULL,
  /** Atributo do atacante usado no CD (ex. força/destreza do ataque). */
  dc_ability rpg.save_ability NULL,
  dc_formula rpg.effect_amount_formula NOT NULL
    DEFAULT 'eight_plus_mod_plus_pb'
);
