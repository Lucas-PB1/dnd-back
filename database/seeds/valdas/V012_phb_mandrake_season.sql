-- Seed rpg.phb_mandrake_season

INSERT INTO rpg.phb_mandrake_season (slug, name, benefit)
VALUES
  (
    'spring',
    'Primavera',
    'Suas Vinhas Enredantes podem atingir uma criatura aérea a até 9 metros do solo, que é puxada com segurança para o solo quando você usa esta característica.'
  ),
  (
    'summer',
    'Verão',
    'Suas Vinhas Enredantes podem mover o alvo até 3 metros para um espaço desocupado no chão.'
  ),
  (
    'autumn',
    'Outono',
    'Suas Vinhas Enredantes podem afetar uma segunda criatura a até 1,5 metro do primeiro alvo.'
  ),
  (
    'winter',
    'Inverno',
    'O alvo sofre dano Gélido igual ao seu Bônus de Proficiência.'
  )
ON CONFLICT (slug) DO UPDATE
SET
  name = EXCLUDED.name,
  benefit = EXCLUDED.benefit;
