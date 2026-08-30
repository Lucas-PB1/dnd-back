-- Remove antecedentes avançados incorretos (wiki Advanced Backgrounds)

DELETE FROM rpg.phb_background
WHERE slug IN ('gh-academic', 'gh-aristocrat', 'gh-clan-member', 'gh-clergy', 'gh-common-folk', 'gh-criminal', 'gh-militarist', 'gh-outlander', 'gh-pauper', 'gh-seafarer');
