import { Injectable } from '@nestjs/common';
import {
  assignScoresToAbilities,
  generateAbilityScores,
  rollAbilityScores,
  standardArrayScores,
  AbilityGenerationMethodSlug,
} from '../domain/ability-generation';
import { RollAbilitiesDto, RollAbilitiesResponseDto } from '../dto/roll-abilities.dto';

@Injectable()
export class RollAbilitiesHandler {
  execute(dto: RollAbilitiesDto): RollAbilitiesResponseDto {
    const method = dto.method as AbilityGenerationMethodSlug;

    if (method === 'roll') {
      const rawValues = rollAbilityScores();
      return {
        method: dto.method,
        abilityScores: assignScoresToAbilities(rawValues),
        rawValues,
      };
    }

    if (method === 'standard-array') {
      const rawValues = standardArrayScores();
      return {
        method: dto.method,
        abilityScores: assignScoresToAbilities(rawValues),
        rawValues,
      };
    }

    return {
      method: dto.method,
      abilityScores: generateAbilityScores(method, {
        abilityScores: dto.abilityScores,
      }),
    };
  }
}
