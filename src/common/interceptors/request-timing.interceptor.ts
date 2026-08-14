import {
  CallHandler,
  ExecutionContext,
  Injectable,
  Logger,
  NestInterceptor,
} from '@nestjs/common';
import { Observable, tap } from 'rxjs';
import type { Request, Response } from 'express';

const SLOW_MS = 500;

/** Mede duração HTTP; header `X-Response-Time` + log se > 500ms. */
@Injectable()
export class RequestTimingInterceptor implements NestInterceptor {
  private readonly logger = new Logger(RequestTimingInterceptor.name);

  intercept(context: ExecutionContext, next: CallHandler): Observable<unknown> {
    const http = context.switchToHttp();
    const req = http.getRequest<Request>();
    const res = http.getResponse<Response>();
    const started = process.hrtime.bigint();

    return next.handle().pipe(
      tap({
        next: () => this.finish(req, res, started),
        error: () => this.finish(req, res, started),
      }),
    );
  }

  private finish(req: Request, res: Response, started: bigint): void {
    const elapsedMs = Number(process.hrtime.bigint() - started) / 1e6;
    const rounded = Math.round(elapsedMs * 10) / 10;
    if (!res.headersSent) {
      res.setHeader('X-Response-Time', `${rounded}ms`);
    }
    if (rounded >= SLOW_MS) {
      this.logger.warn(
        `${req.method} ${req.originalUrl ?? req.url} ${rounded}ms`,
      );
    }
  }
}
