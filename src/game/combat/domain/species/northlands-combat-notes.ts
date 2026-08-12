import type { SpeciesChoiceLike } from './combat-notes';

/** Passivas Northlands para o painel Passivas (lado direito). */
export function northlandsSpeciesCombatNotes(
  speciesSlug: string,
  _speciesChoices?: readonly SpeciesChoiceLike[],
): string[] {
  switch (speciesSlug) {
    case 'bearfolk':
      return [
        'Pelagem Espessa: Resistência a Gélido; Imunidade a frio extremo.',
        'Coração Selvagem: você e aliados a 1,5 m — Vantagem vs Amedrontado (se consciente e sem Incapacitado).',
        'Predador de Ápice: em teste de Carisma, pode somar FOR ou CON (usos = PB / DL).',
      ];
    case 'beastkin':
      return [
        'Instinto Animal / Armas Naturais: declare ataques naturais na mesa.',
        'Adaptação Natural: benefício da adaptação escolhida na criação.',
      ];
    case 'giantkin':
      return [
        'Constituição Poderosa: benefício passivo da ancestria.',
        'Pegar e Arremessar: declare arremesso de criatura/objeto na mesa.',
      ];
    case 'trollkin':
      return [
        'Visão no Escuro.',
        'Regeneração Trollística: Ação Bônus + gasto de HD (declare na mesa).',
        'Arma Natural / Adaptação: conforme ancestria.',
      ];
    case 'werekin':
      return [
        'Visão no Escuro; Garras; Faro; Proeza Predatória.',
        'Mudar Aspecto: use a Economia; Força Bestial concede PV temp. (2× PB).',
      ];
    case 'baugsmidr-dwarf':
      return [
        'Visão no Escuro 36 m; Resiliência Anã (Veneno).',
        'Artesão Mágico / Lore Arcano: declare na mesa.',
        'Sentir Magia: use a Economia.',
      ];
    case 'fjord-dwarf':
      return [
        'Visão no Escuro; Tenacidade Anã (+1 PV máx./nível).',
        'Guerreiro dos Fiordes / Maestria das Ondas: declare na mesa.',
      ];
    default:
      return [];
  }
}
