import { join } from 'path';
import type { NestExpressApplication } from '@nestjs/platform-express';

export function useCatalogStaticAssets(app: NestExpressApplication): void {
  app.useStaticAssets(join(process.cwd(), 'public'), {
    index: false,
    fallthrough: true,
    maxAge: '7d',
  });
}
