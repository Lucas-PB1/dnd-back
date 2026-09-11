-- Notas Northlands → phb_level_combat_note

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Fúria dos Gigantes: ao ativar Fúria, pode tornar-se Grande (equipamento cresce). Em Grande: carga ×2; Vantagem em FOR; +1 dado de dano em armas/Desarmado.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'path-of-the-titan'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Fúria dos Gigantes: ao ativar Fúria, pode tornar-se Grande (equipamento cresce). Em Grande: carga ×2; Vantagem em FOR; +1 dado de dano em armas/Desarmado.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Passos Esmagadores: atravessar espaço de criatura menor; inimigo — salv. FOR ou Caído e sem Reações.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'path-of-the-titan'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Passos Esmagadores: atravessar espaço de criatura menor; inimigo — salv. FOR ou Caído e sem Reações.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 10, 'Golpes Titânicos: Golpe Forçoso empurra o dobro; Golpe no Tendão — Velocidade 0 até o próximo turno do alvo.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'path-of-the-titan'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 10 AND n.note = 'Golpes Titânicos: Golpe Forçoso empurra o dobro; Golpe no Tendão — Velocidade 0 até o próximo turno do alvo.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 14, 'Fúria dos Titãs: ao ativar Fúria, pode tornar-se Enorme (carga ×3; alcance +1,5 m; +2 dados de dano).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'path-of-the-titan'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 14 AND n.note = 'Fúria dos Titãs: ao ativar Fúria, pode tornar-se Enorme (carga ×3; alcance +1,5 m; +2 dados de dano).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Nascido no Mar: Vantagem vs empurrão/Caído/movimento forçado; Vantagem ao pilotar veículo aquático.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'viking'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Nascido no Mar: Vantagem vs empurrão/Caído/movimento forçado; Vantagem ao pilotar veículo aquático.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Maestria Viking: 1×/turno +PB no dano com Machado de Batalha, Espada Longa ou Lança (se tiver maestria).', 1
FROM rpg.phb_subclass s WHERE s.slug = 'viking'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Maestria Viking: 1×/turno +PB no dano com Machado de Batalha, Espada Longa ou Lança (se tiver maestria).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 7, 'Investida Selvagem: ação Atacar — mover + ataque CA; no acerto, AB Disparar pelo espaço do alvo.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'viking'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 7 AND n.note = 'Investida Selvagem: ação Atacar — mover + ataque CA; no acerto, AB Disparar pelo espaço do alvo.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 10, 'Chamado das Terras Nórdicas: no DL escolha Matador de Dragões / Nadador / Frio / Matador de Trolls.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'viking'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 10 AND n.note = 'Chamado das Terras Nórdicas: no DL escolha Matador de Dragões / Nadador / Frio / Matador de Trolls.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 15, 'Represália do Saqueador: use a Economia (Reação; crítico + PV temp.).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'viking'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 15 AND n.note = 'Represália do Saqueador: use a Economia (Reação; crítico + PV temp.).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 18, 'Assalto Imparável: use a Economia (1×/DL).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'viking'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 18 AND n.note = 'Assalto Imparável: use a Economia (1×/DL).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Destruição Encorajadora / Guardião dos Mortos: use a Economia (Canalizar).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'oath-of-valhalla'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Destruição Encorajadora / Guardião dos Mortos: use a Economia (Canalizar).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 7, 'Aura Trovejante: você e aliados — Imunidade a Trovão na Aura de Proteção; montaria pode causar Trovão.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'oath-of-valhalla'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 7 AND n.note = 'Aura Trovejante: você e aliados — Imunidade a Trovão na Aura de Proteção; montaria pode causar Trovão.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 15, 'Alma Valorosa: ao reduzir inimigo a 0 PV (CA), aliados a 18 m — Vantagem 1 min; morte com Repouso Tranquilo.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'oath-of-valhalla'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 15 AND n.note = 'Alma Valorosa: ao reduzir inimigo a 0 PV (CA), aliados a 18 m — Vantagem 1 min; morte com Repouso Tranquilo.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 20, 'Espírito da Valquíria: use a Economia (forma 10 min).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'oath-of-valhalla'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 20 AND n.note = 'Espírito da Valquíria: use a Economia (forma 10 min).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Provocação Poética: Zombaria Perversa sempre preparada; falha na salv. — Desvantagem na próxima salv. de SAB/INT/CAR.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'skald'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Provocação Poética: Zombaria Perversa sempre preparada; falha na salv. — Desvantagem na próxima salv. de SAB/INT/CAR.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Treino Marcial: armas Marciais, armadura Média e Escudos; arma como Foco; 1 maestria de arma (troca no DL).', 1
FROM rpg.phb_subclass s WHERE s.slug = 'skald'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Treino Marcial: armas Marciais, armadura Média e Escudos; arma como Foco; 1 maestria de arma (troca no DL).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Runa de Bragi: use a Economia (Escárnio / Eloquência / Vitalidade).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'skald'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Runa de Bragi: use a Economia (Escárnio / Eloquência / Vitalidade).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 14, 'Sagas de Batalha: use a Economia (1 min de recitação; benefícios 1 h).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'skald'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 14 AND n.note = 'Sagas de Batalha: use a Economia (1 min de recitação; benefícios 1 h).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Fios da Teia: role 2d6 no DL (dado sobe L7/11/15). Reação: some/subtraia 1 Fio a ataque/dano/salv./teste a 18 m.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'nornbound'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Fios da Teia: role 2d6 no DL (dado sobe L7/11/15). Reação: some/subtraia 1 Fio a ataque/dano/salv./teste a 18 m.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Puxar os Fios: use a Economia (Canalizar — Vantagem a aliados).', 1
FROM rpg.phb_subclass s WHERE s.slug = 'nornbound'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Puxar os Fios: use a Economia (Canalizar — Vantagem a aliados).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Destino Entrelaçado: use a Economia (espaço → dano Força + cura/PV temp.).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'nornbound'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Destino Entrelaçado: use a Economia (espaço → dano Força + cura/PV temp.).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 17, 'Tecelão da Teia: ao Puxar os Fios, inimigos a 9 m — salv. CAR ou Desvantagem 1 min.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'nornbound'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 17 AND n.note = 'Tecelão da Teia: ao Puxar os Fios, inimigos a 9 m — salv. CAR ou Desvantagem 1 min.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Manto do Lobo: use a Economia (Forma Selvagem). Com Manto: bônus FOR (Atletismo/salv.) = mod. SAB; mordida espectral.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'circle-of-fenris'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Manto do Lobo: use a Economia (Forma Selvagem). Com Manto: bônus FOR (Atletismo/salv.) = mod. SAB; mordida espectral.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Manto Aprimorado: mordidas ×2 vs objetos; Visão no Escuro 18 m (ou +9 m); Velocidade +3 m.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'circle-of-fenris'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Manto Aprimorado: mordidas ×2 vs objetos; Visão no Escuro 18 m (ou +9 m); Velocidade +3 m.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 10, 'Defender a Alcateia: use a Economia (Reação — lobo fantasma 4d8 Força + Caído; L14: 6d8).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'circle-of-fenris'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 10 AND n.note = 'Defender a Alcateia: use a Economia (Reação — lobo fantasma 4d8 Força + Caído; L14: 6d8).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 14, 'Filhos do Grande Lobo: use a Economia (1×/dia ao assumir Manto — fenrikyn).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'circle-of-fenris'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 14 AND n.note = 'Filhos do Grande Lobo: use a Economia (1×/dia ao assumir Manto — fenrikyn).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Expertise Oculta: Arcanismo e Religião; pode usar CAR nesses testes se maior que INT.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'spirit-caller'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Expertise Oculta: Arcanismo e Religião; pode usar CAR nesses testes se maior que INT.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Orientação Espiritual: use a Economia (AB — Vantagem em perícia).', 1
FROM rpg.phb_subclass s WHERE s.slug = 'spirit-caller'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Orientação Espiritual: use a Economia (AB — Vantagem em perícia).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Aura Espiritual: use a Economia (2×/DL ou 3 Pontos de Feitiçaria).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'spirit-caller'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Aura Espiritual: use a Economia (2×/DL ou 3 Pontos de Feitiçaria).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 14, 'Segredos Espirituais: use a Economia (rerrolar falha; ou 3 PF).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'spirit-caller'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 14 AND n.note = 'Segredos Espirituais: use a Economia (rerrolar falha; ou 3 PF).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 18, 'Tempestade Espiritual: Aura 4,5 m; inimigo que entra/inicia — 2d8 Psíquico (1×/turno).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'spirit-caller'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 18 AND n.note = 'Tempestade Espiritual: Aura 4,5 m; inimigo que entra/inicia — 2d8 Psíquico (1×/turno).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Troca de Contexto: use a Economia (Reação — troca de lugar).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'trickster'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Troca de Contexto: use a Economia (Reação — troca de lugar).'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 3, 'Trapaça Ágil: prof. Prestidigitação; Vantagem ao trocar itens semelhantes.', 1
FROM rpg.phb_subclass s WHERE s.slug = 'trickster'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 3 AND n.note = 'Trapaça Ágil: prof. Prestidigitação; Vantagem ao trocar itens semelhantes.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 6, 'Troca Distante: alcance 9 m na Troca; ou Desvantagem na salv. + Invisível se falhar.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'trickster'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 6 AND n.note = 'Troca Distante: alcance 9 m na Troca; ou Desvantagem na salv. + Invisível se falhar.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 10, 'Irrealidade Dolorosa: sucesso auto ao Analisar ilusões; falha ao discernir — salv. SAB, 4d10 Psíquico + Atordoado.', 0
FROM rpg.phb_subclass s WHERE s.slug = 'trickster'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 10 AND n.note = 'Irrealidade Dolorosa: sucesso auto ao Analisar ilusões; falha ao discernir — salv. SAB, 4d10 Psíquico + Atordoado.'
  );

INSERT INTO rpg.phb_level_combat_note (owner_kind, class_id, subclass_id, unlock_level, note, sort_order)
SELECT 'subclass', NULL, s.id, 14, 'Arauto do Caos: use a Economia (1×/DC).', 0
FROM rpg.phb_subclass s WHERE s.slug = 'trickster'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_level_combat_note n
    WHERE n.subclass_id = s.id AND n.unlock_level = 14 AND n.note = 'Arauto do Caos: use a Economia (1×/DC).'
  );
