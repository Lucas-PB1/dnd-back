/**
 * Classifica traços GH Cap.1 → seeds tipados (combat_modifier / economy_action).
 * Uso: node scripts/classify-gh-heritage-trait-mechanics.mjs
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

import { extracts } from './lib/docs-source.mjs';
import { translateGhpgBody } from './lib/ghpg-mechanical-glossary.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const apiRoot = path.join(__dirname, '..');
const cap1 = JSON.parse(fs.readFileSync(extracts.grimHollow.cap1Heritages, 'utf8'));
const ptOverlay = fs.existsSync(extracts.grimHollow.cap1HeritagesPt)
  ? JSON.parse(fs.readFileSync(extracts.grimHollow.cap1HeritagesPt, 'utf8'))
  : null;

const CORE_SLUGS = new Set([
  'improved-darkvision',
  'damage-immunity',
  'extra-tough',
  'weapon-specialist',
  'helpful-tactics',
  'magical-savant',
  'potent-breath',
  'stand-fast',
  'artisanal-expertise',
  'restorative-rest',
]);

/** @param {string} value */
function sqlLiteral(value) {
  return `'${String(value ?? '').replace(/'/g, "''")}'`;
}

/** @param {typeof cap1.traits[0]} trait */
function traitText(trait) {
  const pt = ptOverlay?.traits?.[trait.slug];
  return `${pt?.benefitBase ?? trait.benefitBase ?? ''} ${pt?.benefitImproved ?? trait.benefitImproved ?? ''} ${pt?.description ?? trait.description ?? ''}`.toLowerCase();
}

/** @param {typeof cap1.traits[0]} trait */
function classifyTrait(trait) {
  const text = traitText(trait);
  const name = trait.name.toLowerCase();

  if (trait.slug === 'extra-tough' || /hit point maximum increases by 1 per level/i.test(text)) {
    return { kind: 'passive_hp', perLevel: 1, label: 'Robustez extra' };
  }
  if (trait.slug === 'improved-darkvision' || /darkvision/i.test(text)) {
    return {
      kind: 'passive_sense',
      label: 'Visão no escuro 18 m (36 m se 2×)',
      sense: 'darkvision',
      rangeMeters: 18,
      improvedRangeMeters: 36,
    };
  }
  if (trait.slug === 'damage-immunity' || (/resistance to one/i.test(text) && trait.slug.includes('damage'))) {
    return { kind: 'passive_resistance', label: 'Resistência a dano (escolha)' };
  }
  if (trait.slug === 'weapon-specialist' || /weapon.*proficiency/i.test(text)) {
    return { kind: 'proficiency_grant', label: 'Proficiência em armas (escolha)' };
  }
  if (trait.slug === 'helpful-tactics') {
    return { kind: 'check_advantage', label: 'Vantagem em testes de ajuda' };
  }
  if (trait.slug === 'magical-savant' || trait.slug === 'magical-savant') {
    return { kind: 'spell_grant', label: 'Truques e magias de truque adicionais' };
  }
  if (trait.slug === 'stand-fast') {
    return { kind: 'passive_save', label: 'Bônus em salvaguardas contra movimento' };
  }
  if (trait.slug === 'artisanal-expertise') {
    return { kind: 'proficiency_grant', label: 'Proficiência em ferramentas (escolha)' };
  }
  if (trait.slug === 'restorative-rest') {
    return {
      kind: 'economy_passive',
      actionId: 'heritage-restorative-rest',
      name: 'Descanso Restaurador',
      economy: 'passive',
      summary: 'Gasta Dados de Vida adicionais no descanso curto',
    };
  }
  if (trait.slug === 'potent-breath' || /breath weapon/i.test(text)) {
    return {
      kind: 'economy_action',
      actionId: 'heritage-potent-breath',
      name: 'Sopro Potente',
      economy: 'action',
      resourceSlug: 'potentBreath',
      summary: 'Sopro elemental (PB usos/LR)',
    };
  }
  if (trait.slug === 'restorative-rest' || (/finish a short rest/i.test(text) && /spend.*hit dice/i.test(text))) {
    return {
      kind: 'economy_passive',
      actionId: 'heritage-restorative-rest',
      name: 'Descanso Restaurador',
      economy: 'passive',
      summary: 'Gasta Dados de Vida adicionais no descanso curto',
    };
  }
  if (/proficiency in the/i.test(text) || /proficiency with/i.test(text)) {
    return { kind: 'proficiency_grant', label: trait.name.replace(/\.$/, '') };
  }
  if (/bonus action/i.test(text) && /regain.*long rest/i.test(text)) {
    return { kind: 'economy_action', economy: 'bonus', generic: true };
  }
  if (/as an action/i.test(text) && /regain.*long rest/i.test(text)) {
    return { kind: 'economy_action', economy: 'action', generic: true };
  }
  if (/as a reaction/i.test(text)) {
    return { kind: 'economy_reaction', generic: true };
  }
  if (/advantage on/i.test(text) && !/saving throw against/i.test(text)) {
    return { kind: 'check_advantage', generic: true };
  }
  if (name.includes('speed') || /speed by/i.test(text)) {
    return { kind: 'speed_modifier', generic: true };
  }
  return { kind: 'narrative_only' };
}

