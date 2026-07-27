-- Seed rpg.phb_spell save_ability / requires_attack_roll
-- Gerado por scripts/generate-spell-save-seed.mjs — revisar ambíguos se necessário

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'carisma'),
    requires_attack_roll = FALSE
WHERE slug = 'acalmar-emocoes';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'),
    requires_attack_roll = TRUE
WHERE slug = 'amigos';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'),
    requires_attack_roll = FALSE
WHERE slug = 'amizade-animal';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'carisma'),
    requires_attack_roll = FALSE
WHERE slug = 'ancora-planar';

UPDATE rpg.phb_spell
SET save_ability_id = NULL,
    requires_attack_roll = TRUE
WHERE slug = 'animar-objetos';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'),
    requires_attack_roll = FALSE
WHERE slug = 'antipatia-simpatia';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'),
    requires_attack_roll = FALSE
WHERE slug = 'aprisionamento';

UPDATE rpg.phb_spell
SET save_ability_id = NULL,
    requires_attack_roll = TRUE
WHERE slug = 'armadura-de-agathys';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'),
    requires_attack_roll = FALSE
WHERE slug = 'assassino-fantasmagorico';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'constituicao'),
    requires_attack_roll = FALSE
WHERE slug = 'aumentar-reduzir';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'constituicao'),
    requires_attack_roll = TRUE
WHERE slug = 'aura-sagrada';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'),
    requires_attack_roll = FALSE
WHERE slug = 'badalar-funebre';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'carisma'),
    requires_attack_roll = FALSE
WHERE slug = 'banimento';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'),
    requires_attack_roll = FALSE
WHERE slug = 'barreira-de-laminas';

UPDATE rpg.phb_spell
SET save_ability_id = NULL,
    requires_attack_roll = TRUE
WHERE slug = 'bencao';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'),
    requires_attack_roll = FALSE
WHERE slug = 'bola-de-fogo-adiavel';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'),
    requires_attack_roll = FALSE
WHERE slug = 'bolha-acida';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'forca'),
    requires_attack_roll = FALSE
WHERE slug = 'bracos-de-hadar';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'),
    requires_attack_roll = FALSE
WHERE slug = 'cao-fiel-de-mordenkainen';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'carisma'),
    requires_attack_roll = FALSE
WHERE slug = 'carcere-de-energia';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'constituicao'),
    requires_attack_roll = FALSE
WHERE slug = 'cegueira-surdez';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'),
    requires_attack_roll = FALSE
WHERE slug = 'chama-sagrada';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'),
    requires_attack_roll = FALSE
WHERE slug = 'chuva-de-meteoros';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'carisma'),
    requires_attack_roll = FALSE
WHERE slug = 'circulo-magico';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'),
    requires_attack_roll = FALSE
WHERE slug = 'coluna-de-chamas';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'),
    requires_attack_roll = FALSE
WHERE slug = 'comando';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'constituicao'),
    requires_attack_roll = FALSE
WHERE slug = 'cone-de-frio';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'),
    requires_attack_roll = FALSE
WHERE slug = 'confusao';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'constituicao'),
    requires_attack_roll = FALSE
WHERE slug = 'contagio';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'inteligencia'),
    requires_attack_roll = FALSE
WHERE slug = 'contato-extraplanar';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'constituicao'),
    requires_attack_roll = FALSE
WHERE slug = 'contramagia';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'forca'),
    requires_attack_roll = FALSE
WHERE slug = 'controlar-agua';

UPDATE rpg.phb_spell
SET save_ability_id = NULL,
    requires_attack_roll = TRUE
WHERE slug = 'convocar-celestial';

UPDATE rpg.phb_spell
SET save_ability_id = NULL,
    requires_attack_roll = TRUE
WHERE slug = 'convocar-elemental';

UPDATE rpg.phb_spell
SET save_ability_id = NULL,
    requires_attack_roll = TRUE
WHERE slug = 'convocar-feerico';

UPDATE rpg.phb_spell
SET save_ability_id = NULL,
    requires_attack_roll = TRUE
WHERE slug = 'convocar-montaria';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'),
    requires_attack_roll = FALSE
WHERE slug = 'convocar-relampagos';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'),
    requires_attack_roll = FALSE
WHERE slug = 'cordao-de-flechas';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'),
    requires_attack_roll = FALSE
WHERE slug = 'coroa-da-loucura';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'),
    requires_attack_roll = FALSE
WHERE slug = 'corrente-de-relampagos';

UPDATE rpg.phb_spell
SET save_ability_id = NULL,
    requires_attack_roll = TRUE
