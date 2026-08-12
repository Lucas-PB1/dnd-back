export function missingFilledOptionKeys(
  requiredKeys: readonly string[],
  options: readonly { optionKey: string; valueId?: string }[] | undefined,
): string[] {
  const filled = new Set(
    (options ?? [])
      .filter((option) => Boolean(option.valueId?.trim()))
      .map((option) => option.optionKey),
  );
  return requiredKeys.filter((key) => !filled.has(key));
}
