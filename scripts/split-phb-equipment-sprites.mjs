/**
 * Recorta sprites compostos do PHB (armas/armaduras em um PNG)
 * em arquivos individuais por slug de item.
 *
 * Uso:
 *   node scripts/split-phb-equipment-sprites.mjs --dry-run
 *   node scripts/split-phb-equipment-sprites.mjs
 *   node scripts/split-phb-equipment-sprites.mjs --review
 *   node scripts/split-phb-equipment-sprites.mjs --group simple-range
 *   node scripts/split-phb-equipment-sprites.mjs --only wrong,pending
 *   node scripts/split-phb-equipment-sprites.mjs --skip-verified
 *   node scripts/split-phb-equipment-sprites.mjs --slug battleaxe
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import sharp from 'sharp';
import {
  loadManifest,
  loadStatus,
  publicImagePath,
  saveStatus,
  statusPath,
} from './lib/phb-equipment-sprite-registry.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const apiRoot = path.join(__dirname, '..');
const sourceDir = path.join(apiRoot, 'docs/source/phb-equipment-images');
const manifestPath = path.join(
  apiRoot,
  'docs/source/phb-cap7-equipment-sprites-extract.json',
);
const defaultOutDir = path.join(apiRoot, 'public/catalog/equipment');
const reviewDir = path.join(sourceDir, '_review');

const args = new Set(process.argv.slice(2));
const dryRun = args.has('--dry-run');
const review = args.has('--review');
const groupFilter = (() => {
  const idx = process.argv.indexOf('--group');
  return idx >= 0 ? process.argv[idx + 1] : null;
})();
const slugFilter = (() => {
  const idx = process.argv.indexOf('--slug');
  return idx >= 0 ? process.argv[idx + 1] : null;
})();
const onlyFilter = (() => {
  const idx = process.argv.indexOf('--only');
  return idx >= 0 ? process.argv[idx + 1] : null;
})();
const skipVerified = args.has('--skip-verified');
const forceExport = args.has('--force');

const PADDING_PX = 8;
const MIN_BLOB_PIXELS = 400;
const MERGE_GAP_PX = 56;
const MIN_AREA_FOR_STANDALONE = 2500;

function index(x, y, width) {
  return y * width + x;
}

function isForeground(data, i, channels) {
  const alpha = channels === 4 ? data[i + 3] : 255;
  if (alpha < 12) return false;
  const r = data[i];
  const g = data[i + 1];
  const b = data[i + 2];
  return r + g + b > 28;
}

function findBlobs(data, width, height, channels) {
  const labels = new Int32Array(width * height);
  const blobs = [];
  let label = 0;

  for (let y = 0; y < height; y++) {
    for (let x = 0; x < width; x++) {
      const i = index(x, y, width);
      if (labels[i] !== 0) continue;
      const px = i * channels;
      if (!isForeground(data, px, channels)) continue;

      label += 1;
      const stack = [[x, y]];
      labels[i] = label;
      let minX = x;
      let maxX = x;
      let minY = y;
      let maxY = y;
      let count = 0;

      while (stack.length > 0) {
        const [cx, cy] = stack.pop();
        count += 1;

        const neighbors = [
          [cx - 1, cy],
          [cx + 1, cy],
          [cx, cy - 1],
          [cx, cy + 1],
        ];

        for (const [nx, ny] of neighbors) {
          if (nx < 0 || ny < 0 || nx >= width || ny >= height) continue;
          const ni = index(nx, ny, width);
          if (labels[ni] !== 0) continue;
          const npx = ni * channels;
          if (!isForeground(data, npx, channels)) continue;
          labels[ni] = label;
          stack.push([nx, ny]);
          if (nx < minX) minX = nx;
          if (nx > maxX) maxX = nx;
          if (ny < minY) minY = ny;
          if (ny > maxY) maxY = ny;
        }
      }

      if (count < MIN_BLOB_PIXELS) continue;

      blobs.push({
        minX,
        minY,
        maxX,
        maxY,
        count,
        centerX: (minX + maxX) / 2,
        centerY: (minY + maxY) / 2,
        width: maxX - minX + 1,
        height: maxY - minY + 1,
      });
    }
  }

  return blobs;
}

function gapBetween(a, b) {
  const dx = Math.max(0, Math.max(a.minX - b.maxX, b.minX - a.maxX));
  const dy = Math.max(0, Math.max(a.minY - b.maxY, b.minY - a.maxY));
  return Math.hypot(dx, dy);
}

function unionBox(a, b) {
  const minX = Math.min(a.minX, b.minX);
  const minY = Math.min(a.minY, b.minY);
  const maxX = Math.max(a.maxX, b.maxX);
  const maxY = Math.max(a.maxY, b.maxY);
  return {
    minX,
    minY,
    maxX,
    maxY,
    count: a.count + b.count,
    centerX: (minX + maxX) / 2,
    centerY: (minY + maxY) / 2,
    width: maxX - minX + 1,
    height: maxY - minY + 1,
  };
}

function mergeNearbyBlobs(blobs, maxGap = MERGE_GAP_PX) {
  let merged = [...blobs];
  let changed = true;

  while (changed) {
    changed = false;
    const next = [];
    const used = new Set();

    for (let i = 0; i < merged.length; i++) {
      if (used.has(i)) continue;
      let box = { ...merged[i] };
      used.add(i);

      for (let j = i + 1; j < merged.length; j++) {
        if (used.has(j)) continue;
        if (gapBetween(box, merged[j]) > maxGap) continue;
        box = unionBox(box, merged[j]);
        used.add(j);
        changed = true;
      }

      next.push(box);
    }

    merged = next;
  }

  return merged;
}

function attachSmallBlobs(blobs) {
  const large = blobs.filter((blob) => blob.width * blob.height >= MIN_AREA_FOR_STANDALONE);
  const small = blobs.filter((blob) => blob.width * blob.height < MIN_AREA_FOR_STANDALONE);
  if (small.length === 0) return blobs;

  const merged = [...large];
  for (const tiny of small) {
    let bestIdx = -1;
    let bestGap = Infinity;
    for (let i = 0; i < merged.length; i++) {
      const gap = gapBetween(tiny, merged[i]);
      if (gap < bestGap) {
        bestGap = gap;
        bestIdx = i;
      }
    }
    if (bestIdx >= 0 && bestGap <= MERGE_GAP_PX * 3) {
      merged[bestIdx] = unionBox(merged[bestIdx], tiny);
    } else {
      merged.push(tiny);
    }
  }
  return merged;
}

function sortBlobs(blobs, mode) {
  if (mode === 'x') {
    return [...blobs].sort((a, b) => a.centerX - b.centerX);
  }
  return sortReadingOrder(blobs);
}

function dropNoiseBlobs(blobs, minAreaRatio = 0.03) {
  if (blobs.length === 0) return blobs;
  const maxArea = Math.max(...blobs.map((blob) => blob.width * blob.height));
  const minArea = maxArea * minAreaRatio;
  return blobs.filter((blob) => blob.width * blob.height >= minArea);
}

function trimExtraBlobs(blobs, expectedCount) {
  if (blobs.length <= expectedCount) return blobs;
  const ranked = blobs
    .map((blob, index) => ({
      index,
      area: blob.width * blob.height,
      blob,
    }))
    .sort((a, b) => a.area - b.area);
  const drop = new Set(
    ranked.slice(0, blobs.length - expectedCount).map((row) => row.index),
  );
  return blobs.filter((_, index) => !drop.has(index));
}

function sortReadingOrder(blobs) {
  if (blobs.length === 0) return blobs;

  const avgHeight =
    blobs.reduce((sum, blob) => sum + blob.height, 0) / blobs.length;
  const rowThreshold = Math.max(avgHeight * 0.45, 40);

  return [...blobs].sort((a, b) => {
    const rowA = Math.round(a.centerY / rowThreshold);
    const rowB = Math.round(b.centerY / rowThreshold);
    if (rowA !== rowB) return rowA - rowB;
    return a.centerX - b.centerX;
  });
}

function padBox(box, imageWidth, imageHeight) {
  return {
    left: Math.max(0, box.minX - PADDING_PX),
    top: Math.max(0, box.minY - PADDING_PX),
    width: Math.min(imageWidth, box.maxX + PADDING_PX + 1) - Math.max(0, box.minX - PADDING_PX),
    height: Math.min(imageHeight, box.maxY + PADDING_PX + 1) - Math.max(0, box.minY - PADDING_PX),
  };
}

async function analyzeComposite(composite) {
  const sourcePath = path.join(sourceDir, composite.source);
  if (!fs.existsSync(sourcePath)) {
    throw new Error(`Arquivo ausente: ${composite.source}`);
  }

  const { data, info } = await sharp(sourcePath)
    .ensureAlpha()
    .raw()
    .toBuffer({ resolveWithObject: true });

  const rawBlobs = findBlobs(data, info.width, info.height, info.channels);
  const withFragments = attachSmallBlobs(rawBlobs);
  const denoised = dropNoiseBlobs(withFragments);
  const merged = composite.mergeGap
    ? mergeNearbyBlobs(denoised, composite.mergeGap)
    : denoised;
  const sorted = sortBlobs(merged, composite.sort ?? 'reading-order');

  return { sourcePath, info, blobs: sorted };
}

function formatBlobSummary(blobs, slugs) {
  return blobs
    .map((blob, idx) => {
      const slug = slugs[idx] ?? '?';
      return `  ${String(idx + 1).padStart(2, '0')}. ${slug} — ${blob.width}×${blob.height} @ (${Math.round(blob.centerX)}, ${Math.round(blob.centerY)})`;
    })
    .join('\n');
}

async function cropBlob(sourcePath, box, destPath) {
  await sharp(sourcePath)
    .extract(box)
    .png()
    .toFile(destPath);
}

function shouldExportSlug(slug, status) {
  if (slugFilter && slug !== slugFilter) return false;
  const item = status?.items?.[slug];
  if (forceExport) return true;
  if (onlyFilter) {
    const allowed = new Set(onlyFilter.split(',').map((value) => value.trim()));
    if (!item || !allowed.has(item.status)) return false;
  }
  if (skipVerified && item?.status === 'ok') return false;
  return true;
}

function resolveSlugPlan(slug, composite, blobs, status) {
  const item = status?.items?.[slug];
  if (item?.frozen) {
    return {
      slug,
      box: {
        left: item.frozen.left,
        top: item.frozen.top,
        width: item.frozen.width,
        height: item.frozen.height,
      },
      from: 'frozen',
    };
  }

  if (composite.crops?.length) {
    const crop = composite.crops.find((row) => row.slug === slug);
    if (!crop) return null;
    return {
      slug,
      box: { left: crop.left, top: crop.top, width: crop.width, height: crop.height },
      from: 'crop',
    };
  }

  const index = composite.itemSlugs.indexOf(slug);
  if (index < 0 || !blobs[index]) return null;
  return { slug, blob: blobs[index], from: 'blob' };
}

async function processComposite(composite, manifest, status) {
  const sourcePath = path.join(sourceDir, composite.source);
  if (!fs.existsSync(sourcePath)) {
    throw new Error(`Arquivo ausente: ${composite.source}`);
  }

  const info = await sharp(sourcePath).metadata();
  const analyzed = composite.crops?.length ? null : await analyzeComposite(composite);
  const blobs = analyzed?.blobs ?? [];

  const slugList = composite.crops?.length
    ? composite.crops.map((crop) => crop.slug)
    : composite.itemSlugs;

  const plans = slugList
    .map((slug) => resolveSlugPlan(slug, composite, blobs, status))
    .filter(Boolean)
    .filter((plan) => shouldExportSlug(plan.slug, status));

  console.log(`\n${composite.source} [${composite.group}]`);
  console.log(`  exportar: ${plans.length}/${slugList.length} slug(s)`);

  if (plans.length === 0) {
    return { composite, exported: [], skipped: slugList.length, mismatched: false };
  }

  for (const plan of plans) {
    const label = plan.from === 'blob'
      ? `${plan.blob.width}×${plan.blob.height} @ (${Math.round(plan.blob.centerX)}, ${Math.round(plan.blob.centerY)})`
      : `${plan.box.width}×${plan.box.height} @ (${Math.round(plan.box.left + plan.box.width / 2)}, ${Math.round(plan.box.top + plan.box.height / 2)})`;
    console.log(`  · ${plan.slug} [${plan.from}] — ${label}`);
  }

  if (dryRun) {
    return {
      composite,
      exported: plans.map((plan) => plan.slug),
      skipped: slugList.length - plans.length,
      mismatched: false,
    };
  }

  const outBase = review
    ? path.join(reviewDir, path.basename(composite.source, '.png'))
    : defaultOutDir;

  fs.mkdirSync(outBase, { recursive: true });

  const exported = [];

  for (const plan of plans) {
    const box = plan.box
      ? plan.box
      : padBox(plan.blob, info.width, info.height);
    const fileName = review
      ? `${String(slugList.indexOf(plan.slug) + 1).padStart(2, '0')}-${plan.slug}.png`
      : `${plan.slug}.png`;
    const destPath = path.join(outBase, fileName);
    await cropBlob(sourcePath, box, destPath);

    if (status?.items?.[plan.slug]) {
      status.items[plan.slug].lastExport = {
        ...box,
        exportedAt: new Date().toISOString(),
        from: plan.from,
      };
    }

    exported.push(plan.slug);
    console.log(`  ✓ ${plan.slug}`);
  }

  return {
    composite,
    exported,
    skipped: slugList.length - plans.length,
    mismatched: false,
  };
}

async function main() {
  const manifest = loadManifest();
  let composites = manifest.composites;
  let status = loadStatus();

  if (!status && (skipVerified || onlyFilter)) {
    console.warn(`Status ausente (${statusPath}). Rode: node scripts/verify-phb-equipment-sprites.mjs init`);
  }

  if (groupFilter) {
    composites = composites.filter((row) => row.group === groupFilter);
    if (composites.length === 0) {
      throw new Error(`Grupo não encontrado: ${groupFilter}`);
    }
  }

  if (slugFilter) {
    composites = composites.filter((composite) => {
      if (composite.crops?.some((crop) => crop.slug === slugFilter)) return true;
      return composite.itemSlugs?.includes(slugFilter);
    });
    if (composites.length === 0) {
      throw new Error(`Slug não encontrado no manifesto: ${slugFilter}`);
    }
  }

  let exportedTotal = 0;
  let skippedTotal = 0;

  for (const composite of composites) {
    const result = await processComposite(composite, manifest, status);
    exportedTotal += result.exported.length;
    skippedTotal += result.skipped;
  }

  if (status) {
    saveStatus(status);
  }

  if (dryRun) {
    console.log(`\n--dry-run: ${exportedTotal} slug(s) seriam exportados, ${skippedTotal} ignorados.`);
    return;
  }

  if (review) {
    console.log(`\nRevisão em: ${reviewDir}`);
    return;
  }

  console.log(`\nSaída: ${defaultOutDir}`);
  console.log(`Exportados: ${exportedTotal} | Ignorados: ${skippedTotal}`);
  if (status) {
    console.log(`Status: ${statusPath}`);
  }
}

main().catch((error) => {
  console.error(error.message);
  process.exit(1);
});
