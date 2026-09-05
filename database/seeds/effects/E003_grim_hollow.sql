DELETE FROM rpg.phb_effect e
USING rpg.phb_feat f
WHERE e.owner_kind = 'feat'
  AND e.owner_id = f.id
  AND f.slug IN (
    'fortuneofthe-thaumaturge', 'resolutionofthe-syndicate', 'triage-expert',
    'blood-hound', 'deathbound', 'survivor', 'convincing-inquisitor',
    'free-sword-mercenarys-will', 'insightful-collector'
  );

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'fortuneofthe-thaumaturge'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'fortunes-fortitude'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 1, 1, 'Fortitude da Fortuna — usos'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'proficiency_bonus'::rpg.resource_max_formula, NULL,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'fortuneofthe-thaumaturge'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, resource_slug, unlock_level, sort_order, label
  )
  SELECT 'combat_note'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 'fortunes-fortitude', 1, 2,
         'Fortitude da Fortuna — oferta d20'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Toggle oferta (default on): em Teste d20, perguntar se usa Fortitude. Gasta 1 uso (fortunes-fortitude), rola DV e soma ao resultado. Morte: oferta na falha. Máx/mín no DV → recupera o DV (automático).'
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'resolutionofthe-syndicate'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'combat_mod'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 1, 'Resiliente'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_combat_mod (
  effect_id, mod_kind, flat_bonus, per_level_bonus, from_level
)
SELECT id, 'hp_bonus'::rpg.effect_combat_mod_kind, 0, 1, 1 FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'resolutionofthe-syndicate'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'scaled_damage_dice'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_damage_roll'::rpg.effect_trigger, 1, 2, 'Golpe Rápido'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Toggle: arma Golpe Rápido no próximo dano (1d4; 2d4 nv.9; 4d4 nv.16). Após aplicar, desarma. Sem start-of-turn.'
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'triage-expert'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT v.kind, 'feat'::rpg.effect_owner_kind, feat.id, 'passive'::rpg.effect_trigger,
         1, v.sort_order, v.label
  FROM feat CROSS JOIN (
    VALUES
      ('combat_note'::rpg.effect_kind, 1, 'Trato ao Paciente'),
      ('combat_note'::rpg.effect_kind, 2, 'Sangue e Osso')
  ) AS v(kind, sort_order, label)
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  CASE sort_order
    WHEN 1 THEN 'Trato ao Paciente: ao curar / Sangue e Osso, dado extra e descarte o menor (mesa: outra criatura rola — nota até fluxo tipado).'
    ELSE 'Sangue e Osso: Utilizar + Kit de Curandeiro; alvo a 1,5 m gasta DV e recupera PV iguais à rolagem (nota até mesa tipar).'
  END
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blood-hound'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'combat_note'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 1, 'Sensor de Movimento'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Sensor de Movimento: criatura P+ a 3 m → você fica imediatamente ciente da presença dela (se não Inconsciente).'
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blood-hound'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'check_advantage'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 2, 'Sem Esconderijo'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Circunstância: vantagem em Sabedoria (Percepção) que dependam de som ou olfato.'
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'deathbound'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'death_save_advantage'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_death_save'::rpg.effect_trigger, 1, 1, 'Um Último Suspiro'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Com 2 falhas em Salvaguardas contra Morte: vantagem nas death saves até sair de 0 PV.'
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'deathbound'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'hit_die_roll_twice_keep_high'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_rest_short'::rpg.effect_trigger, 1, 2, 'Recuperação'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Ao gastar DV no Descanso Curto: role 2× e use o maior (automático).'
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'survivor'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT v.kind, 'feat'::rpg.effect_owner_kind, feat.id, v.trigger::rpg.effect_trigger,
         1, v.sort_order, v.label
  FROM feat CROSS JOIN (
    VALUES
      ('combat_note'::rpg.effect_kind, 'passive', 1, 'Resistente'),
      ('check_advantage'::rpg.effect_kind, 'passive', 2, 'Intuitivo'),
      ('reduce_exhaustion_on_rest'::rpg.effect_kind, 'on_rest_short', 3, 'Sacudir — DC'),
      ('reduce_exhaustion_on_rest'::rpg.effect_kind, 'on_rest_long', 4, 'Sacudir — DL')
  ) AS v(kind, trigger, sort_order, label)
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  CASE sort_order
    WHEN 1 THEN 'Resistente: metade da comida diária (por tamanho).'
    WHEN 2 THEN 'Circunstância: vantagem em testes de Inteligência na ação Estudar (só se a rolagem marcar ação Estudar).'
    WHEN 3 THEN 'Sacudir: ao terminar Descanso Curto, −1 nível de Exaustão.'
    ELSE 'Sacudir: ao terminar Descanso Longo, −2 níveis de Exaustão.'
  END
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'survivor'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN feat ON feat.id = e.owner_id
  WHERE e.owner_kind = 'feat' AND e.kind = 'reduce_exhaustion_on_rest'
    AND e.trigger = 'on_rest_short'
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'fixed'::rpg.effect_amount_formula, 1 FROM fx;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'survivor'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN feat ON feat.id = e.owner_id
  WHERE e.owner_kind = 'feat' AND e.kind = 'reduce_exhaustion_on_rest'
    AND e.trigger = 'on_rest_long'
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'fixed'::rpg.effect_amount_formula, 2 FROM fx;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'convincing-inquisitor'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT v.kind, 'feat'::rpg.effect_owner_kind, feat.id, 'passive'::rpg.effect_trigger,
         1, v.sort_order, v.label
  FROM feat CROSS JOIN (
    VALUES
      ('combat_note'::rpg.effect_kind, 1, 'Presença Cativante'),
      ('choose_ability_for_check'::rpg.effect_kind, 2, 'Múltiplos Caminhos'),
      ('initiative_advantage_vs_target'::rpg.effect_kind, 3, 'Intuição Zelosa')
  ) AS v(kind, sort_order, label)
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  CASE sort_order
    WHEN 1 THEN 'Influenciar: sem Desvantagem vs Hostis; Vantagem vs Indiferentes (nota — atitude NPC).'
    WHEN 2 THEN 'Influenciar Intimidação/Persuasão: escolher qualquer atributo (sugerir o maior).'
    ELSE 'Procurar + Intuição (mentiras) sucesso → vantagem em Iniciativa vs alvo por 1 h.'
  END
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'free-sword-mercenarys-will'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT v.kind, 'feat'::rpg.effect_owner_kind, feat.id, 'passive'::rpg.effect_trigger,
         1, v.sort_order, v.label
  FROM feat CROSS JOIN (
    VALUES
      ('combat_note'::rpg.effect_kind, 1, 'Manter o Terreno'),
      ('check_advantage'::rpg.effect_kind, 2, 'Resoluto')
  ) AS v(kind, sort_order, label)
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  CASE sort_order
    WHEN 1 THEN 'Manter o Terreno: reação ao ser movido — reduz distância até seu Deslocamento (nota).'
    ELSE 'Oferta (toggle) em salvaguarda: se aplicaria condição → vantagem.'
  END
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'insightful-collector'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT v.kind, 'feat'::rpg.effect_owner_kind, feat.id, 'passive'::rpg.effect_trigger,
         1, v.sort_order, v.label
  FROM feat CROSS JOIN (
    VALUES
      ('identify_magic_item'::rpg.effect_kind, 1, 'Intuição de Objetos'),
      ('grant_magic_item_choice'::rpg.effect_kind, 2, 'Descoberta Rara')
  ) AS v(kind, sort_order, label)
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  CASE sort_order
    WHEN 1 THEN 'Ação Estudar objeto mágico: informar raridade; 5% cumulativo por raridade > Comum de errar. Não revela maldição.'
    ELSE 'Criação: escolher 1 item mágico de raridade Comum do catálogo (kind genérico por raridade).'
  END
