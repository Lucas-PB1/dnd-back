/**
 * Parsers auxiliares — extract Cap. 6 GHPG (transformações).
 */
import {
  detectActionEconomy,
  extractParagraphs,
  extractStructuredProse,
  extractTableProse,
  stripAsideBlocks,
  stripCap6FlavorAside,
  stripTags,
} from './ghpg-html-utils.mjs';

/** Remove metadado `<em> X Stage N Boon</em>` do corpo do h5. */
export function cleanCap6BoonBodyHtml(html) {
  return stripAsideBlocks(
    html.replace(/<em>\s*[^<]*(?:Boon|Flaw)[^<]*<\/em>\s*/gi, ''),
  );
}

/** @param {string} block */
export function extractCap6Prose(block) {
  const cleaned = cleanCap6BoonBodyHtml(block);
  const text =
    extractStructuredProse(cleaned) || extractParagraphs(cleaned).join('\n\n');
  return stripCap6FlavorAside(text);
}

/** @param {string} stageBlock */
export function parseBoonsAndFlaws(stageBlock) {
  const boons = [];
  const flaws = [];

  for (const m of stageBlock.matchAll(
    /<h5[^>]*\sid="([^"]+)"[^>]*>([\s\S]*?)<\/h5>\s*([\s\S]*?)(?=<h5|<h4|<h3|<h2|<hr|$)/gi,
  )) {
    const anchorId = m[1];
    const label = stripTags(m[2] || anchorId);
    const text = extractCap6Prose(m[3]);
    const entry = {
      anchorId,
      name: label,
      description: text,
      actionEconomy: detectActionEconomy(text),
    };
    if (/flaw/i.test(anchorId) || /flaw/i.test(label)) flaws.push(entry);
    else boons.push(entry);
  }

  return { boons, flaws };
}

/**
 * @param {string} typeBlock HTML do h2 da transformação
 * @param {string} typeName
 */
export function parseStages(typeBlock, typeName) {
  const h4Blocks = [];
  for (const m of typeBlock.matchAll(
    /<h4[^>]*\sid="([^"]+)"[^>]*>[\s\S]*?<\/h4>\s*([\s\S]*?)(?=<h4|<h3|<h2|<hr class="separator">|$)/gi,
  )) {
    h4Blocks.push({ anchorId: m[1], body: m[2] });
  }

  /** @type {Map<number, { anchorId: string; text: string }>} */
  const advancementByStage = new Map();
  const stages = [];

  for (const block of h4Blocks) {
    const ach = block.anchorId.match(/^AchievingANewStage(\d+)$/i);
    if (ach) {
      advancementByStage.set(Number(ach[1]), {
        anchorId: block.anchorId,
        text: extractCap6Prose(block.body),
      });
      continue;
    }

    const stageNum = block.anchorId.match(/Stage(\d+)$/i);
    if (!stageNum) continue;

    const stage = Number(stageNum[1]);
    const stageBlock = block.body;
    const { boons, flaws } = parseBoonsAndFlaws(stageBlock);
    const bodyText = extractCap6Prose(stageBlock);
    const advancement = advancementByStage.get(stage);

    stages.push({
      stage,
      anchorId: block.anchorId,
      title: `${typeName} Stage ${stage}`,
      summary: bodyText.split('\n\n')[0] ?? '',
      body: bodyText,
      advancementAnchorId: advancement?.anchorId ?? null,
      advancementText: advancement?.text ?? null,
      boons,
      flaws,
      actionEconomy: detectActionEconomy(bodyText),
    });
  }

  return stages.sort((a, b) => a.stage - b.stage);
}

/** @param {string} sectionHtml */
function parseGiftEntries(sectionHtml) {
  const entries = [];
  for (const m of sectionHtml.matchAll(
    /<h5[^>]*\sid="([^"]+)"[^>]*>([\s\S]*?)<\/h5>\s*([\s\S]*?)(?=<h5|<h4|<h3|<h2|$)/gi,
  )) {
    entries.push({
      anchorId: m[1],
      name: stripTags(m[2]),
      description: extractCap6Prose(m[3]),
    });
  }
  return entries;
}

/** @param {string} typeBlock */
export function parseAppendices(typeBlock) {
  const appendices = [];

  const giftsMatch = typeBlock.match(
    /<h3[^>]*\bid="GiftsOfDamnation"[^>]*>[\s\S]*?(?=<h2\b|$)/i,
  );
  if (giftsMatch) {
    const section = giftsMatch[0];
    const intro = extractCap6Prose(
      section.split(/<h4/i)[0] ?? section,
    );
    const groups = [];
    for (const m of section.matchAll(
      /<h4[^>]*\bid="([^"]+)"[^>]*>[\s\S]*?<\/h4>\s*([\s\S]*?)(?=<h4|<h3|<h2|$)/gi,
    )) {
      groups.push({
        anchorId: m[1],
        title: stripTags(m[0].match(/<h4[^>]*>([\s\S]*?)<\/h4>/i)?.[1] ?? m[1]),
        intro: extractCap6Prose(m[2].split(/<h5/i)[0] ?? ''),
        entries: parseGiftEntries(m[2]),
      });
    }
    appendices.push({
      kind: 'gifts',
      anchorId: 'GiftsOfDamnation',
      title: 'Dádivas da Perdição',
      intro,
      groups,
    });
  }

  for (const m of typeBlock.matchAll(
    /<div class="table-overflow-wrapper">([\s\S]*?)<\/div>/gi,
  )) {
    const tableHtml = m[1];
    const anchorId =
      tableHtml.match(/\bid="([^"]*Table[^"]*)"/i)?.[1] ??
      tableHtml.match(/\bid="([^"]+)"/i)?.[1];
    if (!anchorId) continue;
    const title =
      stripTags(
        tableHtml.match(/<h4[^>]*>([\s\S]*?)<\/h4>/i)?.[1] ??
          tableHtml.match(/<caption[^>]*>([\s\S]*?)<\/caption>/i)?.[1] ??
          anchorId,
      ) || anchorId;
    appendices.push({
      kind: 'table',
      anchorId,
      title,
      description: extractTableProse(tableHtml),
    });
  }

  for (const m of typeBlock.matchAll(
    /<aside class="grim--rules-sidebar"[^>]*\bid="([^"]+)"[^>]*>([\s\S]*?)<\/aside>/gi,
  )) {
    const title =
      stripTags(m[2].match(/<p[^>]*>([\s\S]*?)<\/p>/i)?.[1] ?? m[1]) || m[1];
    appendices.push({
      kind: 'sidebar',
      anchorId: m[1],
      title,
      description: extractCap6Prose(m[2]),
    });
  }

  return appendices;
}