const modifierLines = [];
const economyLines = [];
const report = { total: 0, byKind: {} };

for (const trait of cap1.traits) {
  report.total += 1;
  const effect = classifyTrait(trait);
  report.byKind[effect.kind] = (report.byKind[effect.kind] ?? 0) + 1;

  if (effect.kind === 'passive_hp') {
    modifierLines.push(`INSERT INTO rpg.phb_combat_modifier (
  kind, owner_kind, owner_id, heritage_trait_id, label, per_level_bonus, min_trait_takes
)
SELECT
  'hp_bonus'::rpg.combat_modifier_kind,
  'heritage'::rpg.combat_modifier_owner,
  ht.id,
  ht.id,
  ${sqlLiteral(effect.label)},
  ${effect.perLevel},
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = ${sqlLiteral(trait.slug)}
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_combat_modifier cm
    WHERE cm.heritage_trait_id = ht.id AND cm.kind = 'hp_bonus'::rpg.combat_modifier_kind
  );`);
  }

  if (effect.kind === 'economy_action' && trait.slug === 'potent-breath') {
    const desc = translateGhpgBody(trait.benefitBase ?? trait.description).slice(0, 500);
    economyLines.push(`INSERT INTO rpg.phb_class_economy_action (
  action_id, heritage_trait_id, name, economy, unlock_level,
  resource_slug, always_spends_resource, summary, description, table_action, sort_order, min_trait_takes
)
SELECT
  ${sqlLiteral(effect.actionId)},
  ht.id,
  ${sqlLiteral(effect.name)},
  ${sqlLiteral(effect.economy)}::rpg.action_economy_bucket,
  1,
  ${sqlLiteral(effect.resourceSlug)},
  TRUE,
  ${sqlLiteral(effect.summary)},
  ${sqlLiteral(desc)},
  'spend-resource',
  700,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'potent-breath'
ON CONFLICT (action_id) DO UPDATE SET
  heritage_trait_id = EXCLUDED.heritage_trait_id,
  name = EXCLUDED.name,
  summary = EXCLUDED.summary,
  description = EXCLUDED.description,
  min_trait_takes = EXCLUDED.min_trait_takes;`);
  }

  if (effect.kind === 'economy_action' && effect.generic) {
    const actionId = `heritage-${trait.slug}`;
    const name = trait.name.replace(/\.$/, '');
    economyLines.push(`INSERT INTO rpg.phb_class_economy_action (
  action_id, heritage_trait_id, name, economy, unlock_level,
  resource_slug, always_spends_resource, summary, description, table_action, sort_order, min_trait_takes
)
SELECT
  ${sqlLiteral(actionId)},
  ht.id,
  ${sqlLiteral(name)},
  ${sqlLiteral(effect.economy ?? 'bonus')}::rpg.action_economy_bucket,
  1,
  ${sqlLiteral(trait.slug.replace(/-/g, ''))},
  TRUE,
  ${sqlLiteral(name)},
  ${sqlLiteral(translateGhpgBody(trait.benefitBase ?? trait.description).slice(0, 400))},
  'spend-resource',
  700,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = ${sqlLiteral(trait.slug)}
ON CONFLICT (action_id) DO UPDATE SET
  heritage_trait_id = EXCLUDED.heritage_trait_id,
  name = EXCLUDED.name,
  description = EXCLUDED.description;`);
  }

  if (effect.kind === 'economy_reaction' && CORE_SLUGS.has(trait.slug)) {
    const actionId = `heritage-${trait.slug}-reaction`;
    economyLines.push(`INSERT INTO rpg.phb_class_economy_action (
  action_id, heritage_trait_id, name, economy, unlock_level,
  resource_slug, always_spends_resource, summary, description, table_action, sort_order, min_trait_takes
)
SELECT
  ${sqlLiteral(actionId)},
  ht.id,
  ${sqlLiteral(trait.name.replace(/\.$/, ''))},
  'reaction'::rpg.action_economy_bucket,
  1,
  ${sqlLiteral(`${trait.slug.replace(/-/g, '')}Rx`)},
  TRUE,
  ${sqlLiteral(trait.improvedName ?? trait.name.replace(/\.$/, ''))},
  ${sqlLiteral(translateGhpgBody(trait.benefitImproved ?? trait.benefitBase ?? '').slice(0, 400))},
  'spend-resource',
  701,
  2
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = ${sqlLiteral(trait.slug)}
ON CONFLICT (action_id) DO UPDATE SET
  heritage_trait_id = EXCLUDED.heritage_trait_id,
  min_trait_takes = EXCLUDED.min_trait_takes;`);
  }
}

