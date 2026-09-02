import { DataSource } from 'typeorm';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { CharacterDomainService } from '../../domain/core/character-domain.service';
import type { ClassAbilityBoostRow } from '../../domain/stats/class-ability-boost';
import { CharacterSheetData } from '../../domain/character-sheet.types';
import { loadClassAbilityBoosts } from '../load-class-ability-boosts';
import { sheetProfile } from '@common/perf/sheet-profile';

/** Prefere meta do P032; fallback para queries legadas se o bundle ainda não trouxer. */
export async function resolveSheetMeta(
  domain: CharacterDomainService,
  dataSource: DataSource,
  row: PlayerCharacter,
  loaded: CharacterSheetData,
): Promise<{
  proficiencyBonus: number;
  classBoosts: ClassAbilityBoostRow[];
  speciesSize: string | null;
}> {
  if (loaded.proficiencyBonus != null) {
    return {
      proficiencyBonus: loaded.proficiencyBonus,
      classBoosts: loaded.classAbilityBoosts ?? [],
      speciesSize: loaded.speciesSize ?? null,
    };
  }

  const [proficiencyBonus, classBoosts] = await sheetProfile(
    'pb+boosts+species',
    () =>
      Promise.all([
        domain.getProficiencyBonus(row.level),
        loadClassAbilityBoosts(dataSource, row.classSlug),
      ]),
  );
  return {
    proficiencyBonus,
    classBoosts: loaded.classAbilityBoosts ?? classBoosts,
    speciesSize: loaded.speciesSize ?? null,
  };
}
