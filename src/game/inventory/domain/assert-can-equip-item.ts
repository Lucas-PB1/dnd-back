import { BadRequestException } from '@nestjs/common';

export type AssertCanEquipArmorInput = {
  kind: 'armor';
};

export type AssertCanEquipWeaponInput = {
  kind: 'weapon';
};

export function assertCanEquipItem(
  _input: AssertCanEquipArmorInput | AssertCanEquipWeaponInput,
): void {
}

export function assertCoverageNotEquippable(itemSlug: string): never {
  throw new BadRequestException(
    `Item '${itemSlug}' is a coverage — attach it to a base piece instead of equipping`,
  );
}
