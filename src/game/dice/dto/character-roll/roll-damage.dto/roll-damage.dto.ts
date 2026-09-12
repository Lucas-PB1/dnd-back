import { ApiPropertyOptional } from '@nestjs/swagger';
import { IsBoolean, IsInt, IsOptional, Max, Min } from 'class-validator';
import { RollDamageBaseDto } from './base.dto';

export class RollDamageDto extends RollDamageBaseDto {
  @ApiPropertyOptional({
    default: false,
    description: 'Golpe Venenoso (Perseguidor Aracnídeo): Ataque Furtivo usa d8 Venenoso',
  })
  @IsOptional()
  @IsBoolean()
  poisonousSneak?: boolean;

  @ApiPropertyOptional({
    default: false,
    description: 'Golpe Surpreendente (Assassino): soma o nível de Ladino na primeira rodada',
  })
  @IsOptional()
  @IsBoolean()
  assassinSurprise?: boolean;

  @ApiPropertyOptional({
    default: false,
    description: 'Golpe Mortal (Assassino nv.17): dobra o dano quando o alvo falha na salvaguarda',
  })
  @IsOptional()
  @IsBoolean()
  assassinDeathStrike?: boolean;

  @ApiPropertyOptional({
    default: false,
    description: 'Armas Venenosas (Assassino nv.13): +2d6 quando Envenenar falha',
  })
  @IsOptional()
  @IsBoolean()
  assassinPoisonFailedSave?: boolean;

  @ApiPropertyOptional({
    default: false,
    description:
      'Destruição Divina (Paladino): gasta um espaço de magia e adiciona dano Radiante',
  })
  @IsOptional()
  @IsBoolean()
  divineSmite?: boolean;

  @ApiPropertyOptional({
    minimum: 1,
    maximum: 5,
    description: 'Círculo do espaço de magia gasto na Destruição Divina',
  })
  @IsOptional()
  @IsInt()
  @Min(1)
  @Max(5)
  smiteSlotLevel?: number;

  @ApiPropertyOptional({
    default: false,
    description: 'Destruição Divina contra Corruptor ou Morto-vivo: +1d8',
  })
  @IsOptional()
  @IsBoolean()
  smiteVsUndeadOrFiend?: boolean;

  @ApiPropertyOptional({
    default: false,
    description:
      'Marca do Predador (Patrulheiro): adiciona o dado da marca (1d6 ou 1d10 no nv.20)',
  })
  @IsOptional()
  @IsBoolean()
  huntersMark?: boolean;

  @ApiPropertyOptional({
    default: false,
    description:
      'Assassino de Colossos (Caçador): +1d8 1×/turno contra alvo abaixo do máximo de PV',
  })
  @IsOptional()
  @IsBoolean()
  colossusSlayer?: boolean;

  @ApiPropertyOptional({
    default: false,
    description:
      'Golpes Terríveis (Andarilho Feérico): +1d4/+1d6 Psíquico 1×/turno',
  })
  @IsOptional()
  @IsBoolean()
  dreadfulStrikes?: boolean;

  @ApiPropertyOptional({
    default: false,
    description:
      'Golpe Terrível (Vigilante das Sombras): +2d6/+2d8 Psíquico; gasta 1 uso',
  })
  @IsOptional()
  @IsBoolean()
  dreadAmbusher?: boolean;

  @ApiPropertyOptional({
    default: false,
    description:
      'Golpe Divino (Clérigo nv.7+): +1d8/+2d8 Necrótico ou Radiante com arma',
  })
  @IsOptional()
  @IsBoolean()
  divineStrike?: boolean;
}
