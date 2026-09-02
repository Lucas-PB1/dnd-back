import { BadRequestException } from '@nestjs/common';
import { assertAndConsumeHighElfCantripSwap } from './assert-high-elf-cantrip-swap';

describe('assertAndConsumeHighElfCantripSwap', () => {
  let dataSource: { query: jest.Mock };

  beforeEach(() => {
    dataSource = { query: jest.fn() };
  });

  it('no-ops when cantrip unchanged', async () => {
    await assertAndConsumeHighElfCantripSwap(
      dataSource as never,
      'c1',
      [{ choiceKind: 'high_elf_cantrip', choiceSlug: 'fire-bolt' }],
      [{ choiceKind: 'high_elf_cantrip', choiceSlug: 'fire-bolt' }],
    );
    expect(dataSource.query).not.toHaveBeenCalled();
  });

  it('rejects swap when flag is false', async () => {
    dataSource.query.mockResolvedValueOnce([
      { high_elf_cantrip_swap_available: false },
    ]);
    await expect(
      assertAndConsumeHighElfCantripSwap(
        dataSource as never,
        'c1',
        [{ choiceKind: 'high_elf_cantrip', choiceSlug: 'prestidigitacao-arcana' }],
        [{ choiceKind: 'high_elf_cantrip', choiceSlug: 'fire-bolt' }],
      ),
    ).rejects.toThrow(BadRequestException);
  });

  it('consumes flag when swap allowed', async () => {
    dataSource.query
      .mockResolvedValueOnce([{ high_elf_cantrip_swap_available: true }])
      .mockResolvedValueOnce([]);
    await assertAndConsumeHighElfCantripSwap(
      dataSource as never,
      'c1',
      [],
      [{ choiceKind: 'high_elf_cantrip', choiceSlug: 'fire-bolt' }],
    );
    expect(dataSource.query).toHaveBeenCalledTimes(2);
    expect(dataSource.query.mock.calls[1][0]).toContain(
      'high_elf_cantrip_swap_available = false',
    );
  });
});
