-- Seed: Battle Master maneuvers

INSERT INTO rpg.phb_battle_master_maneuver (slug, name, description, timing, adds_to_damage, adds_to_attack)
VALUES
  ('parry', 'Aparar', 'Reação ao receber dano corpo a corpo: reduza o dano pelo Dado + FOR ou DES.', 'reaction', false, false),
  ('menacing-attack', 'Ataque Ameaçador', 'No acerto: +dado de dano; alvo faz salvaguarda de Sabedoria ou fica Amedrontado.', 'on_hit', true, false),
  ('sweeping-attack', 'Ataque de Varredura', 'No acerto corpo a corpo: outra criatura a 1,5 m sofre dano igual ao dado.', 'on_hit', false, false),
  ('lunging-attack', 'Ataque Estendido', 'Ação Bônus: gaste o dado e Corra; se mover 1,5 m em linha reta antes do ataque, +dado no dano.', 'bonus_action', true, false),
  ('distracting-attack', 'Ataque para Distrair', 'No acerto: +dado de dano; próximo ataque de outro atacante tem Vantagem.', 'on_hit', true, false),
  ('precision-attack', 'Ataque Preciso', 'No erro: adicione o dado à jogada de ataque.', 'on_miss', false, true),
  ('trip-attack', 'Ataque Derrubador', 'No acerto: +dado de dano; alvo Grande ou menor faz salvaguarda de Força ou fica Caído.', 'on_hit', true, false),
  ('pushing-attack', 'Ataque Empurrão', 'No acerto: +dado de dano; alvo Grande ou menor faz salvaguarda de Força ou é empurrado 4,5 m.', 'on_hit', true, false),
  ('riposte', 'Repostagem', 'Reação ao ser errado por ataque corpo a corpo: ataque com +dado no dano se acertar.', 'reaction', true, false),
  ('rally', 'Reunir', 'Ação Bônus: aliado ganha PV temporários iguais ao dado + modificador de Carisma.', 'bonus_action', false, false),
  ('commanders-strike', 'Golpe do Comandante', 'Ao atacar, abra mão de um ataque: aliado usa Reação para atacar com +dado no dano.', 'other', true, false),
  ('maneuvering-attack', 'Ataque de Manobra', 'No acerto: +dado de dano; aliado pode se mover metade do Deslocamento sem provocar AO.', 'on_hit', true, false),
  ('goading-attack', 'Ataque Provocador', 'No acerto: +dado de dano; alvo faz salvaguarda de Sabedoria ou tem Desvantagem contra outros.', 'on_hit', true, false),
  ('feinting-attack', 'Ataque Fintado', 'Ação Bônus: Vantagem no próximo ataque neste turno; +dado no dano se acertar.', 'bonus_action', true, false),
  ('evasive-footwork', 'Pés Escorregadios', 'Ao se mover: +dado na CA até o fim do movimento.', 'other', false, false),
  ('ambush', 'Emboscada', 'Ao fazer teste de Iniciativa ou Furtividade: +dado no teste.', 'other', false, false),
  ('bait-and-switch', 'Isca e Troca', 'Ao estar a 1,5 m de aliado voluntário: ambos se movem; você ou o aliado ganha +dado na CA.', 'other', false, false),
  ('commanding-presence', 'Presença Comandante', 'Ao falhar em Intimidação/Performance/Persuasão: +dado no teste.', 'other', false, false),
  ('tactical-assessment', 'Avaliação Tática', 'Ao falhar em História/Investigação/Insight: +dado no teste.', 'other', false, false),
  ('disarming-attack', 'Ataque Desarmador', 'No acerto: +dado de dano; alvo faz salvaguarda de Força ou solta um objeto.', 'on_hit', true, false)
ON CONFLICT (slug) DO UPDATE
  SET name = EXCLUDED.name,
      description = EXCLUDED.description,
      timing = EXCLUDED.timing,
      adds_to_damage = EXCLUDED.adds_to_damage,
      adds_to_attack = EXCLUDED.adds_to_attack;
