import type { BattleMasterManeuver } from '../../domain/fighter';
import type {
  ClassEconomyActionRecord,
  ClassPanelActionRecord,
} from '../../domain/class-action-ui-catalog';
import type { PrecautionSpell } from '../../domain/fighter';
import type { GunslingerManeuver } from '../../domain/gunslinger';
import type { CunningStrikeEffect } from '../../domain/rogue/types';
import type { SubclassTableAction } from '../../domain/catalog';
import type { StrikeOption } from '../../domain/strike-option';

export type PersonaMaskCatalogEntry = {
  slug: string;
  name: string;
};

export type CombatMechanicalCatalog = {
  gunslingerManeuvers: GunslingerManeuver[];
  battleMasterManeuvers: BattleMasterManeuver[];
  cunningStrikeEffects: CunningStrikeEffect[];
  strikeOptions: StrikeOption[];
  tableActions: SubclassTableAction[];
  personaMasks: PersonaMaskCatalogEntry[];
  personaMaskSlugs: string[];
  beastborneAspectBenefits: { level: number; note: string }[];
  dungeoneerSlayerLabels: string[];
  precautionSpells: PrecautionSpell[];
  economyActions: ClassEconomyActionRecord[];
  panelActions: ClassPanelActionRecord[];
  /** gate_key → unlock_level, por subclass slug. */
  featureGatesBySubclassSlug: ReadonlyMap<string, ReadonlyMap<string, number>>;
  /** Schedules nível→valor por class slug. */
  featureSchedulesByClassSlug: ReadonlyMap<
    string,
    readonly import('../../domain/feature-schedule').FeatureScheduleBand[]
  >;
  /** Schedules nível→valor por subclass slug. */
  featureSchedulesBySubclassSlug: ReadonlyMap<
    string,
    readonly import('../../domain/feature-schedule').FeatureScheduleBand[]
  >;
};
