export type SpiritHpMode = 'per_slot' | 'above_min';

/** Parâmetros de `phb_creature_scale_by_slot`. */
export type ScaleBySlot = {
  scaleMinSlot: number;
  acBase: number;
  acPerSlot: number;
  hpBase: number;
  hpPerSlot: number;
  hpMode: SpiritHpMode;
};

export type ScaledSpiritCombatStats = {
  hitPointsMax: number;
  armorClass: number;
};

/**
 * Escala AC/HP pelo círculo do slot (não pelo nível do personagem).
 * - AC = acBase + acPerSlot × slotLevel
 * - HP per_slot: hpBase + hpPerSlot × slotLevel
 * - HP above_min: hpBase + hpPerSlot × max(0, slotLevel − scaleMinSlot)
 */
export function scaleSpiritCombatStats(
  scale: ScaleBySlot,
  slotLevel: number,
): ScaledSpiritCombatStats {
  const slot = Math.max(0, Math.floor(slotLevel));
  const armorClass = scale.acBase + scale.acPerSlot * slot;

  let hitPointsMax: number;
  if (scale.hpMode === 'per_slot') {
    hitPointsMax = scale.hpBase + scale.hpPerSlot * slot;
  } else {
    const above = Math.max(0, slot - scale.scaleMinSlot);
    hitPointsMax = scale.hpBase + scale.hpPerSlot * above;
  }

  return { hitPointsMax, armorClass };
}
