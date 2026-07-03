import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbArmor } from '../../../entities/views/v-phb-armor.entity';
import { PaginatedResponseDto, paginate } from '../../../common/dto/pagination.dto';
import { ArmorResponseDto } from '../dto/armor-response.dto';
import { EquipmentMapper } from '../equipment.mapper';

@Injectable()
export class FindArmorQuery {
  constructor(
    @InjectRepository(VPhbArmor)
    private readonly armorRepo: Repository<VPhbArmor>,
    private readonly mapper: EquipmentMapper,
  ) {}

  async execute(page = 1, limit = 20): Promise<PaginatedResponseDto<ArmorResponseDto>> {
    const rows = await this.armorRepo.find({ order: { itemName: 'ASC' } });
    return paginate(rows.map((row) => this.mapper.toArmorDto(row)), page, limit);
  }
}
