import {
  CanActivate,
  ExecutionContext,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { AuthenticatedRequest } from '../../src/identity/guards/supabase-auth.guard';

/** E2E / dev test only — set header X-Test-User-Id with a UUID. */
@Injectable()
export class TestAuthGuard implements CanActivate {
  canActivate(context: ExecutionContext): boolean {
    const request = context.switchToHttp().getRequest<AuthenticatedRequest>();
    const userId = request.headers['x-test-user-id'];
    if (!userId || typeof userId !== 'string') {
      throw new UnauthorizedException('Missing X-Test-User-Id header');
    }
    request.user = { id: userId, email: 'test@example.com' };
    return true;
  }
}
