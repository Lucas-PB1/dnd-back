import { isPickableLanguageChoice } from './language-choice-rules';

describe('isPickableLanguageChoice', () => {
  it('allows standard languages', () => {
    expect(isPickableLanguageChoice('elvish', { isRare: false })).toBe(true);
    expect(isPickableLanguageChoice('sign-language', { isRare: false })).toBe(
      true,
    );
  });

  it('blocks rare languages', () => {
    expect(isPickableLanguageChoice('abyssal', { isRare: true })).toBe(false);
    expect(isPickableLanguageChoice('undercommon', { isRare: true })).toBe(
      false,
    );
  });

  it('blocks class-exclusive languages even when marked standard', () => {
    expect(isPickableLanguageChoice('druidic', { isRare: false })).toBe(false);
    expect(isPickableLanguageChoice('thieves-cant', { isRare: false })).toBe(
      false,
    );
  });
});