WHERE slug = 'danacao';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'),
    requires_attack_roll = FALSE
WHERE slug = 'danca-irresistivel-de-otto';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'constituicao'),
    requires_attack_roll = FALSE
WHERE slug = 'de-carne-para-pedra';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'constituicao'),
    requires_attack_roll = FALSE
WHERE slug = 'dedo-da-morte';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'),
    requires_attack_roll = FALSE
WHERE slug = 'defensor-da-fe';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'),
    requires_attack_roll = FALSE
WHERE slug = 'desintegrar';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'constituicao'),
    requires_attack_roll = FALSE
WHERE slug = 'despedacar';

UPDATE rpg.phb_spell
SET save_ability_id = NULL,
    requires_attack_roll = TRUE
WHERE slug = 'despistar';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'),
    requires_attack_roll = FALSE
WHERE slug = 'destruicao-atordoante';

UPDATE rpg.phb_spell
SET save_ability_id = NULL,
    requires_attack_roll = TRUE
WHERE slug = 'destruicao-banidora';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'constituicao'),
    requires_attack_roll = FALSE
WHERE slug = 'destruicao-cauterizante';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'constituicao'),
    requires_attack_roll = FALSE
WHERE slug = 'destruicao-cegante';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'),
    requires_attack_roll = FALSE
WHERE slug = 'destruicao-colerica';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'forca'),
    requires_attack_roll = FALSE
WHERE slug = 'destruicao-estrondosa';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'),
    requires_attack_roll = FALSE
WHERE slug = 'detectar-pensamentos';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'carisma'),
    requires_attack_roll = FALSE
WHERE slug = 'dissipar-o-bem-e-o-mal';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'),
    requires_attack_roll = FALSE
WHERE slug = 'dominar-fera';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'),
    requires_attack_roll = FALSE
WHERE slug = 'dominar-monstro';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'),
    requires_attack_roll = FALSE
WHERE slug = 'dominar-pessoa';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'),
    requires_attack_roll = TRUE
WHERE slug = 'duelo-compelido';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'forca'),
    requires_attack_roll = FALSE
WHERE slug = 'emaranhar';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'),
    requires_attack_roll = FALSE
WHERE slug = 'encarnacao-fantasmagorica';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'),
    requires_attack_roll = FALSE
WHERE slug = 'enfeiticar-monstro';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'),
    requires_attack_roll = FALSE
WHERE slug = 'enfeiticar-pessoa';

UPDATE rpg.phb_spell
SET save_ability_id = NULL,
    requires_attack_roll = TRUE
WHERE slug = 'escudo-arcano';

UPDATE rpg.phb_spell
SET save_ability_id = NULL,
    requires_attack_roll = TRUE
WHERE slug = 'escudo-ardente';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'constituicao'),
    requires_attack_roll = FALSE
WHERE slug = 'esfera-congelante-de-otiluke';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'),
    requires_attack_roll = FALSE
WHERE slug = 'esfera-flamejante';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'),
    requires_attack_roll = FALSE
WHERE slug = 'esfera-resiliente-de-otiluke';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'),
    requires_attack_roll = FALSE
WHERE slug = 'esfera-vitriolica';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'),
    requires_attack_roll = FALSE
WHERE slug = 'espinho-mental';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'constituicao'),
    requires_attack_roll = FALSE
WHERE slug = 'esquentar-metal';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'inteligencia'),
    requires_attack_roll = FALSE
WHERE slug = 'estatica-sinaptica';

UPDATE rpg.phb_spell
SET save_ability_id = NULL,
    requires_attack_roll = TRUE
WHERE slug = 'explosao-elemental';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'constituicao'),
    requires_attack_roll = FALSE
WHERE slug = 'explosao-solar';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'),
    requires_attack_roll = FALSE
WHERE slug = 'flecha-relampago';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'),
    requires_attack_roll = FALSE
WHERE slug = 'fogo-das-fadas';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'),
    requires_attack_roll = FALSE
WHERE slug = 'fome-de-hadar';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'constituicao'),
    requires_attack_roll = FALSE
WHERE slug = 'fonte-do-luar';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'inteligencia'),
    requires_attack_roll = FALSE
WHERE slug = 'forca-espectral';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'),
    requires_attack_roll = FALSE
WHERE slug = 'gargalhada-nefasta-de-tasha';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'),
    requires_attack_roll = FALSE
WHERE slug = 'glifo-de-protecao';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'forca'),
    requires_attack_roll = FALSE
WHERE slug = 'golpe-constritor';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'),
    requires_attack_roll = FALSE
