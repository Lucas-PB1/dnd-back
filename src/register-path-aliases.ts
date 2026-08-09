import Module from 'module';
import { existsSync } from 'fs';
import { join } from 'path';

/**
 * Resolve path aliases (@/, @entities/, …) em runtime no bundle Vercel / dist.
 * Deve ser o primeiro import de main.ts.
 *
 * Usa hook em Module._resolveFilename (mais confiável que tsconfig-paths no
 * runtime serverless, onde o entry pode não espelhar o layout do nest build).
 */
const ALIAS_PREFIXES: ReadonlyArray<readonly [string, string]> = [
  ['@entities/', 'entities/'],
  ['@common/', 'common/'],
  ['@catalog/', 'catalog/'],
  ['@game/', 'game/'],
  ['@identity/', 'identity/'],
  ['@config/', 'config/'],
  ['@/', ''],
];

const EXTENSIONS = ['', '.js', '.cjs', '.mjs', '.ts', '.tsx'] as const;

const baseCandidates = [
  __dirname,
  join(__dirname, 'src'),
  join(process.cwd(), 'src'),
  process.cwd(),
];

function resolveAliasedRequest(request: string): string | undefined {
  for (const [prefix, folder] of ALIAS_PREFIXES) {
    if (!request.startsWith(prefix)) continue;
    const rest = request.slice(prefix.length);
    for (const base of baseCandidates) {
      const stem = join(base, folder, rest);
      for (const ext of EXTENSIONS) {
        const candidate = `${stem}${ext}`;
        if (existsSync(candidate)) return candidate;
      }
    }
  }
  return undefined;
}

const moduleWithResolve = Module as typeof Module & {
  _resolveFilename: (
    request: string,
    parent: NodeModule | undefined,
    isMain: boolean,
    options?: unknown,
  ) => string;
};

const originalResolveFilename = moduleWithResolve._resolveFilename.bind(Module);

moduleWithResolve._resolveFilename = (
  request: string,
  parent: NodeModule | undefined,
  isMain: boolean,
  options?: unknown,
): string => {
  const mapped = resolveAliasedRequest(request);
  return originalResolveFilename(mapped ?? request, parent, isMain, options);
};
