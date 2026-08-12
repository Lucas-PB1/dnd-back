import { DataSource } from 'typeorm';
import type {
  SpeciesChoiceRef,
  SpeciesResourceOptionGate,
} from '@game/session/domain/filter-species-resources-by-option';

export async function loadCharacterSpeciesChoices(
  dataSource: DataSource,
  characterId: string,
): Promise<SpeciesChoiceRef[]> {
  if (!characterId) return [];
  const rows = await dataSource.query<
    { choice_kind: string; choice_slug: string }[]
  >(
    `SELECT choice_kind::text AS choice_kind, choice_slug
     FROM rpg.player_character_species_choice
     WHERE character_id = $1`,
    [characterId],
  );
  return rows.map((row) => ({
    choiceKind: row.choice_kind,
    choiceSlug: row.choice_slug,
  }));
}

/** Gates de economy por resource_slug da espécie (C011/C055). */
export async function loadSpeciesResourceOptionGates(
  dataSource: DataSource,
  speciesSlug: string,
): Promise<SpeciesResourceOptionGate[]> {
  if (!speciesSlug) return [];
  const rows = await dataSource.query<
    {
      resource_slug: string;
      requires_option_key: string | null;
      requires_option_value: string | null;
    }[]
  >(
    `SELECT e.resource_slug,
            e.requires_option_key,
            e.requires_option_value
     FROM rpg.phb_class_economy_action e
     JOIN rpg.phb_species sp ON sp.id = e.species_id
     WHERE sp.slug = $1
       AND e.resource_slug IS NOT NULL`,
    [speciesSlug],
  );
  return rows.map((row) => ({
    resourceSlug: row.resource_slug,
    requiresOptionKey: row.requires_option_key,
    requiresOptionValue: row.requires_option_value,
  }));
}
