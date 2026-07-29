import {
  itemEffectsActive,
  itemEffectsStatus,
} from './item-effects-active';

describe('itemEffectsActive', () => {
  it.each([
    {
      name: 'equipped without attunement requirement',
      input: {
        location: 'equipped' as const,
        attuned: false,
        requiresAttunement: false,
      },
      active: true,
      status: 'active',
    },
    {
      name: 'equipped + attuned when required',
      input: {
        location: 'equipped' as const,
        attuned: true,
        requiresAttunement: true,
      },
      active: true,
      status: 'active',
    },
    {
      name: 'equipped but not attuned when required',
      input: {
        location: 'equipped' as const,
        attuned: false,
        requiresAttunement: true,
      },
      active: false,
      status: 'inactive_unattuned',
    },
    {
      name: 'backpack even when attuned',
      input: {
        location: 'backpack' as const,
        attuned: true,
        requiresAttunement: true,
      },
      active: false,
      status: 'inactive_unequipped',
    },
    {
      name: 'backpack without attunement requirement',
      input: {
        location: 'backpack' as const,
        attuned: false,
        requiresAttunement: false,
      },
      active: false,
      status: 'inactive_unequipped',
    },
  ])('$name', ({ input, active, status }) => {
    expect(itemEffectsActive(input)).toBe(active);
    expect(itemEffectsStatus(input)).toBe(status);
  });
});
