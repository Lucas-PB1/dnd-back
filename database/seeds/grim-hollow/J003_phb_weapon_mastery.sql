-- Maestrias de arma avançadas (Grim Hollow Cap. 5)

INSERT INTO rpg.phb_weapon_mastery (slug, name, description)
VALUES
  ('brutal', 'Brutal', 'Quando você rola o dano de um ataque com esta arma, pode rolar novamente qualquer dado que mostrar 1 ou 2 no dano da arma e usar o novo resultado.'),
  ('defending', 'Defensiva', 'Se você atingir uma criatura com esta arma, pode usar uma Reação para ganhar +1 na CA contra ataques dessa criatura até o início do seu próximo turno.'),
  ('disarming', 'Desarmar', 'Se você atingir uma criatura com esta arma, pode forçá-la a fazer uma salvaguarda de Força; em falha, deixa cair um objeto que segura.'),
  ('entangling', 'Enredar', 'Se você atingir uma criatura com esta arma, pode restringir o movimento dela (condição Enredado ou redução de Deslocamento conforme a arma).'),
  ('returning', 'Retorno', 'Após arremessar esta arma, ela retorna à sua mão no final do seu turno se não houver obstáculo.'),
  ('set', 'Preparada', 'Se você não se moveu neste turno, o primeiro ataque com esta arma tem Vantagem.'),
  ('strong-draw', 'Tensão Forte', 'Se você não se moveu neste turno antes do ataque, adicione +2 à jogada de dano do ataque à distância.'),
  ('swift', 'Rápida', 'Após acertar um ataque com esta arma, você pode se mover até 3 metros sem provocar Ataques de Oportunidade.')
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;
