import { DataSource } from 'typeorm';
import type { CharacterDomainService } from '../../../sheet/domain/core/character-domain.service';
import { collectSaveProficiencyAbilities } from '../../../sheet/domain/stats/character-check-bonuses';
import { computeAbilityModifiers } from '../../../sheet/domain/stats/character-derived-stats';
import type { CharacterSheetRepository } from '../../../sheet/infrastructure/character-sheet.repository';
import type { PlayerCharacterAccessService } from '../../../shared/player-character-access.service';
import type { AbilityKey } from '../../../build/domain/ability-generation';
import { rollD20Check } from '../../domain/dice';
import type {
  CharacterRollResponseDto,
  RollSavingThrowDto,
} from '../../dto/character-roll.dto';
import { loadAccessibleCharacter } from './roll-weapon-context';
import type { ResolveActivePermanentItemEffects } from '../../../inventory/application/resolve-active-permanent-item-effects';
import { applyItemAbilityBonuses } from '../../../inventory/domain/permanent-item-effects';

const ABILITY_LABELS: Record<AbilityKey, string> = {
  forca: 'Força',
  destreza: 'Destreza',
  constituicao: 'Constituição',
  inteligencia: 'Inteligência',
  sabedoria: 'Sabedoria',
  carisma: 'Carisma',
};

export async function executeRollSavingThrow(input: {
  access: PlayerCharacterAccessService;
  sheet: CharacterSheetRepository;
  domain: CharacterDomainService;
  dataSource: DataSource;
  permanentItemEffects: ResolveActivePermanentItemEffects;
  userId: string;
  characterId: string;
  dto: RollSavingThrowDto;
}): Promise<CharacterRollResponseDto> {
  const character = await loadAccessibleCharacter(
    input.access,
    input.userId,
    input.characterId,
  );
  const ability = input.dto.abilitySlug as AbilityKey;
  const stRows = await input.dataSource.query<{ slug: string }[]>(
    `SELECT a.slug
     FROM rpg.phb_class_saving_throw cst
     JOIN rpg.phb_class c ON c.id = cst.class_id
     JOIN rpg.phb_ability a ON a.id = cst.ability_id
     WHERE c.slug = $1`,
    [character.classSlug],
  );
  const sheet = await input.sheet.load(character.id, character.backgroundSlug);
  const saveProficiencies = new Set(
    collectSaveProficiencyAbilities(
      stRows.map((row) => row.slug),
      sheet.featOptions,
    ),
  );
  const proficient = saveProficiencies.has(ability);
  const pb = await input.domain.getProficiencyBonus(character.level);
  const itemEffects = await input.permanentItemEffects.resolve(character.id);
  const scores = applyItemAbilityBonuses(
    character.abilityScores,
    itemEffects.abilityBonuses,
  );
  const mods = computeAbilityModifiers(scores);
  const itemSaveBonus = itemEffects.savingThrowBonuses[ability] ?? 0;
  const bonus = mods[ability] + (proficient ? pb : 0) + itemSaveBonus;
  const result = rollD20Check(bonus, input.dto.advantage ?? 'normal');
  return {
    kind: 'saving_throw',
    label: `Salvaguarda — ${ABILITY_LABELS[ability]}`,
    expression: result.expression,
    total: result.total,
    modifier: result.modifier,
    mode: result.mode,
    rolls: result.d20.rolls,
    kept: result.d20.kept,
  };
}
