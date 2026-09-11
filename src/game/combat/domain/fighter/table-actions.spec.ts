import {
  FIXTURE_BATTLE_MASTER_MANEUVERS,
  FIXTURE_DUNGEONEER_PRECAUTION_SPELLS,
} from '../__fixtures__/mechanical-catalog';
import { fixtureSchedulesFor } from '../feature-schedule.fixtures';
import {
  findDungeoneerPrecautionSpell,
  resolveBattleMasterTableRoll,
} from './table-actions';

const BM_BANDS = fixtureSchedulesFor('fighter', 'battle-master');

describe('fighter tabletop actions', () => {
  describe('Battle Master', () => {
    it('resolves maneuver die, save DC and damage note', () => {
      const result = resolveBattleMasterTableRoll({
        catalog: FIXTURE_BATTLE_MASTER_MANEUVERS,
        maneuverSlug: 'trip-attack',
        level: 7,
        proficiencyBonus: 3,
        strengthModifier: 4,
        dexterityModifier: 2,
        charismaModifier: 0,
        dieRoll: 6,
        bands: BM_BANDS,
      });

      expect(result.expression).toBe('1d8');
      expect(result.effectValue).toBe(6);
      expect(result.saveDc).toBe(15);
      expect(result.resourceSpent).toBe(true);
      expect(result.note).toContain('CD 15');
    });

    it('adds the relevant ability modifier to Parry and Rally', () => {
      const parry = resolveBattleMasterTableRoll({
        catalog: FIXTURE_BATTLE_MASTER_MANEUVERS,
        maneuverSlug: 'parry',
        level: 10,
        proficiencyBonus: 4,
        strengthModifier: 2,
        dexterityModifier: 5,
        charismaModifier: 1,
        dieRoll: 7,
        bands: BM_BANDS,
      });
      const rally = resolveBattleMasterTableRoll({
        catalog: FIXTURE_BATTLE_MASTER_MANEUVERS,
        maneuverSlug: 'rally',
        level: 10,
        proficiencyBonus: 4,
        strengthModifier: 2,
        dexterityModifier: 5,
        charismaModifier: 1,
        dieRoll: 7,
        bands: BM_BANDS,
      });

      expect(parry.expression).toBe('1d10+5');
      expect(parry.effectValue).toBe(12);
      expect(rally.expression).toBe('1d10+1');
      expect(rally.effectValue).toBe(8);
      expect(rally.note).toContain('PV temporários');
    });

    it('uses Relentless d8 without spending superiority at level 15', () => {
      const result = resolveBattleMasterTableRoll({
        catalog: FIXTURE_BATTLE_MASTER_MANEUVERS,
        maneuverSlug: 'precision-attack',
        level: 15,
        proficiencyBonus: 5,
        strengthModifier: 3,
        dexterityModifier: 4,
        charismaModifier: 0,
        dieRoll: 8,
        useRelentless: true,
        bands: BM_BANDS,
      });

      expect(result.dieFaces).toBe(8);
      expect(result.resourceSpent).toBe(false);
      expect(result.note).toContain('Some 8 à jogada de ataque');
    });

    it('rejects Relentless before level 15', () => {
      expect(() =>
        resolveBattleMasterTableRoll({
          catalog: FIXTURE_BATTLE_MASTER_MANEUVERS,
          maneuverSlug: 'parry',
          level: 14,
          proficiencyBonus: 5,
          strengthModifier: 3,
          dexterityModifier: 4,
          charismaModifier: 0,
          dieRoll: 4,
          useRelentless: true,
          bands: BM_BANDS,
        }),
      ).toThrow(/level 15/);
    });
  });

  it('recognizes only Dungeoneer precaution spells', () => {
    expect(
      findDungeoneerPrecautionSpell(
        FIXTURE_DUNGEONEER_PRECAUTION_SPELLS,
        'detectar-magia',
      )?.name,
    ).toBe('Detectar Magia');
    expect(
      findDungeoneerPrecautionSpell(
        FIXTURE_DUNGEONEER_PRECAUTION_SPELLS,
        'bola-de-fogo',
      ),
    ).toBeUndefined();
  });
});
