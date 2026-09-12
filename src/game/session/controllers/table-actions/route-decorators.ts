import { applyDecorators, HttpCode, HttpStatus, Post } from '@nestjs/common';
import { ApiOkResponse, ApiOperation } from '@nestjs/swagger';
import { TableActionResponseDto } from '../../dto/fighter/fighter-session.dto';

export function TableActionEndpoint(classSlug: string, summary: string) {
  return applyDecorators(
    Post(`:id/${classSlug}/table-action`),
    HttpCode(HttpStatus.OK),
    ApiOperation({ summary }),
    ApiOkResponse({ type: TableActionResponseDto }),
  );
}
