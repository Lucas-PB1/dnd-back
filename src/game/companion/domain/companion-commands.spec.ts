import { describe, expect, it } from '@jest/globals';
import {
  formatCompanionCommandNote,
  isCompanionCommandSlug,
} from './companion-commands';

const CATALOG = new Map([
  [
    'strike',
    { slug: 'strike', labelPt: 'Golpe da Fera', noteKind: 'strike' as const },
  ],
  [
    'help',
    { slug: 'help', labelPt: 'Ajudar', noteKind: 'bonus_action' as const },
  ],
]);

describe('companion-commands', () => {
  it('validates known slugs', () => {
    expect(isCompanionCommandSlug('strike')).toBe(true);
    expect(isCompanionCommandSlug('fly')).toBe(false);
  });

  it('formats strike and bonus-action notes from catalog labels', () => {
    expect(formatCompanionCommandNote('strike', CATALOG, 'Céu')).toContain(
      'Golpe da Fera',
    );
    expect(formatCompanionCommandNote('help', CATALOG)).toBe(
      'Companheiro: Ação Bônus — Ajudar.',
    );
  });
});
