const mockHttpsGet = jest.fn();

jest.mock('node:https', () => {
  const actual = jest.requireActual<typeof import('node:https')>('node:https');
  return {
    ...actual,
    get: (...args: Parameters<typeof actual.get>) => mockHttpsGet(...args),
  };
});

import { EventEmitter } from 'node:events';
import { IncomingMessage, ClientRequest } from 'node:http';
import { Readable } from 'node:stream';

import { UnauthorizedException } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { exportJWK, generateKeyPair, SignJWT } from 'jose';
import { SupabaseJwtService } from './supabase-jwt.service';

function mockJwksHttpsResponse(keys: object[]) {
  mockHttpsGet.mockImplementation(() => {
    const body = JSON.stringify({ keys });
    const response = new Readable({
      read() {
        this.push(body);
        this.push(null);
      },
    }) as IncomingMessage;
    response.statusCode = 200;

    const request = new EventEmitter() as ClientRequest;
    request.destroy = jest.fn();

    process.nextTick(() => {
      request.emit('response', response);
    });

    return request;
  });
}

describe('SupabaseJwtService', () => {
  const supabaseUrl = 'https://test-project.supabase.co';

  afterEach(() => {
    mockHttpsGet.mockReset();
  });

  function createService(config: Record<string, string | undefined>): SupabaseJwtService {
    return new SupabaseJwtService({
      get: (key: string) => config[key],
    } as ConfigService);
  }

  it('verifies ES256 access token via JWKS', async () => {
    const { publicKey, privateKey } = await generateKeyPair('ES256');
    const publicJwk = await exportJWK(publicKey);
    publicJwk.kid = 'test-kid';
    publicJwk.alg = 'ES256';
    publicJwk.use = 'sig';

    mockJwksHttpsResponse([publicJwk]);

    const token = await new SignJWT({ email: 'user@test.com' })
      .setProtectedHeader({ alg: 'ES256', kid: 'test-kid' })
      .setSubject('user-123')
      .setIssuer(`${supabaseUrl}/auth/v1`)
      .setAudience('authenticated')
      .setIssuedAt()
      .setExpirationTime('1h')
      .sign(privateKey);

    const service = createService({ SUPABASE_URL: supabaseUrl });
    const user = await service.verifyAccessToken(token);

    expect(user.id).toBe('user-123');
    expect(user.email).toBe('user@test.com');
  });

  it('throws when SUPABASE_URL is not configured', async () => {
    const service = createService({});
    await expect(service.verifyAccessToken('token')).rejects.toThrow(UnauthorizedException);
  });

  it('throws for invalid token', async () => {
    mockJwksHttpsResponse([]);
    const service = createService({ SUPABASE_URL: supabaseUrl });
    await expect(service.verifyAccessToken('not-a-jwt')).rejects.toThrow(UnauthorizedException);
  });
});
