import { ApiPropertyOptional } from '@nestjs/swagger';
import {
  IsArray,
  IsBoolean,
  IsIn,
  IsInt,
  IsOptional,
  IsString,
  Max,
  MaxLength,
  Min,
  MinLength,
} from 'class-validator';

/**
 * Flags de ataque/dano alinhadas a `CombatAttackCommand`.
 * Skirmish / encontro estendem e acrescentam IDs de combatente.
 */
export class CombatAttackFlagsDto {
  @ApiPropertyOptional({ enum: ['normal', 'advantage', 'disadvantage'] })
  @IsOptional()
  @IsIn(['normal', 'advantage', 'disadvantage'])
  advantage?: 'normal' | 'advantage' | 'disadvantage';

  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  @MinLength(1)
  @MaxLength(120)
  itemSlug?: string;

  @ApiPropertyOptional({ enum: ['melee', 'ranged'] })
  @IsOptional()
  @IsIn(['melee', 'ranged'])
  mode?: 'melee' | 'ranged';

  @ApiPropertyOptional({
    description: 'Ação de ataque do actor (só caminho monstro)',
  })
  @IsOptional()
  @IsString()
  actionId?: string;

  @ApiPropertyOptional()
  @IsOptional()
  @IsBoolean()
  spentInspiration?: boolean;

  @ApiPropertyOptional()
  @IsOptional()
  @IsBoolean()
  automatic?: boolean;

  @ApiPropertyOptional()
  @IsOptional()
  @IsBoolean()
  studiedAttack?: boolean;

  @ApiPropertyOptional()
  @IsOptional()
  @IsBoolean()
  doorKick?: boolean;

  @ApiPropertyOptional()
  @IsOptional()
  @IsBoolean()
  steadyAim?: boolean;

  @ApiPropertyOptional()
  @IsOptional()
  @IsBoolean()
  strokeOfLuck?: boolean;

  @ApiPropertyOptional()
  @IsOptional()
  @IsBoolean()
  assassinate?: boolean;

  @ApiPropertyOptional()
  @IsOptional()
  @IsBoolean()
  preciseHunter?: boolean;

  @ApiPropertyOptional()
  @IsOptional()
  @IsBoolean()
  brutalStrike?: boolean;

  @ApiPropertyOptional({
    enum: ['none', 'half', 'three_quarters', 'full'],
  })
  @IsOptional()
  @IsIn(['none', 'half', 'three_quarters', 'full'])
  targetCover?: 'none' | 'half' | 'three_quarters' | 'full';

  @ApiPropertyOptional()
  @IsOptional()
  @IsBoolean()
  longRange?: boolean;

  @ApiPropertyOptional()
  @IsOptional()
  @IsBoolean()
  meleeWithRanged?: boolean;

  @ApiPropertyOptional()
  @IsOptional()
  @IsBoolean()
  graze?: boolean;

  @ApiPropertyOptional()
  @IsOptional()
  @IsBoolean()
  sneakAttack?: boolean;

  @ApiPropertyOptional({ type: [String] })
  @IsOptional()
  @IsArray()
  @IsString({ each: true })
  cunningStrikeEffects?: string[];

  @ApiPropertyOptional({
    description:
      'Destruição Divina (Paladino): gasta espaço e adiciona dano Radiante',
  })
  @IsOptional()
  @IsBoolean()
  divineSmite?: boolean;

  @ApiPropertyOptional({
    minimum: 1,
    maximum: 5,
    description: 'Círculo do espaço gasto na Destruição Divina',
  })
  @IsOptional()
  @IsInt()
  @Min(1)
  @Max(5)
  smiteSlotLevel?: number;

  @ApiPropertyOptional({
    description: 'Destruição Divina vs Corruptor/Morto-vivo (+1d8)',
  })
  @IsOptional()
  @IsBoolean()
  smiteVsUndeadOrFiend?: boolean;

  @ApiPropertyOptional({
    description:
      'Punição Mística (Bruxo): gasta slot de Pacto; +1d8 Energético/círculo',
  })
  @IsOptional()
  @IsBoolean()
  eldritchSmite?: boolean;

  @ApiPropertyOptional()
  @IsOptional()
  @IsBoolean()
  huntersMark?: boolean;

  @ApiPropertyOptional()
  @IsOptional()
  @IsBoolean()
  colossusSlayer?: boolean;

  @ApiPropertyOptional()
  @IsOptional()
  @IsBoolean()
  dreadfulStrikes?: boolean;

  @ApiPropertyOptional()
  @IsOptional()
  @IsBoolean()
  dreadAmbusher?: boolean;

  @ApiPropertyOptional()
  @IsOptional()
  @IsBoolean()
  divineStrike?: boolean;

  @ApiPropertyOptional()
  @IsOptional()
  @IsBoolean()
  savageAttacker?: boolean;

  @ApiPropertyOptional()
  @IsOptional()
  @IsBoolean()
  chargerStrike?: boolean;

  @ApiPropertyOptional()
  @IsOptional()
  @IsBoolean()
  poisonousSneak?: boolean;

  @ApiPropertyOptional()
  @IsOptional()
  @IsBoolean()
  assassinSurprise?: boolean;

  @ApiPropertyOptional()
  @IsOptional()
  @IsBoolean()
  psiStrike?: boolean;

  @ApiPropertyOptional()
  @IsOptional()
  @IsBoolean()
  monsterSlayer?: boolean;

  @ApiPropertyOptional()
  @IsOptional()
  @IsBoolean()
  divineFury?: boolean;

  @ApiPropertyOptional()
  @IsOptional()
  @IsBoolean()
  quickStrike?: boolean;
}
