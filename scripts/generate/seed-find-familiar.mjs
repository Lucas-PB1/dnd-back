import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, '..', '..');

const data = JSON.parse(
  fs.readFileSync(
    path.join(root, 'docs/source/extracts/srd/monsters-5.2.1.json'),
    'utf8',
  ),
);

/**
 * Monstros CR0 do bestiário. Find Familiar só mapeia a eles —
 * o template não é “um familiar”.
 * @type {{ en: string; key: string; label: string; scrap?: string }[]}
 */
const forms = [
  { en: 'Spider', key: 'aranha', label: 'Aranha', scrap: 'Spider' },
  { en: 'Owl', key: 'coruja', label: 'Coruja', scrap: 'Owl' },
  { en: 'Raven', key: 'corvo', label: 'Corvo', scrap: 'Raven' },
  { en: 'Weasel', key: 'doninha', label: 'Doninha', scrap: 'Weasel' },
  { en: 'Hawk', key: 'falcao', label: 'Falcão', scrap: 'Hawk' },
  { en: 'Cat', key: 'gato', label: 'Gato', scrap: 'Cat' },
  { en: 'Lizard', key: 'lagarto', label: 'Lagarto', scrap: 'Lizard' },
  { en: 'Bat', key: 'morcego', label: 'Morcego' },
  { en: 'Octopus', key: 'polvo', label: 'Polvo', scrap: 'Octopus' },
  { en: 'Rat', key: 'rato', label: 'Rato', scrap: 'Rat' },
  { en: 'Frog', key: 'sapo', label: 'Sapo', scrap: 'Frog' },
];

const sizeMap = {
  Tiny: 'tiny',
  Small: 'small',
  Medium: 'medium',
  Large: 'large',
};

const traitPt = {
  'Keen Smell': [
    'Olfato Aguçado',
    'Vantagem em testes de Sabedoria (Percepção) que dependem do olfato.',
  ],
  Flyby: [
    'Voo de Passagem',
    'Não provoca Ataques de Oportunidade ao voar para fora do alcance de um inimigo.',
  ],
  'Keen Hearing and Sight': [
    'Audição e Visão Aguçadas',
    'Vantagem em testes de Sabedoria (Percepção) que dependem da audição ou visão.',
  ],
  Mimicry: [
    'Mimetismo',
    'Pode imitar sons simples. Criatura ouvinte: teste de Sabedoria (Intuição) CD 10 para perceber a imitação.',
  ],
  'Spider Climb': [
    'Escalada de Aranha',
    'Pode escalar superfícies difíceis, inclusive de cabeça para baixo, sem teste.',
  ],
  'Web Sense': [
    'Sentido de Teia',
    'Em contato com uma teia, sabe a localização exata de qualquer criatura em contato com a mesma teia.',
  ],
  'Web Walker': [
    'Andarilho de Teias',
    'Ignora restrições de movimento causadas por teias.',
  ],
  'Keen Hearing and Smell': [
    'Audição e Olfato Aguçados',
    'Vantagem em testes de Sabedoria (Percepção) que dependem da audição ou olfato.',
  ],
  'Keen Sight': [
    'Visão Aguçada',
    'Vantagem em testes de Sabedoria (Percepção) que dependem da visão.',
  ],
  Amphibious: ['Anfíbio', 'Pode respirar ar e água.'],
  'Standing Leap': [
    'Salto em Pé',
    'Salto em distância até 3 m e em altura até 1,5 m, com ou sem corrida.',
  ],
  'Hold Breath': [
    'Prender a Respiração',
    'Fora da água, pode prender a respiração por 30 minutos.',
  ],
  'Underwater Camouflage': [
    'Camuflagem Subaquática',
    'Vantagem em testes de Destreza (Furtividade) debaixo d’água.',
  ],
  'Water Breathing': ['Respiração Aquática', 'Só respira debaixo d’água.'],
  Echolocation: [
    'Ecolocalização',
    'Não pode usar Visão às Cegas enquanto estiver Surdo.',
  ],
  'Keen Hearing': [
    'Audição Aguçada',
    'Vantagem em testes de Sabedoria (Percepção) que dependem da audição.',
  ],
};

