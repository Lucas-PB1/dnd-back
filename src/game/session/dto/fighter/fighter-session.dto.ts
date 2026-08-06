import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsBoolean, IsIn, IsInt, IsOptional, IsString, Min } from 'class-validator';
import { CharacterStateResponseDto } from '../core/character-state-response.dto';

export class SecondWindResponseDto {
  @ApiProperty({ type: () => CharacterStateResponseDto })
  state!: CharacterStateResponseDto;

  @ApiProperty({ example: '1d10+5' })
  expression!: string;

  @ApiProperty({ example: 12 })
  healAmount!: number;

  @ApiProperty({ example: 8 })
  hitPointsCurrent!: number;

  @ApiPropertyOptional({
    example: 'Ajuste Tático: mova-se até metade do Deslocamento sem provocar AO',
  })
  note?: string;
}

export class TacticalMindDto {
  /** Opcional: se enviados check+CD, só gasta Fôlego se virar sucesso. */
  @ApiPropertyOptional({
    example: 14,
    description:
      'Total atual do teste (opcional). Sem check/CD, gasta 1 uso e só rola o +1d10.',
  })
  @IsOptional()
  @IsInt()
  @Min(1)
  checkTotal?: number;

  @ApiPropertyOptional({
    example: 15,
    description: 'CD do teste (opcional; exige checkTotal).',
  })
  @IsOptional()
  @IsInt()
  @Min(1)
  dc?: number;
}

export class TacticalMindResponseDto {
  @ApiProperty({ type: () => CharacterStateResponseDto })
  state!: CharacterStateResponseDto;

  @ApiProperty({ example: '1d10' })
  expression!: string;

  @ApiProperty({ example: 7 })
  roll!: number;

  @ApiPropertyOptional({
    example: 21,
    description: 'Total com bônus; só quando checkTotal foi informado',
  })
  newTotal?: number;

  @ApiPropertyOptional({
    example: true,
    description: 'Sucesso vs CD; só quando check+CD foram informados',
  })
  success?: boolean;

  @ApiProperty({ example: true })
  resourceSpent!: boolean;

  @ApiProperty({ example: 'Mente Tática: +7 (1d10). Some ao teste.' })
  note!: string;
}

export class ActionSurgeResponseDto {
  @ApiProperty({ type: () => CharacterStateResponseDto })
  state!: CharacterStateResponseDto;

  @ApiProperty({
    example: 'Surto de Ação: execute uma ação adicional (exceto Usar Magia)',
  })
  note!: string;
}

export class UseBattleMasterManeuverDto {
  @ApiProperty({ example: 'trip-attack' })
  @IsString()
  maneuverSlug!: string;

  @ApiPropertyOptional({
    example: false,
    description:
      'Implacável (nível 15+): usa 1d8 sem gastar Superioridade; controle de 1×/turno fica na mesa',
  })
  @IsOptional()
  @IsBoolean()
  useRelentless?: boolean;
}

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

/** @deprecated Use TableActionResponseDto — alias de compatibilidade. */
export class FighterTableActionResponseDto extends TableActionResponseDto {}

export class UsePsiWarriorActionDto {
  @ApiProperty({
    enum: [
      'protective-field',
      'telekinetic-movement',
      'psychic-leap',
      'mental-guard',
      'energy-bulwark',
      'telekinetic-master',
    ],
    example: 'protective-field',
  })
  @IsIn([
    'protective-field',
    'telekinetic-movement',
    'psychic-leap',
    'mental-guard',
    'energy-bulwark',
    'telekinetic-master',
  ])
  actionSlug!:
    | 'protective-field'
    | 'telekinetic-movement'
    | 'psychic-leap'
    | 'mental-guard'
    | 'energy-bulwark'
    | 'telekinetic-master';

  @ApiPropertyOptional({
    example: false,
    description:
      'Gasta Energia Psiônica em vez do uso gratuito da característica',
  })
  @IsOptional()
  @IsBoolean()
  usePsiDie?: boolean;
}

export class UseDungeonPrecautionDto {
  @ApiProperty({ example: 'detectar-magia' })
  @IsString()
  spellSlug!: string;
}
