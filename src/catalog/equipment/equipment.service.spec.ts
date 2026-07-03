import { Test, TestingModule } from '@nestjs/testing';
import { getRepositoryToken } from '@nestjs/typeorm';
import { NotFoundException } from '@nestjs/common';
import { Repository } from 'typeorm';
import { EquipmentService } from './equipment.service';
import { PhbWeapon } from '../../entities/phb-weapon.entity';
import { VPhbArmor } from '../../entities/views/v-phb-armor.entity';

describe('EquipmentService', () => {
  let service: EquipmentService;
  let weaponsRepo: jest.Mocked<Pick<Repository<PhbWeapon>, 'find' | 'findOne'>>;
  let armorRepo: jest.Mocked<Pick<Repository<VPhbArmor>, 'find' | 'findOne'>>;

  beforeEach(async () => {
    weaponsRepo = { find: jest.fn(), findOne: jest.fn() };
    armorRepo = { find: jest.fn(), findOne: jest.fn() };
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        EquipmentService,
        { provide: getRepositoryToken(PhbWeapon), useValue: weaponsRepo },
        { provide: getRepositoryToken(VPhbArmor), useValue: armorRepo },
      ],
    }).compile();
    service = module.get(EquipmentService);
  });

  it('findWeaponBySlug throws when not found', async () => {
    weaponsRepo.findOne.mockResolvedValue(null);
    await expect(service.findWeaponBySlug('invalid')).rejects.toThrow(NotFoundException);
  });

  it('findArmorBySlug throws when not found', async () => {
    armorRepo.findOne.mockResolvedValue(null);
    await expect(service.findArmorBySlug('invalid')).rejects.toThrow(NotFoundException);
  });
});