FROM ins;

UPDATE rpg.phb_feat
SET name = 'Vontade do Mercenário'
WHERE slug = 'free-sword-mercenarys-will';

UPDATE rpg.phb_feat_benefit b
SET description =
  'Sempre que uma criatura Pequena ou maior se mover a até 3 m de você enquanto você não estiver com a condição Inconsciente, você fica imediatamente ciente da presença dela.'
FROM rpg.phb_feat f
WHERE b.feat_id = f.id
  AND f.slug = 'blood-hound'
  AND b.name = 'Sensor de Movimento';

DELETE FROM rpg.phb_effect e
USING rpg.phb_feat f
WHERE e.owner_kind = 'feat'
  AND e.owner_id = f.id
  AND f.slug IN (
    'blackpowder-pistol-expert', 'expanded-grip', 'hulking-figure', 'iron-gut',
    'lightning-caster', 'medicianofthe-morbus-doctore', 'nimble-physique',
    'sangromantic-initiate', 'shadowsteel-adept', 'shadowsteel-master',
    'syndicate-spy', 'thrown-weapon-master', 'witch-hunter'
  );

WITH rows(slug, sort_order, label, note) AS (
  VALUES
    ('blackpowder-pistol-expert', 10, 'Olho de Águia',
     'Olho de Águia: sem Desvantagem em alcance longo com pistola.'),
    ('blackpowder-pistol-expert', 11, 'Recarga Rápida',
     'Recarga Rápida: ignora propriedade Recarregar da pistola.'),
    ('expanded-grip', 10, 'Empunhadura a Uma Mão',
     'Empunhadura a Uma Mão: Versátil com uma mão usa dano entre parênteses.'),
    ('expanded-grip', 11, 'Agarre Zeloso',
     'Agarre Zeloso: CD 15 FOR para manter agarre; Vantagem em salvaguardas para não soltar.'),
    ('hulking-figure', 10, 'Brutal',
     'Brutal: 1×/turno +1d4 Contundente em Ataque Desarmado.'),
    ('hulking-figure', 11, 'Intimidante',
     'Intimidante: soma mod. FOR em Intimidação/Atuação/Persuasão.'),
    ('hulking-figure', 12, 'Poderoso',
     'Poderoso: conta como um tamanho maior (até Grande) para carga.'),
    ('iron-gut', 10, 'Imune a Veneno',
     'Imune a Veneno: Vantagem vs Envenenado.'),
    ('iron-gut', 11, 'Tudo Parece Delicioso',
     'Tudo Parece Delicioso: Vantagem em Sobrevivência para forragear.'),
    ('lightning-caster', 10, 'Alvo Duplo',
     'Alvo Duplo: truque 1 ação / 1 alvo → AB para 2º alvo no alcance (offer+toggle).'),
    ('lightning-caster', 11, 'Resposta Imediata',
     'Resposta Imediata: ao conjurar magia como Reação, free cast 1×/DL (grant_resource wire).'),
    ('medicianofthe-morbus-doctore', 10, 'Médico Habilidoso',
     'Médico Habilidoso: Sangue e Osso permite até 3 Dados de Vida.'),
    ('medicianofthe-morbus-doctore', 11, 'Cirurgião de Campo',
     'Cirurgião de Campo: Sangue e Osso pode curar Ferida Grave ou encerrar condição (3 DV).'),
    ('nimble-physique', 10, 'Esquivo',
     'Esquivo: sem armadura/Escudo → Desviar como Ação Bônus.'),
    ('nimble-physique', 11, 'Escorregadio',
     'Escorregadio: Agarrado/Impedido — ataques sem Desvantagem; inimigos sem Vantagem.'),
    ('sangromantic-initiate', 10, 'Magia de Sangue',
     'Magia de Sangue: 1 magia de Sangromancia preparada; 1×/DL sem espaço.'),
    ('sangromantic-initiate', 11, 'Potência Sanguínea',
     'Potência Sanguínea: pool de 2d12 no lugar de DV em magias de Sangromancia (recupera no DL).'),
    ('shadowsteel-adept', 10, 'Conjurador de Maldições',
     'Conjurador de Maldições: maldições Shadowsteel sempre preparadas.'),
    ('shadowsteel-adept', 11, 'Mordida de Shadowsteel',
     'Mordida de Shadowsteel: +1 ataque mágico e CD com foco.'),
    ('shadowsteel-adept', 12, 'Arma de Shadowsteel',
     'Arma de Shadowsteel: foco-arma +1 ataque e dano.'),
    ('shadowsteel-master', 10, 'Harmonia Necrótica',
     'Harmonia Necrótica: alvo de magia sofre +1d4 Necrótico/nível de espaço.'),
    ('shadowsteel-master', 11, 'Arma Necrótica',
     'Arma Necrótica: foco-arma +2; 1×/turno +2d8 Necrótico no acerto.'),
    ('syndicate-spy', 10, 'Chaveiro',
     'Chaveiro: prof. Ferramentas de Ladrão; fabrica chave em 10 min.'),
    ('syndicate-spy', 11, 'Mestre do Disfarce',
     'Mestre do Disfarce: prof. Kit de Disfarce; aparência customizável (10 min).'),
    ('syndicate-spy', 12, 'Mestre Calígrafo',
     'Mestre Calígrafo: prof. Kit de Falsificação; sem limite de 10 palavras.'),
    ('syndicate-spy', 13, 'Passar Despercebido',
     'Passar Despercebido: Esconder-se Levemente Obscurecido; pode usar Carisma.'),
    ('thrown-weapon-master', 10, 'Arremesso Múltiplo',
     'Arremesso Múltiplo: após Atacar com Arremesso simples → 2 ataques extras (AB).'),
    ('thrown-weapon-master', 11, 'Mãos Rápidas',
     'Mãos Rápidas: AB para pegar/guardar armas Arremesso simples a 1,5 m.'),
    ('thrown-weapon-master', 12, 'Retorno',
     'Retorno: arremesso simples proficiente ganha Retorno.'),
    ('witch-hunter', 10, 'Mantenha Inimigos Perto',
     'Mantenha Inimigos Perto: acerto corpo a corpo → −4,5 m Deslocamento do alvo.'),
    ('witch-hunter', 11, 'Resistir a Maldições',
     'Resistir a Maldições: Vantagem vs maldições Shadowsteel e magias >10 min.')
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'combat_note'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, f.id,
         'passive'::rpg.effect_trigger, 1, r.sort_order, r.label
  FROM rows r
  JOIN rpg.phb_feat f ON f.slug = r.slug
  RETURNING id, label
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT ins.id, r.note
FROM ins
JOIN rows r ON r.label = ins.label;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'expanded-grip'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'versatile_one_hand_full_damage'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 1, 'Versátil — uma mão'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, 'Versátil empunhada a uma mão usa dado entre parênteses (Agarre Zeloso = nota).' FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'hulking-figure'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT v.kind, 'feat'::rpg.effect_owner_kind, feat.id, 'passive'::rpg.effect_trigger,
         1, v.sort_order, v.label
  FROM feat CROSS JOIN (
    VALUES
      ('damage_bonus'::rpg.effect_kind, 1, 'Brutal — +1d4'),
      ('add_ability_mod_to_check'::rpg.effect_kind, 2, 'Intimidante'),
      ('carry_as_larger_size'::rpg.effect_kind, 3, 'Poderoso')
  ) AS v(kind, sort_order, label)
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  CASE sort_order
    WHEN 1 THEN 'Toggle 1×/turno: +1d4 Contundente em Ataque Desarmado.'
    WHEN 2 THEN 'Soma mod. FOR em Intimidação, Atuação e Persuasão.'
    ELSE 'Conta como um tamanho maior (até Grande) para carga.'
  END
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'iron-gut'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT v.kind, 'feat'::rpg.effect_owner_kind, feat.id, 'passive'::rpg.effect_trigger,
         1, v.sort_order, v.label
  FROM feat CROSS JOIN (
    VALUES
      ('check_advantage'::rpg.effect_kind, 1, 'Veneno'),
      ('check_advantage'::rpg.effect_kind, 2, 'Forragear'),
      ('combat_note'::rpg.effect_kind, 3, 'Recuperação Rápida')
  ) AS v(kind, sort_order, label)
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  CASE sort_order
    WHEN 1 THEN 'Vantagem vs Envenenado (salvaguardas e testes relacionados).'
    WHEN 2 THEN 'Vantagem em Sobrevivência para forragear (toggle offer).'
    ELSE 'AB: gaste 1 DV + mod. Con → cura (1×/DC ou DL; pool de uso em economy/mesa).'
  END
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'sangromantic-initiate'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'combat_note'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, v.sort_order, v.label
  FROM feat CROSS JOIN (
    VALUES
      (1, 'Magia de Sangromancia — tipado'),
      (2, 'Potência Sanguínea — pool')
  ) AS v(sort_order, label)
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  CASE sort_order
    WHEN 1 THEN '1 magia Sangromancia preparada; free 1/DL (grant_spell+option wire depois).'
    ELSE 'Pool 2d12 no lugar de DV em magias Sangromancia; recupera no DL (UI escolher pool ou DV).'
  END
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'shadowsteel-adept'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT v.kind, 'feat'::rpg.effect_owner_kind, feat.id, 'passive'::rpg.effect_trigger,
         1, v.sort_order, v.label
  FROM feat CROSS JOIN (
    VALUES
      ('grant_spell'::rpg.effect_kind, 1, 'Maldições Shadowsteel'),
      ('spell_attack_bonus'::rpg.effect_kind, 2, 'Mordida — ataque'),
      ('spell_save_dc_bonus'::rpg.effect_kind, 3, 'Mordida — CD'),
      ('attack_bonus'::rpg.effect_kind, 4, 'Arma — ataque'),
      ('damage_bonus'::rpg.effect_kind, 5, 'Arma — dano')
  ) AS v(kind, sort_order, label)
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  CASE sort_order
    WHEN 1 THEN 'Maldições Shadowsteel sempre preparadas (wire lista depois).'
    WHEN 2 THEN '+1 ataque mágico com foco Shadowsteel.'
    WHEN 3 THEN '+1 CD de magia com foco Shadowsteel.'
    WHEN 4 THEN '+1 ataque com foco-arma vinculada.'
    ELSE '+1 dano com foco-arma vinculada.'
  END
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'shadowsteel-master'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT v.kind, 'feat'::rpg.effect_owner_kind, feat.id, v.trigger::rpg.effect_trigger,
         1, v.sort_order, v.label
  FROM feat CROSS JOIN (
    VALUES
      ('damage_bonus'::rpg.effect_kind, 'on_damage_roll', 1, 'Harmonia Necrótica'),
      ('attack_bonus'::rpg.effect_kind, 'passive', 2, 'Arma Necrótica — ataque'),
      ('damage_bonus'::rpg.effect_kind, 'on_damage_roll', 3, 'Arma Necrótica — dano'),
      ('damage_bonus'::rpg.effect_kind, 'on_damage_roll', 4, 'Arma Necrótica — 2d8')
  ) AS v(kind, trigger, sort_order, label)
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  CASE sort_order
    WHEN 1 THEN '+1d4 Necrótico/nível de espaço (magias >1 alvo; rolagem separada).'
    WHEN 2 THEN 'Foco-arma +2 ataque (substitui Adept +1).'
    WHEN 3 THEN 'Foco-arma +2 dano (substitui Adept +1).'
    ELSE 'Toggle 1×/turno: +2d8 Necrótico no acerto com foco-arma.'
  END
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'blackpowder-pistol-expert'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'extra_melee_attack'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 1, 'Tiro Improvisado'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  'Reação: após inimigo mover a 1,5 m → ataque à distância com pistola (creature_moves_within_5ft).'
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'thrown-weapon-master'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT v.kind, 'feat'::rpg.effect_owner_kind, feat.id, 'passive'::rpg.effect_trigger,
         1, v.sort_order, v.label
  FROM feat CROSS JOIN (
    VALUES
      ('extra_melee_attack'::rpg.effect_kind, 1, 'Arremesso Múltiplo'),
      ('grant_weapon_property'::rpg.effect_kind, 2, 'Retorno')
  ) AS v(kind, sort_order, label)
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  CASE sort_order
    WHEN 1 THEN 'BA pós-Atacar com Arremesso simples: 2 ataques extras (count=2).'
    ELSE 'Arremesso simples proficiente: propriedade Retorno.'
  END
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'thrown-weapon-master'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN feat ON feat.id = e.owner_id
  WHERE e.owner_kind = 'feat' AND e.kind = 'grant_weapon_property'
)
INSERT INTO rpg.phb_effect_weapon (effect_id, property_slug)
SELECT id, 'returning' FROM fx;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'witch-hunter'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT v.kind, 'feat'::rpg.effect_owner_kind, feat.id, 'passive'::rpg.effect_trigger,
         1, v.sort_order, v.label
  FROM feat CROSS JOIN (
    VALUES
      ('reduce_target_speed_on_hit'::rpg.effect_kind, 1, 'Mantenha Inimigos Perto'),
      ('check_advantage'::rpg.effect_kind, 2, 'Resistir a Maldições')
  ) AS v(kind, sort_order, label)
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id,
  CASE sort_order
    WHEN 1 THEN 'Acerto corpo a corpo: −4,5 m Deslocamento do alvo (−15 ft interno).'
    ELSE 'Offer+toggle: Vantagem vs maldições Shadowsteel e magias >10 min.'
  END
FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'witch-hunter'),
fx AS (
  SELECT e.id FROM rpg.phb_effect e
  JOIN feat ON feat.id = e.owner_id
  WHERE e.owner_kind = 'feat' AND e.kind = 'reduce_target_speed_on_hit'
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'fixed'::rpg.effect_amount_formula, 15 FROM fx;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'iron-gut'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'iron-gut-quick-recover'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 4, 20, 'Recuperação Rápida — pool'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, TRUE, TRUE
FROM ins CROSS JOIN rd;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'lightning-caster'),
rd AS (SELECT id FROM rpg.phb_resource_definition WHERE slug = 'lightning-immediate-response'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_resource'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_build'::rpg.effect_trigger, 4, 20, 'Resposta Imediata — pool'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_resource (
  effect_id, resource_id, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT ins.id, rd.id, 'fixed'::rpg.resource_max_formula, 1,
       FALSE, FALSE, TRUE
FROM ins CROSS JOIN rd;

DELETE FROM rpg.phb_effect e
USING rpg.phb_feat f
WHERE e.owner_kind = 'feat'
  AND e.owner_id = f.id
  AND f.slug IN (
    'advanced-weapon-proficiency', 'close-combat-artillerist', 'dual-shot',
    'flurry', 'mobile-combatant', 'opportunist', 'prone-defense'
  );

WITH rows(slug, sort_order, label, note) AS (
  VALUES
    ('advanced-weapon-proficiency', 10, 'Armas Avançadas',
     'Proficiência com armas Avançadas e maestrias dessas armas.'),
    ('close-combat-artillerist', 10, 'Disparo em C/C',
     'Sem Desvantagem em ataques à distância a 1,5 m de inimigo.'),
    ('close-combat-artillerist', 11, 'Queima-roupa',
     '+2 dano em ataque à distância vs alvo a 1,5 m.'),
    ('dual-shot', 10, 'Tiro Duplo',
     'Ação Atacar com arco/besta: ataque extra vs criatura a ≤3 m do alvo (ambos c/ Desvantagem).'),
    ('flurry', 10, 'Golpe Rápido',
     '1×/turno com Vantagem: abrir mão da Vantagem → 2º ataque vs criatura diferente a 1,5 m.'),
    ('mobile-combatant', 10, 'Escorregadio',
     'Na ação Atacar: +3 m Deslocamento; OA têm Desvantagem contra você até fim do turno.'),
    ('opportunist', 10, 'Explorar Fraqueza',
     'Ataque como Reação: +2 ataque e +2 dano.'),
    ('prone-defense', 10, 'Defensivo Caído',
     'Caído: sem Desvantagem nos seus ataques; ataques contra você sem Vantagem por Caído.'),
    ('prone-defense', 11, 'Levantar-se',
     'Caído: levantar com 1,5 m de deslocamento.')
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'combat_note'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, f.id,
         'passive'::rpg.effect_trigger, 1, r.sort_order, r.label
  FROM rows r
  JOIN rpg.phb_feat f ON f.slug = r.slug
  RETURNING id, label
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT i.id, r.note
FROM ins i
JOIN rows r ON r.label = i.label;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'close-combat-artillerist'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'damage_bonus'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_damage_roll'::rpg.effect_trigger, 1, 2, 'Queima-roupa +2'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'fixed'::rpg.effect_amount_formula, 2 FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'opportunist'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'attack_bonus'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 1, 'Reação +2 ataque'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'fixed'::rpg.effect_amount_formula, 2 FROM ins;

INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT e.id, 'Escopo: ataque feito como Reação.'
FROM rpg.phb_effect e
JOIN rpg.phb_feat f ON f.id = e.owner_id
WHERE e.owner_kind = 'feat' AND e.label = 'Reação +2 ataque';

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'opportunist'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'damage_bonus'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'on_damage_roll'::rpg.effect_trigger, 1, 2, 'Reação +2 dano'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'fixed'::rpg.effect_amount_formula, 2 FROM ins;

DELETE FROM rpg.phb_effect e
USING rpg.phb_feat f
WHERE e.owner_kind = 'feat'
  AND e.owner_id = f.id
  AND f.slug IN (
    'boonofthe-archlich', 'boonofthe-ascended-vampire', 'boonofthe-earthly-tether',
    'boonofthe-elder-horror', 'boonofthe-elder-fey', 'boonofthe-elder-fiend',
    'boonofthe-elemental-temperance', 'boonofthe-high-seraph',
    'boonof-magic-resistance', 'boonof-perfect-flight',
    'boonof-shadowsteel-mastery', 'boonofthe-wilds'
  );

WITH rows(slug, sort_order, label, note) AS (
  VALUES
    ('boonofthe-archlich', 10, 'Vaso de Vitalidade',
     'Após DL: se Vaso da Alma não carregado, recebe alma e fica carregado.'),
    ('boonofthe-ascended-vampire', 10, 'Imune à Luz Solar',
     'Não é mais afetado pela luz solar.'),
    ('boonofthe-earthly-tether', 10, 'Assombração Persistente',
     'Não é mais afetado pela Falha Realidade Desfiada.'),
    ('boonofthe-earthly-tether', 11, 'Crescimento Espectro',
     'Ganha 1 Dádiva de Transformação Espectro ainda não tomada (prereqs).'),
    ('boonofthe-elder-horror', 10, 'Forma Estabilizada',
     'Ao rolar ≤25 em Forma Instável: rerrola (1×/DL).'),
    ('boonofthe-elder-horror', 11, 'Crescimento Horror',
     'Ganha 1 Dádiva de Transformação Horror Aberrante ainda não tomada.'),
    ('boonofthe-elder-fey', 10, 'Baluarte Fey',
     'Não é mais afetado pela Falha Constituição Enfraquecida.'),
    ('boonofthe-elder-fey', 11, 'Crescimento Fey',
     'Ganha 1 Dádiva de Transformação Fey ainda não tomada.'),
    ('boonofthe-elder-fiend', 10, 'Agente Livre',
     'Não é mais afetado pela Falha Puxão do Submundo.'),
    ('boonofthe-elder-fiend', 11, 'Crescimento Diabo',
     'Ganha 1 Dádiva de Transformação Diabo ainda não tomada.'),
    ('boonofthe-elemental-temperance', 10, 'Caos Controlado',
     'Não é mais afetado pela Falha Caos Primordial.'),
    ('boonofthe-high-seraph', 10, 'Absolvição',
     'Não é mais afetado pela Falha Corrupção Serafim.'),
    ('boonofthe-high-seraph', 11, 'Crescimento Serafim',
     'Ganha 1 Dádiva de Transformação Serafim ainda não tomada.'),
    ('boonof-magic-resistance', 10, 'Resistência Heroica (note)',
     'Falha em salvaguarda → sucesso; 1× até DC ou DL.'),
    ('boonof-perfect-flight', 10, 'Voo (note)',
     'Deslocamento de Voo 12 m; pode pairar.'),
    ('boonof-perfect-flight', 11, 'Queda Graciosa',
     'Queda >1,5 m: taxa ≤18 m/rodada até pousar.'),
    ('boonof-shadowsteel-mastery', 10, 'Estranhos Companheiros',
     'Não é mais afetado pela Falha Solitária.'),
    ('boonofthe-wilds', 10, 'Predador Supremo',
     'Forma Híbrida: +25 PV temp ao entrar; +10/turno se sem temp; Vantagem em ataques sem temp HP.')
),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'combat_note'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, f.id,
         'passive'::rpg.effect_trigger, 1, r.sort_order, r.label
  FROM rows r
  JOIN rpg.phb_feat f ON f.slug = r.slug
  RETURNING id, label
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT i.id, r.note
FROM ins i
JOIN rows r ON r.label = i.label;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'boonof-magic-resistance'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'succeed_failed_save'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 1, 'Resistência Heroica'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT id, '1× até DC ou DL: falha em salvaguarda → sucesso.' FROM ins;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'boonof-perfect-flight'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'grant_fly_speed'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 1, 'Voo 12 m'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'fixed'::rpg.effect_amount_formula, 40 FROM ins;

INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT e.id, '40 ft = 12 m; hover (grant_fly_speed).'
FROM rpg.phb_effect e
JOIN rpg.phb_feat f ON f.id = e.owner_id
WHERE e.owner_kind = 'feat' AND e.label = 'Voo 12 m';

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'boonof-perfect-flight'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'slow_fall'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 1, 2, 'Queda Graciosa tipada'
  FROM feat RETURNING id
)
INSERT INTO rpg.phb_effect_numeric (effect_id, amount_formula, flat)
SELECT id, 'fixed'::rpg.effect_amount_formula, 60 FROM ins;

INSERT INTO rpg.phb_effect_note (effect_id, note)
SELECT e.id, 'Cap 60 ft/rodada = 18 m (slow_fall).'
FROM rpg.phb_effect e
JOIN rpg.phb_feat f ON f.id = e.owner_id
WHERE e.owner_kind = 'feat' AND e.label = 'Queda Graciosa tipada';
