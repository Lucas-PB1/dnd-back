import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
export const apiRoot = path.join(__dirname, '../..');
export const sourceDir = path.join(apiRoot, 'docs/source/phb-equipment-images');
export const manifestPath = path.join(
  apiRoot,
  'docs/source/phb-cap7-equipment-sprites-extract.json',
);
export const statusPath = path.join(
  apiRoot,
  'docs/source/phb-cap7-equipment-images-status.json',
);
export const publicDir = path.join(apiRoot, 'public/catalog/equipment');
export const reviewDir = path.join(sourceDir, '_review');

export function loadManifest() {
  return JSON.parse(fs.readFileSync(manifestPath, 'utf8'));
}

export function loadStatus() {
  if (!fs.existsSync(statusPath)) return null;
  return JSON.parse(fs.readFileSync(statusPath, 'utf8'));
}

export function saveStatus(status) {
  status.updatedAt = new Date().toISOString();
  fs.writeFileSync(statusPath, `${JSON.stringify(status, null, 2)}\n`);
}

export function listManifestItems(manifest) {
  const items = [];
  for (const composite of manifest.composites) {
    if (composite.crops?.length) {
      for (const [index, crop] of composite.crops.entries()) {
        items.push({
          slug: crop.slug,
          group: composite.group,
          source: composite.source,
          method: 'crop',
          cropIndex: index,
          crop: {
            left: crop.left,
            top: crop.top,
            width: crop.width,
            height: crop.height,
          },
        });
      }
      continue;
    }
    for (const [index, slug] of composite.itemSlugs.entries()) {
      items.push({
        slug,
        group: composite.group,
        source: composite.source,
        method: 'blob',
        blobIndex: index,
        sort: composite.sort ?? 'reading-order',
        dropExtraBlobs: Boolean(composite.dropExtraBlobs),
      });
    }
  }
  return items;
}

export function findCompositeForSlug(manifest, slug) {
  return manifest.composites.find((composite) => {
    if (composite.crops?.some((crop) => crop.slug === slug)) return true;
    return composite.itemSlugs?.includes(slug);
  });
}

export function initStatusFromManifest(manifest) {
  const existing = loadStatus();
  const previous = existing?.items ?? {};
  const items = {};

  for (const entry of listManifestItems(manifest)) {
    const prior = previous[entry.slug];
    items[entry.slug] = {
      slug: entry.slug,
      group: entry.group,
      source: entry.source,
      method: entry.method,
      status: prior?.status ?? 'pending',
      note: prior?.note ?? null,
      verifiedAt: prior?.verifiedAt ?? null,
      frozen: prior?.frozen ?? null,
      blobIndex: entry.blobIndex ?? null,
      cropIndex: entry.cropIndex ?? null,
    };
  }

  return {
    version: 1,
    publicPathPrefix: manifest.publicPathPrefix,
    items,
    updatedAt: new Date().toISOString(),
  };
}

export function publicImagePath(slug) {
  return path.join(publicDir, `${slug}.png`);
}

export function reviewImagePath(entry, slug) {
  const compositeName = path.basename(entry.source, '.png');
  const reviewFolder = path.join(reviewDir, compositeName);
  if (!fs.existsSync(reviewFolder)) return null;
  const files = fs
    .readdirSync(reviewFolder)
    .filter((name) => name.endsWith(`-${slug}.png`));
  return files.length > 0 ? path.join(reviewFolder, files[0]) : null;
}
