import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsBoolean, IsIn, IsOptional, IsString } from 'class-validator';
import type { AdvantageMode } from '../../domain/dice';

export class RollAttackDto {
  @ApiProperty({ example: 'longsword' })
  @IsString()
  itemSlug!: string;

  @ApiProperty({ enum: ['melee', 'ranged'], example: 'melee' })
  @IsIn(['melee', 'ranged'])
  mode!: 'melee' | 'ranged';

  @ApiPropertyOptional({
    enum: ['normal', 'advantage', 'disadvantage'],
    default: 'normal',
  })
  @IsOptional()
  @IsIn(['normal', 'advantage', 'disadvantage'])
  advantage?: AdvantageMode;

  @ApiPropertyOptional({
    default: false,
    description: 'Maestria Automática: forçar desvantagem (2 ataques / 2× munição)',
  })
  @IsOptional()
  @IsBoolean()
  automatic?: boolean;

  @ApiPropertyOptional({
    default: false,
    description:
      'Ataques Estudados (Guerreiro nv.13+): vantagem após errar o mesmo alvo',
  })
  @IsOptional()
  @IsBoolean()
  studiedAttack?: boolean;

  @ApiPropertyOptional({
    default: false,
    description:
      'Chute na Porta (Explorador de Masmorras): vantagem na 1ª rodada',
  })
  @IsOptional()
  @IsBoolean()
  doorKick?: boolean;

  @ApiPropertyOptional({
    default: false,
    description: 'Mira Firme (Ladino nv.3+): vantagem; deslocamento 0 neste turno',
  })
  @IsOptional()
  @IsBoolean()
  steadyAim?: boolean;

  @ApiPropertyOptional({
    default: false,
    description: 'Golpe de Sorte (Ladino nv.20): transforma o d20 em 20 e gasta o uso',
  })
  @IsOptional()
  @IsBoolean()
  strokeOfLuck?: boolean;

  @ApiPropertyOptional({
    default: false,
    description: 'Assassinar: vantagem contra criatura que ainda não agiu na primeira rodada',
  })
  @IsOptional()
  @IsBoolean()
  assassinate?: boolean;

  @ApiPropertyOptional({
    default: false,
    description:
      'Caçador Preciso (Patrulheiro nv.17): vantagem contra a criatura marcada',
  })
  @IsOptional()
  @IsBoolean()
  preciseHunter?: boolean;
}
