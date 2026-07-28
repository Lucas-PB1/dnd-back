import { BadRequestException, ForbiddenException } from '@nestjs/common';
import {
  applyCombatantPatch,
  assertPlayerCanViewEncounter,
  viewerFromMember,
} from './encounter-combatant-ops';
import type { CampaignMember } from '../infrastructure/campaign-member.entity';
import type { CampaignEncounter } from '../infrastructure/campaign-encounter.entity';
import type { CampaignEncounterCombatant } from '../infrastructure/campaign-encounter-combatant.entity';

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
    displayName: null,
    hpCurrent: null,
    hpMax: null,
    armorClass: null,
    initiativeTotal: null,
    initiativeModifier: null,
    sortOrder: 0,
    isActive: true,
    ...overrides,
  };
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

    it('trims creature displayName and clamps hpCurrent to hpMax', () => {
      const creature = combatant({
        kind: 'creature',
        displayName: ' Goblin ',
        hpCurrent: 20,
        hpMax: 10,
      });
      applyCombatantPatch(creature, {
        displayName: '  Orc  ',
        hpCurrent: 15,
        hpMax: 10,
      });
      expect(creature.displayName).toBe('Orc');
      expect(creature.hpMax).toBe(10);
      expect(creature.hpCurrent).toBe(10);
    });
  });
});
