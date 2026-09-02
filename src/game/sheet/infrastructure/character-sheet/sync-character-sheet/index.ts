import { CharacterSheetInput } from '@game/sheet/domain/character-sheet.types';
import {
  syncOptionsAndFeats,
  syncSkillsAndOrigin,
  syncSpellsEquipmentLanguages,
} from './sync-sections';
import type { CharacterSheetSyncDeps } from './types';

export type { CharacterSheetSyncDeps } from './types';

export async function syncCharacterSheet(
  deps: CharacterSheetSyncDeps,
  characterId: string,
  input: CharacterSheetInput,
): Promise<void> {
  await syncSkillsAndOrigin(deps, characterId, input);
  await syncOptionsAndFeats(deps, characterId, input);
  await syncSpellsEquipmentLanguages(deps, characterId, input);
}

export async function clearSubclassOptions(
  deps: CharacterSheetSyncDeps,
  characterId: string,
): Promise<void> {
  await deps.options.delete({ characterId, scope: 'subclass' });
}

export async function clearClassOptions(
  deps: CharacterSheetSyncDeps,
  characterId: string,
): Promise<void> {
  await deps.options.delete({ characterId, scope: 'class' });
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
