import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import {
  IsArray,
  IsBoolean,
  IsIn,
  IsOptional,
  IsString,
} from 'class-validator';

const CUNNING_STRIKE_EFFECTS = [
  'poison',
  'withdraw',
  'trip',
  'hidden-attack',
  'daze',
  'knock-out',
  'obscure',
  'paralyze',
] as const;

export class RollDamageBaseDto {
  @ApiProperty({ example: 'longsword' })
  @IsString()
  itemSlug!: string;

  @ApiProperty({ enum: ['melee', 'ranged'], example: 'melee' })
  @IsIn(['melee', 'ranged'])
  mode!: 'melee' | 'ranged';

  @ApiPropertyOptional({ default: false })
  @IsOptional()
  @IsBoolean()
  critical?: boolean;

  @ApiPropertyOptional({
    default: false,
    description: 'Dano de Resvalar (Graze) no erro — só modificador de atributo',
  })
  @IsOptional()
  @IsBoolean()
  grazeMiss?: boolean;

  @ApiPropertyOptional({
    default: false,
    description: 'Tiro na cabeça (Pistoleiro nv.20, no crítico): +10d10 ou morte se <100 PV',
  })
  @IsOptional()
  @IsBoolean()
  headShot?: boolean;

  @ApiPropertyOptional({
    default: false,
    description: 'Maestria Mira: rerrolar um dado de dano',
  })
  @IsOptional()
  @IsBoolean()
  sightedReroll?: boolean;

  @ApiPropertyOptional({
    default: false,
    description: 'Golpe Brutal (Bárbaro nv.9+): dados extras; abre mão da vantagem do Imprudente',
  })
  @IsOptional()
  @IsBoolean()
  brutalStrike?: boolean;

  @ApiPropertyOptional({
    default: false,
    description:
      'Golpe Rápido (Determinação do Sindicato): +1d4/2d4/4d4 no 1º dano após Iniciativa',
  })
  @IsOptional()
  @IsBoolean()
  quickStrike?: boolean;

  @ApiPropertyOptional({
    default: false,
    description: 'Fúria Divina (Fanático): 1d6 + metade do nível enquanto enfurecido',
  })
  @IsOptional()
  @IsBoolean()
  divineFury?: boolean;

  @ApiPropertyOptional({
    default: false,
    description:
      'Golpe Psiônico (Combatente Psíquico): gasta 1 Dado de Energia + INT',
  })
  @IsOptional()
  @IsBoolean()
  psiStrike?: boolean;

  @ApiPropertyOptional({
    default: false,
    description:
      'Matar Monstro (Explorador de Masmorras): +1d10 vs tipos elegíveis',
  })
  @IsOptional()
  @IsBoolean()
  monsterSlayer?: boolean;

  @ApiPropertyOptional({
    default: false,
    description: 'Ataque Furtivo (Ladino): adiciona os dados permitidos pelo nível',
  })
  @IsOptional()
  @IsBoolean()
  sneakAttack?: boolean;

  @ApiPropertyOptional({
    type: [String],
    enum: [...CUNNING_STRIKE_EFFECTS],
    description: 'Efeitos de Golpe Astuto; o custo é removido dos dados de Ataque Furtivo',
  })
  @IsOptional()
  @IsArray()
  @IsIn([...CUNNING_STRIKE_EFFECTS], { each: true })
  cunningStrikeEffects?: string[];

  @ApiPropertyOptional({
    default: false,
    description:
      'Atacante Selvagem: rola o dano da arma duas vezes; API devolve ambas (escolha no cliente)',
  })
  @IsOptional()
  @IsBoolean()
  savageAttacker?: boolean;

  @ApiPropertyOptional({
    default: false,
    description:
      'Charger: +1d8 no dano (toggle auto-off); requer talento charger',
  })
  @IsOptional()
  @IsBoolean()
  chargerStrike?: boolean;

  @ApiPropertyOptional({
    default: false,
    description:
      'Elemental Adept / damage_die_floor: faces 1 viram 2 nos dados de dano',
  })
  @IsOptional()
  @IsBoolean()
  damageDieFloor?: boolean;

  @ApiPropertyOptional({
    default: false,
    description:
      'Marksman luck / damage_die_flip: virar o menor dado (lados > 4)',
  })
  @IsOptional()
  @IsBoolean()
  damageDieFlip?: boolean;

  @ApiPropertyOptional({
    default: false,
    description:
      'Pyromaniac / damage_die_explode: face máxima gera um dado extra',
  })
  @IsOptional()
  @IsBoolean()
  damageDieExplode?: boolean;
}
