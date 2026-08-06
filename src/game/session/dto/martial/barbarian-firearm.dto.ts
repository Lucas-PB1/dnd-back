import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsBoolean, IsInt, IsOptional, IsString, Min } from 'class-validator';

export class ToggleRageDto {
  @ApiPropertyOptional({
    example: true,
    description: 'true = entrar (gasta 1 Fúria); false = sair; omitido = alternar',
  })
  @IsOptional()
  @IsBoolean()
  active?: boolean;
}

export class ToggleRecklessDto {
  @ApiPropertyOptional({
    example: true,
    description: 'true = ativar; false = desativar; omitido = alternar',
  })
  @IsOptional()
  @IsBoolean()
  active?: boolean;
}

export class FirearmChamberDto {
  @ApiProperty({ example: 'revolver' })
  itemSlug!: string;

  @ApiProperty({ example: 4 })
  remaining!: number;

  @ApiProperty({ example: 6 })
  capacity!: number;
}

export class ReloadFirearmDto {
  @ApiProperty({ example: 'revolver' })
  @IsString()
  itemSlug!: string;
}

export class FireChamberDto {
  @ApiProperty({ example: 'revolver' })
  @IsString()
  itemSlug!: string;

  @ApiPropertyOptional({
    example: 1,
    description: 'Tiros a gastar (Automática = 2)',
  })
  @IsOptional()
  @IsInt()
  @Min(1)
  shots?: number;
}
