export type Cap6StageMode =
  | 'auto_all'
  | 'pick1'
  | 'pick2'
  | 'fixed_plus_pick1'
  | 'auto_single';

export type Cap6SubOptionRule = {
  key: string;
  fromStage: number;
  whenChoice?: { key: string; value: string };
  values: readonly { id: string; label: string }[];
};

export type Cap6StageRule = {
  mode: Cap6StageMode;
  autoBoons: readonly string[];
  pickKeys: readonly string[];
};

export type Cap6TransformationRule = {
  stages: Record<string, Cap6StageRule>;
  subOptions: readonly Cap6SubOptionRule[];
  requireMatch: readonly {
    laterKey: string;
    earlierKey: string;
    pairs: Record<string, string>;
  }[];
};
