-- Thread residual: brackets Cursemarked + notes de spend Fatebound.

UPDATE rpg.phb_character_thread_milestone_benefit b
SET
  bracket_max_kept = v.max_kept,
  bracket_roll_kinds = v.kinds::text[],
  bracket_trigger_note = v.trigger_note
FROM (
  VALUES
    (
      'tides-of-fate',
      3,
      ARRAY['save'],
      'Cursemarked — Marés do Destino: −3 m de deslocamento; aliado +3 m. Anti-overlap até o início do seu próximo turno.'
    ),
    (
      'burdens-shield',
      5,
      ARRAY['save', 'skill'],
      'Cursemarked — Escudo do Fardo: −2 CA; aliado +2 CA. Anti-overlap até o início do seu próximo turno.'
    ),
    (
      'threads-entwined',
      7,
      ARRAY['save', 'skill', 'attack'],
      'Cursemarked — Fios Entrelaçados: sem Ações Bônus/Reações; aliado ganha Reação (Disparar/Ajudar/Esconder-se/ataque). Anti-overlap até o início do seu próximo turno.'
    ),
    (
      'two-edged-gift',
      9,
      ARRAY['save', 'skill', 'attack'],
      'Cursemarked — Dádiva de Dois Gumes: metade do dano; próximo acerto do aliado causa dano máximo. Anti-overlap até o início do seu próximo turno.'
    )
) AS v(benefit_key, max_kept, kinds, trigger_note)
WHERE b.benefit_key = v.benefit_key;

UPDATE rpg.phb_character_thread_milestone_benefit b
SET spend_side_effect_note = v.note
FROM (
  VALUES
    ('doom-delayed', 'Ruína Adiada: estável a 0 PV (1/DL).'),
    (
      'last-act-of-fate',
      'Último Ato: 1 PV, condições limpas. Neste turno: imunidade + vantagem + dano +nível. Após o turno: morte permanente (mesa). Fim Glorioso: aliados testemunhas — vantagem em d20 por 24h.'
    ),
    (
      'glorious-end',
      'Fim Glorioso: aliados testemunhas — vantagem em testes d20 por 24 horas.'
    )
) AS v(benefit_key, note)
WHERE b.benefit_key = v.benefit_key;
