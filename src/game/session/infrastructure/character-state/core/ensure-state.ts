import { Repository } from 'typeorm';
import { PlayerCharacterState } from '@game/session/infrastructure/player-character-state.entity';

export async function findOrCreateCharacterState(
  stateRepo: Repository<PlayerCharacterState>,
  characterId: string,
  level = 1,
): Promise<PlayerCharacterState> {
  let row = await stateRepo.findOne({ where: { characterId } });
  if (!row) {
    row = stateRepo.create({
      characterId,
      spellSlotsUsed: {},
      resourcesUsed: {},
      grantedSpellUses: {},
      conditions: [],
      tempHp: 0,
      concentratingOn: null,
      hitDiceCurrent: level,
      deathSaveSuccesses: 0,
      deathSaveFailures: 0,
      inspiration: false,
      wildShapeActorId: null,
      boardedActorId: null,
      skinriderActorId: null,
      featureState: {},
    });
    await stateRepo.save(row);
  }
  if (!row.resourcesUsed) {
    row.resourcesUsed = {};
  }
  if (!row.grantedSpellUses) {
    row.grantedSpellUses = {};
  }
  if (!row.featureState) {
    row.featureState = {};
  }
  if (row.wildShapeActorId === undefined) {
    row.wildShapeActorId = null;
  }
  if (row.skinriderActorId === undefined) {
    row.skinriderActorId = null;
  }
  return row;
}
