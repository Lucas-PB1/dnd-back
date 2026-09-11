import {
  armorPresetSlugFromChoices,
  computeSpeciesArmorPreset,
  findArmorPreset,
  type SpeciesArmorPresetRow,
} from './manikin-armor';

const MANIKIN_PRESETS: SpeciesArmorPresetRow[] = [
  {
    presetSlug: 'infiltrator',
    label: 'Manikin (Infiltrador)',
    baseAc: 11,
    abilityASlug: 'destreza',
    abilityACap: null,
    abilityBSlug: null,
    abilityBCap: null,
    pickMode: 'single',
    countsAsWornArmor: false,
  },
  {
    presetSlug: 'sentinel',
    label: 'Manikin (Sentinela)',
    baseAc: 13,
    abilityASlug: 'destreza',
    abilityACap: 2,
    abilityBSlug: 'forca',
    abilityBCap: 3,
    pickMode: 'max_of',
    countsAsWornArmor: true,
  },
  {
    presetSlug: 'tormentor',
    label: 'Manikin (Tormentador)',
    baseAc: 16,
    abilityASlug: 'forca',
    abilityACap: 2,
    abilityBSlug: null,
    abilityBCap: null,
    pickMode: 'single',
    countsAsWornArmor: true,
  },
];

describe('species armor preset', () => {
  const scores = {
    forca: 16,
    destreza: 14,
    constituicao: 12,
    inteligencia: 10,
    sabedoria: 10,
    carisma: 8,
  };

  it('reads preset slug from speciesChoices against catalog', () => {
    expect(
      armorPresetSlugFromChoices(MANIKIN_PRESETS, [
        { choiceKind: 'manikin_armor', choiceSlug: 'sentinel' },
      ]),
    ).toBe('sentinel');
    expect(armorPresetSlugFromChoices([], [{ choiceKind: 'manikin_armor', choiceSlug: 'sentinel' }])).toBeNull();
    expect(armorPresetSlugFromChoices(MANIKIN_PRESETS, [])).toBeNull();
  });

  it('computes infiltrator as 11 + DEX', () => {
    const preset = findArmorPreset(MANIKIN_PRESETS, 'infiltrator')!;
    expect(computeSpeciesArmorPreset(scores, preset)).toEqual({
      armorClass: 13,
      label: 'Manikin (Infiltrador)',
      countsAsWornArmor: false,
    });
  });

  it('computes sentinel as best of DEX cap 2 or STR cap 3', () => {
    const preset = findArmorPreset(MANIKIN_PRESETS, 'sentinel')!;
    expect(computeSpeciesArmorPreset(scores, preset).armorClass).toBe(16);
  });

  it('computes tormentor as 16 + STR cap 2', () => {
    const preset = findArmorPreset(MANIKIN_PRESETS, 'tormentor')!;
    expect(computeSpeciesArmorPreset(scores, preset)).toEqual({
      armorClass: 18,
      label: 'Manikin (Tormentador)',
      countsAsWornArmor: true,
    });
  });
});
