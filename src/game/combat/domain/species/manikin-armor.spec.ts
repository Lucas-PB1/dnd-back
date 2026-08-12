import {
  computeManikinArmorPreset,
  manikinArmorPresetFromChoices,
} from './manikin-armor';

describe('manikin-armor', () => {
  const scores = {
    forca: 16,
    destreza: 14,
    constituicao: 12,
    inteligencia: 10,
    sabedoria: 10,
    carisma: 8,
  };

  it('reads preset from speciesChoices', () => {
    expect(
      manikinArmorPresetFromChoices('manikin', [
        { choiceKind: 'manikin_armor', choiceSlug: 'sentinel' },
      ]),
    ).toBe('sentinel');
    expect(manikinArmorPresetFromChoices('elf', [])).toBeNull();
  });

  it('computes infiltrator as 11 + DEX', () => {
    expect(computeManikinArmorPreset(scores, 'infiltrator')).toEqual({
      armorClass: 13,
      label: 'Manikin (Infiltrador)',
      countsAsWornArmor: false,
    });
  });

  it('computes sentinel as best of DEX cap 2 or STR cap 3', () => {
    // DEX +2 → 15; STR +3 → 16 → 16
    expect(computeManikinArmorPreset(scores, 'sentinel')?.armorClass).toBe(16);
  });

  it('computes tormentor as 16 + STR cap 2', () => {
    expect(computeManikinArmorPreset(scores, 'tormentor')).toEqual({
      armorClass: 18,
      label: 'Manikin (Tormentador)',
      countsAsWornArmor: true,
    });
  });
});
