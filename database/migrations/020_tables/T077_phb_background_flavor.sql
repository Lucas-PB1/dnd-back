-- tagline + summary em phb_background (paridade com class/species)

ALTER TABLE rpg.phb_background
  ADD COLUMN IF NOT EXISTS tagline TEXT,
  ADD COLUMN IF NOT EXISTS summary TEXT;

UPDATE rpg.phb_background SET
  tagline = v.tagline,
  summary = v.summary
FROM (VALUES
  ('acolyte', 'Serviço no templo', 'Devoto de um culto que aprendeu a canalizar um pouco do poder divino.'),
  ('wanderer', 'Filho das ruas', 'Sobreviveu entre rejeitados — orgulho intacto e destino ainda em aberto.'),
  ('artisan', 'Aprendiz de ofício', 'Oficina, clientes exigentes e um olhar aguçado para o detalhe.'),
  ('entertainer', 'Palco e aplausos', 'Feiras itinerantes, corda bamba e a sede pelo próximo espetáculo.'),
  ('charlatan', 'Mentiras reconfortantes', 'Taverna em taverna, vendendo esperança embalada em meias-verdades.'),
  ('criminal', 'Becos e risco', 'Furtos, gangues ou a solidão do lobo — sempre um passo à frente da lei.'),
  ('hermit', 'Solidão contemplativa', 'Cabana ou mosteiro: horas a ponderar os mistérios da criação.'),
  ('scribe', 'Mão firme e tinta', 'Scriptorium, tomos e a disciplina de não deixar passar um erro.'),
  ('farmer', 'Perto da terra', 'Paciência, saúde e respeito pela generosidade — e pela ira — da natureza.'),
  ('guard', 'Olhos na muralha', 'Posto na torre: ameaças lá fora e encrenqueiros lá dentro.'),
  ('guide', 'Trilhas selvagens', 'Acampamento onde o saco de dormir pousa — e magia da natureza no caminho.'),
  ('sailor', 'Vento e convés', 'Portos, tempestades e histórias trocadas sob as ondas.'),
  ('merchant', 'Rotas e barganha', 'Caravanas, lojas e o pulso do comércio entre artesãos e clientes.'),
  ('noble', 'Castelo e corte', 'Educação privilegiada e lições de liderança observadas de perto.'),
  ('sage', 'Bibliotecas do multiverso', 'Noites entre livros, pergaminhos e os rudimentos da magia.'),
  ('soldier', 'Batalha no sangue', 'Treino desde a idade adulta — o reino protegido pela guerra.')
) AS v(slug, tagline, summary)
WHERE rpg.phb_background.slug = v.slug;
