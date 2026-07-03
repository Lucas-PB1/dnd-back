import { Injectable } from '@nestjs/common';
import { CharacterRepository } from '../../shared/infrastructure/character.repository';
import { CharacterMapper } from '../infrastructure/character.mapper';
import { CharacterResponseDto } from '../dto/character-response.dto';

@Injectable()
export class ListCharactersQuery {
  constructor(
    private readonly repository: CharacterRepository,
    private readonly mapper: CharacterMapper,
  ) {}

  async execute(userId: string): Promise<CharacterResponseDto[]> {
    const rows = await this.repository.findAllByUser(userId);
    return this.mapper.toDtoList(rows);
  }
}
