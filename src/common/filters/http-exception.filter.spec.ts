import {
  ArgumentsHost,
  BadRequestException,
  HttpException,
  HttpStatus,
} from '@nestjs/common';
import { HttpExceptionFilter } from './http-exception.filter';

function mockHost(url = '/test'): {
  host: ArgumentsHost;
  json: jest.Mock;
  status: jest.Mock;
} {
  const json = jest.fn();
  const status = jest.fn(() => ({ json }));
  const host = {
    switchToHttp: () => ({
      getResponse: () => ({ status }),
      getRequest: () => ({ url }),
    }),
  } as unknown as ArgumentsHost;
  return { host, json, status };
}

describe('HttpExceptionFilter', () => {
  let filter: HttpExceptionFilter;

  beforeEach(() => {
    filter = new HttpExceptionFilter();
  });

  it('maps HttpException with string body', () => {
    const { host, json, status } = mockHost('/items');
    filter.catch(new BadRequestException('Invalid slug'), host);
    expect(status).toHaveBeenCalledWith(HttpStatus.BAD_REQUEST);
    expect(json).toHaveBeenCalledWith(
      expect.objectContaining({
        statusCode: HttpStatus.BAD_REQUEST,
        message: 'slug inválido(a)',
        error: 'Requisição inválida',
        path: '/items',
        timestamp: expect.any(String),
      }),
    );
  });

  it('maps HttpException with object body', () => {
    const { host, json, status } = mockHost();
    filter.catch(
      new HttpException({ message: ['a', 'b'], error: 'Validation Error' }, 422),
      host,
    );
    expect(status).toHaveBeenCalledWith(422);
    expect(json).toHaveBeenCalledWith(
      expect.objectContaining({
        statusCode: 422,
        message: ['a', 'b'],
        error: 'Erro de validação',
      }),
    );
  });

  it('returns 500 for unknown Error', () => {
    const { host, json, status } = mockHost('/boom');
    filter.catch(new Error('Unexpected'), host);
    expect(status).toHaveBeenCalledWith(HttpStatus.INTERNAL_SERVER_ERROR);
    expect(json).toHaveBeenCalledWith(
      expect.objectContaining({
        statusCode: HttpStatus.INTERNAL_SERVER_ERROR,
        message: 'Erro interno do servidor',
        error: 'Erro interno do servidor',
        path: '/boom',
      }),
    );
  });

  it('maps player_character user FK to 401', () => {
    const { host, json, status } = mockHost('/characters');
    filter.catch(
      new Error(
        'insert or update on table "player_character" violates foreign key constraint "player_character_user_id_fkey"',
      ),
      host,
    );
    expect(status).toHaveBeenCalledWith(HttpStatus.UNAUTHORIZED);
    expect(json).toHaveBeenCalledWith(
      expect.objectContaining({
        statusCode: HttpStatus.UNAUTHORIZED,
        message:
          'Sessão inválida: usuário não encontrado. Faça login novamente.',
      }),
    );
  });
});
