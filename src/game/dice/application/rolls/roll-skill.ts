import { BadRequestException } from '@nestjs/common';
import { DataSource } from 'typeorm';
import type { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import {
  skillCheckBonus,
  skillProficiencyRank,
} from '@game/sheet/domain/stats/character-check-bonuses';
import { computeAbilityModifiers } from '@game/sheet/domain/stats/character-derived-stats';
import type { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import { resolveEffectiveAbilityScores } from '@game/sheet/infrastructure/load-class-ability-boosts';
import type { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import type { AbilityKey } from '@game/build/domain/ability-generation';
import { rollD20Check } from '@game/dice/domain/dice';
import type { CharacterRollResponseDto, RollSkillDto } from '@game/dice/dto/character-roll.dto';
import type { CharacterResourceSpender } from '@game/session/domain/character-resource-spender';
import { forceAdvantageIfNormal } from './advantage-mode';
import { loadAccessibleCharacter } from './roll-weapon-context';
import { applyStrokeOfLuckIfRequested } from './stroke-of-luck';

export async function executeRollSkill(input: {
  access: PlayerCharacterAccessService;
  sheet: CharacterSheetRepository;
  domain: CharacterDomainService;
  dataSource: DataSource;
  resourceSpender: CharacterResourceSpender;
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
    characterFeats: sheet.characterFeats,
    classOptions: sheet.classOptions,
    classSlug: character.classSlug,
    level: character.level,
  });
  const bonus = skillCheckBonus(mods[ability], pb, rank);
  let mode = input.dto.advantage ?? 'normal';
  if (
    character.subclassSlug === 'champion' &&
    character.level >= 3 &&
    input.dto.skillSlug === 'athletics'
  ) {
    mode = forceAdvantageIfNormal(mode);
  }
  let result = rollD20Check(bonus, mode);
  const notes: string[] = [];
  const reliableTalent =
    character.classSlug === 'rogue' &&
    character.level >= 7 &&
    (rank === 'proficient' || rank === 'expertise');
  const kept = result.d20.kept[0] ?? 0;
  if (reliableTalent && kept < 10) {
    result = {
      ...result,
      expression: `${result.expression} (mín. 10)`,
      total: 10 + bonus,
      d20: { ...result.d20, kept: [10] },
    };
    notes.push(`Talento Confiável: ${kept} tratado como 10`);
  }
  result = await applyStrokeOfLuckIfRequested({
    requested: input.dto.strokeOfLuck,
    spender: input.resourceSpender,
    character,
    result,
    notes,
  });
  if (
    mode === 'advantage' &&
    character.subclassSlug === 'champion' &&
    input.dto.skillSlug === 'athletics'
  ) {
    notes.push('Atleta Extraordinário: Vantagem em Atletismo');
  }
  return {
    kind: 'skill',
    label: `Perícia — ${skill.name}`,
    expression: result.expression,
    total: result.total,
    modifier: result.modifier,
    mode: result.mode,
    rolls: result.d20.rolls,
    kept: result.d20.kept,
    note: notes.length > 0 ? notes.join(' · ') : undefined,
  };
}
