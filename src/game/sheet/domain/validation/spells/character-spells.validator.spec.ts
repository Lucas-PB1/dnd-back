import { asDep } from '@common/testing/as-dep';
jest.mock('./validate-spell-list-access', () => ({
  validateSpellListAccess: jest.fn().mockResolvedValue(undefined),
}));

jest.mock('./assert-spell-quotas', () => ({
  assertSpellQuotas: jest.fn().mockResolvedValue(undefined),
}));

import { DataSource, Repository } from 'typeorm';
import { VSubclassSpellSlots } from '@entities/views/v-subclass-spell-slots.entity';
import { VClassSpellSlots } from '@entities/views/v-class-spell-slots.entity';
import { VSpellByClass } from '@entities/views/v-spell-by-class.entity';
import { VPhbSubclassPreparedSpell } from '@entities/views/v-phb-subclass-prepared-spell.entity';
import { LoadGrantedSpellCatalog } from '@game/spellcasting/application/load-granted-spell-catalog';
import { CharacterSpellsValidator } from './character-spells.validator';
import { assertSpellQuotas } from './assert-spell-quotas';
import { validateSpellListAccess } from './validate-spell-list-access';

describe('CharacterSpellsValidator', () => {
  let validator: CharacterSpellsValidator;
  let dataSource: { query: jest.Mock; getRepository: jest.Mock };
  let subclassSpellSlotsRepo: { findOne: jest.Mock };
  let classSpellSlotsRepo: { findOne: jest.Mock };
  let grantedSpellCatalog: jest.Mocked<Pick<LoadGrantedSpellCatalog, 'loadMergeCatalog'>>;
  let resolveSubclassOptionGrants: jest.Mocked<
    Pick<import('@game/spellcasting/application/resolve-subclass-option-granted-spells').ResolveSubclassOptionGrantedSpells, 'resolveExtraGrantedSlugs'>
  >;

  const ctx = {
    level: 1,
    classSlug: 'wizard',
    speciesSlug: 'human',
    backgroundSlug: 'sage',
    subclassSlug: null,
  };

  beforeEach(() => {
    subclassSpellSlotsRepo = { findOne: jest.fn().mockResolvedValue(null) };
    classSpellSlotsRepo = {
      findOne: jest.fn().mockResolvedValue({ spellSlots: { '1': 1 } }),
    };
    dataSource = {
      query: jest.fn().mockResolvedValue([]),
      getRepository: jest.fn((entity) => {
        if (entity === VSubclassSpellSlots) return subclassSpellSlotsRepo;
        if (entity === VClassSpellSlots) return classSpellSlotsRepo;
        throw new Error(`Unexpected entity ${String(entity)}`);
      }),
    };
    grantedSpellCatalog = {
      loadMergeCatalog: jest.fn().mockResolvedValue({
        speciesCatalog: [],
        featFixedSpells: [],
      }),
    };
    resolveSubclassOptionGrants = {
      resolveExtraGrantedSlugs: jest.fn().mockResolvedValue(new Set()),
    };
    validator = new CharacterSpellsValidator(
      dataSource as unknown as DataSource,
      {} as Repository<VSpellByClass>,
      {} as Repository<VPhbSubclassPreparedSpell>,
      grantedSpellCatalog as unknown as LoadGrantedSpellCatalog,
      asDep(resolveSubclassOptionGrants),
    );
  });

  it('rejects duplicate spell entries', async () => {
    await expect(
      validator.validateCharacterSpells(
        [
          { spellSlug: 'fire-bolt', listType: 'known' },
          { spellSlug: 'fire-bolt', listType: 'known' },
        ],
        ctx,
      ),
    ).rejects.toThrow(/mesma magia não pode aparecer mais de uma vez/i);
  });

  it('rejects the same slug as prepared and always_prepared', async () => {
    await expect(
      validator.validateCharacterSpells(
        [
          { spellSlug: 'restauracao-maior', listType: 'prepared' },
          { spellSlug: 'restauracao-maior', listType: 'always_prepared' },
        ],
        ctx,
      ),
    ).rejects.toThrow(/mesma magia não pode aparecer mais de uma vez/i);
  });

  it('loads granted catalog and delegates spell validation', async () => {
    const spells = [{ spellSlug: 'fire-bolt', listType: 'known' as const }];
    const feats = [{ featSlug: 'magic-initiate', instanceIndex: 0 }];
    const featOptions = [{ featSlug: 'magic-initiate', optionKey: 'spellList', valueId: 'wizard' }];

    await validator.validateCharacterSpells(spells, ctx, featOptions, feats);

    expect(grantedSpellCatalog.loadMergeCatalog).toHaveBeenCalledWith({
      speciesSlugs: ['human'],
      featSlugs: ['magic-initiate', 'magic-initiate'],
      classSlug: 'wizard',
    });
    expect(validateSpellListAccess).toHaveBeenCalled();
    expect(assertSpellQuotas).toHaveBeenCalled();
  });

  it('loadSubclassSpellcasting delegates to query helper', async () => {
    subclassSpellSlotsRepo.findOne.mockResolvedValue({
      spellListClassSlug: 'wizard',
    });
    await expect(validator.loadSubclassSpellcasting('evoker')).resolves.toEqual({
      spellListClassSlug: 'wizard',
      spellcastingMode: 'prepared',
    });
  });

  it('loadSubclassSpellcasting returns null for empty slug', async () => {
    await expect(validator.loadSubclassSpellcasting(null)).resolves.toBeNull();
    expect(subclassSpellSlotsRepo.findOne).not.toHaveBeenCalled();
  });
});
