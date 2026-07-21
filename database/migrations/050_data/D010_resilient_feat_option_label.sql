-- Resiliente — rótulo da opção de atributo (regra: sem prof. em salvaguarda da classe)

UPDATE rpg.phb_feat_option_def
SET label = 'Atributo (+1, sem proficiência em salvaguarda)'
WHERE feat_id = (SELECT id FROM rpg.phb_feat WHERE slug = 'resilient')
  AND option_key = 'abilityIncrease';
