/**
 * Gera overlay PT para Cap. 5 GH (nomes editoriais + prosa via glossário GH).
 *
 * Uso: node scripts/build-ghpg-cap5-pt-overlay.mjs
 */
import fs from 'fs';

import {
  CAP5_ITEM_DESCRIPTIONS_PT,
  CAP5_MASTERY_DESCRIPTIONS_PT,
  CAP5_PROPERTY_DESCRIPTIONS_PT,
} from './lib/ghpg-cap5-descriptions-pt.mjs';
import {
  CAP5_MASTERY_NAMES_PT,
  CAP5_NAMES_PT,
  CAP5_PROPERTY_NAMES_PT,
} from './lib/ghpg-cap5-names-pt.mjs';
import { translateGhpgBody } from './lib/ghpg-mechanical-glossary.mjs';
import { extracts } from './lib/docs-source.mjs';

const extractPath = extracts.grimHollow.cap5AdvancedEquipment;
const outPath = extracts.grimHollow.cap5AdvancedEquipmentPt;

const WEAPON_DESC_PT =
  'Arma avançada de Grim Hollow. Sem proficiência em Armas Avançadas, você tem Desvantagem nos ataques. ' +
  'Propriedades marcadas com * e maestrias exigem o talento Proficiência em Armas Avançadas ' +
  '(Estilo de Luta ou talento Geral a partir do nível 8).';

const AMMO_DESC_PT =
  'Munição avançada de Grim Hollow. Exige proficiência na arma que dispara a munição e nível 3 ou superior.';

/** @param {string} slug @param {string} enName @param {string} enDescription @param {'weapon'|'equipment'|'ammunition'} kind */
function resolveItem(slug, enName, enDescription, kind) {
  const name = CAP5_NAMES_PT[slug] ?? enName;
  let description = CAP5_ITEM_DESCRIPTIONS_PT[slug];

  if (!description) {
    description = enDescription?.trim() ?? '';
    if (kind === 'weapon' && description.startsWith('Arma avançada de Grim Hollow')) {
      description = WEAPON_DESC_PT;
    } else if (
      kind === 'ammunition' &&
      (description.startsWith('Munição avançada') || description.length < 40)
    ) {
      description = AMMO_DESC_PT;
    } else if (description.length > 20) {
      description = translateGhpgBody(description);
    }
  }

  return { name, description };
}

const extract = JSON.parse(fs.readFileSync(extractPath, 'utf8'));
const overlay = {
  generatedAt: new Date().toISOString(),
  sourceExtract: extractPath,
  items: {},
  weaponProperties: {},
  weaponMasteries: {},
  rules: {
    advancedWeaponTrainingIntro: translateGhpgBody(
      extract.rules?.advancedWeaponTraining?.introEn ?? '',
    ),
    advancedAmmunitionIntro: translateGhpgBody(
      extract.rules?.advancedAmmunition?.introEn ?? '',
    ),
    advancedEquipmentIntro: translateGhpgBody(
      extract.rules?.advancedEquipment?.introEn ?? '',
    ),
  },
};

for (const w of [...extract.meleeWeapons, ...extract.rangedWeapons]) {
  overlay.items[w.slug] = resolveItem(w.slug, w.name, w.description, 'weapon');
}

for (const g of extract.equipment ?? []) {
  overlay.items[g.slug] = resolveItem(g.slug, g.name, g.description, 'equipment');
}

for (const a of extract.ammunition ?? []) {
  overlay.items[a.slug] = resolveItem(a.slug, a.name, a.description, 'ammunition');
}

for (const row of extract.rules?.weaponProperties ?? []) {
  overlay.weaponProperties[row.slug] = {
    name: CAP5_PROPERTY_NAMES_PT[row.slug] ?? row.slug,
    description:
      CAP5_PROPERTY_DESCRIPTIONS_PT[row.slug] ??
      translateGhpgBody(row.descriptionEn),
  };
}

for (const row of extract.rules?.weaponMasteries ?? []) {
  overlay.weaponMasteries[row.slug] = {
    name: CAP5_MASTERY_NAMES_PT[row.slug] ?? row.slug,
    description:
      CAP5_MASTERY_DESCRIPTIONS_PT[row.slug] ??
      translateGhpgBody(row.descriptionEn),
  };
}

for (const slug of ['swift']) {
  if (!overlay.weaponMasteries[slug] && CAP5_MASTERY_DESCRIPTIONS_PT[slug]) {
    overlay.weaponMasteries[slug] = {
      name: CAP5_MASTERY_NAMES_PT[slug] ?? slug,
      description: CAP5_MASTERY_DESCRIPTIONS_PT[slug],
    };
  }
}

fs.writeFileSync(outPath, `${JSON.stringify(overlay, null, 2)}\n`);
console.log(
  `Overlay PT: ${outPath.replace(/\\/g, '/')}`,
);
console.log(
  `  itens=${Object.keys(overlay.items).length} props=${Object.keys(overlay.weaponProperties).length} maestrias=${Object.keys(overlay.weaponMasteries).length}`,
);
