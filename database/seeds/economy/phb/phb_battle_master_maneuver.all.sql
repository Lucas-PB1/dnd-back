-- Seed: Battle Master maneuvers

INSERT INTO rpg.phb_battle_master_maneuver (slug, name, description, timing, mesa_roll_kind, adds_to_damage, adds_to_attack)
VALUES
  ('parry', 'Aparar', 'Reação ao receber dano corpo a corpo: reduza o dano pelo Dado + FOR ou DES.', 'reaction', 'parry_reduce_damage', false, false),
  ('menacing-attack', 'Ataque Ameaçador', 'No acerto: +dado de dano; alvo faz salvaguarda de Sabedoria ou fica Amedrontado.', 'on_hit', 'superiority_die', true, false),
  ('sweeping-attack', 'Ataque de Varredura', 'No acerto corpo a corpo: outra criatura a 1,5 m sofre dano igual ao dado.', 'on_hit', 'superiority_die', false, false),
  ('lunging-attack', 'Ataque Estendido', 'Ação Bônus: gaste o dado e Corra; se mover 1,5 m em linha reta antes do ataque, +dado no dano.', 'bonus_action', 'superiority_die', true, false),
  ('distracting-attack', 'Ataque para Distrair', 'No acerto: +dado de dano; próximo ataque de outro atacante tem Vantagem.', 'on_hit', 'superiority_die', true, false),
  ('precision-attack', 'Ataque Preciso', 'No erro: adicione o dado à jogada de ataque.', 'on_miss', 'precision_add_attack', false, true),
  ('trip-attack', 'Ataque Derrubador', 'No acerto: +dado de dano; alvo Grande ou menor faz salvaguarda de Força ou fica Caído.', 'on_hit', 'superiority_die', true, false),
  ('pushing-attack', 'Ataque Empurrão', 'No acerto: +dado de dano; alvo Grande ou menor faz salvaguarda de Força ou é empurrado 4,5 m.', 'on_hit', 'superiority_die', true, false),
  ('riposte', 'Repostagem', 'Reação ao ser errado por ataque corpo a corpo: ataque com +dado no dano se acertar.', 'reaction', 'superiority_die', true, false),
  ('rally', 'Reunir', 'Ação Bônus: aliado ganha PV temporários iguais ao dado + modificador de Carisma.', 'bonus_action', 'rally_temp_hp', false, false),
  ('commanders-strike', 'Golpe do Comandante', 'Ao atacar, abra mão de um ataque: aliado usa Reação para atacar com +dado no dano.', 'other', 'superiority_die', true, false),
  ('maneuvering-attack', 'Ataque de Manobra', 'No acerto: +dado de dano; aliado pode se mover metade do Deslocamento sem provocar AO.', 'on_hit', 'superiority_die', true, false),
  ('goading-attack', 'Ataque Provocador', 'No acerto: +dado de dano; alvo faz salvaguarda de Sabedoria ou tem Desvantagem contra outros.', 'on_hit', 'superiority_die', true, false),
  ('feinting-attack', 'Ataque Fintado', 'Ação Bônus: Vantagem no próximo ataque neste turno; +dado no dano se acertar.', 'bonus_action', 'superiority_die', true, false),
  ('evasive-footwork', 'Pés Escorregadios', 'Ao se mover: +dado na CA até o fim do movimento.', 'other', 'superiority_die', false, false),
  ('ambush', 'Emboscada', 'Ao fazer teste de Iniciativa ou Furtividade: +dado no teste.', 'other', 'superiority_die', false, false),
  ('bait-and-switch', 'Isca e Troca', 'Ao estar a 1,5 m de aliado voluntário: ambos se movem; você ou o aliado ganha +dado na CA.', 'other', 'superiority_die', false, false),
  ('commanding-presence', 'Presença Comandante', 'Ao falhar em Intimidação/Performance/Persuasão: +dado no teste.', 'other', 'superiority_die', false, false),
  ('tactical-assessment', 'Avaliação Tática', 'Ao falhar em História/Investigação/Insight: +dado no teste.', 'other', 'superiority_die', false, false),
  ('disarming-attack', 'Ataque Desarmador', 'No acerto: +dado de dano; alvo faz salvaguarda de Força ou solta um objeto.', 'on_hit', 'superiority_die', true, false)
ON CONFLICT (slug) DO UPDATE
  SET name = EXCLUDED.name,
      description = EXCLUDED.description,
      timing = EXCLUDED.timing,
      mesa_roll_kind = EXCLUDED.mesa_roll_kind,
      adds_to_damage = EXCLUDED.adds_to_damage,
      adds_to_attack = EXCLUDED.adds_to_attack;
