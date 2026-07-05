import { createPublicKey, type JsonWebKey } from 'node:crypto';

import { Injectable, UnauthorizedException } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import jwt from 'jsonwebtoken';
import { AuthUser } from './auth-user';

type JsonWebKeyWithKid = Record<string, unknown> & { kid?: string };

type JwtPayload = jwt.JwtPayload & {
  email?: string;
};

@Injectable()
export class SupabaseJwtService {
  private static readonly JWKS_CACHE_MS = 600_000;

  private readonly jwksCache = new Map<
    string,
    { keys: JsonWebKeyWithKid[]; fetchedAt: number }
  >();

  constructor(private readonly config: ConfigService) {}

  async verifyAccessToken(token: string): Promise<AuthUser> {
    const supabaseUrl = this.normalizeSupabaseUrl(
      this.config.get<string>('SUPABASE_URL'),
    );
    if (!supabaseUrl) {
      throw new UnauthorizedException('SUPABASE_URL is not configured');
    }

    try {
      const decoded = jwt.decode(token, { complete: true });
      const kid = decoded?.header.kid;
      if (!kid) {
        throw new Error('JWT header missing kid');
      }

      const jwk = (await this.fetchJwks(supabaseUrl)).find(
        (key) => key.kid === kid,
      );
      if (!jwk) {
        throw new Error('JWKS key not found');
      }

      const publicKey = createPublicKey({
        key: jwk as JsonWebKey,
        format: 'jwk',
      });
      const payload = jwt.verify(token, publicKey, {
        audience: 'authenticated',
        issuer: `${supabaseUrl}/auth/v1`,
        algorithms: ['ES256', 'RS256'],
      });

      if (typeof payload === 'string') {
        throw new Error('Unexpected JWT payload');
      }

      return this.toAuthUser(payload);
    } catch {
      throw new UnauthorizedException('Invalid or expired token');
    }
  }

  private async fetchJwks(supabaseUrl: string): Promise<JsonWebKeyWithKid[]> {
    const cached = this.jwksCache.get(supabaseUrl);
    if (
      cached &&
      Date.now() - cached.fetchedAt < SupabaseJwtService.JWKS_CACHE_MS
    ) {
      return cached.keys;
    }

    const response = await fetch(
      `${supabaseUrl}/auth/v1/.well-known/jwks.json`,
    );
    if (!response.ok) {
      throw new Error(`JWKS fetch failed: ${response.status}`);
    }

    const body = (await response.json()) as { keys: JsonWebKeyWithKid[] };
    const keys = body.keys ?? [];
    this.jwksCache.set(supabaseUrl, { keys, fetchedAt: Date.now() });
    return keys;
  }

  private normalizeSupabaseUrl(url?: string): string | undefined {
    if (!url?.trim()) {
      return undefined;
    }
    return url.trim().replace(/\/+$/, '');
  }

  private toAuthUser(payload: JwtPayload): AuthUser {
    const sub = payload.sub;
    if (!sub || typeof sub !== 'string') {
      throw new UnauthorizedException('Invalid token: missing subject');
    }

    return {
      id: sub,
      email: typeof payload.email === 'string' ? payload.email : undefined,
    };
  }
}
