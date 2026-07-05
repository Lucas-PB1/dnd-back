import { Injectable, UnauthorizedException } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import jwt from 'jsonwebtoken';
import jwksClient, { type JwksClient } from 'jwks-rsa';
import { AuthUser } from './auth-user';

type JwtPayload = jwt.JwtPayload & {
  email?: string;
};

@Injectable()
export class SupabaseJwtService {
  private readonly clients = new Map<string, JwksClient>();

  constructor(private readonly config: ConfigService) {}

  async verifyAccessToken(token: string): Promise<AuthUser> {
    const supabaseUrl = this.normalizeSupabaseUrl(
      this.config.get<string>('SUPABASE_URL'),
    );
    if (!supabaseUrl) {
      throw new UnauthorizedException('SUPABASE_URL is not configured');
    }

    try {
      const payload = await this.verifyWithJwks(token, supabaseUrl);
      return this.toAuthUser(payload);
    } catch {
      throw new UnauthorizedException('Invalid or expired token');
    }
  }

  private verifyWithJwks(
    token: string,
    supabaseUrl: string,
  ): Promise<JwtPayload> {
    const client = this.getClient(supabaseUrl);

    return new Promise((resolve, reject) => {
      jwt.verify(
        token,
        (header, callback) => {
          if (!header.kid) {
            callback(new Error('JWT header missing kid'));
            return;
          }

          client.getSigningKey(header.kid, (error, key) => {
            if (error || !key) {
              callback(error ?? new Error('Signing key not found'));
              return;
            }
            callback(null, key.getPublicKey());
          });
        },
        {
          audience: 'authenticated',
          issuer: `${supabaseUrl}/auth/v1`,
          algorithms: ['ES256', 'RS256'],
        },
        (error, decoded) => {
          if (error || !decoded || typeof decoded === 'string') {
            reject(error ?? new Error('Invalid token payload'));
            return;
          }
          resolve(decoded as JwtPayload);
        },
      );
    });
  }

  private getClient(supabaseUrl: string): JwksClient {
    let client = this.clients.get(supabaseUrl);
    if (!client) {
      client = jwksClient({
        jwksUri: `${supabaseUrl}/auth/v1/.well-known/jwks.json`,
        cache: true,
        cacheMaxAge: 600_000,
        rateLimit: true,
        jwksRequestsPerMinute: 10,
      });
      this.clients.set(supabaseUrl, client);
    }
    return client;
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
