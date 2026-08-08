export type SpeciesChoiceLike = {
  choiceKind: string;
  choiceSlug: string;
};

const DRAGON_DAMAGE: Record<string, string> = {
  blue: 'Elétrico',
  black: 'Ácido',
  white: 'Gélido',
  gold: 'Ígneo',
  bronze: 'Elétrico',
  silver: 'Gélido',
  copper: 'Ácido',
  green: 'Venenoso',
  brass: 'Ígneo',
  red: 'Ígneo',
};

const TIEFLING_RESISTANCE: Record<string, string> = {
  abyssal: 'Venenoso',
  chthonic: 'Necrótico',
  infernal: 'Ígneo',
};

function choiceSlug(
  choices: readonly SpeciesChoiceLike[] | undefined,
  kind: string,
): string | null {
  return choices?.find((c) => c.choiceKind === kind)?.choiceSlug ?? null;
}

/** Lembretes passivos de espécie para Passivas (não entram na Economia). */
export function speciesCombatNotes(input: {
  speciesSlug: string;
  speciesChoices?: readonly SpeciesChoiceLike[];
}): string[] {
  const { speciesSlug, speciesChoices } = input;
  const notes: string[] = [];

  switch (speciesSlug) {
    case 'aasimar':
      notes.push('Resistência a dano Necrótico e Radiante.');
      notes.push('Visão no Escuro 18 m.');
      break;
    case 'dwarf':
      notes.push('Visão no Escuro 36 m.');
      notes.push(
        'Resistência a Veneno; Vantagem contra a condição Envenenado.',
      );
      notes.push('Tenacidade Anã: +1 PV máx. por nível.');
      break;
    case 'dragonborn': {
      notes.push('Visão no Escuro 18 m.');
      const ancestry = choiceSlug(speciesChoices, 'dragon_ancestry');
      const damage = ancestry ? DRAGON_DAMAGE[ancestry] : null;
      notes.push(
        damage
          ? `Resistência a dano ${damage} (Herança Dracônica).`
          : 'Resistência a dano da Herança Dracônica.',
      );
      break;
    }
    case 'elf': {
      const lineage = choiceSlug(speciesChoices, 'elf_lineage');
      notes.push(
        lineage === 'drow'
          ? 'Visão no Escuro 36 m (Drow).'
          : 'Visão no Escuro 18 m.',
      );
      notes.push(
        'Ancestralidade Feérica: Vantagem contra Enfeitiçado.',
      );
      notes.push('Transe: Descanso Longo em 4 h (sem dormir).');
      if (lineage === 'wood-elf') {
        notes.push('Deslocamento 10,5 m (Elfo Silvestre).');
      }
      break;
    }
    case 'gnome': {
      notes.push('Visão no Escuro 18 m.');
      notes.push('Astúcia: Vantagem em salvaguardas de INT, SAB e CAR.');
      const lineage = choiceSlug(speciesChoices, 'gnome_lineage');
      if (lineage === 'rock-gnome') {
        notes.push(
          'Dispositivo gnômico: ativar com Ação Bônus (toque; qualquer criatura).',
        );
      }
      break;
    }
    case 'goliath':
      notes.push(
        'Porte Poderoso: Vantagem para encerrar Imobilizado; carga como tamanho maior.',
      );
      break;
    case 'human':
      notes.push('Eficiente: Inspiração Heroica ao completar Descanso Longo.');
      break;
    case 'orc':
      notes.push('Visão no Escuro 36 m.');
      break;
    case 'halfling':
      notes.push(
        'Corajoso: Vantagem contra a condição Amedrontado.',
      );
      notes.push(
        'Agilidade Pequenina: atravessar espaço de criatura maior (sem parar).',
      );
      break;
    case 'tiefling': {
      notes.push('Visão no Escuro 18 m.');
      const legacy = choiceSlug(speciesChoices, 'infernal_legacy');
      const damage = legacy ? TIEFLING_RESISTANCE[legacy] : null;
      notes.push(
        damage
          ? `Resistência a dano ${damage} (Legado Ínfero).`
          : 'Resistência a dano do Legado Ínfero.',
      );
      break;
    }
    case 'geppettin': {
      notes.push('Visão no Escuro 18 m.');
      notes.push(
        'Natureza de Construto: sem comida/bebida/ar; LR em 4 h imóvel.',
      );
      if (choiceSlug(speciesChoices, 'geppettin_construction') === 'marionette') {
        notes.push(
          'Marionete: +1,5 m de alcance em arma corpo a corpo (sem Alcance/Duas Mãos/Versátil).',
        );
      }
      break;
    }
    case 'mandrake':
      notes.push(
        'Natureza Vegetal: sem comida com 4 h de sol; respira/absorve pelos pés.',
      );
      break;
    default:
      break;
  }

  return notes;
}
