import { DataSource } from 'typeorm';
import { PhbFightingStyle } from '@entities/class/phb-fighting-style.entity';
import { PhbItem } from '@entities/equipment/phb-item.entity';
import { PhbSkill } from '@entities/reference/phb-skill.entity';
import { VPhbSpell } from '@entities/views/v-phb-spell.entity';
import {
  featSpellMatchesExactLevel,
  featSpellMatchesRitualLevel,
  featSpellMatchesSchool,
  fightingStyleExists,
  isSkillOrToolSlug,
} from './feat-option.queries';

describe('feat-option.queries', () => {
  let fightingStyleRepo: { exists: jest.Mock };
  let skillRepo: { exists: jest.Mock };
  let itemRepo: { exists: jest.Mock };
  let spellRepo: { exists: jest.Mock; findOne: jest.Mock };
  let dataSource: DataSource;

  beforeEach(() => {
    fightingStyleRepo = { exists: jest.fn() };
    skillRepo = { exists: jest.fn() };
    itemRepo = { exists: jest.fn() };
    spellRepo = { exists: jest.fn(), findOne: jest.fn() };
    dataSource = {
      getRepository: jest.fn((entity) => {
        if (entity === PhbFightingStyle) return fightingStyleRepo;
        if (entity === PhbSkill) return skillRepo;
        if (entity === PhbItem) return itemRepo;
        if (entity === VPhbSpell) return spellRepo;
        throw new Error(`Unexpected entity ${String(entity)}`);
      }),
    } as unknown as DataSource;
  });

  it('fightingStyleExists checks catalog row', async () => {
    fightingStyleRepo.exists.mockResolvedValue(true);
    await expect(fightingStyleExists(dataSource, 'defense')).resolves.toBe(true);
  });

  it('isSkillOrToolSlug accepts skill slugs', async () => {
    skillRepo.exists.mockResolvedValue(true);
    await expect(isSkillOrToolSlug(dataSource, 'stealth')).resolves.toBe(true);
    expect(itemRepo.exists).not.toHaveBeenCalled();
  });

  it('isSkillOrToolSlug falls back to tool items', async () => {
    skillRepo.exists.mockResolvedValue(false);
    itemRepo.exists.mockResolvedValue(true);
    await expect(isSkillOrToolSlug(dataSource, 'smiths-tools')).resolves.toBe(true);
  });

  it('featSpellMatchesRitualLevel requires ritual flag', async () => {
    spellRepo.exists.mockResolvedValue(true);
    await featSpellMatchesRitualLevel(dataSource, 'alarme', 1);
    expect(spellRepo.exists).toHaveBeenCalledWith({
      where: { slug: 'alarme', level: 1, ritual: true },
    });
  });

  it('featSpellMatchesSchool with fixed level', async () => {
    spellRepo.exists.mockResolvedValue(true);
    await featSpellMatchesSchool(dataSource, 'fogo-familiar', ['evocation'], 1);
    expect(spellRepo.exists).toHaveBeenCalled();
  });

  it('featSpellMatchesSchool without max level requires level >= 1', async () => {
    spellRepo.findOne.mockResolvedValue({ level: 2 });
    await expect(
      featSpellMatchesSchool(dataSource, 'sangue-boiling', ['sangromancy'], null),
    ).resolves.toBe(true);
  });

  it('featSpellMatchesExactLevel checks slug and level', async () => {
    spellRepo.exists.mockResolvedValue(true);
    await featSpellMatchesExactLevel(dataSource, 'bencao', 1);
    expect(spellRepo.exists).toHaveBeenCalledWith({
      where: { slug: 'bencao', level: 1 },
    });
  });
});
