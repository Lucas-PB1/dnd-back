-- Forward: kinds tipados para rotas estruturadas (Fonte de Magia, metamagia, pistoleiro, druida).

ALTER TYPE rpg.effect_kind ADD VALUE IF NOT EXISTS 'convert_spell_points';
ALTER TYPE rpg.effect_kind ADD VALUE IF NOT EXISTS 'catalog_metamagic';
ALTER TYPE rpg.effect_kind ADD VALUE IF NOT EXISTS 'firearm_reload';
ALTER TYPE rpg.effect_kind ADD VALUE IF NOT EXISTS 'firearm_fire';
ALTER TYPE rpg.effect_kind ADD VALUE IF NOT EXISTS 'wild_resurgence';
ALTER TYPE rpg.effect_kind ADD VALUE IF NOT EXISTS 'set_starry_form';
