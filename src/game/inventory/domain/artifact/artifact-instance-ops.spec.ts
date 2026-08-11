import {
  applyAbilityPenalties,
  clearAbilityPenaltiesFromInstance,
  collectAbilityPenaltiesFromInventory,
  findArtifactRegenOnInstance,
  mapArtifactSpellSpendFlags,
  markArtifactSpellSpent,
  readArtifactSpellProp,
} from './artifact-instance-ops';

describe('artifact-instance-ops', () => {
  const spellInstance = {
    artifactRandom: {
      minorBeneficial: [
        {
          slug: 'spell-1st',
          summaryPt: 'Conjura magia',
          effect: {
            type: 'artifactSpell',
            spellLevel: 1,
            spellSlug: 'escudo',
            spentUntilLongRest: false,
            spellSaveDc: 18,
          },
        },
      ],
      majorBeneficial: [
        {
          slug: 'regen',
          summaryPt: 'Regen',
          effect: { type: 'artifactRegen', dice: '1d6' },
        },
      ],
    },
    abilityPenalties: { forca: -2 },
  };

  it('marks artifact spell spent and rejects double spend', () => {
    const spent = markArtifactSpellSpent({
      instance: spellInstance,
      bucket: 'minorBeneficial',
      index: 0,
    });
    const effect = readArtifactSpellProp({
      instance: spent,
      bucket: 'minorBeneficial',
      index: 0,
    }).effect;
    expect(effect.spentUntilLongRest).toBe(true);
    expect(() =>
      markArtifactSpellSpent({
        instance: spent,
        bucket: 'minorBeneficial',
        index: 0,
      }),
    ).toThrow(/already spent/);
  });

  it('resets spent flags on long rest map', () => {
    const spent = markArtifactSpellSpent({
      instance: spellInstance,
      bucket: 'minorBeneficial',
      index: 0,
    });
    const recovered = mapArtifactSpellSpendFlags(spent, false);
    expect(
      readArtifactSpellProp({
        instance: recovered,
        bucket: 'minorBeneficial',
        index: 0,
      }).effect.spentUntilLongRest,
    ).toBe(false);
  });

  it('finds regen and applies/clears ability penalties', () => {
    expect(findArtifactRegenOnInstance(spellInstance)?.dice).toBe('1d6');
    const scores = applyAbilityPenalties(
      {
        forca: 10,
        destreza: 10,
        constituicao: 10,
        inteligencia: 10,
        sabedoria: 10,
        carisma: 10,
      },
      collectAbilityPenaltiesFromInventory([{ instanceProperties: spellInstance }]),
    );
    expect(scores.forca).toBe(8);
    expect(clearAbilityPenaltiesFromInstance(spellInstance)?.abilityPenalties).toBeUndefined();
  });
});
