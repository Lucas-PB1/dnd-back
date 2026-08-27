-- Benefícios PT das opções de subclasse Caçador (wizard preview).
-- Idempotente: só atualiza benefit quando o valor existir.

UPDATE rpg.phb_option_value v
SET benefit = u.benefit
FROM (VALUES
  ('hunter', 'huntersPrey', 'colossus-slayer',
   'Ao atingir com arma uma criatura com PV abaixo do máximo, causa +1d8 de dano (1× por turno).'),
  ('hunter', 'huntersPrey', 'horde-breaker',
   '1× por turno, ao atacar com arma, pode atacar outra criatura a 1,5 m do alvo original (mesmo alcance, ainda não atacada neste turno).'),
  ('hunter', 'defensiveTactics', 'multiattack-defense',
   'Ao ser atingido por uma criatura, ela tem Desvantagem nas demais jogadas de ataque contra você neste turno.'),
  ('hunter', 'defensiveTactics', 'escape-the-horde',
   'Ataques de Oportunidade têm Desvantagem contra você.')
) AS u(subclass_slug, option_key, value_id, benefit)
JOIN rpg.phb_subclass s ON s.slug = u.subclass_slug
WHERE v.scope = 'subclass'::rpg.option_scope
  AND v.owner_id = s.id
  AND v.option_key = u.option_key
  AND v.value_id = u.value_id;
