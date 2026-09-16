import { DataSource } from 'typeorm';
import { executeCatalogEffect } from '@game/effects';
import type { CatalogEffect, LoadEffectCatalog } from '@game/effects';
import { extraFromUpcastOption } from '@game/session/domain/spell-upcast-option';
import { PlayerCharacterState } from '@game/session/infrastructure/player-character-state.entity';
import { CharacterRepository } from '@game/shared/infrastructure/character.repository';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import { loadSpellcastingAbilitySlug } from '@game/spellcasting/application/resolve-character-spellcasting-slice';

export async function applyCastSheetEffects(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  characters: CharacterRepository;
  effectCatalog: LoadEffectCatalog;
  dataSource: DataSource;
  spellSlug: string;
  spellLevel: number;
  slotLevelUsed: number | null;
  rng?: () => number;
}): Promise<string | null> {
  const effects = await input.effectCatalog.load({
    ownerKind: 'spell',
    ownerSlugs: [input.spellSlug],
    triggers: ['on_cast'],
    kinds: ['heal', 'temp_hp'],
  });
  if (effects.length === 0) return null;

  const abilitySlug = await loadSpellcastingAbilitySlug(
    input.dataSource,
    input.character.classSlug,
  );
  const scores = input.character.abilityScores;
  const castingMod =
    abilitySlug && scores
      ? abilityModifier(scores[abilitySlug] ?? 10)
      : 0;
  const slotLevel = input.slotLevelUsed ?? input.spellLevel;
  const extraSlots = Math.max(0, slotLevel - input.spellLevel);

  const notes: string[] = [];
  for (const effect of effects) {
    const note = await applyOneCastSheetEffect({
      character: input.character,
      state: input.state,
      characters: input.characters,
      effect,
      extraSlots,
      castingMod,
      rng: input.rng,
    });
    if (note) notes.push(note);
  }
  return notes.length ? notes.join(' · ') : null;
}

async function applyOneCastSheetEffect(input: {
  character: PlayerCharacter;
  state: PlayerCharacterState;
  characters: CharacterRepository;
  effect: CatalogEffect;
  extraSlots: number;
  castingMod: number;
  rng?: () => number;
}): Promise<string | null> {
  const extra = extraFromUpcastOption(
    input.effect.spell?.optionKey ?? null,
    input.extraSlots,
  );
  const usesCastingMod = input.effect.numeric?.amountFormula === 'ability_mod';
  const baseFlat = usesCastingMod
    ? input.castingMod
    : (input.effect.numeric?.flat ?? 0);
  const executed = executeCatalogEffect(input.effect, {
    level: input.character.level,
    rng: input.rng,
    diceCount: extra.extraDice,
    flatOverride: baseFlat + extra.extraFlat,
  });
  if (executed.kind !== 'heal' && executed.kind !== 'temp_hp') {
    return null;
  }

  if (executed.kind === 'heal') {
    const healed = await applySelfHeal(
      input.characters,
      input.character,
      executed.amount,
    );
    const expression = executed.expression ?? String(executed.amount);
    const catalogNote = executed.note
      ?.replace(/\{total\}/g, String(executed.amount))
      .replace(/\{expression\}/g, expression);
    return [catalogNote, `Cura: ${expression} → +${healed} PV.`]
      .filter(Boolean)
      .join(' ');
  }

  input.state.tempHp = Math.max(input.state.tempHp ?? 0, executed.amount);
  const expression = executed.expression ?? String(executed.amount);
  const catalogNote = executed.note
    ?.replace(/\{total\}/g, String(executed.amount))
    .replace(/\{expression\}/g, expression);
  return [catalogNote, `PV temporários: ${expression} → ${input.state.tempHp}.`]
    .filter(Boolean)
    .join(' ');
}

async function applySelfHeal(
  characters: CharacterRepository,
  character: PlayerCharacter,
  amount: number,
): Promise<number> {
  if (
    amount <= 0 ||
    character.hitPointsCurrent == null ||
    character.hitPointsMax == null
  ) {
    return 0;
  }
  const before = character.hitPointsCurrent;
  const after = Math.min(character.hitPointsMax, before + amount);
  const healed = after - before;
  character.hitPointsCurrent = after;
  await characters.save(character);
  return healed;
}
