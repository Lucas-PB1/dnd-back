import { UnauthorizedException } from '@nestjs/common';
import { DataSource, QueryFailedError } from 'typeorm';

export const AUTH_USER_MISSING_MESSAGE =
  'Sessão inválida: usuário não encontrado. Faça login novamente.';

export async function assertAuthUserExists(
  dataSource: DataSource,
  userId: string,
): Promise<void> {
  try {
    const rows = await dataSource.query(
      `SELECT 1 FROM auth.users WHERE id = $1 LIMIT 1`,
      [userId],
    );
    if (!Array.isArray(rows) || rows.length === 0) {
      throw new UnauthorizedException(AUTH_USER_MISSING_MESSAGE);
    }
  } catch (error) {
    if (error instanceof UnauthorizedException) throw error;
    // Sem schema auth (ex.: Postgres local de teste) — deixa o save decidir.
  }
}

export function isPlayerCharacterUserFkError(error: unknown): boolean {
  if (!(error instanceof QueryFailedError)) return false;
  const message = error.message ?? '';
  return message.includes('player_character_user_id_fkey');
}
