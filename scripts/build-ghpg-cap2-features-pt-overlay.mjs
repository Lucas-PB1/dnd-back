/**
 * Gera overlay PT editorial para Cap. 2 GH (218 subclass features + 15 MH class features).
 * Lê cap2-subclasses-en.json (extract) e grava cap2-features-pt.json.
 *
 * Uso: node scripts/build-ghpg-cap2-features-pt-overlay.mjs
 */
import fs from 'fs';
import path from 'path';
import { extracts } from './lib/docs-source.mjs';
import { translateFeatureName } from './lib/ghpg-cap2-feature-names-pt.mjs';
import { SUBCLASS_PT } from './lib/ghpg-cap2-subclass-pt.mjs';
import { translateGhpgBody, translateGhpgProse } from './lib/ghpg-mechanical-glossary.mjs';

const enPath = extracts.grimHollow.cap2SubclassesEn;
const outPath = extracts.grimHollow.cap2FeaturesPt;

/** Refino editorial além do glossário automático. */
const DESCRIPTION_OVERRIDES = {
  'sangromancer:3:Sangromancy Savant':
    'Magias de Sangromancia contam como magias de Mago para você. Escolha duas magias de Sangromancia, cada uma de no máximo 2º círculo, e adicione-as ao seu grimório gratuitamente. Além disso, sempre que ganhar acesso a um novo nível de espaços de magia nesta classe, você pode adicionar uma magia de Sangromancia ao grimório gratuitamente. A magia escolhida deve ser de um nível para o qual você tenha espaços de magia.',
  'sangromancer:3:Full-Blooded':
    'Você extrai magia do sangue, representada pelos Dados de Sangromancia que alimentam os poderes desta subclasse. Você tem um pool de d12 que pode gastar no lugar de um Dado de Vida ao conjurar magias de Sangromancia. O número de dados no pool é igual a 1 + seu nível de Mago. Recupera 1 Dado de Sangromancia ao terminar um Descanso Curto e todos ao terminar um Descanso Longo.',
  'sangromancer:6:Sanguine Vigor':
    'Seu máximo de Pontos de Vida aumenta em 6 e aumenta em 1 sempre que você ganha um nível de Mago. Além disso, sempre que conjura uma magia de Sangromancia gastando um espaço de magia, recupera Pontos de Vida iguais ao nível do espaço gasto.',
  'sangromancer:10:Blood for Blood':
    'Uma vez em cada um dos seus turnos, quando você causar dano a uma ou mais criaturas com uma magia de Mago que conjurou, pode gastar um Dado de Vida ou um Dado de Sangromancia, rolar o dado e causar dano extra a uma dessas criaturas igual ao resultado. Se a criatura estiver Ferida, você rola duas vezes e usa o maior resultado.',
  'sangromancer:14:Red Renewal':
    'Ao terminar um Descanso Curto, recupera Dados de Vida e Dados de Sangromancia gastos em quantidade igual à metade do seu nível de Mago. Depois de usar este recurso, não pode usá-lo de novo até terminar um Descanso Longo.',
};

const SUBCLASS_META_OVERRIDES = {
  sangromancer: {
    tagline: 'Derramar sangue por poder',
    summary:
      'Você estuda uma escola incomum de magia conhecida como Sangromancia ou magia de sangue.',
    description:
      'Você estuda uma escola incomum de magia conhecida como Sangromancia ou magia de sangue. Apesar da reputação sombria, não há nada inerentemente maligno na prática — embora as exigências sobre quem a domina sejam macabras. Como Sangromante, sua magia exige mais que conhecimento: exige sacrifício. Outros magos podem encará-lo com ceticismo ou hostilidade, mas ninguém nega a potência da sua arte.',
  },
};

const NAME_OVERRIDES = {
  'sangromancer:3:Sangromancy Savant': 'Especialista em Sangromancia',
  'sangromancer:3:Full-Blooded': 'Sangue Pleno',
  'sangromancer:6:Sanguine Vigor': 'Vigor Sanguíneo',
  'sangromancer:10:Blood for Blood': 'Sangue por Sangue',
  'sangromancer:14:Red Renewal': 'Renovação Rubra',
};

function featureKey(sc, feat) {
  return `${sc.slug}:${feat.level}:${feat.name}`;
}

function classFeatureKey(feat) {
  return `${feat.level}:${feat.name}`;
}

if (!fs.existsSync(enPath)) {
  console.error(`Extract EN ausente: ${enPath}`);
  console.error('Rode: node scripts/extract-ghpg-cap2.mjs');
  process.exit(1);
}

const en = JSON.parse(fs.readFileSync(enPath, 'utf8'));
const overlay = {
  generatedAt: new Date().toISOString(),
  source: enPath.replace(/\\/g, '/'),
  subclassFeatures: {},
  classFeatures: {},
  subclasses: {},
};

for (const sc of en.subclasses ?? []) {
  const metaOverride = SUBCLASS_META_OVERRIDES[sc.slug];
  const ptMeta = SUBCLASS_PT[sc.slug] ?? {};
  const fallbackTagline = sc.summary?.split('\n\n')[0]?.trim() ?? '';
  overlay.subclasses[sc.slug] = {
    tagline: translateGhpgProse(ptMeta.tagline ?? sc.tagline ?? fallbackTagline),
    summary: translateGhpgBody(sc.summary),
    description: translateGhpgBody(sc.description),
    ...(metaOverride ?? {}),
  };
  for (const feat of sc.features ?? []) {
    const key = featureKey(sc, feat);
    overlay.subclassFeatures[key] = {
      name: NAME_OVERRIDES[key] ?? translateFeatureName(feat.name),
      description:
        DESCRIPTION_OVERRIDES[key] ?? translateGhpgBody(feat.description),
    };
  }
}

for (const feat of en.monsterHunter?.features ?? []) {
  const key = classFeatureKey(feat);
  overlay.classFeatures[key] = {
    name: translateFeatureName(feat.name),
    description: translateGhpgBody(feat.description),
  };
}

fs.mkdirSync(path.dirname(outPath), { recursive: true });
fs.writeFileSync(outPath, `${JSON.stringify(overlay, null, 2)}\n`, 'utf8');
console.log(
  `wrote ${outPath.replace(/\\/g, '/')} — ${Object.keys(overlay.subclassFeatures).length} subclass features, ${Object.keys(overlay.classFeatures).length} class features`,
);
