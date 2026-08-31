import {
  aggregateTraitTakes,
  collectHeritageTraitPicks,
  type HeritageTraitPick,
} from '@game/sheet/domain/heritage/aggregate-trait-takes';

const DARKVISION_BASE_M = 18;
const DARKVISION_IMPROVED_M = 36;

/** Lembretes passivos de traços GH para a faixa de combate/ficha. */
export function heritageCombatNotes(input: {
  heritageChoices?: readonly HeritageTraitPick[];
}): string[] {
  const picks = collectHeritageTraitPicks(input.heritageChoices ?? []);
  if (picks.length === 0) return [];

  const notes: string[] = [];
  const aggregated = aggregateTraitTakes(picks);

  for (const entry of aggregated) {
    switch (entry.traitSlug) {
      case 'improved-darkvision':
        notes.push(
          entry.takeCount >= 2
            ? `Visão no Escuro ${DARKVISION_IMPROVED_M} m.`
            : `Visão no Escuro ${DARKVISION_BASE_M} m.`,
        );
        break;
      case 'damage-immunity':
        notes.push('Resistência a um tipo de dano (escolha do traço).');
        break;
      case 'extra-tough':
        notes.push(`+${entry.takeCount} PV máx. por nível (Robustez).`);
        break;
      case 'weapon-specialist':
        notes.push('Proficiência em armas (escolha do traço).');
        break;
      case 'helpful-tactics':
        notes.push('Vantagem em testes para ajudar aliados.');
        break;
      case 'magical-savant':
      case 'magical-savvy':
        notes.push('Truques adicionais (escolha do traço).');
        break;
      case 'stand-fast':
        notes.push('Bônus em salvaguardas contra ser movido.');
        break;
      case 'artisanal-expertise':
        notes.push('Proficiência em ferramentas (escolha do traço).');
        break;
      case 'restorative-rest':
        notes.push('Descanso curto: gasta Dados de Vida adicionais.');
        break;
      default:
        break;
    }
  }

  return notes;
}

export async function loadHeritageHitPointsBonus(
  dataSource: import('typeorm').DataSource,
  heritageChoices: readonly HeritageTraitPick[],
  level: number,
): Promise<number> {
  const aggregated = aggregateTraitTakes(collectHeritageTraitPicks(heritageChoices));
  if (aggregated.length === 0) return 0;

  const rows = await dataSource.query<
    Array<{
      trait_slug: string;
      per_level_bonus: number;
      flat_bonus: number;
      min_trait_takes: number;
      from_level: number;
    }>
  >(
    `SELECT trait_slug, per_level_bonus, flat_bonus, min_trait_takes, from_level
     FROM rpg.v_phb_heritage_passive_modifier
     WHERE kind = 'hp_bonus'`,
  );

  let bonus = 0;
  for (const entry of aggregated) {
    const row = rows.find(
      (candidate) =>
        candidate.trait_slug === entry.traitSlug &&
        entry.takeCount >= Number(candidate.min_trait_takes),
    );
    if (!row) continue;
    const fromLevel = Number(row.from_level) || 1;
    if (level < fromLevel) continue;
    bonus += Number(row.flat_bonus) || 0;
    bonus += (Number(row.per_level_bonus) || 0) * level;
  }
  return bonus;
}
