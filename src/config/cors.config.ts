import type { CorsOptions } from '@nestjs/common/interfaces/external/cors-options.interface';

const LOCAL_FRONTEND = 'http://localhost:3001';
const VERCEL_APP_ORIGIN = /^https:\/\/[\w.-]+\.vercel\.app$/;

function isAllowedOrigin(origin: string): boolean {
  const frontend = process.env.FRONTEND_URL?.trim();
  if (frontend && origin === frontend) {
    return true;
  }
  if (VERCEL_APP_ORIGIN.test(origin)) {
    return true;
  }
  if (origin === LOCAL_FRONTEND) {
    return true;
  }
  return false;
}

export function corsConfig(): CorsOptions {
  return {
    origin: (origin, callback) => {
      if (!origin) {
        callback(null, true);
        return;
      }
      if (isAllowedOrigin(origin)) {
        callback(null, true);
        return;
      }
      callback(null, false);
    },
    credentials: true,
  };
}
