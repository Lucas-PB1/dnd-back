import { Controller, Get, Param, Query } from '@nestjs/common';
import {
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
  ApiParam,
  ApiTags,
} from '@nestjs/swagger';
import { CharacterThreadsQueryDto } from './dto/character-threads-query.dto';
import { CharacterThreadResponseDto } from './dto/character-thread-response.dto';
import {
  FindCharacterThreadBySlugQuery,
  FindCharacterThreadsQuery,
} from './queries/find-character-threads.query';

@ApiTags('catalog-character-threads')
@Controller('character-threads')
export class CharacterThreadsController {
  constructor(
    private readonly findThreads: FindCharacterThreadsQuery,
    private readonly findBySlug: FindCharacterThreadBySlugQuery,
  ) {}

  @Get()
  @ApiOperation({ summary: 'List character threads (paginated, searchable)' })
  @ApiOkResponse({ description: 'Paginated character threads' })
  findAll(@Query() query: CharacterThreadsQueryDto) {
    return this.findThreads.execute(
      query.cursor,
      query.limit,
      query.q,
      query.editionSlugs,
      query.fields,
    );
  }

  @Get(':slug')
  @ApiOperation({ summary: 'Get character thread bundle by slug' })
  @ApiParam({ name: 'slug', example: 'bloodsworn' })
  @ApiOkResponse({ type: CharacterThreadResponseDto })
  @ApiNotFoundResponse()
  findOne(@Param('slug') slug: string): Promise<CharacterThreadResponseDto> {
    return this.findBySlug.execute(slug);
  }
}
