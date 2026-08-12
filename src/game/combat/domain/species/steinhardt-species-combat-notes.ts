import type { SpeciesChoiceLike } from './combat-notes';

function choiceSlug(
  choices: readonly SpeciesChoiceLike[] | undefined,
  kind: string,
): string | null {
  return choices?.find((c) => c.choiceKind === kind)?.choiceSlug ?? null;
}

/** Passivas Steinhardt (Manikin / Scourgeborne) no painel Passivas. */
export function steinhardtSpeciesCombatNotes(
  speciesSlug: string,
  speciesChoices?: readonly SpeciesChoiceLike[],
): string[] {
  if (speciesSlug === 'manikin') {
    const notes: string[] = [];
    const armor = choiceSlug(speciesChoices, 'manikin_armor');
    if (armor === 'infiltrator') {
      notes.push(
        'Infiltrador: CA 11+DES; sem armadura; Vantagem em Furtividade.',
      );
    } else if (armor === 'sentinel') {
      notes.push(
        'Sentinela: CA 13+DES(máx.2) ou FOR(máx.3); conta como armadura Média.',
      );
    } else if (armor === 'tormentor') {
      notes.push(
        'Tormentador: CA 16+FOR(máx.2); conta como armadura Pesada; Desvantagem em Furtividade.',
      );
    }
    const model = choiceSlug(speciesChoices, 'manikin_service_model');
    if (model === 'custodian') {
      notes.push(
        'Custódio: Vantagem para encerrar Agarrado; carga como tamanho maior.',
      );
    } else if (model === 'handler') {
      notes.push(
        'Manipulador: Furtividade + Kit de Disfarce; até 2 armas embutidas.',
      );
    } else if (model === 'thespian') {
      notes.push('Teatral: proficiência em Atuação; conexão via cordas.');
    }
    return notes;
  }

  if (speciesSlug === 'scourgeborne') {
    const notes: string[] = [];
    const madness = choiceSlug(speciesChoices, 'scourgeborne_madness');
    if (madness === 'good') {
      notes.push(
        'Loucura (Bom): Vantagem vs Enfeitiçado; Desvantagem em Intimidação.',
      );
    } else if (madness === 'evil') {
      notes.push(
        'Loucura (Mau): +PB em salvaguardas de DES; Desvantagem vs Enfeitiçado.',
      );
    }
    const lineage = choiceSlug(speciesChoices, 'scourgeborne_lineage');
    if (lineage === 'aranea') {
      notes.push('Aranea: Escalada 9 m; Desvantagem na água.');
    } else if (lineage === 'belua') {
      notes.push(
        'Belua: Vantagem em Percepção (audição/olfato); 1d4 psíquico ao Ensanguentar.',
      );
    } else if (lineage === 'cervus') {
      notes.push('Cervus: Deslocamento 12 m; levantar-se +1,5 m.');
    } else if (lineage === 'vespertilio') {
      notes.push(
        'Vespertilio: Visão Cega 9 m; Desvantagem em visão além disso.',
      );
    }
    return notes;
  }

  return [];
}