WHERE slug = 'graxa';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'constituicao'),
    requires_attack_roll = FALSE
WHERE slug = 'infligir-ferimentos';

UPDATE rpg.phb_spell
SET save_ability_id = NULL,
    requires_attack_roll = TRUE
WHERE slug = 'inseto-gigante';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'),
    requires_attack_roll = FALSE
WHERE slug = 'inverter-a-gravidade';

UPDATE rpg.phb_spell
SET save_ability_id = NULL,
    requires_attack_roll = TRUE
WHERE slug = 'invisibilidade';

UPDATE rpg.phb_spell
SET save_ability_id = NULL,
    requires_attack_roll = TRUE
WHERE slug = 'invocar-aberracao';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'),
    requires_attack_roll = FALSE
WHERE slug = 'invocar-animais';

UPDATE rpg.phb_spell
SET save_ability_id = NULL,
    requires_attack_roll = TRUE
WHERE slug = 'invocar-constructo';

UPDATE rpg.phb_spell
SET save_ability_id = NULL,
    requires_attack_roll = TRUE
WHERE slug = 'invocar-dragao';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'),
    requires_attack_roll = FALSE
WHERE slug = 'invocar-elemental';

UPDATE rpg.phb_spell
SET save_ability_id = NULL,
    requires_attack_roll = TRUE
WHERE slug = 'invocar-infero';

UPDATE rpg.phb_spell
SET save_ability_id = NULL,
    requires_attack_roll = TRUE
WHERE slug = 'invocar-morto-vivo';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'),
    requires_attack_roll = FALSE
WHERE slug = 'invocar-saraivada';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'),
    requires_attack_roll = FALSE
WHERE slug = 'invocar-seres-da-floresta';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'),
    requires_attack_roll = FALSE
WHERE slug = 'lentidao';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'constituicao'),
    requires_attack_roll = FALSE
WHERE slug = 'leque-cromatico';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'constituicao'),
    requires_attack_roll = FALSE
WHERE slug = 'levitacao';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'forca'),
    requires_attack_roll = FALSE
WHERE slug = 'lufada-de-vento';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'constituicao'),
    requires_attack_roll = FALSE
WHERE slug = 'malogro';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'),
    requires_attack_roll = FALSE
WHERE slug = 'mao-de-bigby';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'),
    requires_attack_roll = FALSE
WHERE slug = 'maos-flamejantes';

UPDATE rpg.phb_spell
SET save_ability_id = NULL,
    requires_attack_roll = TRUE
WHERE slug = 'marca-do-predador';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'),
    requires_attack_roll = FALSE
WHERE slug = 'mau-olhado';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'),
    requires_attack_roll = FALSE
WHERE slug = 'medo';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'carisma'),
    requires_attack_roll = FALSE
WHERE slug = 'mensageiro-animal';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'),
    requires_attack_roll = FALSE
WHERE slug = 'missao';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'),
    requires_attack_roll = FALSE
WHERE slug = 'modificar-memoria';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'constituicao'),
    requires_attack_roll = FALSE
WHERE slug = 'molestia';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'),
    requires_attack_roll = FALSE
WHERE slug = 'muralha-de-espinhos';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'),
    requires_attack_roll = FALSE
WHERE slug = 'muralha-de-fogo';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'),
    requires_attack_roll = FALSE
WHERE slug = 'muralha-de-gelo';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'),
    requires_attack_roll = FALSE
WHERE slug = 'muralha-de-pedra';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'forca'),
    requires_attack_roll = FALSE
WHERE slug = 'muralha-de-vento';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'constituicao'),
    requires_attack_roll = FALSE
WHERE slug = 'muralha-prismatica';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'),
    requires_attack_roll = FALSE
WHERE slug = 'nevasca';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'constituicao'),
    requires_attack_roll = FALSE
WHERE slug = 'nuvem-fetida';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'),
    requires_attack_roll = FALSE
WHERE slug = 'nuvem-incendiaria';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'constituicao'),
    requires_attack_roll = FALSE
WHERE slug = 'onda-destrutiva';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'constituicao'),
    requires_attack_roll = FALSE
WHERE slug = 'onda-trovejante';

UPDATE rpg.phb_spell
SET save_ability_id = NULL,
    requires_attack_roll = TRUE
WHERE slug = 'orbe-cromatico';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'),
    requires_attack_roll = FALSE
WHERE slug = 'padrao-hipnotico';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'constituicao'),
    requires_attack_roll = FALSE
WHERE slug = 'palavra-de-poder-atordoar';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'constituicao'),
    requires_attack_roll = FALSE
