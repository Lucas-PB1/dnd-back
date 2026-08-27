import { BadRequestException, ForbiddenException } from '@nestjs/common';
import {
  applyCombatantPatch,
  assertPlayerCanViewEncounter,
  viewerFromMember,
} from './encounter-combatant-ops';
import type { CampaignMember } from '../infrastructure/campaign-member.entity';
import type { CampaignEncounter } from '../infrastructure/campaign-encounter.entity';
import type { CampaignEncounterCombatant } from '../infrastructure/campaign-encounter-combatant.entity';
import type { GameActor } from '@game/actor/infrastructure/game-actor.entity';

function member(role: CampaignMember['role']): CampaignMember {
  return {
    id: 'm1',
    campaignId: 'c1',
    userId: 'u1',
    role,
    joinedAt: new Date(),
  };
}

function encounter(overrides: Partial<CampaignEncounter> = {}): CampaignEncounter {
  return {
    id: 'e1',
    campaignId: 'c1',
    name: 'Fight',
    status: 'active',
    round: 1,
    currentTurnIndex: 0,
    playersCanView: false,
    creatureHpVisibility: 'percent',
    createdBy: 'u1',
    createdAt: new Date(),
    updatedAt: new Date(),
    ...overrides,
  };
}

function combatant(
  overrides: Partial<CampaignEncounterCombatant>,
): CampaignEncounterCombatant {
  return {
    id: 'cb1',
    encounterId: 'e1',
    kind: 'pc',
    characterId: 'char1',
    actorId: null,
    initiativeTotal: null,
    initiativeModifier: null,
    sortOrder: 0,
    isActive: true,
    ...overrides,
  };
}

function actor(overrides: Partial<GameActor> = {}): GameActor {
  return {
    id: 'actor1',
    ownerUserId: 'u1',
    campaignId: 'c1',
    parentCharacterId: null,
    actorKind: 'creature',
    templateSlug: null,
    name: ' Goblin ',
    hitPointsMax: 10,
    hitPointsCurrent: 20,
    armorClass: 15,
    initiativeModifier: null,
    proficiencyBonus: null,
    abilityScores: {
      forca: 10,
      destreza: 10,
      constituicao: 10,
      inteligencia: 10,
      sabedoria: 10,
      carisma: 10,
    },
    sizeSlug: null,
    notes: null,
    spellcastingAbilitySlug: null,
    spellSaveDc: null,
    spellAttackBonus: null,
    damageThreshold: null,
    crewCapacity: null,
    cargoCapacityLb: null,
    createdAt: new Date(),
    updatedAt: new Date(),
    ...overrides,
  } as GameActor;
}

describe('encounter-combatant-ops', () => {
  describe('viewerFromMember', () => {
    it('maps dm and assistant to dm viewer', () => {
      expect(viewerFromMember(member('dm'))).toBe('dm');
      expect(viewerFromMember(member('assistant'))).toBe('dm');
    });

    it('maps player to player viewer', () => {
      expect(viewerFromMember(member('player'))).toBe('player');
    });
  });

  describe('assertPlayerCanViewEncounter', () => {
    it('allows dm and assistant regardless of playersCanView', () => {
      const enc = encounter({ playersCanView: false });
      expect(() => assertPlayerCanViewEncounter(member('dm'), enc)).not.toThrow();
      expect(() =>
        assertPlayerCanViewEncounter(member('assistant'), enc),
      ).not.toThrow();
    });

    it('forbids player when playersCanView is false', () => {
      expect(() =>
        assertPlayerCanViewEncounter(
          member('player'),
          encounter({ playersCanView: false }),
        ),
      ).toThrow(ForbiddenException);
    });

    it('allows player when playersCanView is true', () => {
      expect(() =>
        assertPlayerCanViewEncounter(
          member('player'),
          encounter({ playersCanView: true }),
        ),
      ).not.toThrow();
    });
  });

  describe('applyCombatantPatch', () => {
    it('rejects hp and displayName patches on PCs', () => {
      const pc = combatant({ kind: 'pc' });
      expect(() => applyCombatantPatch(pc, { hpCurrent: 10 })).toThrow(
        BadRequestException,
      );
      expect(() => applyCombatantPatch(pc, { displayName: 'X' })).toThrow(
        BadRequestException,
      );
    });

    it('allows initiative patches on PCs', () => {
      const pc = combatant({ kind: 'pc' });
      applyCombatantPatch(pc, { initiativeTotal: 14, initiativeModifier: 2 });
      expect(pc.initiativeTotal).toBe(14);
      expect(pc.initiativeModifier).toBe(2);
    });

    it('trims actor displayName and clamps hpCurrent to hpMax', () => {
      const actorRow = actor();
      const actorCombatant = combatant({
        kind: 'actor',
        characterId: null,
        actorId: 'actor1',
      });
      applyCombatantPatch(
        actorCombatant,
        {
          displayName: '  Orc  ',
          hpCurrent: 15,
          hpMax: 10,
        },
        actorRow,
      );
      expect(actorRow.name).toBe('Orc');
      expect(actorRow.hitPointsMax).toBe(10);
      expect(actorRow.hitPointsCurrent).toBe(10);
    });
  });
});
