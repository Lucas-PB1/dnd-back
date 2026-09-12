
export function asDep<T = never>(mock: object): T {
  return mock as unknown as T;
}