WHERE slug = 'palavra-de-radiancia';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'carisma'),
    requires_attack_roll = FALSE
WHERE slug = 'palavra-sagrada';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'),
    requires_attack_roll = FALSE
WHERE slug = 'paralisar-pessoa';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'carisma'),
    requires_attack_roll = TRUE
WHERE slug = 'perdicao';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'),
    requires_attack_roll = FALSE
WHERE slug = 'polimorfia';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'),
    requires_attack_roll = FALSE
WHERE slug = 'polimorfia-total';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'constituicao'),
    requires_attack_roll = FALSE
WHERE slug = 'praga-de-insetos';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'),
    requires_attack_roll = FALSE
WHERE slug = 'presenca-regia-de-yolande';

UPDATE rpg.phb_spell
SET save_ability_id = NULL,
    requires_attack_roll = TRUE
WHERE slug = 'protecao-contra-laminas';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'constituicao'),
    requires_attack_roll = TRUE
WHERE slug = 'raio-do-enfraquecimento';

UPDATE rpg.phb_spell
SET save_ability_id = NULL,
    requires_attack_roll = TRUE
WHERE slug = 'raio-guia';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'constituicao'),
    requires_attack_roll = FALSE
WHERE slug = 'raio-lunar';

UPDATE rpg.phb_spell
SET save_ability_id = NULL,
    requires_attack_roll = TRUE
WHERE slug = 'raio-mistico';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'constituicao'),
    requires_attack_roll = FALSE
WHERE slug = 'raio-solar';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'),
    requires_attack_roll = FALSE
WHERE slug = 'rajada-prismatica';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'carisma'),
    requires_attack_roll = FALSE
WHERE slug = 'receptaculo-arcano';

UPDATE rpg.phb_spell
SET save_ability_id = NULL,
    requires_attack_roll = TRUE
WHERE slug = 'reflexos';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'),
    requires_attack_roll = FALSE
WHERE slug = 'relampago';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'),
    requires_attack_roll = FALSE
WHERE slug = 'repreensao-diabolica';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'),
    requires_attack_roll = TRUE
WHERE slug = 'rogar-maldicao';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'),
    requires_attack_roll = TRUE
WHERE slug = 'santuario';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'),
    requires_attack_roll = FALSE
WHERE slug = 'saraivada-de-espinhos';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'),
    requires_attack_roll = FALSE
WHERE slug = 'simbolo';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'carisma'),
    requires_attack_roll = FALSE
WHERE slug = 'similaridade';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'),
    requires_attack_roll = FALSE
WHERE slug = 'sonho';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'),
    requires_attack_roll = FALSE
WHERE slug = 'sono';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'),
    requires_attack_roll = FALSE
WHERE slug = 'sopro-de-dragao';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'),
    requires_attack_roll = FALSE
WHERE slug = 'sugestao-em-massa';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'inteligencia'),
    requires_attack_roll = FALSE
WHERE slug = 'suplicio';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'),
    requires_attack_roll = FALSE
WHERE slug = 'sussurros-dissonantes';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'inteligencia'),
    requires_attack_roll = FALSE
WHERE slug = 'talho-mental';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'),
    requires_attack_roll = FALSE
WHERE slug = 'teia';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'forca'),
    requires_attack_roll = FALSE
WHERE slug = 'telecinese';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'constituicao'),
    requires_attack_roll = FALSE
WHERE slug = 'tempestade-da-vinganca';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'),
    requires_attack_roll = FALSE
WHERE slug = 'tempestade-de-fogo';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'),
    requires_attack_roll = FALSE
WHERE slug = 'tempestade-glacial';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'constituicao'),
    requires_attack_roll = FALSE
WHERE slug = 'tempestade-radiante-de-jallarzi';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'),
    requires_attack_roll = FALSE
WHERE slug = 'terremoto';

UPDATE rpg.phb_spell
SET save_ability_id = NULL,
    requires_attack_roll = TRUE
WHERE slug = 'toque-chocante';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'constituicao'),
    requires_attack_roll = FALSE
WHERE slug = 'trovao';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'forca'),
    requires_attack_roll = FALSE
WHERE slug = 'tsunami';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'),
    requires_attack_roll = FALSE
WHERE slug = 'videncia';

UPDATE rpg.phb_spell
SET save_ability_id = NULL,
    requires_attack_roll = TRUE
WHERE slug = 'zombaria-perversa';

UPDATE rpg.phb_spell
SET save_ability_id = (SELECT id FROM rpg.phb_ability WHERE slug = 'carisma'),
    requires_attack_roll = FALSE
WHERE slug = 'zona-da-verdade';
