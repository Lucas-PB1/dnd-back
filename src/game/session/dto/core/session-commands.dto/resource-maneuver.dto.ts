import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsInt, IsOptional, IsString, Min } from 'class-validator';
import { CharacterStateResponseDto } from '../character-state-response.dto';

export class UseClassResourceDto {
  @ApiProperty({ example: 'rage' })
  @IsString()
  resourceSlug!: string;

  @ApiPropertyOptional({ example: 1, description: 'Usos a gastar (padrão 1)' })
  @IsOptional()
  @IsInt()
  @Min(1)
  amount?: number;
}

export class ResourceDieRollDto {
  @ApiProperty({ example: 'risk' })
  resourceSlug!: string;

  @ApiProperty({ example: 8 })
  faces!: number;

  @ApiProperty({ example: 5 })
  value!: number;

  @ApiProperty({ example: '1d8' })
  expression!: string;
}

export class UseClassResourceResponseDto {
  @ApiProperty({ type: CharacterStateResponseDto })
  state!: CharacterStateResponseDto;

  @ApiPropertyOptional({ type: ResourceDieRollDto })
  roll?: ResourceDieRollDto | null;

  @ApiPropertyOptional({
    example:
      'Mudar Aspecto — Força Bestial: 6 PV temp. (2× PB) aplicados.',
  })
  note?: string | null;
}

export class UseManeuverDto {
  @ApiProperty({ example: 'bite-the-bullet' })
  @IsString()
  maneuverSlug!: string;
}

export class UseManeuverResponseDto {
  @ApiProperty({ type: CharacterStateResponseDto })
  state!: CharacterStateResponseDto;

  @ApiProperty({ example: 'bite-the-bullet' })
  maneuverSlug!: string;

  @ApiProperty({ example: 'Morda a Bala' })
  maneuverName!: string;

  @ApiProperty({ example: 'temp_hp' })
  effectKind!: string;

  @ApiProperty({ type: ResourceDieRollDto })
  riskRoll!: ResourceDieRollDto;

  @ApiPropertyOptional({ example: 12 })
  tempHpGained?: number;

  @ApiPropertyOptional({ example: 7 })
  missDamage?: number;

  @ApiPropertyOptional({ example: 4 })
  acBonus?: number;

  @ApiPropertyOptional({ example: 3 })
  checkBonus?: number;

  @ApiProperty({ example: '+12 PV Temporários' })
  note!: string;
}
