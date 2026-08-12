import { wickerboneBehemothNote } from './symbiosis-actions';

describe('wickerboneBehemothNote', () => {
  it('uses 1d4 shard below L10', () => {
    const note = wickerboneBehemothNote(3);
    expect(note).toContain('1d4');
    expect(note).not.toContain('Ira da Natureza');
  });

  it('adds Ira da Natureza and 2d4 at L10+', () => {
    const note = wickerboneBehemothNote(10);
    expect(note).toContain('2d4');
    expect(note).toContain('Ira da Natureza');
  });

  it('mentions Nick mastery at L14+', () => {
    expect(wickerboneBehemothNote(14)).toContain('Nick');
  });
});
