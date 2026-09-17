import { In } from 'typeorm';
import {
  pickActorAttackAction,
  pickEquippedWeaponItemSlug,
  rollActorEncounterDamage,
} from './encounter-attack-weapons';

describe('encounter-attack-weapons', () => {
  it('pickEquippedWeaponItemSlug uses the requested slug', async () => {
    const items = { find: jest.fn() };
    await expect(
      pickEquippedWeaponItemSlug(
        items as never,
        'c1',
        'longsword',
      ),
    ).resolves.toBe('longsword');
    expect(items.find).not.toHaveBeenCalled();
  });

  it('pickEquippedWeaponItemSlug reads the first equipped hand item', async () => {
    const items = {
      find: jest.fn().mockResolvedValue([{ itemSlug: 'dagger' }]),
    };
    await expect(
      pickEquippedWeaponItemSlug(items as never, 'c1'),
    ).resolves.toBe('dagger');
    expect(items.find).toHaveBeenCalledWith({
      where: {
        characterId: 'c1',
        location: 'equipped',
        equipmentSlot: In(['main_hand', 'off_hand']),
      },
    });
  });

  it('pickActorAttackAction uses the first action with an attack bonus', async () => {
    const actions = {
      findOne: jest.fn(),
      find: jest.fn().mockResolvedValue([
        { id: '1', attackBonus: null },
        { id: '2', attackBonus: 4, name: 'Scimitar' },
      ]),
    };
    const picked = await pickActorAttackAction(actions as never, 'actor1');
    expect(picked.id).toBe('2');
  });

  it('rollActorEncounterDamage doubles dice on a critical', () => {
    const result = rollActorEncounterDamage('1d6+2', true);
    expect(result?.critical).toBe(true);
    expect(result?.expression).toMatch(/^2d6/);
  });

  it('rollActorEncounterDamage accepts a flat number', () => {
    expect(rollActorEncounterDamage('5', false)).toMatchObject({
      total: 5,
      expression: '5',
    });
  });
});
