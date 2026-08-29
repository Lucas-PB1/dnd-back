/**
 * Gera M005_phb_mounts.sql a partir de docs/source/phb-cap6-mounts-extract.json + SRD 5.2.1
 * Uso: node scripts/gen-phb-mount-seeds.mjs
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const rootDir = path.join(__dirname, '..');

const monsters = JSON.parse(
  fs.readFileSync(path.join(rootDir, 'docs/source/srd-5.2.1-monsters.json'), 'utf8'),
).monsters;
const extract = JSON.parse(
  fs.readFileSync(path.join(rootDir, 'docs/source/phb-cap6-mounts-extract.json'), 'utf8'),
);

const sizePt = { Large: 'Grande', Medium: 'Médio', Huge: 'Enorme' };
const pbByCr = { '1/8': 2, '1/4': 2, '1/2': 2, '4': 2 };

const overrides = {
  'cavalo-de-guerra': {
    armor_class: 11,
    hit_points_avg: 19,
    hit_points_formula: '3d10+3',
    initiative_modifier: 1,
    ability_scores: {
      forca: 18,
      destreza: 12,
      constituicao: 13,
      inteligencia: 2,
      sabedoria: 12,
      carisma: 7,
    },
    speeds: [{ movementKind: 'walk', speedFt: 60 }],
    traits: [{ name: 'Sentidos', description: 'Percepção passiva 11', sortOrder: 1 }],
    actions: [
      {
        name: 'Cascos',
        actionBucket: 'action',
        attackBonus: 6,
        damageExpression: '9 (2d4+4)',
        description:
          'Ataque corpo a corpo: +6, alcance 1,5 m. Acerto: 9 (2d4 + 4) de dano de Concussão. Se o cavalo se moveu pelo menos 6 m em linha reta em direção ao alvo imediatamente antes do acerto, o alvo sofre 5 (2d4) de dano de Concussão extra e, se for Enorme ou menor, fica Caído.',
        sortOrder: 1,
      },
    ],
  },
  elefante: {
    armor_class: 12,
    hit_points_avg: 76,
    hit_points_formula: '8d12+24',
    initiative_modifier: -1,
    challenge_rating: '4',
    ability_scores: {
      forca: 22,
      destreza: 9,
      constituicao: 17,
      inteligencia: 3,
      sabedoria: 11,
      carisma: 6,
    },
    speeds: [{ movementKind: 'walk', speedFt: 40 }],
    traits: [{ name: 'Sentidos', description: 'Percepção passiva 10', sortOrder: 1 }],
    actions: [
      {
        name: 'Ataques Múltiplos',
        actionBucket: 'action',
        attackBonus: null,
        damageExpression: null,
        description: 'O elefante realiza dois ataques de Chifrar.',
        sortOrder: 1,
      },
      {
        name: 'Chifrar',
        actionBucket: 'action',
        attackBonus: 8,
        damageExpression: '15 (2d8+6)',
        description:
          'Ataque corpo a corpo: +8, alcance 1,5 m. Acerto: 15 (2d8 + 6) de dano Perfurante. Se o elefante se moveu pelo menos 6 m em linha reta em direção ao alvo imediatamente antes do acerto, o alvo também fica Caído.',
        sortOrder: 2,
      },
      {
        name: 'Atropelar',
        actionBucket: 'bonus',
        attackBonus: null,
        damageExpression: '17 (2d10+6)',
        description:
          'Teste de resistência de Destreza: CD 16, uma criatura a até 1,5 m que esteja Caída. Falha: 17 (2d10 + 6) de dano de Concussão. Sucesso: metade do dano.',
        sortOrder: 3,
      },
    ],
  },
};

const traitTranslations = {
  'Keen Hearing and Smell': {
    name: 'Audição e Faro Aguçados',
    description:
      'O mastim tem vantagem em testes de Sabedoria (Percepção) que dependam de audição ou olfato.',
  },
  'Beast of Burden': {
    name: 'Animal de Carga',
    description:
      'A mula conta como uma categoria de tamanho maior para determinar sua capacidade de carga.',
  },
  'Sure-Footed': {
    name: 'Pé Firme',
    description:
      'A mula tem vantagem em testes de resistência de Força e Destreza contra efeitos que a derrubariam.',
  },
};

const actionNamePt = {
  Bite: 'Mordida',
  Hooves: 'Cascos',
  Gore: 'Chifrar',
  Stomp: 'Pisotear',
};

function translateActionDesc(desc) {
  return desc
    .replace(/Melee Weapon Attack/g, 'Ataque corpo a corpo')
    .replace(/Melee Attack Roll/g, 'Ataque corpo a corpo')
    .replace(/\+(\d+) to hit/g, '+$1')
    .replace(/reach 5 ft\./g, 'alcance 1,5 m.')
    .replace(/Hit:/g, 'Acerto:')
    .replace(/one target/g, 'um alvo')
    .replace(/one creature/g, 'uma criatura')
    .replace(/one prone creature/g, 'uma criatura caída')
    .replace(/bludgeoning damage/g, 'de dano de Concussão')
    .replace(/piercing damage/g, 'de dano Perfurante')
    .replace(
      /If the target is a creature, it must succeed on a DC (\d+) Strength saving throw or be knocked prone\./g,
      'Se o alvo for uma criatura, deve passar em um teste de resistência de Força CD $1 ou ficar Caído.',
    );
}

function sqlStr(value) {
  if (value == null) return 'NULL';
  return `'${String(value).replace(/'/g, "''")}'`;
}

const lines = [];
lines.push('-- PHB 2024 — montarias animais (Cap. 6 + Apêndice B)');
lines.push('-- Slug do template = slug do item em S031 (spawn via itemSlug na ficha)');
lines.push('-- Fonte: docs/source/phb-cap6-mounts-extract.json + SRD 5.2.1 (CC-BY)');
lines.push('-- Gerado por scripts/gen-phb-mount-seeds.mjs');
lines.push('');

for (const mount of extract.mounts) {
  const srd = monsters.find((m) => m.id === mount.srdId);
  if (!srd) throw new Error(`missing ${mount.srdId}`);
  const block = overrides[mount.itemSlug] ?? null;
  const sb = srd.stat_block_json;
  const sizeSlug = srd.size.toLowerCase();
  const subtitle = `${sizePt[srd.size] ?? srd.size} Fera, Neutro`;
  const cr = block?.challenge_rating ?? srd.cr;
  const pb = pbByCr[cr] ?? 2;
  const ac = block?.armor_class ?? srd.armor_class;
  const hp = block?.hit_points_avg ?? srd.hp_max;
  const hpFormula = block?.hit_points_formula ?? srd.hp_formula;
  const init = block?.initiative_modifier ?? srd.initiative_modifier;
  const abilities = block?.ability_scores ?? {
    forca: sb.ability_scores.str,
    destreza: sb.ability_scores.dex,
    constituicao: sb.ability_scores.con,
    inteligencia: sb.ability_scores.int,
    sabedoria: sb.ability_scores.wis,
    carisma: sb.ability_scores.cha,
  };

  lines.push(`-- ${mount.namePt} (${mount.itemSlug})`);
  lines.push('INSERT INTO rpg.phb_creature_template (');
  lines.push('  slug, edition_slug, name, subtitle, alignment, creature_type, size_slug,');
  lines.push('  challenge_rating, proficiency_bonus, armor_class, hit_points_avg, hit_points_formula,');
  lines.push('  initiative_modifier, ability_scores');
  lines.push(') VALUES (');
  lines.push(`  ${sqlStr(mount.itemSlug)},`);
  lines.push(`  ${sqlStr('phb-2024-pt')},`);
  lines.push(`  ${sqlStr(mount.namePt)},`);
  lines.push(`  ${sqlStr(subtitle)},`);
  lines.push(`  ${sqlStr('Neutro')},`);
  lines.push(`  ${sqlStr('Fera')},`);
  lines.push(`  ${sqlStr(sizeSlug)},`);
  lines.push(`  ${sqlStr(cr)},`);
  lines.push(`  ${pb},`);
  lines.push(`  ${ac},`);
  lines.push(`  ${hp},`);
  lines.push(`  ${sqlStr(hpFormula)},`);
  lines.push(`  ${init},`);
  lines.push(`  '${JSON.stringify(abilities)}'::jsonb`);
  lines.push(') ON CONFLICT (slug) DO UPDATE SET');
  lines.push('  name = EXCLUDED.name, subtitle = EXCLUDED.subtitle, alignment = EXCLUDED.alignment,');
  lines.push('  creature_type = EXCLUDED.creature_type, size_slug = EXCLUDED.size_slug,');
  lines.push('  challenge_rating = EXCLUDED.challenge_rating, proficiency_bonus = EXCLUDED.proficiency_bonus,');
  lines.push('  armor_class = EXCLUDED.armor_class, hit_points_avg = EXCLUDED.hit_points_avg,');
  lines.push('  hit_points_formula = EXCLUDED.hit_points_formula, initiative_modifier = EXCLUDED.initiative_modifier,');
  lines.push('  ability_scores = EXCLUDED.ability_scores;');
  lines.push('');

  const speeds =
    block?.speeds ??
    Object.entries(sb.speed ?? {}).map(([movementKind, speedFt]) => ({
      movementKind,
      speedFt,
    }));
  lines.push(`DELETE FROM rpg.phb_creature_template_speed WHERE template_slug = ${sqlStr(mount.itemSlug)};`);
  for (const sp of speeds) {
    lines.push(
      `INSERT INTO rpg.phb_creature_template_speed (template_slug, movement_kind, speed_ft) VALUES (${sqlStr(mount.itemSlug)}, ${sqlStr(sp.movementKind)}, ${sp.speedFt});`,
    );
  }
  lines.push('');

  lines.push(`DELETE FROM rpg.phb_creature_template_trait WHERE template_slug = ${sqlStr(mount.itemSlug)};`);
  const capKg = mount.carryingCapacityLb / 2;
  lines.push(
    `INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES (${sqlStr(mount.itemSlug)}, 'Capacidade de carga', ${sqlStr(`${capKg} kg`)}, 0);`,
  );
  const traits =
    block?.traits ??
    (sb.traits ?? []).map((t, i) => {
      const tr = traitTranslations[t.name];
      return tr
        ? { ...tr, sortOrder: i + 1 }
        : { name: t.name, description: t.description, sortOrder: i + 1 };
    });
  if (sb.skills?.perception != null && !traits.some((t) => t.name === 'Perícias')) {
    traits.push({
      name: 'Perícias',
      description: `Percepção +${sb.skills.perception}`,
      sortOrder: traits.length + 1,
    });
  }
  if (sb.senses?.passive_perception != null && !traits.some((t) => t.name === 'Sentidos')) {
    traits.push({
      name: 'Sentidos',
      description: `Percepção passiva ${sb.senses.passive_perception}`,
      sortOrder: traits.length + 1,
    });
  }
  for (const trait of traits) {
    lines.push(
      `INSERT INTO rpg.phb_creature_template_trait (template_slug, name, description, sort_order) VALUES (${sqlStr(mount.itemSlug)}, ${sqlStr(trait.name)}, ${sqlStr(trait.description)}, ${trait.sortOrder ?? 0});`,
    );
  }
  lines.push('');

  lines.push(`DELETE FROM rpg.phb_creature_template_action WHERE template_slug = ${sqlStr(mount.itemSlug)};`);
  const actions =
    block?.actions ??
    (sb.actions ?? []).map((a, i) => ({
      name: actionNamePt[a.name] ?? a.name,
      actionBucket: 'action',
      attackBonus: a.attack_bonus ?? null,
      damageExpression: a.damage?.[0]?.dice ?? null,
      description: a.description ? translateActionDesc(a.description) : null,
      sortOrder: i + 1,
    }));
  for (const action of actions) {
    lines.push(
      `INSERT INTO rpg.phb_creature_template_action (template_slug, name, action_bucket, attack_bonus, damage_expression, description, sort_order) VALUES (${sqlStr(mount.itemSlug)}, ${sqlStr(action.name)}, ${sqlStr(action.actionBucket)}::rpg.actor_action_bucket, ${action.attackBonus ?? 'NULL'}, ${sqlStr(action.damageExpression)}, ${sqlStr(action.description)}, ${action.sortOrder});`,
    );
  }
  lines.push('');
}

const out = path.join(rootDir, 'database/seeds/creatures/M005_phb_mounts.sql');
fs.writeFileSync(out, lines.join('\n'));
console.log(`Wrote ${out} (${lines.length} lines)`);
