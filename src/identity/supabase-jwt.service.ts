import { Injectable, UnauthorizedException } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import {
  createRemoteJWKSet,
  jwtVerify,
  type JWTVerifyGetKey,
  type JWTPayload,
} from 'jose';
import { AuthUser } from './auth-user';

@Injectable()
export class SupabaseJwtService {
  private jwks?: JWTVerifyGetKey;

  constructor(private readonly config: ConfigService) {}

  async verifyAccessToken(token: string): Promise<AuthUser> {
    const supabaseUrl = this.normalizeSupabaseUrl(
      this.config.get<string>('SUPABASE_URL'),
    );
    if (!supabaseUrl) {
      throw new UnauthorizedException('SUPABASE_URL is not configured');
    }

    try {
      const { payload } = await jwtVerify(token, this.getJwks(supabaseUrl), {
        issuer: `${supabaseUrl}/auth/v1`,
        audience: 'authenticated',
      });
      return this.toAuthUser(payload);
    } catch {
      throw new UnauthorizedException('Invalid or expired token');
    }
  }

  private getJwks(supabaseUrl: string): JWTVerifyGetKey {
    if (!this.jwks) {
      this.jwks = createRemoteJWKSet(
        new URL(`${supabaseUrl}/auth/v1/.well-known/jwks.json`),
      );
    }
    return this.jwks;
  }

  private normalizeSupabaseUrl(url?: string): string | undefined {
    if (!url?.trim()) {
      return undefined;
    }
    return url.trim().replace(/\/+$/, '');
  }

  private toAuthUser(payload: JWTPayload): AuthUser {
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
