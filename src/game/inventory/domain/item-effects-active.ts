/** Efeitos permanentes só contam com item equipado e sintonizado quando exigido. */

export function itemEffectsActive(input: {
  location: 'equipped' | 'backpack';
  attuned: boolean;
  requiresAttunement: boolean;
}): boolean {
  if (input.location !== 'equipped') return false;
  if (!input.requiresAttunement) return true;
  return input.attuned;
}

export type ItemEffectsStatus =
  | 'active'
  | 'inactive_unequipped'
  | 'inactive_unattuned';

export function itemEffectsStatus(input: {
  location: 'equipped' | 'backpack';
  attuned: boolean;
  requiresAttunement: boolean;
}): ItemEffectsStatus {
  if (itemEffectsActive(input)) return 'active';
  if (input.location !== 'equipped') return 'inactive_unequipped';
  return 'inactive_unattuned';
}
