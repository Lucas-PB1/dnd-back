import { Injectable } from '@nestjs/common';
import { PhbVehicleTemplate } from '@entities/phb-vehicle-template.entity';
import { VPhbVehicleTemplateBundle } from '@entities/views/v-phb-vehicle-template-bundle.entity';
import {
  VehicleTemplateResponseDto,
  VehicleTemplateSummaryResponseDto,
} from './dto/vehicle-template-response.dto';

@Injectable()
export class VehicleTemplateMapper {
  toSummaryDto(row: PhbVehicleTemplate): VehicleTemplateSummaryResponseDto {
    return {
      slug: row.slug,
      name: row.name,
      editionSlug: row.editionSlug,
      armorClass: row.armorClass,
      hitPoints: row.hitPoints,
      crewCapacity: row.crewCapacity,
      imageUrl: row.imageUrl,
    };
  }

  toDto(row: VPhbVehicleTemplateBundle): VehicleTemplateResponseDto {
    return {
      slug: row.slug,
      name: row.name,
      editionSlug: row.editionSlug,
      subtitle: row.subtitle,
      armorClass: row.armorClass,
      hitPoints: row.hitPoints,
      crewCapacity: row.crewCapacity,
      damageThreshold: row.damageThreshold,
      passengerCapacity: row.passengerCapacity,
      cargoCapacityLb: row.cargoCapacityLb,
      cargoCapacityLabel: row.cargoCapacityLabel,
      initiativeModifier: row.initiativeModifier,
      imageUrl: row.imageUrl,
      abilityScores: row.abilityScores,
      speeds: row.speeds ?? [],
      actions: row.actions ?? [],
      traits: row.traits ?? [],
    };
  }
}
