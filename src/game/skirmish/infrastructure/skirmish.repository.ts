import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Skirmish } from './skirmish.entity';
import { SkirmishCombatant } from './skirmish-combatant.entity';
import { compareInitiativeOrder } from '@game/campaign/domain/encounter-initiative';

@Injectable()
export class SkirmishRepository {
  constructor(
    @InjectRepository(Skirmish)
    private readonly skirmishes: Repository<Skirmish>,
    @InjectRepository(SkirmishCombatant)
    private readonly combatants: Repository<SkirmishCombatant>,
  ) {}

  createSkirmish(row: Partial<Skirmish>): Skirmish {
    return this.skirmishes.create(row);
  }

  createCombatant(row: Partial<SkirmishCombatant>): SkirmishCombatant {
    return this.combatants.create(row);
  }

  saveSkirmish(row: Skirmish): Promise<Skirmish> {
    return this.skirmishes.save(row);
  }

  saveCombatants(rows: SkirmishCombatant[]): Promise<SkirmishCombatant[]> {
    return this.combatants.save(rows);
  }

  saveCombatant(row: SkirmishCombatant): Promise<SkirmishCombatant> {
    return this.combatants.save(row);
  }

  findActiveByUser(userId: string): Promise<Skirmish | null> {
    return this.skirmishes.findOne({
      where: { userId, status: 'active' },
    });
  }

  listByUser(userId: string): Promise<Skirmish[]> {
    return this.skirmishes.find({
      where: { userId },
      order: { updatedAt: 'DESC' },
    });
  }

  findOwned(userId: string, id: string): Promise<Skirmish | null> {
    return this.skirmishes.findOne({ where: { id, userId } });
  }

  async listCombatants(skirmishId: string): Promise<SkirmishCombatant[]> {
    const rows = await this.combatants.find({ where: { skirmishId } });
    return [...rows].sort((left, right) =>
      compareInitiativeOrder(
        {
          combatantId: left.id,
          initiativeTotal: left.initiativeTotal,
          initiativeModifier: left.initiativeModifier,
          displayName: left.displayName,
          isActive: left.isActive,
        },
        {
          combatantId: right.id,
          initiativeTotal: right.initiativeTotal,
          initiativeModifier: right.initiativeModifier,
          displayName: right.displayName,
          isActive: right.isActive,
        },
      ),
    );
  }

  findCombatant(
    skirmishId: string,
    combatantId: string,
  ): Promise<SkirmishCombatant | null> {
    return this.combatants.findOne({
      where: { id: combatantId, skirmishId },
    });
  }

  async deleteOwned(userId: string, id: string): Promise<boolean> {
    const row = await this.findOwned(userId, id);
    if (!row) return false;
    row.currentCombatantId = null;
    await this.saveSkirmish(row);
    await this.combatants.delete({ skirmishId: id });
    await this.skirmishes.delete({ id, userId });
    return true;
  }
}
