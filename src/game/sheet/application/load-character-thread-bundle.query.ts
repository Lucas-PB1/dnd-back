import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { In, Repository } from 'typeorm';
import { PhbCharacterThread } from '@entities/phb-character-thread.entity';
import { VPhbCharacterThreadBundle } from '@entities/views/v-phb-character-thread-bundle.entity';
import {
  PlayerCharacterThread,
  PlayerCharacterThreadMilestone,
} from '../infrastructure/player-sheet.entities';
import {
  CharacterThreadBundleDto,
  CharacterThreadMilestoneStateDto,
  CharacterThreadStateDto,
} from '../dto/character-thread.dto';

@Injectable()
export class LoadCharacterThreadBundleQuery {
  constructor(
    @InjectRepository(PlayerCharacterThread)
    private readonly threads: Repository<PlayerCharacterThread>,
    @InjectRepository(PlayerCharacterThreadMilestone)
    private readonly milestones: Repository<PlayerCharacterThreadMilestone>,
    @InjectRepository(PhbCharacterThread)
    private readonly catalog: Repository<PhbCharacterThread>,
    @InjectRepository(VPhbCharacterThreadBundle)
    private readonly bundles: Repository<VPhbCharacterThreadBundle>,
  ) {}

  async execute(characterId: string): Promise<CharacterThreadBundleDto> {
    const rows = await this.threads.find({
      where: { characterId },
      order: { startedAt: 'DESC' },
    });
    if (rows.length === 0) {
      return { active: null, history: [] };
    }

    const threadIds = rows.map((row) => row.id);
    const milestoneRows = await this.milestones.find({
      where: { characterThreadId: In(threadIds) },
      order: { reachedAt: 'ASC' },
    });

    const catalogSlugs = [...new Set(rows.map((row) => row.threadSlug))];
    const [catalogRows, bundleRows] = await Promise.all([
      this.catalog.find({ where: { slug: In(catalogSlugs) } }),
      this.bundles.find({ where: { slug: In(catalogSlugs) } }),
    ]);
    const nameBySlug = new Map(catalogRows.map((row) => [row.slug, row.name]));
    const benefitMeta = new Map<string, { name: string; description: string }>();
    for (const bundle of bundleRows) {
      for (const milestone of bundle.milestones ?? []) {
        for (const benefit of milestone.benefits ?? []) {
          benefitMeta.set(
            `${bundle.slug}:${milestone.rank}:${benefit.benefitKey}`,
            {
              name: benefit.name,
              description: benefit.description,
            },
          );
        }
      }
    }

    const milestonesByThread = new Map<string, CharacterThreadMilestoneStateDto[]>();
    for (const row of milestoneRows) {
      const parent = rows.find((thread) => thread.id === row.characterThreadId);
      const meta = parent
        ? benefitMeta.get(`${parent.threadSlug}:${row.rank}:${row.benefitKey}`)
        : undefined;
      const list = milestonesByThread.get(row.characterThreadId) ?? [];
      list.push({
        rank: row.rank,
        benefitKey: row.benefitKey,
        benefitName: meta?.name ?? null,
        benefitDescription: meta?.description ?? null,
        reachedAt: row.reachedAt.toISOString(),
      });
      milestonesByThread.set(row.characterThreadId, list);
    }

    const mapped = rows.map((row) => this.toStateDto(row, nameBySlug, milestonesByThread));
    return {
      active: mapped.find((row) => row.status === 'active') ?? null,
      history: mapped.filter((row) => row.status !== 'active'),
    };
  }

  private toStateDto(
    row: PlayerCharacterThread,
    nameBySlug: Map<string, string>,
    milestonesByThread: Map<string, CharacterThreadMilestoneStateDto[]>,
  ): CharacterThreadStateDto {
    return {
      id: row.id,
      threadSlug: row.threadSlug,
      threadName: nameBySlug.get(row.threadSlug) ?? null,
      status: row.status,
      goalIndex: row.goalIndex,
      goalText: row.goalText,
      startedAt: row.startedAt.toISOString(),
      endedAt: row.endedAt?.toISOString() ?? null,
      milestones: milestonesByThread.get(row.id) ?? [],
    };
  }
}
