/** Helpers aleatórios. */

export function pickRandom(items) {
  if (!items?.length) {
    throw new Error('pickRandom: lista vazia');
  }
  return items[Math.floor(Math.random() * items.length)];
}

export function pickN(items, n) {
  const copy = [...items];
  const out = [];
  while (out.length < n && copy.length > 0) {
    const idx = Math.floor(Math.random() * copy.length);
    out.push(copy.splice(idx, 1)[0]);
  }
  return out;
}

export function shuffle(items) {
  const copy = [...items];
  for (let i = copy.length - 1; i > 0; i -= 1) {
    const j = Math.floor(Math.random() * (i + 1));
    [copy[i], copy[j]] = [copy[j], copy[i]];
  }
  return copy;
}
