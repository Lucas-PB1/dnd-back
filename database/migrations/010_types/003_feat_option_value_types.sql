-- Tipos adicionais para opções de talentos (Magic Initiate, Skilled)

ALTER TYPE rpg.option_value_type ADD VALUE IF NOT EXISTS 'spell';
ALTER TYPE rpg.option_value_type ADD VALUE IF NOT EXISTS 'proficiency';
