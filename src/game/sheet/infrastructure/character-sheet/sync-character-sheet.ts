import { Repository } from 'typeorm';
import { CharacterSheetInput } from '../../domain/character-sheet.types';
import { featInstanceKey } from '../../domain/validation/feats/character-feat';
import { PlayerCharacterSkill } from '../player-character-skill.entity';
import {
  PlayerCharacterClassOption,
  PlayerCharacterEquipment,
  PlayerCharacterFeat,
  PlayerCharacterFeatOption,
  PlayerCharacterLanguage,
  PlayerCharacterSpeciesChoice,
  PlayerCharacterSpell,
  PlayerCharacterSubclassOption,
} from '../player-sheet.entities';

export type CharacterSheetSyncDeps = {
  skills: Repository<PlayerCharacterSkill>;
  speciesChoices: Repository<PlayerCharacterSpeciesChoice>;
  subclassOptions: Repository<PlayerCharacterSubclassOption>;
  classOptions: Repository<PlayerCharacterClassOption>;
  feats: Repository<PlayerCharacterFeat>;
  featOptions: Repository<PlayerCharacterFeatOption>;
  spells: Repository<PlayerCharacterSpell>;
  equipment: Repository<PlayerCharacterEquipment>;
  languages: Repository<PlayerCharacterLanguage>;
};

export async function syncCharacterSheet(
  deps: CharacterSheetSyncDeps,
  characterId: string,
  input: CharacterSheetInput,
): Promise<void> {
  if (input.classSkillSlugs !== undefined) {
    await deps.skills.delete({ characterId });
    if (input.classSkillSlugs.length > 0) {
      await deps.skills.insert(
        input.classSkillSlugs.map((skillSlug) => ({ characterId, skillSlug })),
      );
    }
  }

  if (input.speciesChoices !== undefined) {
    await deps.speciesChoices.delete({ characterId });
    if (input.speciesChoices.length > 0) {
      await deps.speciesChoices.insert(
        input.speciesChoices.map((choice) => ({
          characterId,
          choiceKind: choice.choiceKind,
          choiceSlug: choice.choiceSlug,
        })),
      );
    }
  }

  if (input.subclassOptions !== undefined) {
    await deps.subclassOptions.delete({ characterId });
    if (input.subclassOptions.length > 0) {
      await deps.subclassOptions.insert(
        input.subclassOptions.map((option) => ({
          characterId,
          optionKey: option.optionKey,
          valueId: option.valueId,
        })),
      );
    }
  }

  if (input.classOptions !== undefined) {
    await deps.classOptions.delete({ characterId });
    if (input.classOptions.length > 0) {
      await deps.classOptions.insert(
        input.classOptions.map((option) => ({
          characterId,
          optionKey: option.optionKey,
          valueId: option.valueId,
        })),
      );
    }
  }

  if (input.characterFeats !== undefined) {
    await deps.feats.delete({ characterId });
    if (input.characterFeats.length > 0) {
      await deps.feats.insert(
        input.characterFeats.map((feat) => ({
          characterId,
          featSlug: feat.featSlug,
          instanceIndex: feat.instanceIndex,
        })),
      );
    }

    const validKeys = new Set(
      input.characterFeats.map((feat) =>
        featInstanceKey(feat.featSlug, feat.instanceIndex),
      ),
    );
    // Lote C: featOptions now use ownerSlug + scope
    const existingOptions = await deps.featOptions.find({
      where: { characterId, scope: 'feat' },
    });
    const orphanIds = existingOptions.filter(
      (option) =>
        !validKeys.has(featInstanceKey(option.ownerSlug, option.instanceIndex)),
    );
    if (orphanIds.length > 0) {
      await deps.featOptions.delete(orphanIds.map((o) => o.id));
    }
  }

  if (input.featOptions !== undefined) {
    await deps.featOptions.delete({ characterId, scope: 'feat' });
    if (input.featOptions.length > 0) {
      await deps.featOptions.insert(
        input.featOptions.map((option) => ({
          characterId,
          scope: 'feat' as const,
          ownerSlug: option.featSlug, // API uses featSlug, DB uses ownerSlug
          instanceIndex: option.instanceIndex ?? 0,
          optionKey: option.optionKey,
          valueId: option.valueId,
        })),
      );
    }
  }

  if (input.characterSpells !== undefined) {
    await deps.spells.delete({ characterId });
    if (input.characterSpells.length > 0) {
      await deps.spells.insert(
        input.characterSpells.map((spell) => ({
          characterId,
          spellSlug: spell.spellSlug,
          listType: spell.listType,
        })),
      );
    }
  }

  if (input.equipment !== undefined) {
    await deps.equipment.delete({ characterId });
    if (input.equipment.length > 0) {
      await deps.equipment.insert(
        input.equipment.map((item, index) => ({
          characterId,
          source: item.source,
          packageSlug: item.packageSlug,
          itemSlug: item.itemSlug ?? null,
          quantity: item.quantity ?? 1,
          sortOrder: item.sortOrder ?? index,
        })),
      );
    }
  }

  if (input.languageSlugs !== undefined) {
    await deps.languages.delete({ characterId });
    if (input.languageSlugs.length > 0) {
      await deps.languages.insert(
        input.languageSlugs.map((languageSlug) => ({
          characterId,
          languageSlug,
        })),
      );
    }
  }
}

export async function clearSubclassOptions(
  deps: CharacterSheetSyncDeps,
  characterId: string,
): Promise<void> {
  await deps.subclassOptions.delete({ characterId });
}

export async function clearClassOptions(
  deps: CharacterSheetSyncDeps,
  characterId: string,
): Promise<void> {
  await deps.classOptions.delete({ characterId });
}

export async function clearClassSkills(
  deps: CharacterSheetSyncDeps,
  characterId: string,
): Promise<void> {
  await deps.skills.delete({ characterId });
}

export async function clearSpeciesChoices(
  deps: CharacterSheetSyncDeps,
  characterId: string,
): Promise<void> {
  await deps.speciesChoices.delete({ characterId });
}
