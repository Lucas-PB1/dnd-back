import { BadRequestException } from '@nestjs/common';

export function requireCatalog<T>(
  value: T | null | undefined,
  message: string,
): T {
  if (value == null) {
    throw new BadRequestException(message);
  }
  return value;
}

export function assertUnique(
  values: readonly unknown[],
  message: string,
): void {
  if (new Set(values).size !== values.length) {
    throw new BadRequestException(message);
  }
}
