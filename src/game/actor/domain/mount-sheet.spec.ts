import {
  applyHealToActorVitals,
  clearMountLongRestUses,
  consumeLongRestUse,
  isCelestialSteedTemplate,
  isMountSheetAction,
  isPhantomSteedTemplate,
  isVitalBondMountTemplate,
  longRestUseRemaining,
} from './mount-sheet';

describe('mount-sheet', () => {
  it('reconhece templates de montaria sobrenatural e fantasma', () => {
    expect(isVitalBondMountTemplate('montaria-sobrenatural-celestial')).toBe(
      true,
    );
    expect(isCelestialSteedTemplate('montaria-sobrenatural-celestial')).toBe(
      true,
    );
    expect(isPhantomSteedTemplate('montaria-fantasmagorica')).toBe(true);
    expect(isVitalBondMountTemplate('cavalo-de-montaria')).toBe(false);
    expect(isMountSheetAction('healing-touch')).toBe(true);
    expect(isMountSheetAction('trample')).toBe(false);
  });

  it('cura a montaria até o máximo', () => {
    expect(
      applyHealToActorVitals({
        hitPointsCurrent: 10,
        hitPointsMax: 25,
        amount: 20,
      }),
    ).toEqual({ hitPointsCurrent: 25, healed: 15 });
    expect(
      applyHealToActorVitals({
        hitPointsCurrent: 10,
        hitPointsMax: 25,
        amount: 0,
      }),
    ).toEqual({ hitPointsCurrent: 10, healed: 0 });
  });

  it('gasta e limpa usos de descanso longo da montaria', () => {
    expect(longRestUseRemaining({}, 'toque-curativo')).toBe(true);
    const spent = consumeLongRestUse({}, 'toque-curativo');
    expect(longRestUseRemaining(spent, 'toque-curativo')).toBe(false);
    expect(clearMountLongRestUses(spent)).toEqual({});
  });
});
