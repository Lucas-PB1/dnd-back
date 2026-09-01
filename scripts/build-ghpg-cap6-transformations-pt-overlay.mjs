/**
 * Gera overlay PT para Cap. 6 GH (12 transformações).
 * Uso: node scripts/build-ghpg-cap6-transformations-pt-overlay.mjs
 */
import fs from 'fs';
import path from 'path';

import { extracts } from './lib/docs-source.mjs';
import {
  resolveCap6Becoming,
  resolveCap6BenefitDescription,
  resolveCap6BenefitName,
  resolveCap6AppendixDescription,
  resolveCap6AppendixTitle,
  resolveCap6StageSummary,
} from './lib/ghpg-cap6-transformation-pt.mjs';

const enPath = extracts.grimHollow.cap6Transformations;
const outPath = path.join(
  path.dirname(enPath),
  'cap6-transformations-pt.json',
);

const en = JSON.parse(fs.readFileSync(enPath, 'utf8'));
const overlay = {
  generatedAt: new Date().toISOString(),
  source: enPath.replace(/\\/g, '/'),
  transformations: {},
};

for (const t of en.transformations) {
  const benefits = {};
  if (t.becoming) {
    benefits.becoming = {
      namePt: 'Como começar',
      descriptionPt: resolveCap6Becoming(t.slug, t.becoming),
    };
  }

  for (const stage of t.stages) {
    if (stage.advancementAnchorId) {
      benefits[stage.advancementAnchorId] = {
        namePt: `Estágio ${stage.stage}`,
        descriptionPt: resolveCap6StageSummary(
          t.slug,
          stage.advancementAnchorId,
          stage.advancementText,
        ),
      };
    }
    benefits[stage.anchorId] = {
      namePt: `Estágio ${stage.stage}`,
      descriptionPt: resolveCap6StageSummary(
        t.slug,
        stage.anchorId,
        stage.summary || stage.body,
      ),
    };
    for (const boon of stage.boons) {
      benefits[boon.anchorId] = {
        namePt: resolveCap6BenefitName(t.slug, boon.anchorId, boon.name),
        descriptionPt: resolveCap6BenefitDescription(
          t.slug,
          boon.anchorId,
          boon.description,
        ),
      };
    }
    for (const flaw of stage.flaws) {
      benefits[flaw.anchorId] = {
        namePt: resolveCap6BenefitName(t.slug, flaw.anchorId, flaw.name),
        descriptionPt: resolveCap6BenefitDescription(
          t.slug,
          flaw.anchorId,
          flaw.description,
        ),
      };
    }
  }

  for (const appendix of t.appendices ?? []) {
    if (appendix.kind === 'gifts') {
      benefits[appendix.anchorId] = {
        namePt: resolveCap6AppendixTitle(appendix.title),
        descriptionPt: resolveCap6AppendixDescription(
          t.slug,
          appendix.anchorId,
          appendix.intro,
        ),
      };
      for (const group of appendix.groups ?? []) {
        if (group.intro) {
          benefits[group.anchorId] = {
            namePt: resolveCap6AppendixTitle(group.title),
            descriptionPt: resolveCap6AppendixDescription(
              t.slug,
              group.anchorId,
              group.intro,
            ),
          };
        }
        for (const entry of group.entries ?? []) {
          benefits[entry.anchorId] = {
            namePt: resolveCap6BenefitName(t.slug, entry.anchorId, entry.name),
            descriptionPt: resolveCap6AppendixDescription(
              t.slug,
              entry.anchorId,
              entry.description,
            ),
          };
        }
      }
      continue;
    }
    benefits[appendix.anchorId] = {
      namePt: `Apêndice: ${resolveCap6AppendixTitle(appendix.title)}`,
      descriptionPt: resolveCap6AppendixDescription(
        t.slug,
        appendix.anchorId,
        appendix.description ?? '',
      ),
    };
  }

  overlay.transformations[t.slug] = {
    namePt: t.namePt,
    benefits,
  };
}

fs.writeFileSync(outPath, `${JSON.stringify(overlay, null, 2)}\n`, 'utf8');
console.log(
  `wrote ${outPath.replace(/\\/g, '/')} — ${Object.keys(overlay.transformations).length} transformações`,
);
