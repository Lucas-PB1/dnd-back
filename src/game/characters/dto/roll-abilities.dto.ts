import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import { IsIn, IsOptional, ValidateNested } from 'class-validator';
import { AbilityScoresDto } from './character-response.dto';

export class RollAbilitiesDto {
  @ApiProperty({ enum: ['standard-array', 'roll', 'point-buy'] })
  @IsIn(['standard-array', 'roll', 'point-buy'])
  method!: 'standard-array' | 'roll' | 'point-buy';

  @ApiPropertyOptional({
    type: AbilityScoresDto,
    description: 'Obrigatório para point-buy (27 pontos, scores 8–15)',
  })
  @IsOptional()
  @ValidateNested()
  @Type(() => AbilityScoresDto)
  abilityScores?: AbilityScoresDto;
}

export class RollAbilitiesResponseDto {
  @ApiProperty({ example: 'roll' })
  method!: string;

  @ApiProperty({ type: AbilityScoresDto })
  abilityScores!: AbilityScoresDto;

  @ApiPropertyOptional({
    example: [15, 14, 13, 12, 10, 8],
    description: 'Valores brutos antes de atribuir (roll / standard-array)',
  })
  rawValues?: number[];
}
