-- Seed rpg.phb_geppettin_construction

INSERT INTO rpg.phb_geppettin_construction (slug, name, benefit)
VALUES
  (
    'bisque',
    'Porcelana',
    'Você é indistinguível de uma boneca de porcelana até o momento em que ataca. Sempre que você causa dano a uma criatura com uma jogada de ataque com arma em seu primeiro turno de combate, a criatura sofre dano extra igual ao seu Bônus de Proficiência. O dano é do mesmo tipo causado pela arma.'
  ),
  (
    'marionette',
    'Marionete',
    'Cordas soltas pendem de seus membros articulados. Durante o seu turno, seu alcance é 1,5 metro maior com qualquer arma corpo a corpo que não tenha as propriedades Alcance, Duas Mãos e Versátil.'
  ),
  (
    'plushie',
    'Pelúcia',
    'Você está cheio de penugem. Ao sofrer dano Contundente, você pode realizar uma Reação para ganhar Resistência ao dano desencadeado. Você também é empurrado 1,5 metro da fonte do dano. Você não pode realizar esta Reação se não puder ser afastado da fonte do dano.'
  )
ON CONFLICT (slug) DO UPDATE
SET
  name = EXCLUDED.name,
  benefit = EXCLUDED.benefit;
