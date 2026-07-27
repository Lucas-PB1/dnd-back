import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import {
  IsIn,
  IsOptional,
  IsString,
  IsUUID,
  MaxLength,
  MinLength,
} from 'class-validator';

export class CreateCampaignDto {
  @ApiProperty({ example: 'Ruínas de Shadowdale' })
  @IsString()
  @MinLength(1)
  @MaxLength(120)
  name!: string;

  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  @MaxLength(2000)
  description?: string;
}

export class UpdateCampaignDto {
  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  @MinLength(1)
  @MaxLength(120)
  name?: string;

  @ApiPropertyOptional({ nullable: true })
  @IsOptional()
  @IsString()
  @MaxLength(2000)
  description?: string | null;
}

export class JoinCampaignDto {
  @ApiProperty({ example: 'A3K9MQ2P' })
  @IsString()
  @MinLength(6)
  @MaxLength(16)
  inviteCode!: string;

  @ApiPropertyOptional({
    enum: ['player', 'assistant'],
    default: 'player',
  })
  @IsOptional()
  @IsIn(['player', 'assistant'])
  role?: 'player' | 'assistant';
}

export class UpdateCampaignMemberDto {
  @ApiProperty({ enum: ['dm', 'player', 'assistant'] })
  @IsIn(['dm', 'player', 'assistant'])
  role!: 'dm' | 'player' | 'assistant';
}

export class LinkCampaignCharacterDto {
  @ApiProperty({ format: 'uuid' })
  @IsUUID()
  characterId!: string;
}

export class CampaignMemberDto {
  @ApiProperty()
  userId!: string;

  @ApiProperty({ enum: ['dm', 'player', 'assistant'] })
  role!: 'dm' | 'player' | 'assistant';

  @ApiProperty()
  joinedAt!: string;
}

export class CampaignCharacterSummaryDto {
  @ApiProperty()
  characterId!: string;

  @ApiProperty()
  name!: string;

  @ApiProperty()
  level!: number;

  @ApiProperty()
  classSlug!: string;

  @ApiProperty()
  speciesSlug!: string;

  @ApiProperty()
  linkedAt!: string;
}

export class CampaignSummaryDto {
  @ApiProperty()
  id!: string;

  @ApiProperty()
  name!: string;

  @ApiPropertyOptional({ nullable: true })
  description!: string | null;

  @ApiProperty()
  inviteCode!: string;

  @ApiProperty({ enum: ['dm', 'player', 'assistant'] })
  myRole!: 'dm' | 'player' | 'assistant';

  @ApiProperty()
  createdAt!: string;

  @ApiProperty()
  updatedAt!: string;
}

export class CampaignDetailDto extends CampaignSummaryDto {
  @ApiProperty({ type: [CampaignMemberDto] })
  members!: CampaignMemberDto[];

  @ApiProperty({ type: [CampaignCharacterSummaryDto] })
  characters!: CampaignCharacterSummaryDto[];
}
