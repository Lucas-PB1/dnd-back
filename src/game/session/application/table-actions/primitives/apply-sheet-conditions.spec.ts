import { applySheetConditions } from './apply-sheet-conditions';
import { asDep } from '@common/testing/as-dep';

describe('applySheetConditions', () => {
  const character = asDep({ id: 'pc-1' });
  const patch = jest.fn();
  const stateRepo = asDep({ patch });

  beforeEach(() => {
    jest.clearAllMocks();
    patch.mockImplementation(async (_c, dto) => dto);
  });

  it('adds a condition without duplicating', async () => {
    await applySheetConditions(
      stateRepo,
      character,
      asDep({ conditions: ['prone'] }),
      { add: ['invisible', 'prone'] },
    );
    expect(patch).toHaveBeenCalledWith(character, {
      conditions: ['prone', 'invisible'],
    });
  });

  it('removes listed conditions', async () => {
    await applySheetConditions(
      stateRepo,
      character,
      asDep({ conditions: ['poisoned', 'frightened', 'charmed'] }),
      { remove: ['poisoned', 'charmed'] },
    );
    expect(patch).toHaveBeenCalledWith(character, {
      conditions: ['frightened'],
    });
  });
});
