import { BadRequestException } from '@nestjs/common';
import type { DataSource, Repository } from 'typeorm';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import {
  applyCoinPurseToColumns,
  coinPurseFromColumns,
  debitCoinsWithExchange,
  type CoinPurse,
} from '../../domain/coin-purse';
import { EMPTY_WEALTH } from './types';

export async function debitCharacterWealth(
  dataSource: DataSource,
  characterId: string,
  debit: CoinPurse,
): Promise<void> {
  await dataSource.transaction(async (manager) => {
    const characters = manager.getRepository(PlayerCharacter);
    const character = await characters.findOne({
      where: { id: characterId },
      lock: { mode: 'pessimistic_write' },
    });
    if (!character) {
      throw new BadRequestException('Character not found');
    }
    const next = debitCoinsWithExchange(
      coinPurseFromColumns(character),
      debit,
    );
    applyCoinPurseToColumns(character, next);
    await characters.save(character);
  });
}

export async function loadCharacterWealth(
  characters: Repository<PlayerCharacter>,
  characterId: string,
): Promise<CoinPurse> {
  const row = await characters.findOne({ where: { id: characterId } });
  return row ? coinPurseFromColumns(row) : EMPTY_WEALTH;
}
