import { BadRequestException } from '@nestjs/common';

export type AssertCanEquipArmorInput = {
  kind: 'armor';
};

export type AssertCanEquipWeaponInput = {
  kind: 'weapon';
};

/**
 * Gate de equip: cobertura não é equipável.
 * Proficiência/treino NÃO bloqueiam — consequências soft na ficha/combat.
 */
export function assertCanEquipItem(
  _input: AssertCanEquipArmorInput | AssertCanEquipWeaponInput,
): void {
  // No-op para arma/armadura: equip permitido sem proficiência.
}

/** Bloqueia equipar peça de cobertura como se fosse equipamento. */
export function assertCoverageNotEquippable(itemSlug: string): never {
  throw new BadRequestException(
    `Item '${itemSlug}' is a coverage — attach it to a base piece instead of equipping`,
  );
}
