import { Injectable, UnauthorizedException } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { jwtVerify } from 'jose';
import { AuthUser } from './auth-user';

@Injectable()
export class SupabaseJwtService {
  constructor(private readonly config: ConfigService) {}

  async verifyAccessToken(token: string): Promise<AuthUser> {
    const secret = this.config.get<string>('SUPABASE_JWT_SECRET');
    if (!secret) {
      throw new UnauthorizedException('SUPABASE_JWT_SECRET is not configured');
    }

    try {
      const { payload } = await jwtVerify(
        token,
        new TextEncoder().encode(secret),
        { algorithms: ['HS256'] },
      );

      const sub = payload.sub;
      if (!sub || typeof sub !== 'string') {
        throw new UnauthorizedException('Invalid token: missing subject');
      }

      return {
        id: sub,
        email: typeof payload.email === 'string' ? payload.email : undefined,
      };
    } catch {
      throw new UnauthorizedException('Invalid or expired token');
    }
  }
}
