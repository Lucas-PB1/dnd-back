import type { CorsOptions } from '@nestjs/common/interfaces/external/cors-options.interface';

const LOCAL_ORIGIN_REGEX = /^http:\/\/(localhost|127\.0\.0\.1|\[::1\])(:\d+)?$/;
const VERCEL_APP_ORIGIN = /^https:\/\/[\w.-]+\.vercel\.app$/;

function isAllowedOrigin(origin: string): boolean {
  const frontendEnv = process.env.FRONTEND_URL?.trim();
  if (frontendEnv) {
    const origins = frontendEnv.split(',').map((o) => o.trim());
    if (origins.includes(origin)) {
      return true;
    }
  }
  if (VERCEL_APP_ORIGIN.test(origin)) {
    return true;
  }
  if (LOCAL_ORIGIN_REGEX.test(origin)) {
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
    exposedHeaders: ['X-Response-Time'],
  };
}

