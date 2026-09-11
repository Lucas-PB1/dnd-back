/**
 * Porta estável Catalog → Game (ACL).
 *
 * O BC Game deve importar daqui (ou `CatalogLookupService` / `CatalogModule`),
 * não de caminhos profundos `@catalog/<feature>/domain|queries|application/...`.
 *
 * Ampliar esta superfície com cuidado — cada export é contrato entre BCs.
 */
export { CatalogLookupService } from '../catalog-lookup.service';
export { ClassProficienciesQuery } from '../classes/queries/class-proficiencies.query';
export { RecordItemCatalogStatsService } from '../items/application/record-item-catalog-stats.service';
export {
  assertNotClassGrantedCatalogItem,
  isClassGrantedCatalogItem,
  EXCLUDE_CLASS_GRANTED_ITEMS_SQL,
  EXCLUDE_CLASS_GRANTED_ITEMS_JOIN_SQL,
} from '../items/domain/class-granted-catalog-item';
export {
  weaponPropsOf,
  loadWeaponPropertyRows,
  loadWeaponMasteryBySlug,
  type WeaponPropsJson,
} from '../equipment/weapon-props';
export { choiceKindForOptionKey } from '../species/domain/species-option-keys';
export {
  DWARF_CULTURE_KIND,
  DWARF_CULTURE_OPTION_KEY,
  resolveDwarfCulture,
  resolveTraitPackageSlug,
  type SpeciesChoiceRef,
} from '../species/domain/species-culture';
