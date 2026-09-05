export type SizeCategory =
  "tiny" | "small" | "medium" | "large" | "huge" | "gargantuan";

export function resolveSizeCategory(
  sizeText: string | null | undefined,
  preferred?: SizeCategory | null,
): SizeCategory {
  if (preferred) return preferred;

  const text = (sizeText ?? "").trim();
  if (!text) return "medium";

  const hasSmall = /\bPequeno\b/i.test(text);
  const hasMedium = /\bM[eé]dio\b/i.test(text);
  const hasLarge = /\bGrande\b/i.test(text);
  const hasTiny = /\bMin[uú]sculo\b/i.test(text);

  if (hasMedium && hasSmall) return "medium";
  if (hasSmall) return "small";
  if (hasTiny) return "tiny";
  if (hasLarge) return "large";
  if (hasMedium) return "medium";
  return "medium";
}

const GENERIC_SIZE_CHOICE_KINDS = new Set(["size", "creature_size", "tamanho"]);

function isSizeChoiceKind(choiceKind: string): boolean {
  return (
    GENERIC_SIZE_CHOICE_KINDS.has(choiceKind) || choiceKind.endsWith("_size")
  );
}

export function sizeCategoryFromChoices(
  choices: readonly { choiceKind: string; choiceSlug: string }[] | undefined,
): SizeCategory | null {
  const match = choices?.find((c) => isSizeChoiceKind(c.choiceKind));
  if (!match) return null;
  const slug = match.choiceSlug.toLowerCase();
  if (slug === "small" || slug === "pequeno") return "small";
  if (slug === "medium" || slug === "medio" || slug === "médio")
    return "medium";
  if (slug === "tiny" || slug === "minusculo" || slug === "minúsculo")
    return "tiny";
  if (slug === "large" || slug === "grande") return "large";
  return null;
}