function esc(s) {
  return String(s).replace(/'/g, "''");
}

function actionNamePt(name) {
  const map = {
    Claws: 'Garras',
    Talons: 'Garras',
    Bite: 'Mordida',
    Beak: 'Bico',
    Tentacles: 'Tentáculos',
    'Ink Cloud (Recharges after a Short or Long Rest)':
      'Nuvem de Tinta (recarrega após Descanso)',
  };
  return map[name] || name;
}

function damageExpr(desc) {
  const m = desc?.match(/Hit:\s*(\d+)\s/i);
  return m ? String(m[1]) : null;
}

/** @type {Record<string, string>} */
const imageExtBySlug = {};

const destDir = path.join(root, 'public/catalog/beasts');
fs.mkdirSync(destDir, { recursive: true });
const scrapBase = path.join(root, 'docs/source/scrap/familiar');
for (const form of forms) {
  if (!form.scrap) {
    console.log('skip image (no scrap):', form.key);
    imageExtBySlug[form.key] = '.png';
    continue;
  }
  const filesDir = path.join(
    scrapBase,
    `${form.scrap} - Monsters - D&D Beyond_files`,
  );
  if (!fs.existsSync(filesDir)) {
    console.log('missing files dir', filesDir);
    imageExtBySlug[form.key] = '.png';
    continue;
  }
  const imgs = fs
    .readdirSync(filesDir)
    .filter((x) => /\.(png|jpe?g|webp)$/i.test(x))
    .map((i) => ({ i, size: fs.statSync(path.join(filesDir, i)).size }))
    .sort((a, b) => b.size - a.size);
  if (!imgs.length) {
    imageExtBySlug[form.key] = '.png';
    continue;
  }
  const src = path.join(filesDir, imgs[0].i);
  const ext = path.extname(imgs[0].i).toLowerCase().replace('jpeg', 'jpg');
  const outExt = ext === '.jpg' ? '.jpg' : '.png';
  imageExtBySlug[form.key] = outExt;
  fs.copyFileSync(src, path.join(destDir, `${form.key}${outExt}`));
  console.log('image', form.key, '<-', imgs[0].i);
}

const oldFamiliarDir = path.join(root, 'public/catalog/familiars');
if (fs.existsSync(oldFamiliarDir)) {
  fs.rmSync(oldFamiliarDir, { recursive: true, force: true });
  console.log('removed', oldFamiliarDir);
}

const out = [];
out.push(`-- Bestas CR0 do bestiário (identidade de monstro).`);
out.push(
  `-- Find Familiar (convocar-familiar) só mapeia variantes → estes templates.`,
);
out.push(`-- Stats: SRD 5.2.1; imagens do scrap Beyond.`);
out.push(
  `-- Escala flat (sync spirit exige scale_by_slot; AC/PV não sobem com círculo).`,
);
out.push(
  `-- Flavor Celestial/Feérico/Ínfero = escolha no cast, não no template.`,
);
out.push('');

const slugList = forms.map((f) => `'${f.key}'`).join(', ');

out.push(`-- Remove legado familiar-* (nome misturava vínculo com identidade).`);
out.push(
  `DELETE FROM rpg.phb_spell_spirit_variant WHERE template_slug LIKE 'familiar-%';`,
);
out.push(
  `DELETE FROM rpg.phb_creature_template WHERE slug LIKE 'familiar-%';`,
);
out.push('');

out.push(`INSERT INTO rpg.phb_creature_template (`);
out.push(
  `  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,`,
);
out.push(
  `  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,`,
);
out.push(`  initiative_modifier, ability_scores, image_url`);
out.push(`) VALUES`);

const valueRows = [];
for (const form of forms) {
  const m = data.monsters.find((x) => x.name === form.en);
  if (!m) throw new Error(`missing ${form.en}`);
  const a = m.stat_block_json.ability_scores;
  const size = sizeMap[m.size] || 'tiny';
  const scores = JSON.stringify({
    forca: a.str,
    destreza: a.dex,
    constituicao: a.con,
    inteligencia: a.int,
    sabedoria: a.wis,
    carisma: a.cha,
  });
  const ext = imageExtBySlug[form.key] || '.png';
  valueRows.push(`(
  '${form.key}', 'phb-2024-pt', '${form.label}',
  '${m.size === 'Tiny' ? 'Minúscula' : 'Pequena'} Fera, Neutra', 'Neutra', 'Beast', '${size}',
  0, 2, ${m.armor_class}, ${m.hp_max}, '${esc(m.hp_formula)}', ${m.initiative_modifier},
  '${scores}'::jsonb, '/catalog/beasts/${form.key}${ext}'
)`);
}
out.push(valueRows.join(',\n'));
out.push(`ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, subtitle = EXCLUDED.subtitle, alignment = EXCLUDED.alignment,
  creature_type = EXCLUDED.creature_type, size_slug = EXCLUDED.size_slug,
  challenge_rating = EXCLUDED.challenge_rating, proficiency_bonus = EXCLUDED.proficiency_bonus,
  armor_class = EXCLUDED.armor_class, hit_points_avg = EXCLUDED.hit_points_avg,
  hit_points_formula = EXCLUDED.hit_points_formula,
  initiative_modifier = EXCLUDED.initiative_modifier, ability_scores = EXCLUDED.ability_scores,
  image_url = EXCLUDED.image_url;
`);

out.push(`INSERT INTO rpg.phb_creature_scale_by_slot (
  template_slug, scale_min_slot, ac_base, ac_per_slot, hp_base, hp_per_slot, hp_mode
) VALUES`);
out.push(
  forms
    .map((f) => {
      const m = data.monsters.find((x) => x.name === f.en);
      return `  ('${f.key}', 1, ${m.armor_class}, 0, ${m.hp_max}, 0, 'per_slot')`;
    })
    .join(',\n'),
);
out.push(`ON CONFLICT (template_slug) DO UPDATE SET
  scale_min_slot = EXCLUDED.scale_min_slot,
  ac_base = EXCLUDED.ac_base,
  ac_per_slot = EXCLUDED.ac_per_slot,
  hp_base = EXCLUDED.hp_base,
  hp_per_slot = EXCLUDED.hp_per_slot,
  hp_mode = EXCLUDED.hp_mode;
`);

out.push(
  `DELETE FROM rpg.phb_creature_template_speed WHERE template_slug IN (${slugList});`,
);
out.push(
  `INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES`,
);
const speeds = [];
for (const form of forms) {
  const m = data.monsters.find((x) => x.name === form.en);
  const sp = m.stat_block_json.speed || {};
  for (const [kind, ft] of Object.entries(sp)) {
    const mk =
      kind === 'walk'
        ? 'walk'
        : kind === 'fly'
          ? 'fly'
          : kind === 'swim'
            ? 'swim'
            : kind === 'climb'
              ? 'climb'
              : null;
    if (!mk || ft == null) continue;
    speeds.push(`  ('${form.key}', '${mk}', ${ft})`);
  }
}
out.push(speeds.join(',\n') + ';');
out.push('');

out.push(
  `DELETE FROM rpg.phb_creature_template_trait WHERE template_slug IN (${slugList});`,
);
out.push(
  `INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES`,
);
const traits = [];
for (const form of forms) {
  const m = data.monsters.find((x) => x.name === form.en);
  const sb = m.stat_block_json;
  let order = 0;
  const senses = sb.senses || {};
  const senseParts = [];
  if (senses.darkvision)
    senseParts.push(
      `Visão no Escuro ${Math.round(senses.darkvision * 0.3)} m`,
    );
  if (senses.blindsight)
    senseParts.push(
      `Visão às Cegas ${Math.round(senses.blindsight * 0.3)} m`,
    );
  if (senses.passive_perception != null)
    senseParts.push(`Percepção Passiva ${senses.passive_perception}`);
  if (senseParts.length) {
    traits.push(
      `  ('${form.key}', 'Sentidos', '${esc(senseParts.join('. ') + '.')}', ${order++})`,
    );
  }
  for (const t of sb.traits || []) {
    const pt = traitPt[t.name] || [t.name, t.description];
    traits.push(
      `  ('${form.key}', '${esc(pt[0])}', '${esc(pt[1])}', ${order++})`,
    );
  }
}
out.push(traits.join(',\n') + ';');
out.push('');

out.push(
  `DELETE FROM rpg.phb_creature_template_action WHERE template_slug IN (${slugList});`,
);
out.push(`INSERT INTO rpg.phb_creature_template_action (
  template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order
) VALUES`);
const actions = [];
for (const form of forms) {
  const m = data.monsters.find((x) => x.name === form.en);
  let order = 1;
  for (const a of m.stat_block_json.actions || []) {
    const bonus = a.attack_bonus ?? null;
    const dmg = damageExpr(a.description);
    actions.push(
      `  ('${form.key}', '${esc(actionNamePt(a.name))}', 'action'::rpg.actor_action_bucket, ${bonus === null || bonus === undefined ? 'NULL' : bonus}, ${dmg ? `'${dmg}'` : 'NULL'}, '${esc(a.description)}', ${order++})`,
    );
  }
}
if (actions.length === 0) {
  out.push(`-- (sem ações)`);
} else {
  out.push(actions.join(',\n') + ';');
}
out.push('');

out.push(`INSERT INTO rpg.phb_spell_spirit (spell_slug, actor_kind, replace_policy, fly_speed_min_slot)
VALUES ('convocar-familiar', 'companion', 'replace_same_spell', NULL)
ON CONFLICT (spell_slug) DO UPDATE SET
  actor_kind = EXCLUDED.actor_kind,
  replace_policy = EXCLUDED.replace_policy,
  fly_speed_min_slot = EXCLUDED.fly_speed_min_slot;
DELETE FROM rpg.phb_spell_spirit_variant WHERE spell_slug = 'convocar-familiar';
INSERT INTO rpg.phb_spell_spirit_variant (spell_slug, variant_key, template_slug, label) VALUES`);
out.push(
  forms
    .map((f) => `  ('convocar-familiar', '${f.key}', '${f.key}', '${f.label}')`)
    .join(',\n') + ';',
);
out.push('');

const sqlPath = path.join(
  root,
  'database/seeds/creature/phb/seed.find-familiar.sql',
);
fs.writeFileSync(sqlPath, out.join('\n') + '\n');
console.log('wrote', sqlPath);
