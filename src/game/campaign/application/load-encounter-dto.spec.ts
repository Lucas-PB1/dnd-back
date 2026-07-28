import { LoadEncounterDto } from './load-encounter-dto';

describe('LoadEncounterDto', () => {
  it('loads combatants, enriches PCs and builds DTO', async () => {
    const campaigns = {
      findCharactersByIds: jest.fn().mockResolvedValue([
        { id: 'pc1', name: 'Hero' },
      ]),
    };
    const encounters = {
      listCombatants: jest.fn().mockResolvedValue([
        { id: 'cb1', characterId: 'pc1', kind: 'pc' },
        { id: 'cb2', characterId: null, kind: 'creature' },
      ]),
    };
    const enrichPcs = {
      enrich: jest.fn().mockResolvedValue(new Map([['pc1', { armorClass: 16 }]])),
    };
    const service = new LoadEncounterDto(
      campaigns as never,
      encounters as never,
      enrichPcs as never,
    );

    const encounter = {
      id: 'e1',
      campaignId: 'c1',
      name: 'Ambush',
      status: 'active',
      playersCanView: true,
      creatureHpVisibility: 'percent',
      round: 1,
      turnIndex: 0,
    };

    const dto = await service.load(encounter as never, 'dm');

    expect(encounters.listCombatants).toHaveBeenCalledWith('e1');
    expect(campaigns.findCharactersByIds).toHaveBeenCalledWith(['pc1']);
    expect(enrichPcs.enrich).toHaveBeenCalled();
    expect(dto).toMatchObject({
      id: 'e1',
      name: 'Ambush',
    });
    expect(Array.isArray(dto.combatants)).toBe(true);
  });
});
