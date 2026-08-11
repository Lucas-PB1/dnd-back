import type { DataSource } from 'typeorm';

export type AuthUserProfile = {
  displayName: string | null;
  email: string | null;
  avatarUrl: string | null;
  bio: string | null;
};

type AuthUserRow = {
  id: string;
  email: string | null;
  display_name: string | null;
  avatar_url: string | null;
  bio: string | null;
};

/**
 * Lê display name / e-mail / avatar / bio de auth.users (Supabase).
 * Sem schema auth (testes locais) devolve mapa vazio.
 */
export async function resolveAuthUserProfiles(
  dataSource: DataSource,
  userIds: string[],
): Promise<Map<string, AuthUserProfile>> {
  const unique = [...new Set(userIds.filter(Boolean))];
  const map = new Map<string, AuthUserProfile>();
  if (unique.length === 0) return map;

  try {
    const rows = (await dataSource.query(
      `
      SELECT
        id::text AS id,
        email,
        COALESCE(
          NULLIF(raw_user_meta_data->>'full_name', ''),
          NULLIF(raw_user_meta_data->>'name', ''),
          NULLIF(raw_user_meta_data->>'display_name', ''),
          NULLIF(split_part(email, '@', 1), '')
        ) AS display_name,
        NULLIF(raw_user_meta_data->>'avatar_url', '') AS avatar_url,
        NULLIF(raw_user_meta_data->>'bio', '') AS bio
      FROM auth.users
      WHERE id = ANY($1::uuid[])
      `,
      [unique],
    )) as AuthUserRow[];

    for (const row of rows ?? []) {
      map.set(row.id, {
        displayName: row.display_name ?? null,
        email: row.email ?? null,
        avatarUrl: row.avatar_url ?? null,
        bio: row.bio ?? null,
      });
    }
  } catch {
    // Sem auth schema — UI cai no fallback.
  }

  return map;
}
