import { Injectable } from '@nestjs/common';
import { PhbItem } from '../../entities/phb-item.entity';
import { ItemResponseDto } from './dto/item-response.dto';

@Injectable()
export class ItemsMapper {
  toDto(row: PhbItem): ItemResponseDto {
    const cost = row.cost as { text?: string } | null;
    return {
      slug: row.slug,
      name: row.name,
      itemType: row.itemType,
      costText: cost?.text ?? null,
      weight: row.weight,
    };
  }
}
