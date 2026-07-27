import {
  Body,
  Controller,
  Delete,
  Get,
  HttpCode,
  HttpStatus,
  Param,
  ParseUUIDPipe,
  Patch,
  Post,
  UseGuards,
} from '@nestjs/common';
import {
  ApiBearerAuth,
  ApiCreatedResponse,
  ApiNoContentResponse,
  ApiOkResponse,
  ApiOperation,
  ApiTags,
  ApiUnauthorizedResponse,
} from '@nestjs/swagger';
import { SupabaseAuthGuard } from '../../identity/guards/supabase-auth.guard';
import { CurrentUser } from '../../identity/decorators/current-user.decorator';
import { AuthUser } from '../../identity/auth-user';
import { CampaignService } from './application/campaign.service';
import {
  CampaignCharacterSummaryDto,
  CampaignDetailDto,
  CampaignMemberDto,
  CampaignSummaryDto,
  CreateCampaignDto,
  JoinCampaignDto,
  LinkCampaignCharacterDto,
  UpdateCampaignDto,
  UpdateCampaignMemberDto,
} from './dto/campaign.dto';

@ApiTags('game-campaigns')
@ApiBearerAuth()
@ApiUnauthorizedResponse({ description: 'Missing or invalid Bearer token' })
@UseGuards(SupabaseAuthGuard)
@Controller('campaigns')
export class CampaignsController {
  constructor(private readonly campaigns: CampaignService) {}

  @Get()
  @ApiOperation({ summary: 'List campaigns for the authenticated user' })
  @ApiOkResponse({ type: [CampaignSummaryDto] })
  list(@CurrentUser() user: AuthUser): Promise<CampaignSummaryDto[]> {
    return this.campaigns.list(user.id);
  }

  @Post()
  @ApiOperation({ summary: 'Create a campaign (caller becomes dm)' })
  @ApiCreatedResponse({ type: CampaignSummaryDto })
  create(
    @CurrentUser() user: AuthUser,
    @Body() dto: CreateCampaignDto,
  ): Promise<CampaignSummaryDto> {
    return this.campaigns.create(user.id, dto);
  }

  @Post('join')
  @ApiOperation({ summary: 'Join a campaign by invite code' })
  @ApiOkResponse({ type: CampaignSummaryDto })
  join(
    @CurrentUser() user: AuthUser,
    @Body() dto: JoinCampaignDto,
  ): Promise<CampaignSummaryDto> {
    return this.campaigns.join(user.id, dto);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get campaign detail (members + characters)' })
  @ApiOkResponse({ type: CampaignDetailDto })
  getOne(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<CampaignDetailDto> {
    return this.campaigns.getDetail(user.id, id);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update campaign (dm only)' })
  @ApiOkResponse({ type: CampaignSummaryDto })
  update(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UpdateCampaignDto,
  ): Promise<CampaignSummaryDto> {
    return this.campaigns.update(user.id, id, dto);
  }

  @Delete(':id')
  @HttpCode(HttpStatus.NO_CONTENT)
  @ApiOperation({ summary: 'Delete campaign (dm only)' })
  @ApiNoContentResponse()
  async remove(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<void> {
    await this.campaigns.remove(user.id, id);
  }

  @Patch(':id/members/:userId')
  @ApiOperation({ summary: 'Change member role (dm only)' })
  @ApiOkResponse({ type: CampaignMemberDto })
  updateMember(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Param('userId', ParseUUIDPipe) targetUserId: string,
    @Body() dto: UpdateCampaignMemberDto,
  ) {
    return this.campaigns.updateMemberRole(user.id, id, targetUserId, dto);
  }

  @Delete(':id/members/:userId')
  @HttpCode(HttpStatus.NO_CONTENT)
  @ApiOperation({ summary: 'Remove member or leave campaign' })
  @ApiNoContentResponse()
  async removeMember(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Param('userId', ParseUUIDPipe) targetUserId: string,
  ): Promise<void> {
    await this.campaigns.removeMember(user.id, id, targetUserId);
  }

  @Post(':id/characters')
  @ApiOperation({ summary: 'Link own character to campaign' })
  @ApiCreatedResponse({ type: CampaignCharacterSummaryDto })
  linkCharacter(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: LinkCampaignCharacterDto,
  ) {
    return this.campaigns.linkCharacter(user.id, id, dto);
  }

  @Delete(':id/characters/:characterId')
  @HttpCode(HttpStatus.NO_CONTENT)
  @ApiOperation({ summary: 'Unlink character from campaign' })
  @ApiNoContentResponse()
  async unlinkCharacter(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
    @Param('characterId', ParseUUIDPipe) characterId: string,
  ): Promise<void> {
    await this.campaigns.unlinkCharacter(user.id, id, characterId);
  }

  @Post(':id/invite-code/rotate')
  @ApiOperation({ summary: 'Rotate invite code (dm only)' })
  @ApiOkResponse({ type: CampaignSummaryDto })
  rotateInvite(
    @CurrentUser() user: AuthUser,
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<CampaignSummaryDto> {
    return this.campaigns.rotateInvite(user.id, id);
  }
}
