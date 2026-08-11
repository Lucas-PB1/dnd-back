import {
  buildEldritchCantripCastNote,
  readEldritchInvocationCantripBindings,
  type EldritchFreeCastResolution,
} from '@game/combat/domain/warlock';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import { CastSpellDto } from '@game/session/dto';

export function appendNonItemCastNotes(input: {
  note: string | null;
  usedEldritchFreeCast: EldritchFreeCastResolution | null;
  spell: { level: number };
  dto: CastSpellDto;
  sheetClassOptions: unknown;
  character: PlayerCharacter;
}): string | null {
  let note = input.note;
  if (input.usedEldritchFreeCast) {
    const freeNote = `${input.usedEldritchFreeCast.invocationName}: conjurada sem espaço.`;
    note = note ? `${note} · ${freeNote}` : freeNote;
  }
  const blastNote = buildEldritchCantripCastNote({
    spellLevel: input.spell.level,
    spellSlug: input.dto.spellSlug,
    bindings: readEldritchInvocationCantripBindings(
      input.sheetClassOptions as never,
    ),
    charismaModifier: abilityModifier(
      input.character.abilityScores.carisma ?? 10,
    ),
    warlockLevel: input.character.level,
  });
  if (blastNote) {
    note = note ? `${note} · ${blastNote}` : blastNote;
  }
  return note;
}
