export type RogueSubclassSlug =
  | 'soulknife'
  | 'assassin'
  | 'thief'
  | 'arcane-trickster'
  | 'arachnoid-stalker';

export type CunningStrikeEffectSlug =
  | 'poison'
  | 'withdraw'
  | 'trip'
  | 'hidden-attack'
  | 'daze'
  | 'knock-out'
  | 'obscure'
  | 'paralyze';

export type CunningStrikeEffect = {
  slug: CunningStrikeEffectSlug;
  name: string;
  cost: number;
  unlockLevel: number;
  saveAbility?: 'constitution' | 'dexterity';
  subclassSlug?: 'arachnoid-stalker' | 'thief';
  note: string;
};
