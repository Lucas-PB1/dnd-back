import { ExecutionContext, UnauthorizedException } from '@nestjs/common';
import {
  SupabaseAuthGuard,
  type AuthenticatedRequest,
} from './supabase-auth.guard';
import { SupabaseJwtService } from '../supabase-jwt.service';

describe('SupabaseAuthGuard', () => {
  const jwtService = {
    verifyAccessToken: jest.fn(),
  } as unknown as SupabaseJwtService;
  const guard = new SupabaseAuthGuard(jwtService);

  function createContext(authHeader?: string): {
    context: ExecutionContext;
    request: AuthenticatedRequest;
  } {
    const request = {
      headers: authHeader !== undefined ? { authorization: authHeader } : {},
    } as AuthenticatedRequest;

    const context = {
      switchToHttp: () => ({
        getRequest: () => request,
      }),
    } as unknown as ExecutionContext;

    return { context, request };
  }

  beforeEach(() => {
    jest.clearAllMocks();
  });

  it('throws when Bearer header is missing', async () => {
    const { context } = createContext();
    await expect(guard.canActivate(context)).rejects.toThrow(
      UnauthorizedException,
    );
  });

  it('throws when token is empty after Bearer prefix', async () => {
    const { context } = createContext('Bearer   ');
    await expect(guard.canActivate(context)).rejects.toThrow(
      UnauthorizedException,
    );
  });

  it('verifies token and sets request.user on success', async () => {
    const user = { id: 'user-123', email: 'user@test.com' };
    jwtService.verifyAccessToken = jest.fn().mockResolvedValue(user);
    const { context, request } = createContext('Bearer valid-token');

    await expect(guard.canActivate(context)).resolves.toBe(true);
    expect(jwtService.verifyAccessToken).toHaveBeenCalledWith('valid-token');
    expect(request.user).toEqual(user);
  });
});
