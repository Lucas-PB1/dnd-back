import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsString } from 'class-validator';

/** `{transformationSlug}/{boonId}` — SSOT em C078 / cap6-economy.json */
export class UseTransformationTableActionDto {
  @ApiProperty({ example: 'gh-transformation-fiend/infernal-smite' })
  @IsString()
  @IsNotEmpty()
  actionSlug!: string;
}
