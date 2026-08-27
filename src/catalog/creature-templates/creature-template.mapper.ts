import { Injectable } from '@nestjs/common';
import { PhbCreatureTemplate } from '@entities/phb-creature-template.entity';
import { VPhbCreatureTemplateBundle } from '@entities/views/v-phb-creature-template-bundle.entity';
import {
  CreatureTemplateResponseDto,
  CreatureTemplateSummaryResponseDto,
} from './dto/creature-template-response.dto';

@Injectable()
export class CreatureTemplateMapper {
  toSummaryDto(row: PhbCreatureTemplate): CreatureTemplateSummaryResponseDto {
    return {
      slug: row.slug,
      name: row.name,
      editionSlug: row.editionSlug,
      creatureType: row.creatureType,
      sizeSlug: row.sizeSlug,
      challengeRating: row.challengeRating,
      armorClass: row.armorClass,
      hitPointsAvg: row.hitPointsAvg,
    };
  }

  toDto(row: VPhbCreatureTemplateBundle): CreatureTemplateResponseDto {
    return {
      slug: row.slug,
      name: row.name,
      editionSlug: row.editionSlug,
      subtitle: row.subtitle,
      alignment: row.alignment,
      creatureType: row.creatureType,
      creatureSubtype: row.creatureSubtype,
      sizeSlug: row.sizeSlug,
      challengeRating: row.challengeRating,
      armorClass: row.armorClass,
      hitPointsAvg: row.hitPointsAvg,
      proficiencyBonus: row.proficiencyBonus,
      hitPointsFormula: row.hitPointsFormula,
      initiativeModifier: row.initiativeModifier,
      abilityScores: row.abilityScores,
      spellcastingAbilitySlug: row.spellcastingAbilitySlug,
      spellSaveDc: row.spellSaveDc,
      spellAttackBonus: row.spellAttackBonus,
      speeds: row.speeds ?? [],
      actions: row.actions ?? [],
      spells: row.spells ?? [],
      traits: row.traits ?? [],
    };
  }
}
