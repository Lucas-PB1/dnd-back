import { Injectable } from '@nestjs/common';
import { PhbFightingStyle } from '@entities/class/phb-fighting-style.entity';
import { FightingStyleResponseDto } from './dto/fighting-style-response.dto';

@Injectable()
export class FightingStylesMapper {
  toDto(row: PhbFightingStyle): FightingStyleResponseDto {
    return {
      slug: row.slug,
      name: row.name,
      description: row.description,
    };
  }
}
