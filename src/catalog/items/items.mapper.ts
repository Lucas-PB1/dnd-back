import { Injectable } from '@nestjs/common';
import { PhbItem } from '@entities/phb-item.entity';
import { ItemResponseDto } from './dto/item-response.dto';
import { ItemSummaryResponseDto } from './dto/item-summary-response.dto';

function costTextOf(cost: Record<string, unknown> | null): string | null {
  const text = cost && typeof cost === 'object' ? cost.text : null;
  return typeof text === 'string' ? text : null;
}

function propString(
  properties: Record<string, unknown> | null,
  key: string,
): string | null {
  const value = properties?.[key];
  return typeof value === 'string' ? value : null;
}

@Injectable()
export class ItemsMapper {
  toSummaryDto(row: PhbItem): ItemSummaryResponseDto {
    const properties = row.properties;
    return {
      slug: row.slug,
      name: row.name,
      itemType: row.itemType,
      costText: costTextOf(row.cost),
      weight: row.weight,
      kind: propString(properties, 'kind'),
      consumable: properties?.consumable === true,
      magic: properties?.magic === true,
      imageUrl: row.imageUrl,
    };
  }

  toDto(row: PhbItem): ItemResponseDto {
    return {
      slug: row.slug,
      name: row.name,
      itemType: row.itemType,
      costText: costTextOf(row.cost),
      weight: row.weight,
      description: row.description,
      imageUrl: row.imageUrl,
      properties: row.properties,
    };
  }
}
