import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { CoinPurseDto, PatchCharacterWealthDto } from '../dto/coin-purse.dto';
import {
  applyCoinPatch,
  applyCoinPurseToColumns,
  coinPurseErrorMessage,
  coinPurseFromColumns,
} from '@game/inventory/domain/coin-purse';

@Injectable()
export class PatchCharacterWealthHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    @InjectRepository(PlayerCharacter)
    private readonly characters: Repository<PlayerCharacter>,
  ) {}

  async execute(
    userId: string,
    characterId: string,
    dto: PatchCharacterWealthDto,
  ): Promise<CoinPurseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    try {
      const next = applyCoinPatch(
        coinPurseFromColumns(character),
        dto.coins,
      );
      applyCoinPurseToColumns(character, next);
    } catch (error) {
      throw new BadRequestException(coinPurseErrorMessage(error));
    }
    await this.characters.save(character);
    return coinPurseFromColumns(character);
  }
}
