import { Injectable } from '@nestjs/common';
import { ActorRepository } from '../infrastructure/actor.repository';
import { ActorMapper } from '../infrastructure/actor.mapper';
import { ActorSummaryResponseDto } from '../dto/actor.dto';

@Injectable()
export class ListActorsQuery {
  constructor(
    private readonly repository: ActorRepository,
    private readonly mapper: ActorMapper,
  ) {}

  async execute(userId: string): Promise<ActorSummaryResponseDto[]> {
    const rows = await this.repository.findAllByOwner(userId);
    return rows.map((row) => this.mapper.toSummary(row));
  }
}
