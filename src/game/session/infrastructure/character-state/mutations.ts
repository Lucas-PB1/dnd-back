/** Barrel — imports existentes em `./mutations` continuam estáveis. */
export { applyPatchState } from './core/patch-state';
export {
  applyUseClassResource,
  applyRecoverClassResource,
  applySetPersonaMasks,
  applySetBestialAspectLevel,
} from './resources/resource-mutations';
export {
  applyUseManeuver,
  applyReloadFirearm,
  applyFireChamber,
  listAvailableManeuvers,
} from './martial/gunslinger-mutations';
export {
  applyToggleRage,
  applyToggleReckless,
  applyRecoverAllRage,
} from './martial/barbarian-mutations';
export { applySecondWind } from './martial/fighter/second-wind';
export { applyTacticalMind } from './martial/fighter/tactical-mind';
export { applyActionSurge } from './martial/fighter/action-surge';
