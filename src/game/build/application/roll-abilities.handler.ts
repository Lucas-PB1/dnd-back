import { Injectable } from '@nestjs/common';
import {
  assignScoresToAbilities,
  generateAbilityScores,
  rollAbilityScoreOptions,
  standardArrayScores,
  AbilityGenerationMethodSlug,
} from '../domain/ability-generation';
import { RollAbilitiesDto, RollAbilitiesResponseDto } from '../dto/roll-abilities.dto';

@Injectable()
export class RollAbilitiesHandler {
  execute(dto: RollAbilitiesDto): RollAbilitiesResponseDto {
    const method = dto.method as AbilityGenerationMethodSlug;

    if (method === 'roll') {
      const rawValueOptions = rollAbilityScoreOptions();
      const rawValues = rawValueOptions[0]!;
      return {
        method: dto.method,
        abilityScores: assignScoresToAbilities(rawValues),
        rawValues,
        rawValueOptions,
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
