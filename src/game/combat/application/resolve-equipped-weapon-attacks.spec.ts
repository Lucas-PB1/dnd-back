import { DataSource, Repository } from 'typeorm';
import { PhbItem } from '../../../entities/phb-item.entity';
import { PhbWeapon } from '../../../entities/phb-weapon.entity';
import { PhbWeaponMastery } from '../../../entities/phb-weapon-mastery.entity';
import { ResolveEquippedWeaponAttacks } from './resolve-equipped-weapon-attacks';
import type { PlayerCharacterItem } from '../../inventory/infrastructure/player-character-item.entity';
import { DEFAULT_ABILITY_SCORES } from '../../shared/infrastructure/player-character.entity';

describe('ResolveEquippedWeaponAttacks', () => {
  let inventoryItems: { find: jest.Mock };
  let weapons: { find: jest.Mock };
  let masteryRepo: { find: jest.Mock };
  let catalogItems: { find: jest.Mock };
  let dataSource: { query: jest.Mock };
  let service: ResolveEquippedWeaponAttacks;

  beforeEach(() => {
    inventoryItems = { find: jest.fn() };
    weapons = { find: jest.fn() };
    masteryRepo = { find: jest.fn().mockResolvedValue([]) };
    catalogItems = { find: jest.fn().mockResolvedValue([]) };
    dataSource = {
      query: jest.fn().mockResolvedValue([{ slug: 'simple' }, { slug: 'martial' }]),
    };
    service = new ResolveEquippedWeaponAttacks(
      inventoryItems as unknown as Repository<PlayerCharacterItem>,
      weapons as unknown as Repository<PhbWeapon>,
      masteryRepo as unknown as Repository<PhbWeaponMastery>,
      catalogItems as unknown as Repository<PhbItem>,
      dataSource as unknown as DataSource,
    );
  });

  it('returns empty array when nothing is equipped in hands', async () => {
    inventoryItems.find.mockResolvedValue([]);
    await expect(
      service.resolve('ch1', DEFAULT_ABILITY_SCORES, { classSlug: 'fighter', proficiencyBonus: 2 }),
    ).resolves.toEqual([]);
    expect(weapons.find).not.toHaveBeenCalled();
  });

  it('returns empty array when equipped items have no catalog weapons', async () => {
    inventoryItems.find.mockResolvedValue([
      { itemSlug: 'missing', equipmentSlot: 'main_hand' },
    ]);
    weapons.find.mockResolvedValue([]);
    await expect(
      service.resolve('ch1', DEFAULT_ABILITY_SCORES, { classSlug: 'fighter', proficiencyBonus: 2 }),
    ).resolves.toEqual([]);
  });

  it('computes attacks for equipped weapons with proficiencies', async () => {
    inventoryItems.find.mockResolvedValue([
      { itemSlug: 'longsword', equipmentSlot: 'main_hand', attachedCharmSlug: null },
    ]);
    weapons.find.mockResolvedValue([
      {
        category: 'martial',
        damage: '1d8',
        damageType: 'slashing',
        item: {
          slug: 'longsword',
          name: 'Espada Longa',
          properties: { propertyIds: ['versatile'], versatileDamage: '1d10', masteryId: 'sap' },
        },
      },
    ]);
    masteryRepo.find.mockResolvedValue([{ slug: 'sap', name: 'Sap' }]);

    const attacks = await service.resolve('ch1', DEFAULT_ABILITY_SCORES, {
      classSlug: 'fighter',
      proficiencyBonus: 2,
      featSlugs: [],
      fightingStyleSlugs: ['defense'],
      hasShield: true,
      masteredWeaponSlugs: ['longsword'],
    });

    expect(dataSource.query).toHaveBeenCalledWith(expect.stringContaining('phb_class_proficiency'), [
      'fighter',
    ]);
    expect(attacks.length).toBeGreaterThan(0);
    expect(attacks[0]).toMatchObject({
      itemSlug: 'longsword',
      masterySlug: 'sap',
      masteryName: 'Sap',
      masteryActive: true,
      attachedCharmSlug: null,
    });
  });

  it('applies attached blade charm bonus only on that weapon', async () => {
    inventoryItems.find.mockResolvedValue([
      {
        itemSlug: 'longsword',
        equipmentSlot: 'main_hand',
        attachedCharmSlug: 'weapon-charm-blade-1',
      },
    ]);
    weapons.find.mockResolvedValue([
      {
        category: 'martial',
        damage: '1d8',
        damageType: 'Cortante',
        item: {
          slug: 'longsword',
          name: 'Espada Longa',
          properties: { propertyIds: ['versatile'], versatileDamage: '1d10' },
        },
      },
    ]);
    catalogItems.find.mockResolvedValue([
      {
        slug: 'weapon-charm-blade-1',
        name: 'Encanto de Arma: Lâmina +1',
        properties: {
          weaponCharm: { kind: 'blade', attackBonus: 1, damageBonus: 1 },
        },
      },
    ]);

    const attacks = await service.resolve('ch1', DEFAULT_ABILITY_SCORES, {
      classSlug: 'fighter',
      proficiencyBonus: 2,
    });
    expect(attacks[0].attachedCharmSlug).toBe('weapon-charm-blade-1');
    expect(attacks[0].attachedCharmName).toContain('Lâmina');
    expect(attacks[0].attackNote).toContain('encanto');
  });

  it('defaults missing equipment slot to main_hand', async () => {
    inventoryItems.find.mockResolvedValue([
      { itemSlug: 'dagger', attachedCharmSlug: null },
    ]);
    weapons.find.mockResolvedValue([
      {
        category: 'simple',
        damage: '1d4',
        damageType: 'piercing',
        item: {
          slug: 'dagger',
          name: 'Adaga',
          properties: { propertyIds: ['finesse', 'light'] },
        },
      },
    ]);

    const attacks = await service.resolve('ch1', DEFAULT_ABILITY_SCORES, {
      classSlug: 'rogue',
      proficiencyBonus: 2,
    });
    expect(attacks.some((a) => a.role === 'main')).toBe(true);
  });
});
