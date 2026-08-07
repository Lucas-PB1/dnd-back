import { Repository } from 'typeorm';
import { PlayerCharacterState } from '../../player-character-state.entity';

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
      highElfCantripSwapAvailable: false,
      conditions: [],
      tempHp: 0,
      concentratingOn: null,
      hitDiceCurrent: level,
      deathSaveSuccesses: 0,
      deathSaveFailures: 0,
      inspiration: false,
      firearmChambers: {},
      rageActive: false,
      recklessActive: false,
      personaMasks: [],
      bestialAspectLevel: 0,
      missileShieldArmed: false,
      gigaMissileArmed: false,
    });
    await stateRepo.save(row);
  }
  if (!row.resourcesUsed) {
    row.resourcesUsed = {};
  }
  if (!row.grantedSpellUses) {
    row.grantedSpellUses = {};
  }
  if (!row.firearmChambers) {
    row.firearmChambers = {};
  }
  if (row.rageActive == null) {
    row.rageActive = false;
  }
  if (row.recklessActive == null) {
    row.recklessActive = false;
  }
  if (!row.personaMasks) {
    row.personaMasks = [];
  }
  if (row.bestialAspectLevel == null) {
    row.bestialAspectLevel = 0;
  }
  if (row.missileShieldArmed == null) {
    row.missileShieldArmed = false;
  }
  if (row.gigaMissileArmed == null) {
    row.gigaMissileArmed = false;
  }
  return row;
}
