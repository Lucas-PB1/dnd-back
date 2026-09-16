import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import {
  IsIn,
  IsInt,
  IsOptional,
  IsString,
  IsUUID,
  Min,
  ValidateIf,
} from 'class-validator';
import { MOUNT_SHEET_ACTIONS } from '../domain/mount-sheet';

export class MountSheetActionDto {
  @ApiProperty({ enum: MOUNT_SHEET_ACTIONS, example: 'healing-touch' })
  @IsIn([...MOUNT_SHEET_ACTIONS])
  action!: (typeof MOUNT_SHEET_ACTIONS)[number];

  @ApiPropertyOptional({
    nullable: true,
    description: 'Actor da montaria (obrigatório em board; senão usa a embarcada)',
  })
  @ValidateIf((_, value) => value !== null && value !== undefined)
  @IsUUID()
  @IsOptional()
  actorId?: string | null;

  @ApiPropertyOptional({ example: 12, description: 'PV a aplicar (Toque Curativo)' })
  @IsOptional()
  @IsInt()
  @Min(1)
  amount?: number;

  @ApiPropertyOptional({ enum: ['rider', 'mount'], example: 'rider' })
  @IsOptional()
  @IsString()
  @IsIn(['rider', 'mount'])
  target?: 'rider' | 'mount';
}

export class MountSheetActionResponseDto {
  @ApiPropertyOptional({ nullable: true })
  boardedActorId!: string | null;

  @ApiProperty({ example: 'Toque Curativo' })
  actionName!: string;

  @ApiProperty()
  note!: string;

  @ApiProperty()
  resourceSpent!: boolean;

  @ApiPropertyOptional()
  healed?: number;
}
