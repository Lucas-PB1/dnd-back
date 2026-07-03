import { Test, TestingModule } from '@nestjs/testing';
import { getRepositoryToken } from '@nestjs/typeorm';
import { NotFoundException } from '@nestjs/common';
import { Repository } from 'typeorm';
import { PhbWeapon } from '../../entities/phb-weapon.entity';
import { VPhbArmor } from '../../entities/views/v-phb-armor.entity';
import { EquipmentMapper } from './equipment.mapper';
import { FindWeaponBySlugQuery } from './queries/find-weapon-by-slug.query';
import { FindArmorBySlugQuery } from './queries/find-armor-by-slug.query';

describe('Equipment queries', () => {
  let findWeaponBySlug: FindWeaponBySlugQuery;
  let findArmorBySlug: FindArmorBySlugQuery;
  let weaponsRepo: jest.Mocked<Pick<Repository<PhbWeapon>, 'find' | 'findOne'>>;
  let armorRepo: jest.Mocked<Pick<Repository<VPhbArmor>, 'find' | 'findOne'>>;

  beforeEach(async () => {
    weaponsRepo = { find: jest.fn(), findOne: jest.fn() };
    armorRepo = { find: jest.fn(), findOne: jest.fn() };
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        EquipmentMapper,
        FindWeaponBySlugQuery,
        FindArmorBySlugQuery,
        { provide: getRepositoryToken(PhbWeapon), useValue: weaponsRepo },
        { provide: getRepositoryToken(VPhbArmor), useValue: armorRepo },
      ],
    }).compile();

    findWeaponBySlug = module.get(FindWeaponBySlugQuery);
    findArmorBySlug = module.get(FindArmorBySlugQuery);
  });

  it('findWeaponBySlug throws when not found', async () => {
    weaponsRepo.findOne.mockResolvedValue(null);
    await expect(findWeaponBySlug.execute('invalid')).rejects.toThrow(NotFoundException);
  });

  it('findArmorBySlug throws when not found', async () => {
    armorRepo.findOne.mockResolvedValue(null);
    await expect(findArmorBySlug.execute('invalid')).rejects.toThrow(NotFoundException);
  });
});
