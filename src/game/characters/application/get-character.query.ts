import { Injectable } from '@nestjs/common';
import { CharacterRepository } from '../infrastructure/character.repository';
import { CharacterMapper } from '../infrastructure/character.mapper';
import { CharacterResponseDto } from '../dto/character-response.dto';

@Injectable()
export class GetCharacterQuery {
  constructor(
    private readonly repository: CharacterRepository,
    private readonly mapper: CharacterMapper,
  ) {}

  async execute(userId: string, id: string): Promise<CharacterResponseDto> {
    const row = await this.repository.findOwnedOrFail(userId, id);
    return this.mapper.toDto(row);
  }
}
