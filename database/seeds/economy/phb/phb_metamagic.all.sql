-- Metamagia PHB 2024 (S023 — Opções de Metamagia)

INSERT INTO rpg.phb_metamagic (
  slug, name, description, cost, stacks_with_other, sort_order
) VALUES
(
  'quickened-spell',
  'Magia Acelerada',
  'Custo: 2 Pontos de Feitiçaria. Ao conjurar uma magia com tempo de uma ação, altere para Ação Bônus nesta conjuração. Não pode modificar assim se já conjurou magia de 1º+ no turno, nem conjurar 1º+ depois.',
  2, false, 10
),
(
  'heightened-spell',
  'Magia Agravada',
  'Custo: 2 Pontos de Feitiçaria. Ao conjurar magia que força salvaguarda, conceda Desvantagem a um alvo na salvaguarda contra a magia.',
  2, false, 20
),
(
  'seeking-spell',
  'Magia Buscadora',
  'Custo: 1 Ponto de Feitiçaria. Ao errar uma jogada de ataque com magia, rejogue o d20 e use o novo resultado. Pode ser usada mesmo já tendo outra Metamagia na conjuração.',
  1, true, 30
),
(
  'careful-spell',
  'Magia Cautelosa',
  'Custo: 1 Ponto de Feitiçaria. Ao conjurar magia com salvaguarda, escolha até CAR (mín. 1) criaturas: elas passam automaticamente e não sofrem dano parcial se aplicável.',
  1, false, 40
),
(
  'distant-spell',
  'Magia Distante',
  'Custo: 1 Ponto de Feitiçaria. Dobra o alcance se for ≥1,5 m, ou torna Toque em 9 m.',
  1, false, 50
),
(
  'twinned-spell',
  'Magia Duplicada',
  'Custo: 1 Ponto de Feitiçaria. Em magia que pode atingir criatura adicional com círculo superior, aumente o círculo efetivo em 1 para esse fim.',
  1, false, 60
),
(
  'extended-spell',
  'Magia Persistente',
  'Custo: 1 Ponto de Feitiçaria. Dobra a duração (máx. 24 h) de magia com duração ≥1 minuto. Se exigir Concentração, Vantagem nas salvaguardas para mantê-la.',
  1, false, 70
),
(
  'empowered-spell',
  'Magia Potencializada',
  'Custo: 1 Ponto de Feitiçaria. Ao jogar dano de magia, rejogue até CAR (mín. 1) dados de dano e use os novos resultados. Pode empilhar com outra Metamagia.',
  1, true, 80
),
(
  'subtle-spell',
  'Magia Sutil',
  'Custo: 1 Ponto de Feitiçaria. Conjure sem componentes V, S ou M, exceto materiais consumidos ou com custo detalhado.',
  1, false, 90
),
(
  'transmuted-spell',
  'Magia Transmutada',
  'Custo: 1 Ponto de Feitiçaria. Troque o tipo de dano da magia entre Ácido, Elétrico, Gélido, Ígneo, Trovejante ou Venenoso.',
  1, false, 100
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description,
  cost = EXCLUDED.cost,
  stacks_with_other = EXCLUDED.stacks_with_other,
  sort_order = EXCLUDED.sort_order;
