import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbArmor } from '../../../entities/views/v-phb-armor.entity';
import { ArmorResponseDto } from '../dto/armor-response.dto';
import { EquipmentMapper } from '../equipment.mapper';

@Injectable()
export class FindArmorBySlugQuery {
  constructor(
    @InjectRepository(VPhbArmor)
    private readonly armorRepo: Repository<VPhbArmor>,
    private readonly mapper: EquipmentMapper,
  ) {}

  async execute(slug: string): Promise<ArmorResponseDto> {
    const row = await this.armorRepo.findOne({ where: { itemSlug: slug } });
    if (!row) {
      throw new NotFoundException(`Armor '${slug}' not found`);
    }
    return this.mapper.toArmorDto(row);
  }
}
