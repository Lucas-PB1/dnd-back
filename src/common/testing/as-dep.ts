/**
 * Cast de test double para construtor / DI em specs.
 * Preferir isto a `as never` (code-standards / typescript-quality).
 * Default `never` preserva assignability quando não há tipo contextual (como `as never`).
 */
export function asDep<T = never>(mock: object): T {
  return mock as unknown as T;
}
