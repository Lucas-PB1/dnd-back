-- Fase 6 backfill: spell_slug em varinhas/cajados com magia PHB nomeada.
-- Fora: efeitos de item, Magi custo 0 (sem resource), Magificado (bound), Orcus multi, Maravilhas.
-- Cast: spend < nível da magia → upcast por carga (ex. Relâmpagos/Cuspidora).

UPDATE rpg.phb_class_economy_action SET spell_slug = 'detectar-magia'
WHERE action_id = 'item-varinha-farejadora-de-magias-usar';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'paralisar-pessoa'
WHERE action_id = 'item-varinha-imobilizadora-paralisar-pessoa';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'paralisar-monstro'
WHERE action_id = 'item-varinha-imobilizadora-paralisar-monstro';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'comando'
WHERE action_id = 'item-varinha-do-medo-comando';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'medo'
WHERE action_id = 'item-varinha-do-medo-medo';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'misseis-magicos'
WHERE action_id IN (
  'item-varinha-de-misseis-magicos-1',
  'item-varinha-de-misseis-magicos-2',
  'item-varinha-de-misseis-magicos-3'
);

UPDATE rpg.phb_class_economy_action SET spell_slug = 'curar-ferimentos'
WHERE action_id IN (
  'item-cajado-da-cura-ferimentos-1',
  'item-cajado-da-cura-ferimentos-2',
  'item-cajado-da-cura-ferimentos-3',
  'item-cajado-da-cura-ferimentos-4'
);

UPDATE rpg.phb_class_economy_action SET spell_slug = 'restauracao-menor'
WHERE action_id = 'item-cajado-da-cura-restauracao-menor';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'curar-ferimentos-em-massa'
WHERE action_id = 'item-cajado-da-cura-ferimentos-massa';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'maos-flamejantes'
WHERE action_id = 'item-cajado-do-fogo-maos-flamejantes';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'bola-de-fogo'
WHERE action_id = 'item-cajado-do-fogo-bola-de-fogo';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'muralha-de-fogo'
WHERE action_id = 'item-cajado-do-fogo-muralha-de-fogo';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'nevoa-obscurecente'
WHERE action_id = 'item-cajado-do-gelo-nevoa';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'muralha-de-gelo'
WHERE action_id = 'item-cajado-do-gelo-muralha';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'tempestade-glacial'
WHERE action_id = 'item-cajado-do-gelo-tempestade';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'cone-de-frio'
WHERE action_id = 'item-cajado-do-gelo-cone-frio';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'inseto-gigante'
WHERE action_id = 'item-cajado-do-enxame-inseto-gigante';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'praga-de-insetos'
WHERE action_id = 'item-cajado-do-enxame-praga';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'comando'
WHERE action_id = 'item-cajado-dos-sortilegios-comando';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'compreender-idiomas'
WHERE action_id = 'item-cajado-dos-sortilegios-compreender';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'enfeiticar-pessoa'
WHERE action_id = 'item-cajado-dos-sortilegios-enfeiticar';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'amizade-animal'
WHERE action_id = 'item-cajado-das-matas-amizade-animal';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'falar-com-animais'
WHERE action_id = 'item-cajado-das-matas-falar-animais';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'localizar-animais-ou-plantas'
WHERE action_id = 'item-cajado-das-matas-localizar';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'passo-sem-rastro'
WHERE action_id = 'item-cajado-das-matas-passo-sem-rastro';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'pele-casca'
WHERE action_id = 'item-cajado-das-matas-pele-casca';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'falar-com-plantas'
WHERE action_id = 'item-cajado-das-matas-falar-plantas';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'despertar'
WHERE action_id = 'item-cajado-das-matas-despertar';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'muralha-de-espinhos'
WHERE action_id = 'item-cajado-das-matas-muralha-espinhos';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'misseis-magicos'
WHERE action_id = 'item-cajado-do-poder-misseis';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'raio-do-enfraquecimento'
WHERE action_id = 'item-cajado-do-poder-raio-enfraquecimento';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'levitacao'
WHERE action_id = 'item-cajado-do-poder-levitacao';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'bola-de-fogo'
WHERE action_id = 'item-cajado-do-poder-bola-fogo';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'cone-de-frio'
WHERE action_id = 'item-cajado-do-poder-cone-frio';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'muralha-de-energia'
WHERE action_id = 'item-cajado-do-poder-muralha-energia';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'paralisar-monstro'
WHERE action_id = 'item-cajado-do-poder-paralisar';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'relampago'
WHERE action_id = 'item-cajado-do-poder-relampago';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'globo-de-invulnerabilidade'
WHERE action_id = 'item-cajado-do-poder-globo';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'arrombar'
WHERE action_id = 'item-cajado-dos-magi-arrombar';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'esfera-flamejante'
WHERE action_id = 'item-cajado-dos-magi-esfera-flamejante';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'invisibilidade'
WHERE action_id = 'item-cajado-dos-magi-invisibilidade';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'teia'
WHERE action_id = 'item-cajado-dos-magi-teia';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'dissipar-magia'
WHERE action_id = 'item-cajado-dos-magi-dissipar';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'muralha-de-fogo'
WHERE action_id = 'item-cajado-dos-magi-muralha-fogo';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'tempestade-glacial'
WHERE action_id = 'item-cajado-dos-magi-tempestade-glacial';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'criar-passagem'
WHERE action_id = 'item-cajado-dos-magi-criar-passagem';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'telecinese'
WHERE action_id = 'item-cajado-dos-magi-telecinese';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'bola-de-fogo'
WHERE action_id = 'item-cajado-dos-magi-bola-fogo';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'relampago'
WHERE action_id = 'item-cajado-dos-magi-relampago';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'invocar-elemental'
WHERE action_id = 'item-cajado-dos-magi-invocar-elemental';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'transicao-planar'
WHERE action_id = 'item-cajado-dos-magi-transicao-planar';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'teia'
WHERE action_id = 'item-varinha-de-teia-usar';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'polimorfia'
WHERE action_id = 'item-varinha-de-polimorfia-usar';

UPDATE rpg.phb_class_economy_action SET spell_slug = 'relampago'
WHERE action_id IN (
  'item-varinha-de-relampagos-1',
  'item-varinha-de-relampagos-2',
  'item-varinha-de-relampagos-3'
);

UPDATE rpg.phb_class_economy_action SET spell_slug = 'bola-de-fogo'
WHERE action_id IN (
  'item-varinha-cuspidora-de-fogo-1',
  'item-varinha-cuspidora-de-fogo-2',
  'item-varinha-cuspidora-de-fogo-3'
);
