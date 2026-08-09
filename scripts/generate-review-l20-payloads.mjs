/**
 * Gera payloads L20 completos com nomes Review · …
 * Uso: node scripts/generate-review-l20-payloads.mjs [outDir]
 */
import fs from 'fs';
import path from 'path';
import { loadEnv, rootDir } from './lib/load-env.mjs';
import { createPgClient, maskDatabaseUrl } from './lib/pg-client.mjs';
import { loadCatalog, indexCatalog } from './lib/l20-sheet/catalog.mjs';
import { buildL20Payload } from './lib/l20-sheet/build-payload.mjs';

const CLASS_LABEL = {
  barbarian: 'Bárbaro',
  bard: 'Bardo',
  cleric: 'Clérigo',
  druid: 'Druida',
  fighter: 'Guerreiro',
  gunslinger: 'Pistoleiro',
  monk: 'Monge',
  paladin: 'Paladino',
  ranger: 'Guardião',
  rogue: 'Ladino',
  sorcerer: 'Feiticeiro',
  warlock: 'Bruxo',
  wizard: 'Mago',
};

const PREFERRED_SUBCLASS = {
  wizard: 'magic-missile-mage',
};

loadEnv();

const outDir = path.resolve(
  process.argv[2] ?? path.join(rootDir, 'tmp', 'review-l20'),
);
const url = process.env.DATABASE_URL;
if (!url) {
  console.error('DATABASE_URL não definida');
  process.exit(1);
}

fs.mkdirSync(outDir, { recursive: true });
const client = createPgClient(url);
await client.connect();
console.log('Catálogo', maskDatabaseUrl(url));

const catalog = await loadCatalog(client);
const idx = indexCatalog(catalog);
const index = [];

try {
  for (const cls of catalog.classes) {
    const name = `Review · ${CLASS_LABEL[cls.slug] ?? cls.slug}`;
    try {
      const payload = await buildL20Payload(client, idx, {
        classSlug: cls.slug,
        seedLabel: name,
        preferredSubclassSlug: PREFERRED_SUBCLASS[cls.slug],
      });
      const file = path.join(outDir, `${cls.slug}.json`);
      fs.writeFileSync(file, JSON.stringify(payload, null, 2), 'utf8');
      index.push({
        ok: true,
        classSlug: cls.slug,
        subclassSlug: payload.subclassSlug,
        name,
        file,
        spells: payload.characterSpells?.length ?? 0,
        equipment: payload.equipment?.length ?? 0,
        feats: payload.characterFeats?.length ?? 0,
      });
      console.log(
        `OK ${name} (${payload.subclassSlug}) spells=${payload.characterSpells?.length ?? 0} eq=${payload.equipment?.length ?? 0}`,
      );
    } catch (err) {
      index.push({ ok: false, classSlug: cls.slug, error: err.message });
      console.error(`FAIL ${cls.slug}:`, err.message);
    }
  }
} finally {
  await client.end();
}

fs.writeFileSync(
  path.join(outDir, '_index.json'),
  JSON.stringify(index, null, 2),
  'utf8',
);
const failed = index.filter((e) => !e.ok).length;
console.log(`\nSaída: ${outDir} · total=${index.length} · falhas=${failed}`);
process.exitCode = failed ? 1 : 0;
