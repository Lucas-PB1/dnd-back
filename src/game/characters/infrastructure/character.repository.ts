import {
  ForbiddenException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PlayerCharacter } from './player-character.entity';

@Injectable()
export class CharacterRepository {
  constructor(
    @InjectRepository(PlayerCharacter)
    private readonly repo: Repository<PlayerCharacter>,
  ) {}

  findAllByUser(userId: string): Promise<PlayerCharacter[]> {
    return this.repo.find({
      where: { userId },
      order: { updatedAt: 'DESC' },
    });
  }

  async findOwnedOrFail(userId: string, id: string): Promise<PlayerCharacter> {
    const row = await this.repo.findOne({ where: { id } });
    if (!row) {
      throw new NotFoundException(`Character '${id}' not found`);
    }
    if (row.userId !== userId) {
      throw new ForbiddenException('You do not have access to this character');
    }
    return row;
  }

  create(data: Partial<PlayerCharacter>): PlayerCharacter {
    return this.repo.create(data);
  }

  save(entity: PlayerCharacter): Promise<PlayerCharacter> {
    return this.repo.save(entity);
  }

  async remove(entity: PlayerCharacter): Promise<void> {
    await this.repo.remove(entity);
  }
}
