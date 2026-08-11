import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import {
  IsBoolean,
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

  @ApiPropertyOptional({
    description:
      'Se true, players podem marcar “Não pagar” ao adicionar item no inventário',
  })
  @IsOptional()
  @IsBoolean()
  allowPlayerSkipPayment?: boolean;
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

  @ApiProperty({ nullable: true, required: false })
  displayName!: string | null;

  @ApiProperty({ nullable: true, required: false })
  email!: string | null;

  @ApiProperty({ nullable: true, required: false })
  avatarUrl!: string | null;

  @ApiProperty({ nullable: true, required: false })
  bio!: string | null;

  @ApiProperty({ type: [String], required: false })
  characterNames!: string[];
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

  @ApiProperty({
    description:
      'Se true, players podem marcar “Não pagar” ao adicionar item no inventário',
  })
  allowPlayerSkipPayment!: boolean;

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
