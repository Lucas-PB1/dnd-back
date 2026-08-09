import { NotFoundException } from '@nestjs/common';
import { In, Repository } from 'typeorm';
import { generateCampaignInviteCode } from '@game/campaign/domain/invite-code';
import { Campaign } from '../campaign.entity';
import { CampaignMember, CampaignRole } from '../campaign-member.entity';
import {
  CampaignMembershipDeps,
  requireRole,
} from './campaign-membership';

export type CampaignCrudDeps = CampaignMembershipDeps & {
  campaigns: Repository<Campaign>;
  members: Repository<CampaignMember>;
};

async function allocateUniqueInviteCode(
  campaigns: Repository<Campaign>,
): Promise<string> {
  let inviteCode = generateCampaignInviteCode();
  for (let attempt = 0; attempt < 5; attempt += 1) {
    const exists = await campaigns.exist({ where: { inviteCode } });
    if (!exists) break;
    inviteCode = generateCampaignInviteCode();
  }
  return inviteCode;
}

export async function createCampaign(
  deps: CampaignCrudDeps,
  input: {
    userId: string;
    name: string;
    description?: string | null;
  },
): Promise<{ campaign: Campaign; membership: CampaignMember }> {
  const inviteCode = await allocateUniqueInviteCode(deps.campaigns);

  const campaign = await deps.campaigns.save(
    deps.campaigns.create({
      name: input.name.trim(),
      description: input.description?.trim() || null,
      inviteCode,
      createdBy: input.userId,
    }),
  );

  const membership = await deps.members.save(
    deps.members.create({
      campaignId: campaign.id,
      userId: input.userId,
      role: 'dm',
    }),
  );

  return { campaign, membership };
}

export async function listForUser(
  deps: CampaignCrudDeps,
  userId: string,
): Promise<Array<{ campaign: Campaign; role: CampaignRole }>> {
  const memberships = await deps.members.find({ where: { userId } });
  if (memberships.length === 0) return [];

  const campaigns = await deps.campaigns.find({
    where: { id: In(memberships.map((m) => m.campaignId)) },
    order: { updatedAt: 'DESC' },
  });

  const roleByCampaign = new Map(
    memberships.map((m) => [m.campaignId, m.role] as const),
  );

  return campaigns.map((campaign) => ({
    campaign,
    role: roleByCampaign.get(campaign.id)!,
  }));
}

export async function findCampaignOrFail(
  deps: CampaignCrudDeps,
  id: string,
): Promise<Campaign> {
  const row = await deps.campaigns.findOne({ where: { id } });
  if (!row) throw new NotFoundException(`Campaign '${id}' not found`);
  return row;
}

export async function updateCampaign(
  deps: CampaignCrudDeps,
  campaignId: string,
  userId: string,
  patch: { name?: string; description?: string | null },
): Promise<Campaign> {
  await requireRole(deps, campaignId, userId, ['dm']);
  const campaign = await findCampaignOrFail(deps, campaignId);
  if (patch.name !== undefined) campaign.name = patch.name.trim();
  if (patch.description !== undefined) {
    campaign.description = patch.description?.trim() || null;
  }
  return deps.campaigns.save(campaign);
}

export async function deleteCampaign(
  deps: CampaignCrudDeps,
  campaignId: string,
  userId: string,
): Promise<void> {
  await requireRole(deps, campaignId, userId, ['dm']);
  const campaign = await findCampaignOrFail(deps, campaignId);
  await deps.campaigns.remove(campaign);
}

export async function rotateInviteCode(
  deps: CampaignCrudDeps,
  campaignId: string,
  userId: string,
): Promise<Campaign> {
  await requireRole(deps, campaignId, userId, ['dm']);
  const campaign = await findCampaignOrFail(deps, campaignId);
  campaign.inviteCode = await allocateUniqueInviteCode(deps.campaigns);
  return deps.campaigns.save(campaign);
}
