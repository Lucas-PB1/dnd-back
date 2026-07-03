import { Global, Module } from '@nestjs/common';
import { SupabaseJwtService } from './supabase-jwt.service';
import { SupabaseAuthGuard } from './guards/supabase-auth.guard';

@Global()
@Module({
  providers: [SupabaseJwtService, SupabaseAuthGuard],
  exports: [SupabaseJwtService, SupabaseAuthGuard],
})
export class IdentityModule {}
