import { Injectable } from '@nestjs/common';
import { CharacterRepository } from '../../shared/infrastructure/character.repository';

@Injectable()
export class DeleteCharacterHandler {
  constructor(private readonly repository: CharacterRepository) {}

  async execute(userId: string, id: string): Promise<void> {
    const row = await this.repository.findOwnedOrFail(userId, id);
    await this.repository.remove(row);
  }
}
