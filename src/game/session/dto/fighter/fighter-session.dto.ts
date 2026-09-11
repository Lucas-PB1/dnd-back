import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { CharacterStateResponseDto } from '../core/character-state-response.dto';

export class TableActionResponseDto {
  @ApiProperty({ type: () => CharacterStateResponseDto })
  state!: CharacterStateResponseDto;

  @ApiProperty({ example: 'Ataque Derrubador' })
  actionName!: string;

  @ApiPropertyOptional({ example: '1d8' })
  expression?: string;

  @ApiPropertyOptional({ example: 6 })
  roll?: number;

  @ApiPropertyOptional({ example: 9 })
  total?: number;

  @ApiPropertyOptional({ example: 15 })
  saveDc?: number;

  @ApiProperty({ example: true })
  resourceSpent!: boolean;

  @ApiProperty({
    example:
      'Ataque Derrubador: Dado de Superioridade = 6. CD 15, quando aplicável.',
  })
  note!: string;
}
