import {
  SIGNATURE_SPELL_KEYS,
  signatureSpellKeysAtLevel,
} from './signature-spells';

describe('signature-spells', () => {
  it('unlocks both keys at wizard 20', () => {
    expect(signatureSpellKeysAtLevel(19)).toEqual([]);
    expect(signatureSpellKeysAtLevel(20)).toEqual([...SIGNATURE_SPELL_KEYS]);
  });
});
