import { extraFromUpcastOption } from './spell-upcast-option';

describe('extraFromUpcastOption', () => {
  it('escala dados por círculo acima do base', () => {
    expect(extraFromUpcastOption('upcast_dice:2', 2)).toEqual({
      extraDice: 4,
      extraFlat: 0,
    });
  });

  it('escala flat por círculo acima do base', () => {
    expect(extraFromUpcastOption('upcast_flat:5', 1)).toEqual({
      extraDice: 0,
      extraFlat: 5,
    });
  });

  it('zera sem opção ou sem upcast', () => {
    expect(extraFromUpcastOption(null, 3)).toEqual({
      extraDice: 0,
      extraFlat: 0,
    });
    expect(extraFromUpcastOption('upcast_dice:2', 0)).toEqual({
      extraDice: 0,
      extraFlat: 0,
    });
  });
});
