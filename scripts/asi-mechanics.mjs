/** Funções compartilhadas de ASI (evita dependência circular entre progressão de classe e talentos gerais). */

export function pickAsiBoost(abilities, priority, maxScore = 20) {
  const primary = priority[0];
  if ((abilities[primary] ?? 0) + 2 <= maxScore) {
    return { mode: "single+2", abilityIds: [primary] };
  }
  for (let i = 0; i < priority.length - 1; i++) {
    const a = priority[i];
    const b = priority[i + 1];
    if ((abilities[a] ?? 0) + 1 <= maxScore && (abilities[b] ?? 0) + 1 <= maxScore) {
      return { mode: "double+1", abilityIds: [a, b] };
    }
  }
  for (const a of priority) {
    for (const b of priority) {
      if (a === b) continue;
      if ((abilities[a] ?? 0) + 1 <= maxScore && (abilities[b] ?? 0) + 1 <= maxScore) {
        return { mode: "double+1", abilityIds: [a, b] };
      }
    }
  }
  return { mode: "single+2", abilityIds: [primary] };
}

export function pickEpicBoonAsi(featId, abilities, priority, maxScore = 30) {
  const restricted = {
    "boon-of-spell-recall": ["inteligencia", "sabedoria", "carisma"],
    "boon-of-irresistible-offense": ["forca", "destreza"],
  };
  const pool = restricted[featId] ?? priority;
  for (const id of pool) {
    if ((abilities[id] ?? 0) + 1 <= maxScore) {
      return { mode: "single+1", abilityIds: [id], maxScore };
    }
  }
  return { mode: "single+1", abilityIds: [pool[0]], maxScore };
}

export function applyAsiBoost(abilities, asi) {
  const out = { ...abilities };
  const applied = {};
  const cap = asi.maxScore ?? 20;

  if (asi.mode === "single+2") {
    const id = asi.abilityIds[0];
    const delta = Math.min(2, Math.max(0, cap - (out[id] ?? 0)));
    out[id] = (out[id] ?? 0) + delta;
    if (delta) applied[id] = delta;
  } else if (asi.mode === "double+1") {
    for (const id of asi.abilityIds) {
      const delta = Math.min(1, Math.max(0, cap - (out[id] ?? 0)));
      out[id] = (out[id] ?? 0) + delta;
      if (delta) applied[id] = delta;
    }
  } else if (asi.mode === "single+1") {
    const id = asi.abilityIds[0];
    const delta = Math.min(1, Math.max(0, cap - (out[id] ?? 0)));
    out[id] = (out[id] ?? 0) + delta;
    if (delta) applied[id] = delta;
  }

  asi.applied = applied;
  return out;
}

export function sumAsiDeltas(feats) {
  const deltas = {};
  for (const feat of feats ?? []) {
    const asi = feat.asi;
    if (!asi) continue;
    if (asi.applied) {
      for (const [id, delta] of Object.entries(asi.applied)) {
        deltas[id] = (deltas[id] ?? 0) + delta;
      }
      continue;
    }
    if (asi.mode === "single+2") {
      deltas[asi.abilityIds[0]] = (deltas[asi.abilityIds[0]] ?? 0) + 2;
    } else if (asi.mode === "double+1") {
      for (const id of asi.abilityIds) deltas[id] = (deltas[id] ?? 0) + 1;
    } else if (asi.mode === "single+1") {
      deltas[asi.abilityIds[0]] = (deltas[asi.abilityIds[0]] ?? 0) + 1;
    }
  }
  return deltas;
}

export function abilitiesWithoutAsi(abilities, feats) {
  const out = { ...abilities };
  for (const [id, delta] of Object.entries(sumAsiDeltas(feats))) {
    out[id] = (out[id] ?? 0) - delta;
  }
  return out;
}
