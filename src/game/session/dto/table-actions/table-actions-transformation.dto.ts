import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsIn, IsNotEmpty, IsOptional, IsString } from 'class-validator';
import { ABERRANT_MUTATION_SLUGS } from '@game/session/domain/transformation/aberrant-mutation';
import { TableActionOptionsDto } from './table-action-options.dto';

export class UseTransformationTableActionDto extends TableActionOptionsDto {
  @ApiProperty({ example: 'gh-transformation-fiend/infernal-smite' })
  @IsString()
  @IsNotEmpty()
  actionSlug!: string;

  @ApiPropertyOptional({
    example: 'chitinous-shell',
    description:
      'Mutação Aberrante (obrigatório ao ativar; omitir/null encerra sem gastar uso)',
    enum: ABERRANT_MUTATION_SLUGS,
  })
  @IsOptional()
  @IsIn([...ABERRANT_MUTATION_SLUGS])
  mutationSlug?: (typeof ABERRANT_MUTATION_SLUGS)[number];
}
