import { generateKeyPairSync } from 'node:crypto';

import { UnauthorizedException } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import jwt from 'jsonwebtoken';
import { SupabaseJwtService } from './supabase-jwt.service';

const mockGetSigningKey = jest.fn();

jest.mock('jwks-rsa', () => ({
  __esModule: true,
  default: jest.fn(() => ({
    getSigningKey: (...args: unknown[]) => mockGetSigningKey(...args),
  })),
}));

describe('SupabaseJwtService', () => {
  const supabaseUrl = 'https://test-project.supabase.co';
  let publicPem: string;
  let privateKey: ReturnType<typeof generateKeyPairSync>['privateKey'];

  beforeEach(() => {
    const keys = generateKeyPairSync('ec', { namedCurve: 'P-256' });
    privateKey = keys.privateKey;
    publicPem = keys.publicKey.export({ type: 'spki', format: 'pem' }).toString();

    mockGetSigningKey.mockImplementation(
      (_kid: string, cb: (err: Error | null, key?: { getPublicKey: () => string }) => void) => {
        cb(null, { getPublicKey: () => publicPem });
      },
    );
  });

  afterEach(() => {
    mockGetSigningKey.mockReset();
  });

  function createService(config: Record<string, string | undefined>): SupabaseJwtService {
    return new SupabaseJwtService({
      get: (key: string) => config[key],
    } as ConfigService);
  }

  it('verifies ES256 access token via JWKS', async () => {
    const token = jwt.sign(
      { email: 'user@test.com' },
      privateKey,
      {
        algorithm: 'ES256',
        keyid: 'test-kid',
        audience: 'authenticated',
        issuer: `${supabaseUrl}/auth/v1`,
        subject: 'user-123',
      },
    );

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
    const service = createService({ SUPABASE_URL: supabaseUrl });
    await expect(service.verifyAccessToken('not-a-jwt')).rejects.toThrow(UnauthorizedException);
  });
});
