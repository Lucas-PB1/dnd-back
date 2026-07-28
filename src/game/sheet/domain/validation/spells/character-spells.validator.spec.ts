jest.mock('./validate-spell-list-access', () => ({
  validateSpellListAccess: jest.fn().mockResolvedValue(undefined),
}));

jest.mock('./assert-spell-quotas', () => ({
  assertSpellQuotas: jest.fn().mockResolvedValue(undefined),
}));

import { DataSource, Repository } from 'typeorm';
import { VSpellByClass } from '../../../../../entities/views/v-spell-by-class.entity';
import { VPhbSubclassPreparedSpell } from '../../../../../entities/views/v-phb-subclass-prepared-spell.entity';
import { LoadGrantedSpellCatalog } from '../../../../spellcasting/application/load-granted-spell-catalog';
import { CharacterSpellsValidator } from './character-spells.validator';
import { assertSpellQuotas } from './assert-spell-quotas';
import { validateSpellListAccess } from './validate-spell-list-access';

describe('CharacterSpellsValidator', () => {
  let validator: CharacterSpellsValidator;
  let dataSource: jest.Mocked<Pick<DataSource, 'query'>>;
  let grantedSpellCatalog: jest.Mocked<Pick<LoadGrantedSpellCatalog, 'loadMergeCatalog'>>;

  const ctx = {
    level: 1,
    classSlug: 'wizard',
    speciesSlug: 'human',
    backgroundSlug: 'sage',
    subclassSlug: null,
  };

  beforeEach(() => {
    dataSource = { query: jest.fn().mockResolvedValue([]) };
    grantedSpellCatalog = {
      loadMergeCatalog: jest.fn().mockResolvedValue({
        speciesCatalog: [],
        featFixedSpells: [],
      }),
    };
    validator = new CharacterSpellsValidator(
      dataSource as unknown as DataSource,
      {} as Repository<VSpellByClass>,
      {} as Repository<VPhbSubclassPreparedSpell>,
      grantedSpellCatalog as unknown as LoadGrantedSpellCatalog,
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
    ).rejects.toThrow(/duplicate character spell entries/i);
  });

  it('loads granted catalog and delegates spell validation', async () => {
    const spells = [{ spellSlug: 'fire-bolt', listType: 'known' as const }];
    const feats = [{ featSlug: 'magic-initiate', instanceIndex: 0 }];
    const featOptions = [{ featSlug: 'magic-initiate', optionKey: 'spellList', valueId: 'wizard' }];

    await validator.validateCharacterSpells(spells, ctx, featOptions, feats);

    expect(grantedSpellCatalog.loadMergeCatalog).toHaveBeenCalledWith({
      speciesSlugs: ['human'],
      featSlugs: ['magic-initiate', 'magic-initiate'],
    });
    expect(validateSpellListAccess).toHaveBeenCalled();
    expect(assertSpellQuotas).toHaveBeenCalled();
  });

  it('loadSubclassSpellcasting delegates to query helper', async () => {
    dataSource.query.mockResolvedValue([{ spell_list_class_slug: 'wizard' }]);
    await expect(validator.loadSubclassSpellcasting('evoker')).resolves.toEqual({
      spellListClassSlug: 'wizard',
      spellcastingMode: 'prepared',
    });
  });

  it('loadSubclassSpellcasting returns null for empty slug', async () => {
    await expect(validator.loadSubclassSpellcasting(null)).resolves.toBeNull();
    expect(dataSource.query).not.toHaveBeenCalled();
  });
});