const outCombat = path.join(apiRoot, 'database/seeds/combat');
fs.mkdirSync(outCombat, { recursive: true });

const coreBody = `-- GH heritage traits — core 10 + classificador automático (Cap. 1)

${modifierLines.join('\n\n')}

${economyLines.join('\n\n')}
`;

fs.writeFileSync(path.join(outCombat, 'C070_phb_heritage_trait_mechanics_core.sql'), `${coreBody}\n`, 'utf8');

const bulkTraits = cap1.traits.filter((t) => !CORE_SLUGS.has(t.slug));
const bulkEconomy = [];
for (const trait of cap1.traits) {
  const effect = classifyTrait(trait);
  if (
    (effect.kind === 'economy_action' || effect.kind === 'economy_reaction') &&
    effect.generic &&
    !CORE_SLUGS.has(trait.slug)
  ) {
    const actionId =
      effect.kind === 'economy_reaction'
        ? `heritage-${trait.slug}-reaction`
        : `heritage-${trait.slug}`;
    if (economyLines.some((line) => line.includes(`'${actionId}'`))) continue;
    bulkEconomy.push(`-- ${trait.slug}: ${effect.kind}`);
    bulkEconomy.push(`INSERT INTO rpg.phb_class_economy_action (
  action_id, heritage_trait_id, name, economy, unlock_level,
  resource_slug, always_spends_resource, summary, description, table_action, sort_order, min_trait_takes
)
SELECT
  ${sqlLiteral(actionId)},
  ht.id,
  ${sqlLiteral(trait.name.replace(/\.$/, ''))},
  ${sqlLiteral(effect.economy ?? 'bonus')}::rpg.action_economy_bucket,
  1,
  ${sqlLiteral(trait.slug.replace(/-/g, '').slice(0, 40))},
  TRUE,
  ${sqlLiteral(trait.name.replace(/\.$/, ''))},
  ${sqlLiteral(translateGhpgBody(trait.benefitBase ?? trait.description).slice(0, 350))},
  'spend-resource',
  750,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = ${sqlLiteral(trait.slug)}
ON CONFLICT (action_id) DO NOTHING;`);
  }
}

fs.writeFileSync(
  path.join(outCombat, 'C071_phb_heritage_trait_mechanics_bulk.sql'),
  `-- GH heritage traits — lote bulk (${bulkEconomy.length / 2} ações)\n\n${bulkEconomy.join('\n\n')}\n`,
  'utf8',
);

console.log('Classificação:', report.byKind);
console.log('Gerado C070_phb_heritage_trait_mechanics_core.sql');
console.log('Gerado C071_phb_heritage_trait_mechanics_bulk.sql');
