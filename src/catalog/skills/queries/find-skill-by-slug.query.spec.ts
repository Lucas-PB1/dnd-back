import { NotFoundException } from '@nestjs/common';
import { FindSkillBySlugQuery } from './find-skill-by-slug.query';

describe('FindSkillBySlugQuery', () => {
  it('maps found skill', async () => {
    const skillsRepo = { findOne: jest.fn().mockResolvedValue({ slug: 'athletics' }) };
    const mapper = { toDto: jest.fn().mockReturnValue({ slug: 'athletics' }) };
    const query = new FindSkillBySlugQuery(skillsRepo as never, mapper as never);
    await expect(query.execute('athletics')).resolves.toEqual({ slug: 'athletics' });
  });

  it('throws when missing', async () => {
    const skillsRepo = { findOne: jest.fn().mockResolvedValue(null) };
    const query = new FindSkillBySlugQuery(
      skillsRepo as never,
      { toDto: jest.fn() } as never,
    );
    await expect(query.execute('x')).rejects.toThrow(NotFoundException);
  });
});
