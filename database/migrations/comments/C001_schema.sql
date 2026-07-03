-- Comentários de schema/colunas

COMMENT ON SCHEMA rpg IS 'D&D 5e PHB 2024 PT-BR — catálogo v4 (BIGINT + slug)';

COMMENT ON COLUMN rpg.phb_spell.slug IS 'Identificador canônico do JSON/API; imutável na prática';
