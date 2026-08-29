/**
 * Verificação item a item das ilustrações de equipamento PHB.
 *
 * Uso:
 *   node scripts/verify-phb-equipment-sprites.mjs init
 *   node scripts/verify-phb-equipment-sprites.mjs status
 *   node scripts/verify-phb-equipment-sprites.mjs list --status pending
 *   node scripts/verify-phb-equipment-sprites.mjs checklist --group martial-melee
 *   node scripts/verify-phb-equipment-sprites.mjs mark sling ok
 *   node scripts/verify-phb-equipment-sprites.mjs mark battleaxe wrong --note "mostra flail"
 */
import fs from 'fs';
import {
  initStatusFromManifest,
  loadManifest,
  loadStatus,
  publicImagePath,
  reviewImagePath,
  saveStatus,
  statusPath,
} from './lib/phb-equipment-sprite-registry.mjs';

const [command, slugArg, statusArg, ...rest] = process.argv.slice(2);

function readFlag(name) {
  const idx = rest.indexOf(name);
  if (idx === -1) return null;
  return rest[idx + 1] ?? true;
}

function readOption(name) {
  const idx = process.argv.indexOf(name);
  return idx >= 0 ? process.argv[idx + 1] : null;
}

function ensureStatus() {
  const status = loadStatus();
  if (!status) {
    throw new Error('Status ausente. Rode: node scripts/verify-phb-equipment-sprites.mjs init');
  }
  return status;
}

function countByStatus(status) {
  const counts = { ok: 0, wrong: 0, pending: 0 };
  for (const item of Object.values(status.items)) {
    counts[item.status] = (counts[item.status] ?? 0) + 1;
  }
  return counts;
}

function filterItems(status, { statusFilter, groupFilter }) {
  return Object.values(status.items).filter((item) => {
    if (statusFilter && item.status !== statusFilter) return false;
    if (groupFilter && item.group !== groupFilter) return false;
    return true;
  });
}

function cmdInit() {
  const manifest = loadManifest();
  const status = initStatusFromManifest(manifest);
  saveStatus(status);
  const counts = countByStatus(status);
  console.log(`Status criado: ${statusPath}`);
  console.log(
    `Itens: ${Object.keys(status.items).length} (ok ${counts.ok}, wrong ${counts.wrong}, pending ${counts.pending})`,
  );
}

function cmdStatus() {
  const status = ensureStatus();
  const counts = countByStatus(status);
  const groups = new Map();
  for (const item of Object.values(status.items)) {
    const row = groups.get(item.group) ?? { ok: 0, wrong: 0, pending: 0 };
    row[item.status] += 1;
    groups.set(item.group, row);
  }

  console.log(`Arquivo: ${statusPath}`);
  console.log(`Atualizado: ${status.updatedAt ?? '—'}`);
  console.log(`Total: ok ${counts.ok} | wrong ${counts.wrong} | pending ${counts.pending}`);
  console.log('');
  for (const [group, row] of [...groups.entries()].sort()) {
    console.log(
      `  ${group}: ok ${row.ok}, wrong ${row.wrong}, pending ${row.pending}`,
    );
  }
}

function cmdList() {
  const status = ensureStatus();
  const statusFilter = readOption('--status');
  const groupFilter = readOption('--group');
  const items = filterItems(status, { statusFilter, groupFilter }).sort((a, b) =>
    a.group === b.group
      ? a.slug.localeCompare(b.slug)
      : a.group.localeCompare(b.group),
  );

  for (const item of items) {
    const publicFile = publicImagePath(item.slug);
    const hasPublic = fs.existsSync(publicFile);
    const note = item.note ? ` — ${item.note}` : '';
    console.log(
      `[${item.status}] ${item.group}/${item.slug} (${item.source})${hasPublic ? '' : ' [sem PNG]'}${note}`,
    );
  }
  console.log(`\n${items.length} item(ns)`);
}

function cmdChecklist() {
  const status = ensureStatus();
  const groupFilter = readOption('--group');
  const statusFilter = readOption('--status') ?? 'pending';
  const items = filterItems(status, { statusFilter, groupFilter }).sort((a, b) => {
    if (a.source !== b.source) return a.source.localeCompare(b.source);
    return a.slug.localeCompare(b.slug);
  });

  let currentSource = null;
  for (const item of items) {
    if (item.source !== currentSource) {
      currentSource = item.source;
      console.log(`\n## ${item.source} (${item.group})`);
    }
    const publicFile = publicImagePath(item.slug);
    const reviewFile = reviewImagePath(item, item.slug);
    console.log(`- [ ] ${item.slug}`);
    if (reviewFile) console.log(`      review: ${reviewFile}`);
    if (fs.existsSync(publicFile)) console.log(`      public: ${publicFile}`);
  }
  console.log(`\n${items.length} para conferir. Depois:`);
  console.log('  node scripts/verify-phb-equipment-sprites.mjs mark <slug> ok');
  console.log('  node scripts/verify-phb-equipment-sprites.mjs mark <slug> wrong --note "..."');
  console.log('  node scripts/split-phb-equipment-sprites.mjs --only wrong,pending');
}

function cmdMark() {
  if (!slugArg || !statusArg) {
    throw new Error('Uso: mark <slug> <ok|wrong|pending> [--note "..."] [--frozen left,top,width,height]');
  }
  if (!['ok', 'wrong', 'pending'].includes(statusArg)) {
    throw new Error('Status deve ser ok, wrong ou pending');
  }

  const status = ensureStatus();
  const item = status.items[slugArg];
  if (!item) {
    throw new Error(`Slug desconhecido no status: ${slugArg}`);
  }

  const note = readOption('--note') ?? (statusArg === 'pending' ? null : item.note);
  const frozenArg = readOption('--frozen');

  item.status = statusArg;
  item.note = note ?? null;

  if (statusArg === 'ok') {
    item.verifiedAt = new Date().toISOString();
    if (frozenArg) {
      const [left, top, width, height] = frozenArg.split(',').map(Number);
      if ([left, top, width, height].some((value) => Number.isNaN(value))) {
        throw new Error('Formato --frozen: left,top,width,height');
      }
      item.frozen = { left, top, width, height };
    } else if (item.lastExport) {
      item.frozen = {
        left: item.lastExport.left,
        top: item.lastExport.top,
        width: item.lastExport.width,
        height: item.lastExport.height,
      };
    } else if (fs.existsSync(publicImagePath(slugArg))) {
      console.log('ok: PNG em public/ preservado; congele com --frozen após próximo split se precisar');
    }
  } else {
    item.verifiedAt = null;
    if (statusArg === 'wrong') {
      item.frozen = null;
    }
  }

  saveStatus(status);
  console.log(`${slugArg} → ${statusArg}${note ? ` (${note})` : ''}`);
}

function main() {
  switch (command) {
    case 'init':
      cmdInit();
      break;
    case 'status':
      cmdStatus();
      break;
    case 'list':
      cmdList();
      break;
    case 'checklist':
      cmdChecklist();
      break;
    case 'mark':
      cmdMark();
      break;
    default:
      throw new Error(
        'Comandos: init | status | list | checklist | mark <slug> <ok|wrong|pending>',
      );
  }
}

main();
