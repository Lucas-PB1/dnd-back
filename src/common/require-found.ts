import { NotFoundException } from '@nestjs/common';

/** Lança 404 se o valor for null/undefined. */
export function requireFound<T>(
  value: T | null | undefined,
  message: string,
): T {
  if (value == null) {
    throw new NotFoundException(message);
  }
  return value;
}

/** Lança 404 se a lista estiver vazia. */
export function requireNonEmpty<T>(
  values: T[],
  message: string,
): T[] {
  if (values.length === 0) {
    throw new NotFoundException(message);
  }
  return values;
}
