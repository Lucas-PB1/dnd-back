import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import {
  ArrayMaxSize,
  IsArray,
  IsIn,
  IsInt,
  IsOptional,
  IsString,
  Max,
  MaxLength,
  Min,
  MinLength,
} from 'class-validator';

export const CHARACTER_THREAD_RANKS = [
  'least',
  'lesser',
  'greater',
  'superior',
] as const;

export type CharacterThreadRank = (typeof CHARACTER_THREAD_RANKS)[number];

export class AttachCharacterThreadDto {
  @ApiProperty({ example: 'bloodsworn' })
  @IsString()
  @MinLength(1)
  @MaxLength(80)
  threadSlug!: string;

  @ApiPropertyOptional({ example: 1, minimum: 1, maximum: 6 })
  @IsOptional()
  @IsInt()
  @Min(1)
  @Max(6)
  goalIndex?: number;

  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  @MaxLength(500)
  goalText?: string;
}

export class SetCharacterThreadGoalDto {
  @ApiPropertyOptional({ example: 1, minimum: 1, maximum: 6 })
  @IsOptional()
  @IsInt()
  @Min(1)
  @Max(6)
  goalIndex?: number | null;

  @ApiPropertyOptional({ nullable: true })
  @IsOptional()
  @IsString()
  @MaxLength(500)
  goalText?: string | null;
}

export class ReachCharacterThreadMilestoneDto {
  @ApiProperty({ enum: CHARACTER_THREAD_RANKS })
  @IsIn(CHARACTER_THREAD_RANKS)
  rank!: CharacterThreadRank;

  @ApiPropertyOptional({
    type: [String],
    description:
      'Chaves de benefício escolhidas (obrigatório quando o milestone tem choice_group)',
  })
  @IsOptional()
  @IsArray()
  @ArrayMaxSize(8)
  @IsString({ each: true })
  benefitKeys?: string[];
}

export class CharacterThreadMilestoneStateDto {
  @ApiProperty({ enum: CHARACTER_THREAD_RANKS })
  rank!: CharacterThreadRank;

  @ApiProperty()
  benefitKey!: string;

  @ApiPropertyOptional()
  benefitName!: string | null;

  @ApiPropertyOptional()
  benefitDescription!: string | null;

  @ApiProperty()
  reachedAt!: string;
}

export class CharacterThreadStateDto {
  @ApiProperty({ format: 'uuid' })
  id!: string;

  @ApiProperty({ example: 'bloodsworn' })
  threadSlug!: string;

  @ApiPropertyOptional()
  threadName!: string | null;

  @ApiProperty({ enum: ['active', 'completed', 'abandoned'] })
  status!: 'active' | 'completed' | 'abandoned';

  @ApiPropertyOptional({ nullable: true })
  goalIndex!: number | null;

  @ApiPropertyOptional({ nullable: true })
  goalText!: string | null;

  @ApiProperty()
  startedAt!: string;

  @ApiPropertyOptional({ nullable: true })
  endedAt!: string | null;

  @ApiProperty({ type: [CharacterThreadMilestoneStateDto] })
  milestones!: CharacterThreadMilestoneStateDto[];
}

export class CharacterThreadBundleDto {
  @ApiPropertyOptional({
    type: CharacterThreadStateDto,
    nullable: true,
    description: 'Thread ativo (no máximo um)',
  })
  active!: CharacterThreadStateDto | null;

  @ApiProperty({
    type: [CharacterThreadStateDto],
    description: 'Histórico (completed/abandoned), mais recentes primeiro',
  })
  history!: CharacterThreadStateDto[];
}
