import { UnauthorizedException } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { exportJWK, generateKeyPair, SignJWT } from 'jose';
import { SupabaseJwtService } from './supabase-jwt.service';

describe('SupabaseJwtService', () => {
  const supabaseUrl = 'https://test-project.supabase.co';
  let fetchMock: jest.Mock;

  beforeEach(() => {
    fetchMock = jest.fn();
    global.fetch = fetchMock;
  });

  afterEach(() => {
    jest.restoreAllMocks();
  });

  function createService(config: Record<string, string | undefined>): SupabaseJwtService {
    return new SupabaseJwtService({
      get: (key: string) => config[key],
    } as ConfigService);
  }

  it('verifies ES256 access token via JWKS', async () => {
    const { publicKey, privateKey } = await generateKeyPair('ES256', { extractable: true });
    const publicJwk = await exportJWK(publicKey);
    publicJwk.kid = 'test-kid';
    publicJwk.alg = 'ES256';
    publicJwk.use = 'sig';

    fetchMock.mockResolvedValue({
      ok: true,
      status: 200,
      json: async () => ({ keys: [publicJwk] }),
    });

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
    fetchMock.mockResolvedValue({ ok: false, status: 500 });
    const service = createService({ SUPABASE_URL: supabaseUrl });
    await expect(service.verifyAccessToken('not-a-jwt')).rejects.toThrow(UnauthorizedException);
  });
});
