import { Controller, Get, Param, Query } from '@nestjs/common';
import {
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
  ApiParam,
  ApiTags,
} from '@nestjs/swagger';
import { LanguagesQueryDto } from './dto/languages-query.dto';
import { LanguageResponseDto } from './dto/language-response.dto';
import { FindLanguagesQuery } from './queries/find-languages.query';
import { FindLanguageBySlugQuery } from './queries/find-language-by-slug.query';

@ApiTags('catalog-reference')
@Controller('languages')
export class LanguagesController {
  constructor(
    private readonly findLanguages: FindLanguagesQuery,
    private readonly findLanguageBySlug: FindLanguageBySlugQuery,
  ) {}

  @Get()
  @ApiOperation({ summary: 'List PHB languages (paginated, searchable)' })
  @ApiOkResponse({ description: 'Paginated language list' })
  findAll(@Query() query: LanguagesQueryDto) {
    return this.findLanguages.execute(
      query.page,
      query.limit,
      query.q,
      query.rare,
    );
  }

  @Get(':slug')
  @ApiOperation({ summary: 'Get language by slug' })
  @ApiParam({ name: 'slug', example: 'common' })
  @ApiOkResponse({ type: LanguageResponseDto })
  @ApiNotFoundResponse({ description: 'Language not found' })
  findOne(@Param('slug') slug: string): Promise<LanguageResponseDto> {
    return this.findLanguageBySlug.execute(slug);
  }
}
