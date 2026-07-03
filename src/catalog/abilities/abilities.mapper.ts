import { Injectable } from '@nestjs/common';
import { PhbAbility } from '../../entities/phb-ability.entity';
import { AbilityResponseDto } from './dto/ability-response.dto';

@Injectable()
export class AbilitiesMapper {
  toDto(row: PhbAbility): AbilityResponseDto {
    return {
      slug: row.slug,
      name: row.name,
      sortOrder: row.sortOrder,
    };
  }
}
