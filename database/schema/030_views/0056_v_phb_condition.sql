CREATE VIEW rpg.v_phb_condition AS
SELECT slug, name FROM (VALUES
  ('blinded'::rpg.condition_slug, 'Cegueira'),
  ('charmed'::rpg.condition_slug, 'Enfeitiçado'),
  ('deafened'::rpg.condition_slug, 'Surdez'),
  ('exhaustion'::rpg.condition_slug, 'Exaustão'),
  ('frightened'::rpg.condition_slug, 'Amedrontado'),
  ('grappled'::rpg.condition_slug, 'Agarrado'),
  ('incapacitated'::rpg.condition_slug, 'Incapacitado'),
  ('invisible'::rpg.condition_slug, 'Invisível'),
  ('paralyzed'::rpg.condition_slug, 'Paralisado'),
  ('petrified'::rpg.condition_slug, 'Petrificado'),
  ('poisoned'::rpg.condition_slug, 'Envenenado'),
  ('prone'::rpg.condition_slug, 'Caído'),
  ('restrained'::rpg.condition_slug, 'Restringido'),
  ('stunned'::rpg.condition_slug, 'Atordoado'),
  ('unconscious'::rpg.condition_slug, 'Inconsciente')
) AS t(slug, name);


-- Campanhas: mesa, membros (mestre/jogador/auxiliar) e personagens vinculados.
-- Personagem continua do dono; pode estar em várias campanhas.
