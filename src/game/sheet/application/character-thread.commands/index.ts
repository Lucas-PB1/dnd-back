import {
  BadRequestException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { PhbCharacterThread } from '@entities/phb-character-thread.entity';
import { VPhbCharacterThreadBundle } from '@entities/views/v-phb-character-thread-bundle.entity';
import {
  PlayerCharacterThread,
  PlayerCharacterThreadMilestone,
} from '../../infrastructure/player-sheet.entities';
import {
  AttachCharacterThreadDto,
  CharacterThreadBundleDto,
  ReachCharacterThreadMilestoneDto,
  SetCharacterThreadGoalDto,
} from '../../dto/character-thread.dto';
import { LoadCharacterThreadBundleQuery } from '../load-character-thread-bundle.query';
import { resolveChosenBenefitKeys } from './resolve-chosen-benefit-keys';
import { resolveThreadGoal } from './resolve-thread-goal';

export { resolveChosenBenefitKeys } from './resolve-chosen-benefit-keys';

const CURSEMARKED_SLUG = 'cursemarked';

@Injectable()
export class CharacterThreadCommands {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly dataSource: DataSource,
    private readonly loadBundle: LoadCharacterThreadBundleQuery,
    @InjectRepository(PlayerCharacterThread)
    private readonly threads: Repository<PlayerCharacterThread>,
    @InjectRepository(PlayerCharacterThreadMilestone)
    private readonly milestones: Repository<PlayerCharacterThreadMilestone>,
    @InjectRepository(PhbCharacterThread)
    private readonly catalog: Repository<PhbCharacterThread>,
    @InjectRepository(VPhbCharacterThreadBundle)
    private readonly bundles: Repository<VPhbCharacterThreadBundle>,
  ) {}

  async attach(
    userId: string,
    characterId: string,
    dto: AttachCharacterThreadDto,
  ): Promise<CharacterThreadBundleDto> {
    await this.access.findAccessibleOrFail(userId, characterId, 'write');
    const catalog = await this.catalog.findOne({
      where: { slug: dto.threadSlug },
    });
    if (!catalog) {
      throw new NotFoundException(`Character thread '${dto.threadSlug}' not found`);
    }

    const active = await this.threads.findOne({
      where: { characterId, status: 'active' },
    });
    if (active) {
      throw new BadRequestException(
        'Já existe um Character Thread ativo. Complete ou abandone antes de anexar outro.',
      );
    }

    const goal = await resolveThreadGoal(
      this.bundles,
      dto.threadSlug,
      dto.goalIndex,
      dto.goalText,
    );
    const row = this.threads.create({
      characterId,
      threadSlug: dto.threadSlug,
      status: 'active',
      goalIndex: goal.goalIndex,
      goalText: goal.goalText,
      startedAt: new Date(),
      endedAt: null,
    });
    await this.threads.save(row);
    return this.loadBundle.execute(characterId);
  }

  async setGoal(
    userId: string,
    characterId: string,
    dto: SetCharacterThreadGoalDto,
  ): Promise<CharacterThreadBundleDto> {
    await this.access.findAccessibleOrFail(userId, characterId, 'write');
    const active = await this.requireActive(characterId);
    const goal = await resolveThreadGoal(
      this.bundles,
      active.threadSlug,
      dto.goalIndex === undefined ? active.goalIndex : dto.goalIndex,
      dto.goalText === undefined ? active.goalText : dto.goalText,
    );
    active.goalIndex = goal.goalIndex;
    active.goalText = goal.goalText;
    await this.threads.save(active);
    return this.loadBundle.execute(characterId);
  }

  async reachMilestone(
    userId: string,
    characterId: string,
    dto: ReachCharacterThreadMilestoneDto,
  ): Promise<CharacterThreadBundleDto> {
    await this.access.findAccessibleOrFail(userId, characterId, 'write');
    const active = await this.requireActive(characterId);
    const bundle = await this.bundles.findOne({
      where: { slug: active.threadSlug },
    });
    if (!bundle) {
      throw new NotFoundException(
        `Character thread '${active.threadSlug}' not found in catalog`,
      );
    }

    const milestone = (bundle.milestones ?? []).find((row) => row.rank === dto.rank);
    if (!milestone) {
      throw new BadRequestException(
        `Milestone '${dto.rank}' não existe neste thread`,
      );
    }

    const benefitKeys = resolveChosenBenefitKeys(
      milestone.benefits ?? [],
      dto.benefitKeys ?? [],
    );

    await this.dataSource.transaction(async (manager) => {
      const threadRepo = manager.getRepository(PlayerCharacterThreadMilestone);
      if (active.threadSlug === CURSEMARKED_SLUG && dto.rank !== 'least') {
        await threadRepo.delete({ characterThreadId: active.id });
      } else {
        await threadRepo.delete({
          characterThreadId: active.id,
          rank: dto.rank,
        });
      }
      await threadRepo.save(
        benefitKeys.map((benefitKey) =>
          threadRepo.create({
            characterThreadId: active.id,
            rank: dto.rank,
            benefitKey,
            reachedAt: new Date(),
          }),
        ),
      );
    });

    return this.loadBundle.execute(characterId);
  }

  async complete(
    userId: string,
    characterId: string,
  ): Promise<CharacterThreadBundleDto> {
    await this.access.findAccessibleOrFail(userId, characterId, 'write');
    const active = await this.requireActive(characterId);
    active.status = 'completed';
    active.endedAt = new Date();
    await this.threads.save(active);
    return this.loadBundle.execute(characterId);
  }

  async abandon(
    userId: string,
    characterId: string,
  ): Promise<CharacterThreadBundleDto> {
    await this.access.findAccessibleOrFail(userId, characterId, 'write');
    const active = await this.requireActive(characterId);
    await this.dataSource.transaction(async (manager) => {
      await manager.getRepository(PlayerCharacterThreadMilestone).delete({
        characterThreadId: active.id,
      });
      active.status = 'abandoned';
      active.endedAt = new Date();
      await manager.getRepository(PlayerCharacterThread).save(active);
    });
    return this.loadBundle.execute(characterId);
  }

  private async requireActive(
    characterId: string,
  ): Promise<PlayerCharacterThread> {
    const active = await this.threads.findOne({
      where: { characterId, status: 'active' },
    });
    if (!active) {
      throw new BadRequestException('Nenhum Character Thread ativo neste personagem');
    }
    return active;
  }
}
