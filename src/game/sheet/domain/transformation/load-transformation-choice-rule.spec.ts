import { loadTransformationChoiceRule } from './load-transformation-choice-rule';
import { asDep } from '@common/testing/as-dep';

describe('loadTransformationChoiceRule', () => {
  it('returns null without slug', async () => {
    const query = jest.fn();
    await expect(
      loadTransformationChoiceRule(asDep({ query }), '  '),
    ).resolves.toBeNull();
    expect(query).not.toHaveBeenCalled();
  });

  it('assembles stages, subs and requireMatch', async () => {
    const query = jest
      .fn()
      .mockResolvedValueOnce([
        { stage: 1, mode: 'fixed_plus_pick1', stage_rule_id: '10' },
        { stage: 4, mode: 'pick1', stage_rule_id: '40' },
      ])
      .mockResolvedValueOnce([
        { stage_rule_id: '10', boon_id: 'fanged-bite', sort_order: 0 },
      ])
      .mockResolvedValueOnce([
        { stage_rule_id: '10', pick_key: 'stage1Boon', sort_order: 0 },
        { stage_rule_id: '40', pick_key: 'stage4Boon', sort_order: 0 },
      ])
      .mockResolvedValueOnce([])
      .mockResolvedValueOnce([
        {
          match_id: '7',
          later_key: 'stage4Boon',
          earlier_key: 'stage1Boon',
        },
      ])
      .mockResolvedValueOnce([
        {
          match_id: '7',
          earlier_value: 'soman-bloodline',
          later_value: 'final-soman-bloodline',
        },
      ]);

    const rule = await loadTransformationChoiceRule(
      asDep({ query }),
      'gh-transformation-vampire',
    );

    expect(rule?.stages['1']).toEqual({
      mode: 'fixed_plus_pick1',
      autoBoons: ['fanged-bite'],
      pickKeys: ['stage1Boon'],
    });
    expect(rule?.requireMatch[0]?.pairs['soman-bloodline']).toBe(
      'final-soman-bloodline',
    );
  });
});
