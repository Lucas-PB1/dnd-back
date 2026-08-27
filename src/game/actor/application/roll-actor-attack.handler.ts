import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { GameActorAccessService } from '../game-actor-access.service';
import { GameActorAction } from '../infrastructure/game-actor-action.entity';
import { rollD20Check } from '@game/dice/domain/dice';
import {
  RollActorAttackDto,
  RollActorAttackResponseDto,
} from '../dto/actor.dto';

@Injectable()
export class RollActorAttackHandler {
  constructor(
    private readonly access: GameActorAccessService,
    @InjectRepository(GameActorAction)
    private readonly actions: Repository<GameActorAction>,
  ) {}

  async execute(
    userId: string,
    actorId: string,
    dto: RollActorAttackDto,
  ): Promise<RollActorAttackResponseDto> {
    await this.access.findAccessibleOrFail(userId, actorId, 'read');

    const action = await this.actions.findOne({
      where: { id: dto.actionId, actorId },
    });
    if (!action) {
      throw new BadRequestException('Action not found on this actor');
    }
    if (action.attackBonus == null) {
      throw new BadRequestException('Action has no attack bonus');
    }

    const roll = rollD20Check(action.attackBonus, dto.advantage ?? 'normal');
    return {
      expression: roll.expression,
      total: roll.total,
      modifier: roll.modifier,
      actionName: action.name,
      damageExpression: action.damageExpression,
    };
  }
}
