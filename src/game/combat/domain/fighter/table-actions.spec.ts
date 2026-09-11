import {
  FIXTURE_BATTLE_MASTER_MANEUVERS,
  FIXTURE_DUNGEONEER_PRECAUTION_SPELLS,
  FIXTURE_PSI_ACTIONS,
} from '../__fixtures__/mechanical-catalog';
import { fixtureSchedulesFor } from '../feature-schedule.fixtures';
import {
  findDungeoneerPrecautionSpell,
  resolveBattleMasterTableRoll,
  resolvePsiWarriorTableAction,
} from './table-actions';

const BM_BANDS = fixtureSchedulesFor('fighter', 'battle-master');
const PSI_BANDS = fixtureSchedulesFor('fighter', 'psi-warrior');

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

  describe('Psi Warrior', () => {
    it('rolls Protective Field with Intelligence and spends Psi', () => {
      const result = resolvePsiWarriorTableAction({
        catalog: FIXTURE_PSI_ACTIONS,
        actionSlug: 'protective-field',
        level: 5,
        intelligenceModifier: 3,
        dieRoll: 5,
        bands: PSI_BANDS,
      });

      expect(result.expression).toBe('1d8+3');
      expect(result.total).toBe(8);
      expect(result.resourceSlug).toBe('psi-energy-dice');
      expect(result.note).toContain('reduza 8');
    });

    it('uses free feature resource or Psi die when repeating', () => {
      const free = resolvePsiWarriorTableAction({
        catalog: FIXTURE_PSI_ACTIONS,
        actionSlug: 'psychic-leap',
        level: 7,
        intelligenceModifier: 3,
        bands: PSI_BANDS,
      });
      const repeated = resolvePsiWarriorTableAction({
        catalog: FIXTURE_PSI_ACTIONS,
        actionSlug: 'psychic-leap',
        level: 7,
        intelligenceModifier: 3,
        usePsiDie: true,
        bands: PSI_BANDS,
      });

      expect(free.resourceSlug).toBe('psychic-leap');
      expect(repeated.resourceSlug).toBe('psi-energy-dice');
    });

    it('rejects actions below their unlock level', () => {
      expect(() =>
        resolvePsiWarriorTableAction({
          catalog: FIXTURE_PSI_ACTIONS,
          actionSlug: 'energy-bulwark',
          level: 14,
          intelligenceModifier: 3,
          bands: PSI_BANDS,
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
