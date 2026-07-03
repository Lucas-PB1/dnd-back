/**
 * Proficiências em ferramentas de antecedente + feats de origem (PHB 2024).
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { TOOL_CATEGORIES } from "./tool-categories.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const phb = path.join(__dirname, "..", "..", "data/phb");

const CATEGORY_NAME_TO_SLUG = Object.fromEntries(
  TOOL_CATEGORIES.map((c) => [c.name, c.slug])
);

/** Nomes usados nos JSON de antecedente (podem diferir do rótulo em TOOL_CATEGORIES). */
const CATEGORY_ALIASES = {
  "Kit de Jogos": "kit",
};

function categorySlugForName(categoryName) {
  if (CATEGORY_ALIASES[categoryName]) return CATEGORY_ALIASES[categoryName];
  return CATEGORY_NAME_TO_SLUG[categoryName] ?? null;
}

export function toolsForCategoryName(categoryName) {
  const slug = categorySlugForName(categoryName);
  if (!slug) return [];
  const loader = CATEGORY_TOOL_IDS[slug];
  return loader ? [...loader()].sort() : [];
}

function loadBackground(id) {
  return JSON.parse(fs.readFileSync(path.join(phb, "backgrounds", `${id}.json`), "utf8"));
}

function artisanToolIds() {
  if (!cachedArtisanToolIds) {
    const data = JSON.parse(
      fs.readFileSync(path.join(phb, "equipment/tools/artisan.json"), "utf8")
    );
    cachedArtisanToolIds = data.tools.map((t) => t.id).sort();
  }
  return cachedArtisanToolIds;
}

const CATEGORY_TOOL_IDS = {
  artisan: () => artisanToolIds(),
  instrument: () => ["instrumento-musical"],
  kit: () => ["kit-de-jogos"],
};

let cachedArtisanToolIds = null;

function hashSeed(str) {
  let h = 0;
  for (let i = 0; i < str.length; i++) h = (h * 31 + str.charCodeAt(i)) | 0;
  return Math.abs(h);
}

function pickFromPool(pool, seed) {
  if (!pool.length) return null;
  return pool[seed % pool.length];
}

function pickDistinctFromPool(pool, count, seed, exclude = new Set()) {
  const picked = [];
  for (let i = 0; i < pool.length && picked.length < count; i++) {
    const toolId = pool[(seed + i * 7) % pool.length];
    if (exclude.has(toolId) || picked.includes(toolId)) continue;
    picked.push(toolId);
  }
  for (const toolId of pool) {
    if (picked.length >= count) break;
    if (!exclude.has(toolId) && !picked.includes(toolId)) picked.push(toolId);
  }
  return picked;
}

/** Resolve a ferramenta escolhida (ou fixa) do antecedente. */
export function resolveBackgroundToolId(doc, bg = null) {
  const background = bg ?? loadBackground(doc.backgroundId);
  const toolCfg = background.toolProficiency ?? {};

  if (doc.backgroundChoices?.toolId) {
    return doc.backgroundChoices.toolId;
  }
  if (toolCfg.kind === "fixed") {
    return toolCfg.itemId ?? null;
  }
  if (toolCfg.kind === "choice" && toolCfg.category) {
    const pool = toolsForCategoryName(toolCfg.category);
    return pickFromPool(pool, hashSeed(`${doc.id}:bg-tool`));
  }
  return null;
}

function addTool(tools, have, toolId, source) {
  if (!toolId || have.has(toolId)) return;
  tools.push({ toolId, source });
  have.add(toolId);
}

/** Ferramenta do antecedente (1 proficiência). */
export function applyBackgroundToolProficiencies(doc, bg = null) {
  const background = bg ?? loadBackground(doc.backgroundId);
  const explicit = doc.backgroundChoices?.toolId;
  const toolId = resolveBackgroundToolId(doc, background);
  if (!toolId) return;

  if (explicit) {
    doc.backgroundChoices = { toolId: explicit };
  } else if (background.toolProficiency?.kind === "choice") {
    doc.backgroundChoices = { toolId };
  }

  const tools = [...(doc.toolProficiencies ?? [])];
  const have = new Set(tools.map((t) => t.toolId));
  addTool(tools, have, toolId, "background");
  if (tools.length) doc.toolProficiencies = tools;
}

/** Feats de origem com proficiência em ferramentas (artisan, musician). */
export function applyOriginFeatToolProficiencies(doc) {
  const tools = [...(doc.toolProficiencies ?? [])];
  const have = new Set(tools.map((t) => t.toolId));

  for (const feat of doc.feats ?? []) {
    if (feat.source !== "background") continue;

    if (feat.featId === "artisan") {
      const picked = pickDistinctFromPool(
        artisanToolIds(),
        3,
        hashSeed(`${doc.id}:artisan-feat`),
        have
      );
      for (const toolId of picked) addTool(tools, have, toolId, "background");
    }

    if (feat.featId === "musician") {
      addTool(tools, have, "instrumento-musical", "background");
    }
  }

  if (tools.length) doc.toolProficiencies = tools;
}

export function applyBackgroundToolBenefits(doc, bg = null) {
  applyBackgroundToolProficiencies(doc, bg);
  applyOriginFeatToolProficiencies(doc);
}

export function expectedBackgroundToolProficiencies(doc, bg = null) {
  const background = bg ?? loadBackground(doc.backgroundId);
  const tools = [];
  const have = new Set();

  const bgTool = resolveBackgroundToolId(doc, background);
  addTool(tools, have, bgTool, "background");

  for (const feat of doc.feats ?? []) {
    if (feat.source !== "background") continue;

    if (feat.featId === "artisan") {
      const picked = pickDistinctFromPool(
        artisanToolIds(),
        3,
        hashSeed(`${doc.id}:artisan-feat`),
        have
      );
      for (const toolId of picked) addTool(tools, have, toolId, "background");
    }

    if (feat.featId === "musician") {
      addTool(tools, have, "instrumento-musical", "background");
    }
  }

  return tools;
}

/** Valida que a escolha de ferramenta do antecedente pertence ao pool PHB. */
export function validateBackgroundToolProficiency(doc) {
  const bg = loadBackground(doc.backgroundId);
  const toolCfg = bg.toolProficiency ?? {};
  if (!toolCfg.kind) return { ok: true };

  const bgTools = (doc.toolProficiencies ?? []).filter((t) => t.source === "background");
  const expectedBgTool = resolveBackgroundToolId(doc, bg);
  if (!expectedBgTool) return { ok: true };

  if (!bgTools.some((t) => t.toolId === expectedBgTool)) {
    return {
      ok: false,
      reason: `ferramenta de antecedente ausente: ${expectedBgTool}`,
    };
  }

  if (toolCfg.kind === "choice" && toolCfg.category) {
    const pool = new Set(toolsForCategoryName(toolCfg.category));
    if (!pool.has(expectedBgTool)) {
      return {
        ok: false,
        reason: `${expectedBgTool} fora da categoria ${toolCfg.category}`,
      };
    }
  }

  if (toolCfg.kind === "fixed" && expectedBgTool !== toolCfg.itemId) {
    return {
      ok: false,
      reason: `ferramenta de antecedente ${expectedBgTool}≠${toolCfg.itemId}`,
    };
  }

  return { ok: true };
}
