import { DWARF_CULTURE_KIND } from './species-culture';

/** option_key do catálogo → choiceKind na ficha. */
const OPTION_KEY_TO_CHOICE_KIND: Record<string, string> = {
  giantAncestryId: 'giant_ancestry',
  constructionId: 'geppettin_construction',
  dragonAncestryId: 'dragon_ancestry',
  lineageId: 'elf_lineage',
  gnomeLineageId: 'gnome_lineage',
  infernalLegacyId: 'infernal_legacy',
  serviceModelId: 'manikin_service_model',
  armorPresetId: 'manikin_armor',
  monstrousLineageId: 'scourgeborne_lineage',
  madnessId: 'scourgeborne_madness',
  bearfolkLineageId: 'bearfolk_lineage',
  naturalAdaptationId: 'beastkin_adaptation',
  giantkinAncestryId: 'giantkin_ancestry',
  trollkinAncestryId: 'trollkin_ancestry',
  seasonId: 'mandrake_season',
  dwarfCultureId: DWARF_CULTURE_KIND,
};

export function choiceKindForOptionKey(optionKey: string): string {
  return OPTION_KEY_TO_CHOICE_KIND[optionKey] ?? optionKey;
}
