import { DataSource } from 'typeorm';
import { loadEldritchInvocationEffectCatalog } from '@game/combat/application/load-eldritch-invocation-effect-catalog';
import {
  readEldritchInvocationPicks,
  resolveEldritchInvocationFreeCast,
} from '@game/combat/domain/warlock';
import { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import { freeCastsRemaining } from '@game/spellcasting/domain/resolve-granted-spell-cast-economy';
import { CharacterStateResponseDto } from '@game/session/dto/core/character-state-response.dto';

export type GrantedSpellCastOption =
  CharacterStateResponseDto['grantedSpellCastOptions'][number];

export async function appendEldritchFreeCastOptions(input: {
  sheet: Awaited<ReturnType<CharacterSheetRepository['loadGrantedSpellSlice']>>;
  grantedSpellUses: Record<string, number>;
  dataSource: DataSource;
  options: GrantedSpellCastOption[];
}): Promise<void> {
  const { sheet, grantedSpellUses, dataSource, options } = input;

  const picks = readEldritchInvocationPicks(sheet.classOptions);
  if (picks.length === 0) return;

  const catalog = await loadEldritchInvocationEffectCatalog(dataSource);
  const pickedSlugs = picks.map((pick) => pick.slug);
  const seen = new Set(options.map((row) => row.spellSlug));

  for (const spell of sheet.characterSpells) {
    if (seen.has(spell.spellSlug)) continue;
    const freeCast = resolveEldritchInvocationFreeCast({
      spellSlug: spell.spellSlug,
      pickedSlugs,
      catalog,
    });
    if (!freeCast) continue;
    seen.add(spell.spellSlug);
    options.push({
      spellSlug: spell.spellSlug,
      castEconomy: freeCast.economy,
      freeCastsRemaining: freeCastsRemaining(
        freeCast.economy,
        spell.spellSlug,
        grantedSpellUses,
      ),
    });
  }

  for (const row of catalog) {
    if (row.kind !== 'free_cast' || !row.grantedSpellSlug) continue;
    if (seen.has(row.grantedSpellSlug)) continue;
    const freeCast = resolveEldritchInvocationFreeCast({
      spellSlug: row.grantedSpellSlug,
      pickedSlugs,
      catalog,
    });
    if (!freeCast) continue;
    seen.add(row.grantedSpellSlug);
    options.push({
      spellSlug: row.grantedSpellSlug,
      castEconomy: freeCast.economy,
      freeCastsRemaining: freeCastsRemaining(
        freeCast.economy,
        row.grantedSpellSlug,
        grantedSpellUses,
      ),
    });
  }
}
