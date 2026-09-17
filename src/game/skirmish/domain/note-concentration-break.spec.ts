import { noteSkirmishConcentrationBreak } from './note-concentration-break';
import type { Skirmish } from '../infrastructure/skirmish.entity';
import { MAGICAL_DARKNESS_SPELL_SLUG } from '@game/duel/domain/arena-effects';

describe('noteSkirmishConcentrationBreak', () => {
  function skirmish(overrides: Partial<Skirmish> = {}): Skirmish {
    return {
      id: 's1',
      userId: 'u1',
      characterId: 'pc1',
      status: 'active',
      round: 1,
      turnAttacksRemaining: null,
      currentCombatantId: null,
      combatLog: [],
      arenaEffects: ['magical_darkness'],
      arenaEffectSourceCharacterId: 'pc1',
      winnerKind: null,
      endReason: null,
      createdAt: new Date(),
      updatedAt: new Date(),
      ...overrides,
    } as Skirmish;
  }

  it('clears magical darkness when source loses Escuridão', () => {
    const row = skirmish();
    const note = noteSkirmishConcentrationBreak({
      skirmish: row,
      damagedCharacterId: 'pc1',
      concentration: {
        attempted: true,
        broken: true,
        spellSlug: MAGICAL_DARKNESS_SPELL_SLUG,
        dc: 12,
        total: 8,
      },
    });
    expect(note).toContain('arena sem escuridão');
    expect(row.arenaEffects).not.toContain('magical_darkness');
    expect(row.arenaEffectSourceCharacterId).toBeNull();
  });

  it('keeps darkness if another combatant broke concentration', () => {
    const row = skirmish();
    const note = noteSkirmishConcentrationBreak({
      skirmish: row,
      damagedCharacterId: 'other',
      concentration: {
        attempted: true,
        broken: true,
        spellSlug: MAGICAL_DARKNESS_SPELL_SLUG,
        dc: 12,
        total: 8,
      },
    });
    expect(note).toContain('Escuridão');
    expect(row.arenaEffects).toContain('magical_darkness');
  });
});
