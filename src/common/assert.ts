import { BadRequestException } from '@nestjs/common';

/** Lança 400 se o valor for null/undefined (slug inválido no catálogo). */
export function requireCatalog<T>(
  value: T | null | undefined,
  message: string,
): T {
  if (value == null) {
    throw new BadRequestException(message);
  }
  return value;
}

/** Lança 400 se houver valores duplicados. */
export function assertUnique(
  values: readonly unknown[],
  message: string,
): void {
  if (new Set(values).size !== values.length) {
    throw new BadRequestException(message);
  }
}
