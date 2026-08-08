import { ApiProperty } from '@nestjs/swagger';
import { Transform } from 'class-transformer';
import { ArrayMaxSize, ArrayMinSize, IsArray, IsString } from 'class-validator';

const MAX_FEAT_SLUGS = 40;

function parseSlugsParam(value: unknown): string[] {
  if (value == null || value === '') return [];
  const parts = Array.isArray(value)
    ? value.flatMap((entry) => String(entry).split(','))
    : String(value).split(',');
  return [...new Set(parts.map((part) => part.trim()).filter(Boolean))];
}

export class FeatsBySlugsQueryDto {
  @ApiProperty({
    description: `Comma-separated feat slugs (max ${MAX_FEAT_SLUGS})`,
    example: 'alert,magic-initiate',
  })
  @Transform(({ value }) => parseSlugsParam(value))
  @IsArray()
  @ArrayMinSize(1)
  @ArrayMaxSize(MAX_FEAT_SLUGS)
  @IsString({ each: true })
  slugs!: string[];
}

export { MAX_FEAT_SLUGS };
