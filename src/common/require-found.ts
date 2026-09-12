import { NotFoundException } from '@nestjs/common';

export function requireFound<T>(
  value: T | null | undefined,
  message: string,
): T {
  if (value == null) {
    throw new NotFoundException(message);
  }
  return value;
}

export function requireNonEmpty<T>(
  values: T[],
  message: string,
): T[] {
  if (values.length === 0) {
    throw new NotFoundException(message);
  }
  return values;
}
