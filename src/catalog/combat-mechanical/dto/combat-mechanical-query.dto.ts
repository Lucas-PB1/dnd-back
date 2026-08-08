import { ApiPropertyOptional } from '@nestjs/swagger';
import { IsOptional, IsString } from 'class-validator';

export class CombatMechanicalQueryDto {
  @ApiPropertyOptional({
    description: 'Filtra economy/panel actions da classe (mantém espécies/talentos/itens).',
    example: 'fighter',
  })
  @IsOptional()
  @IsString()
  classSlug?: string;

  @ApiPropertyOptional({
    description: 'Filtra subsets de subclasse (manobras, table actions, etc.).',
    example: 'battle-master',
  })
  @IsOptional()
  @IsString()
  subclassSlug?: string;
}
