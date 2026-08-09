import { register } from 'tsconfig-paths';
import { join } from 'path';

/**
 * Resolve path aliases (@/, @entities/, …) em runtime no dist/.
 * Deve ser o primeiro import de main.ts.
 */
register({
  baseUrl: join(__dirname),
  paths: {
    '@/*': ['./*'],
    '@entities/*': ['./entities/*'],
    '@common/*': ['./common/*'],
    '@catalog/*': ['./catalog/*'],
    '@game/*': ['./game/*'],
    '@identity/*': ['./identity/*'],
    '@config/*': ['./config/*'],
  },
});
