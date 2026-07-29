import { BadRequestException } from '@nestjs/common';
import { DataSource } from 'typeorm';
import type { CharacterDomainService } from '../../../sheet/domain/core/character-domain.service';
import {
  skillCheckBonus,
  skillProficiencyRank,
} from '../../../sheet/domain/stats/character-check-bonuses';
import { computeAbilityModifiers } from '../../../sheet/domain/stats/character-derived-stats';
import type { CharacterSheetRepository } from '../../../sheet/infrastructure/character-sheet.repository';
import { resolveEffectiveAbilityScores } from '../../../sheet/infrastructure/load-class-ability-boosts';
import type { PlayerCharacterAccessService } from '../../../shared/player-character-access.service';
import type { AbilityKey } from '../../../build/domain/ability-generation';
import { rollD20Check } from '../../domain/dice';
import type { CharacterRollResponseDto, RollSkillDto } from '../../dto/character-roll.dto';
import { loadAccessibleCharacter } from './roll-weapon-context';

export async function executeRollSkill(input: {
  access: PlayerCharacterAccessService;
  sheet: CharacterSheetRepository;
  domain: CharacterDomainService;
  dataSource: DataSource;
  userId: string;
  characterId: string;
  dto: RollSkillDto;
}): Promise<CharacterRollResponseDto> {
  const character = await loadAccessibleCharacter(
    input.access,
    input.userId,
    input.characterId,
  );
  const skillRows = await input.dataSource.query<
    { slug: string; name: string; ability_slug: string }[]
  >(
    `SELECT s.slug, s.name, a.slug AS ability_slug
     FROM rpg.phb_skill s
     JOIN rpg.phb_ability a ON a.id = s.ability_id
     WHERE s.slug = $1
     LIMIT 1`,
    [input.dto.skillSlug],
  );
  const skill = skillRows[0];
  if (!skill) {
    throw new BadRequestException(`Unknown skill '${input.dto.skillSlug}'`);
  }
  const ability = skill.ability_slug as AbilityKey;
  const sheet = await input.sheet.load(character.id, character.backgroundSlug);
  const pb = await input.domain.getProficiencyBonus(character.level);
  const scores = await resolveEffectiveAbilityScores(
    input.dataSource,
    character.classSlug,
    character.level,
    character.abilityScores,
  );
  const mods = computeAbilityModifiers(scores);
  const rank = skillProficiencyRank(input.dto.skillSlug, {
    classSkillSlugs: sheet.classSkillSlugs,
    backgroundSkillSlugs: sheet.backgroundSkillSlugs,
    speciesChoices: sheet.speciesChoices,
    featOptions: sheet.featOptions,
    classOptions: sheet.classOptions,
    classSlug: character.classSlug,
    level: character.level,
  });
  const bonus = skillCheckBonus(mods[ability], pb, rank);
  let mode = input.dto.advantage ?? 'normal';
  if (
    character.subclassSlug === 'champion' &&
    character.level >= 3 &&
    input.dto.skillSlug === 'athletics' &&
    mode === 'normal'
  ) {
    mode = 'advantage';
  }
  const result = rollD20Check(bonus, mode);
  return {
    kind: 'skill',
    label: `Perícia — ${skill.name}`,
    expression: result.expression,
    total: result.total,
    modifier: result.modifier,
    mode: result.mode,
    rolls: result.d20.rolls,
    kept: result.d20.kept,
    note:
      mode === 'advantage' &&
      character.subclassSlug === 'champion' &&
      input.dto.skillSlug === 'athletics'
        ? 'Atleta Extraordinário: Vantagem em Atletismo'
        : undefined,
  };
}
