import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import {
  IsBoolean,
  IsIn,
  IsInt,
  IsOptional,
  IsString,
  Min,
} from 'class-validator';
import type { AdvantageMode } from '../../domain/dice';

export class RollSkillDto {
  @ApiProperty({ example: 'athletics' })
  @IsString()
  skillSlug!: string;

  @ApiPropertyOptional({
    enum: ['normal', 'advantage', 'disadvantage'],
    default: 'normal',
  })
  @IsOptional()
  @IsIn(['normal', 'advantage', 'disadvantage'])
  advantage?: AdvantageMode;

  @ApiPropertyOptional({
    default: false,
    description: 'Golpe de Sorte (Ladino nv.20): transforma o d20 em 20 e gasta o uso',
  })
  @IsOptional()
  @IsBoolean()
  strokeOfLuck?: boolean;

  @ApiPropertyOptional({
    default: false,
    description: 'Gastar inspiração neste teste (IH: reembolsa se falhar)',
  })
  @IsOptional()
  @IsBoolean()
  spentInspiration?: boolean;

  @ApiPropertyOptional({
    example: 15,
    description: 'CD do teste (necessária para detectar falha / IH refund)',
  })
  @IsOptional()
  @IsInt()
  @Min(1)
  dc?: number;
}

export class RollSavingThrowDto {
  @ApiProperty({
    example: 'destreza',
    enum: ['forca', 'destreza', 'constituicao', 'inteligencia', 'sabedoria', 'carisma'],
  })
  @IsIn(['forca', 'destreza', 'constituicao', 'inteligencia', 'sabedoria', 'carisma'])
  abilitySlug!: string;

  @ApiPropertyOptional({
    enum: ['normal', 'advantage', 'disadvantage'],
    default: 'normal',
  })
  @IsOptional()
  @IsIn(['normal', 'advantage', 'disadvantage'])
  advantage?: AdvantageMode;

  @ApiPropertyOptional({
    default: false,
    description:
      'Indomável (Guerreiro nv.9+): rerrola salvaguarda com +nível (gasta uso)',
  })
  @IsOptional()
  @IsBoolean()
  indomitable?: boolean;

  @ApiPropertyOptional({
    default: false,
    description: 'Golpe de Sorte (Ladino nv.20): transforma o d20 em 20 e gasta o uso',
  })
  @IsOptional()
  @IsBoolean()
  strokeOfLuck?: boolean;

  @ApiPropertyOptional({
    default: false,
    description: 'Gastar inspiração nesta salvaguarda (IH: reembolsa se falhar)',
  })
  @IsOptional()
  @IsBoolean()
  spentInspiration?: boolean;

  @ApiPropertyOptional({
    example: 15,
    description: 'CD da salvaguarda (necessária para detectar falha / IH refund)',
  })
  @IsOptional()
  @IsInt()
  @Min(1)
  dc?: number;
}

export class RollInitiativeDto {
  @ApiPropertyOptional({
    enum: ['normal', 'advantage', 'disadvantage'],
    default: 'normal',
  })
  @IsOptional()
  @IsIn(['normal', 'advantage', 'disadvantage'])
  advantage?: AdvantageMode;

  @ApiPropertyOptional({
    default: false,
    description: 'Golpe de Sorte (Ladino nv.20): transforma o d20 em 20 e gasta o uso',
  })
  @IsOptional()
  @IsBoolean()
  strokeOfLuck?: boolean;

  @ApiPropertyOptional({
    default: false,
    description:
      'Pulso de Pedra (Gigante pedra): vantagem se todos estão em solo sólido',
  })
  @IsOptional()
  @IsBoolean()
  stonePulse?: boolean;

  @ApiPropertyOptional({
    default: false,
    description: 'Espada de Kas: +1d10 na rolagem de Iniciativa',
  })
  @IsOptional()
  @IsBoolean()
  kasInitiativeBoost?: boolean;
}
