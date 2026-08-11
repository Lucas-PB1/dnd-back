import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const root = path.dirname(fileURLToPath(import.meta.url));
const esc = (s) => s.replace(/'/g, "''");
const j = (o) => esc(JSON.stringify(o));

const minorB = [
  [1, 20, 'skill-proficiency', 'Enquanto sintonizado, você ganha proficiência em uma perícia à escolha do Mestre.', { type: 'reminder', text: 'Proficiência em uma perícia (Mestre).' }],
  [21, 30, 'disease-immunity', 'Enquanto sintonizado, você é imune a doenças.', { type: 'reminder', text: 'Imunidade a doenças.' }],
  [31, 40, 'charm-frighten-immunity', 'Enquanto sintonizado, você não pode ser Enfeitiçado nem Amedrontado.', { type: 'reminder', text: 'Imune a Enfeitiçado e Amedrontado.' }],
  [41, 50, 'damage-resistance', 'Enquanto sintonizado, você tem Resistência a um tipo de dano à escolha do Mestre.', { type: 'reminder', text: 'Resistência a um tipo de dano (Mestre).' }],
  [51, 60, 'cast-cantrip', 'Enquanto sintonizado, você pode usar uma ação para conjurar um truque (escolhido pelo Mestre) a partir do artefato.', { type: 'artifactSpell', spellLevel: 0 }],
  [61, 70, 'cast-spell-1', 'Enquanto sintonizado, você pode usar uma ação para conjurar uma magia de 1º círculo (Mestre). Após conjurar, role 1d6; em 1–5, não pode conjurar assim até o próximo amanhecer.', { type: 'artifactSpell', spellLevel: 1 }],
  [71, 80, 'cast-spell-2', 'Como cast-spell-1, mas a magia é de 2º círculo.', { type: 'artifactSpell', spellLevel: 2 }],
  [81, 90, 'cast-spell-3', 'Como cast-spell-1, mas a magia é de 3º círculo.', { type: 'artifactSpell', spellLevel: 3 }],
  [91, 100, 'ac-bonus-1', 'Enquanto sintonizado, você ganha +1 na Classe de Armadura.', { type: 'permanentEffects', permanentEffects: { acBonus: 1 } }],
];

const majorB = [
  [1, 20, 'ability-plus-2', 'Enquanto sintonizado, um de seus atributos (escolha do Mestre) aumenta em 2, até o máximo de 24.', { type: 'permanentEffects', permanentEffects: { abilityBonusChoice: true } }],
  [21, 30, 'regen-1d6', 'Enquanto sintonizado, você recupera 1d6 PV no início do seu turno se tiver pelo menos 1 PV.', { type: 'artifactRegen', dice: '1d6' }],
  [31, 40, 'extra-force-1d6', 'Ao acertar com um ataque de arma enquanto sintonizado, o alvo sofre 1d6 de dano Energético adicional.', { type: 'reminder', text: '+1d6 dano Energético em acerto com arma.' }],
  [41, 50, 'speed-plus-10ft', 'Enquanto sintonizado, seu deslocamento de caminhada aumenta em 3 metros (10 pés).', { type: 'permanentEffects', permanentEffects: { speedBonusMeters: 3 } }],
  [51, 60, 'cast-spell-4', 'Enquanto sintonizado, você pode usar uma ação para conjurar uma magia de 4º círculo (Mestre). Após conjurar, role 1d6; em 1–5, não pode conjurar assim até o próximo amanhecer.', { type: 'artifactSpell', spellLevel: 4 }],
  [61, 70, 'cast-spell-5', 'Como cast-spell-4, mas a magia é de 5º círculo.', { type: 'artifactSpell', spellLevel: 5 }],
  [71, 80, 'cast-spell-6', 'Como cast-spell-4, mas a magia é de 6º círculo.', { type: 'artifactSpell', spellLevel: 6 }],
  [81, 90, 'cast-spell-7', 'Como cast-spell-4, mas a magia é de 7º círculo.', { type: 'artifactSpell', spellLevel: 7 }],
  [91, 100, 'condition-immunities-major', 'Enquanto sintonizado, você não pode ser Cego, Surdo, Petrificado nem Atordoado.', { type: 'reminder', text: 'Imune a Cego, Surdo, Petrificado e Atordoado.' }],
];

const minorD = [
  [1, 5, 'spell-save-disadvantage', 'Enquanto sintonizado, você tem Desvantagem em salvaguardas contra magias.', { type: 'reminder', text: 'Desvantagem em salvaguardas contra magias.' }],
  [6, 10, 'gem-value-halved', 'Na primeira vez que tocar uma gema ou joia enquanto sintonizado, o valor dela é reduzido pela metade.', { type: 'reminder', text: 'Primeira gema/joia tocada perde metade do valor.' }],
  [11, 15, 'blind-away-10ft', 'Enquanto sintonizado, você fica Cego quando está a mais de 3 metros do artefato.', { type: 'reminder', text: 'Cego a mais de 3 m do artefato.' }],
  [16, 20, 'poison-save-disadvantage', 'Enquanto sintonizado, você tem Desvantagem em salvaguardas contra veneno.', { type: 'reminder', text: 'Desvantagem em salvaguardas contra veneno.' }],
  [21, 30, 'sour-stench', 'Enquanto sintonizado, você emite um odor azedo perceptível a até 3 metros.', { type: 'reminder', text: 'Odor azedo até 3 m.' }],
  [31, 35, 'destroy-holy-water', 'Enquanto sintonizado, toda Água Benta a até 3 metros de você é destruída.', { type: 'reminder', text: 'Destrói Água Benta a até 3 m.' }],
  [36, 40, 'str-con-ill', 'Enquanto sintonizado, você está fisicamente doente e tem Desvantagem em testes e salvaguardas de Força ou Constituição.', { type: 'reminder', text: 'Desvantagem em FOR/CON (doente).' }],
  [41, 45, 'weight-gain', 'Enquanto sintonizado, seu peso aumenta em 1d4 × 5 kg.', { type: 'reminder', text: 'Peso +1d4×5 kg.' }],
  [46, 50, 'appearance-change', 'Enquanto sintonizado, sua aparência muda conforme o Mestre decidir.', { type: 'reminder', text: 'Aparência alterada (Mestre).' }],
  [51, 55, 'deaf-away-10ft', 'Enquanto sintonizado, você fica Surdo quando está a mais de 3 metros do artefato.', { type: 'reminder', text: 'Surdo a mais de 3 m do artefato.' }],
  [56, 60, 'weight-loss', 'Enquanto sintonizado, seu peso diminui em 1d4 × 2,5 kg.', { type: 'reminder', text: 'Peso −1d4×2,5 kg.' }],
  [61, 65, 'no-smell', 'Enquanto sintonizado, você não consegue sentir cheiros.', { type: 'reminder', text: 'Sem olfato.' }],
  [66, 70, 'extinguish-flames', 'Enquanto sintonizado, chamas não mágicas a até 9 metros de você são apagadas.', { type: 'reminder', text: 'Apaga chamas não mágicas a 9 m.' }],
  [71, 80, 'block-rests', 'Enquanto sintonizado, outras criaturas não podem fazer descanso curto ou longo a até 90 metros de você.', { type: 'reminder', text: 'Impede descansos alheios a 90 m.' }],
  [81, 85, 'plant-necrotic', 'Enquanto sintonizado, você causa 1d6 de dano Necrótico a qualquer planta que tocar que não seja uma criatura.', { type: 'reminder', text: '1d6 Necrótico a plantas tocadas.' }],
  [86, 90, 'animals-hostile', 'Enquanto sintonizado, animais a até 9 metros de você são hostis a você.', { type: 'reminder', text: 'Animais hostis a 9 m.' }],
  [91, 95, 'eat-drink-sixfold', 'Enquanto sintonizado, você deve comer e beber seis vezes a quantidade normal por dia.', { type: 'reminder', text: 'Come/bebe 6× o normal.' }],
  [96, 100, 'flaw-amplified', 'Enquanto sintonizado, sua falha é amplificada de um modo determinado pelo Mestre.', { type: 'reminder', text: 'Falha amplificada (Mestre).' }],
];

const majorD = [
  [1, 5, 'body-rots', 'Enquanto sintonizado, seu corpo apodrece ao longo de quatro dias (cabelo, pontas dos dedos, lábios/nariz, orelhas). Regenerar restaura partes perdidas.', { type: 'reminder', text: 'Corpo apodrece em 4 dias.' }],
  [6, 10, 'daily-alignment', 'Enquanto sintonizado, determine seu alinhamento diariamente ao amanhecer com 2d6 (eixo ordem/caos e bem/mal).', { type: 'reminder', text: 'Alinhamento diário aleatório.' }],
  [11, 15, 'geas-quest', 'Ao se sintonizar, o artefato dá uma missão (como Geas). Completar a missão encerra esta propriedade.', { type: 'reminder', text: 'Missão tipo Geas na 1ª sintonia.' }],
  [16, 20, 'hostile-life-force', 'O artefato abriga uma força vital hostil. Ao usar uma propriedade com ação, 50% de chance de posse (CD 20 CAR).', { type: 'reminder', text: 'Força vital hostil (50% posse).' }],
  [21, 25, 'cr0-plants-die', 'Criaturas ND 0 e plantas que não são criaturas caem a 0 PV a até 3 metros do artefato.', { type: 'reminder', text: 'ND 0 / plantas a 0 PV a 3 m.' }],
  [26, 30, 'death-slaad', 'O artefato aprisiona um Slaad da Morte. Ao usar propriedade com ação, 10% de chance de fuga.', { type: 'reminder', text: '10% fuga de Slaad da Morte.' }],
  [31, 35, 'creature-type-hostile', 'Enquanto sintonizado, criaturas de um tipo (exceto humanoides) escolhido pelo Mestre são sempre hostis a você.', { type: 'reminder', text: 'Tipo de criatura sempre hostil (Mestre).' }],
  [36, 40, 'dilute-potions', 'O artefato dilui poções mágicas a até 3 metros, tornando-as não mágicas.', { type: 'reminder', text: 'Dilui poções a 3 m.' }],
  [41, 45, 'erase-scrolls', 'O artefato apaga pergaminhos mágicos a até 3 metros, tornando-os não mágicos.', { type: 'reminder', text: 'Apaga pergaminhos a 3 m.' }],
  [46, 50, 'blood-cost', 'Antes de usar uma propriedade com ação, você deve gastar Ação Bônus para sangrar (1d4) a si ou a criatura disposta/incapacitada ao alcance.', { type: 'reminder', text: 'Custo de sangue (1d4) antes de ativar.' }],
  [51, 60, 'long-term-madness', 'Ao se sintonizar, você ganha uma forma de loucura de longo prazo.', { type: 'reminder', text: 'Loucura de longo prazo na sintonia.' }],
  [61, 65, 'psychic-4d10', 'Você sofre 4d10 de dano Psíquico ao se sintonizar.', { type: 'reminder', text: '4d10 Psíquico na sintonia.' }],
  [66, 70, 'psychic-8d10', 'Você sofre 8d10 de dano Psíquico ao se sintonizar.', { type: 'reminder', text: '8d10 Psíquico na sintonia.' }],
  [71, 75, 'kill-same-alignment', 'Antes de se sintonizar, você deve matar uma criatura do seu alinhamento.', { type: 'reminder', text: 'Exige matar criatura do seu alinhamento.' }],
  [76, 80, 'ability-minus-2', 'Ao se sintonizar, um de seus atributos é reduzido em 2 aleatoriamente. Restauração Maior restaura.', { type: 'abilityPenalty', amount: 2 }],
  [81, 85, 'age-3d10', 'Cada vez que se sintoniza, você envelhece 3d10 anos (CD 10 CON ou morre → Wight).', { type: 'reminder', text: 'Envelhece 3d10 anos na sintonia.' }],
  [86, 90, 'lose-speech', 'Enquanto sintonizado, você perde a capacidade de falar.', { type: 'reminder', text: 'Não pode falar.' }],
  [91, 95, 'vulnerability-all', 'Enquanto sintonizado, você tem Vulnerabilidade a todo dano.', { type: 'reminder', text: 'Vulnerabilidade a todo dano.' }],
  [96, 100, 'god-avatar', 'Ao se sintonizar, 10% de chance de atrair o avatar de um deus que tenta tomar o artefato.', { type: 'reminder', text: '10% avatar divino disputa o artefato.' }],
];

function rows(kind, list) {
  return list
    .map(
      ([min, max, slug, summary, effect]) =>
        `  ('${kind}', ${min}, ${max}, '${slug}', '${esc(summary)}', '${j(effect)}'::jsonb)`,
    )
    .join(',\n');
}

const artifactSql = `-- DMG Treasure: propriedades aleatórias de Artefato (1d100)
DELETE FROM rpg.dmg_artifact_random_property;

INSERT INTO rpg.dmg_artifact_random_property
  (kind, roll_min, roll_max, slug, summary_pt, effect)
VALUES
${rows('minor_beneficial', minorB)},
${rows('major_beneficial', majorB)},
${rows('minor_detrimental', minorD)},
${rows('major_detrimental', majorD)};
`;

fs.writeFileSync(
  path.join(root, '../database/seeds/dmg/D043_dmg_artifact_random_property.sql'),
  artifactSql,
);

const sentient = {
  alignment: [
    [1, 15, 'lg', 'Ordeiro e Bom', { alignment: 'OB' }],
    [16, 35, 'ng', 'Neutro e Bom', { alignment: 'NB' }],
    [36, 50, 'cg', 'Caótico e Bom', { alignment: 'CB' }],
    [51, 63, 'ln', 'Ordeiro e Neutro', { alignment: 'ON' }],
    [64, 73, 'n', 'Neutro', { alignment: 'N' }],
    [74, 85, 'cn', 'Caótico e Neutro', { alignment: 'CN' }],
    [86, 89, 'le', 'Ordeiro e Mau', { alignment: 'OM' }],
    [90, 96, 'ne', 'Neutro e Mau', { alignment: 'NM' }],
    [97, 100, 'ce', 'Caótico e Mau', { alignment: 'CM' }],
  ],
  communication: [
    [1, 6, 'empathy', 'Transmite emoções à criatura que o carrega ou empunha.', { communication: 'empatia' }],
    [7, 9, 'speech', 'Fala um ou mais idiomas.', { communication: 'fala' }],
    [10, 10, 'speech-telepathy', 'Fala um ou mais idiomas e se comunica telepaticamente com quem o carrega ou empunha.', { communication: 'fala+telepatia' }],
  ],
  senses: [
    [1, 1, 'hear-see-30', 'Audição e visão padrão até 9 metros.', { senses: 'audição e visão 9 m' }],
    [2, 2, 'hear-see-60', 'Audição e visão padrão até 18 metros.', { senses: 'audição e visão 18 m' }],
    [3, 3, 'hear-see-120', 'Audição e visão padrão até 36 metros.', { senses: 'audição e visão 36 m' }],
    [4, 4, 'hear-darkvision-120', 'Audição e Visão no Escuro até 36 metros.', { senses: 'audição e Visão no Escuro 36 m' }],
  ],
  special_purpose: [
    [1, 1, 'aligned', 'Alinhado. Busca derrotar ou destruir aqueles de alinhamento diametralmente oposto. Nunca é Neutro.', { purpose: 'aligned', purposeSummary: 'Derrotar alinhamento oposto.' }],
    [2, 2, 'bane', 'Flagelo. Busca frustrar ou destruir criaturas de um tipo particular (ex.: Construtos, Demônios, Mortos-Vivos).', { purpose: 'bane', purposeSummary: 'Destruir um tipo de criatura.' }],
    [3, 3, 'creator-seeker', 'Buscador do Criador. Procura seu criador e quer entender por que foi criado.', { purpose: 'creator_seeker', purposeSummary: 'Encontrar o criador.' }],
    [4, 4, 'destiny-seeker', 'Buscador do Destino. Acredita que ele e o portador têm papéis-chave em eventos futuros.', { purpose: 'destiny_seeker', purposeSummary: 'Cumprir um destino.' }],
    [5, 5, 'destroyer', 'Destruidor. Anseia por destruição e incentiva o usuário a lutar arbitrariamente.', { purpose: 'destroyer', purposeSummary: 'Destruir sem propósito.' }],
    [6, 6, 'glory-seeker', 'Buscador de Glória. Busca renome como o maior item mágico do mundo.', { purpose: 'glory_seeker', purposeSummary: 'Fama e notoriedade.' }],
    [7, 7, 'lore-seeker', 'Buscador de Sabedoria. Anseia por conhecimento, mistérios ou profecias.', { purpose: 'lore_seeker', purposeSummary: 'Buscar conhecimento.' }],
    [8, 8, 'protector', 'Protetor. Busca defender um tipo particular de criatura.', { purpose: 'protector', purposeSummary: 'Proteger um povo/tipo.' }],
    [9, 9, 'soulmate-seeker', 'Buscador de Alma Gêmea. Procura outro item mágico senciente.', { purpose: 'soulmate_seeker', purposeSummary: 'Encontrar outro item senciente.' }],
    [10, 10, 'templar', 'Templário. Busca defender os servos e interesses de uma divindade particular.', { purpose: 'templar', purposeSummary: 'Servir uma divindade.' }],
  ],
  ability_scores: [
    [1, 1, '4d6-drop-lowest', 'Role 4d6 descartando o menor para INT, SAB e CAR.', { method: '4d6dl1', abilities: ['inteligencia', 'sabedoria', 'carisma'] }],
  ],
};

function sentientRows(kind, list) {
  return list
    .map(
      ([min, max, slug, summary, payload]) =>
        `  ('${kind}', ${min}, ${max}, '${slug}', '${esc(summary)}', '${j(payload)}'::jsonb)`,
    )
    .join(',\n');
}

const sentientSql = `-- DMG Treasure: tabelas de geração de item senciente
DELETE FROM rpg.dmg_sentient_trait_table;

INSERT INTO rpg.dmg_sentient_trait_table
  (kind, roll_min, roll_max, slug, summary_pt, payload)
VALUES
${sentientRows('alignment', sentient.alignment)},
${sentientRows('communication', sentient.communication)},
${sentientRows('senses', sentient.senses)},
${sentientRows('special_purpose', sentient.special_purpose)},
${sentientRows('ability_scores', sentient.ability_scores)};
`;

fs.writeFileSync(
  path.join(root, '../database/seeds/dmg/D044_dmg_sentient_trait_table.sql'),
  sentientSql,
);

console.log('ok');
