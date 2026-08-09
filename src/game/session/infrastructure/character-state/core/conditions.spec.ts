import { BadRequestException } from '@nestjs/common';
import { Repository } from 'typeorm';
import { PhbCondition } from '@game/session/infrastructure/phb-condition.entity';
import { assertValidConditions } from './conditions';

describe('conditions', () => {
  function repo(slugs: string[]) {
    return {
      find: jest.fn().mockResolvedValue(slugs.map((slug) => ({ slug }))),
    } as unknown as Repository<PhbCondition>;
  }

  it('accepts empty condition lists', async () => {
    const conditions = repo([]);
    await expect(assertValidConditions(conditions, [])).resolves.toBeUndefined();
    expect(conditions.find).not.toHaveBeenCalled();
  });

  it('accepts when every slug exists in catalog', async () => {
    const conditions = repo(['poisoned', 'prone']);
    await expect(
      assertValidConditions(conditions, ['poisoned', 'prone']),
    ).resolves.toBeUndefined();
  });

  it('throws listing unknown slugs', async () => {
    const conditions = repo(['poisoned']);
    await expect(
      assertValidConditions(conditions, ['poisoned', 'fake', 'also-fake']),
    ).rejects.toThrow(BadRequestException);
    await expect(
      assertValidConditions(conditions, ['poisoned', 'fake']),
    ).rejects.toThrow(/Unknown conditions: fake/);
  });
});
