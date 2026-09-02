import {
  BadRequestException,
  ForbiddenException,
  NotFoundException,
} from '@nestjs/common';
import { Repository } from 'typeorm';
import { Campaign } from '../campaign.entity';
import { CampaignMember, CampaignRole } from '../campaign-member.entity';

export type CampaignMembershipDeps = {
  campaigns: Repository<Campaign>;
  members: Repository<CampaignMember>;
};

export async function requireMember(
  deps: CampaignMembershipDeps,
  campaignId: string,
  userId: string,
): Promise<CampaignMember> {
  const member = await deps.members.findOne({
    where: { campaignId, userId },
  });
  if (!member) {
    throw new ForbiddenException('You are not a member of this campaign');
  }
  return member;
}

export async function requireRole(
  deps: CampaignMembershipDeps,
  campaignId: string,
  userId: string,
  roles: readonly CampaignRole[],
): Promise<CampaignMember> {
  const member = await requireMember(deps, campaignId, userId);
  if (!roles.includes(member.role)) {
    throw new ForbiddenException(
      `Requires campaign role: ${roles.join(' or ')}`,
    );
  }
  return member;
}

export async function joinByInviteCode(
  deps: CampaignMembershipDeps,
  userId: string,
  inviteCode: string,
  role: CampaignRole = 'player',
): Promise<{ campaign: Campaign; membership: CampaignMember }> {
  if (role === 'dm') {
    throw new BadRequestException('Cannot join as dm via invite code');
  }

  const code = inviteCode.trim().toUpperCase();
  const campaign = await deps.campaigns.findOne({
    where: { inviteCode: code },
  });
  if (!campaign) {
    throw new NotFoundException('Invalid invite code');
  }

  const existing = await deps.members.findOne({
    where: { campaignId: campaign.id, userId },
  });
  if (existing) {
    return { campaign, membership: existing };
  }

  const membership = await deps.members.save(
    deps.members.create({
      campaignId: campaign.id,
      userId,
      role,
    }),
  );

  return { campaign, membership };
}

export async function listMembers(
  deps: CampaignMembershipDeps,
  campaignId: string,
): Promise<CampaignMember[]> {
  return deps.members.find({
    where: { campaignId },
    order: { joinedAt: 'ASC' },
  });
}

export async function updateMemberRole(
  deps: CampaignMembershipDeps,
  campaignId: string,
  actorUserId: string,
  targetUserId: string,
  role: CampaignRole,
): Promise<CampaignMember> {
  await requireRole(deps, campaignId, actorUserId, ['dm']);
  const member = await deps.members.findOne({
    where: { campaignId, userId: targetUserId },
  });
  if (!member) {
    throw new NotFoundException('Member not found in this campaign');
  }
  if (member.role === 'dm' && role !== 'dm') {
    const dmCount = await deps.members.count({
      where: { campaignId, role: 'dm' },
    });
    if (dmCount <= 1) {
      throw new BadRequestException('Campaign must keep at least one dm');
    }
  }
  member.role = role;
  return deps.members.save(member);
}

export async function removeMember(
  deps: CampaignMembershipDeps,
  campaignId: string,
  actorUserId: string,
  targetUserId: string,
): Promise<void> {
  const actor = await requireMember(deps, campaignId, actorUserId);
  if (actorUserId !== targetUserId && actor.role !== 'dm') {
    throw new ForbiddenException('Only dm can remove other members');
  }
  const member = await deps.members.findOne({
    where: { campaignId, userId: targetUserId },
  });
  if (!member) {
    throw new NotFoundException('Member not found in this campaign');
  }
  if (member.role === 'dm') {
    const dmCount = await deps.members.count({
      where: { campaignId, role: 'dm' },
    });
    if (dmCount <= 1) {
      throw new BadRequestException('Cannot remove the last dm');
    }
  }
  await deps.members.remove(member);
}
