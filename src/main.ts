import './register-path-aliases';
import 'reflect-metadata';

import { NestFactory } from '@nestjs/core';
import { ValidationPipe } from '@nestjs/common';
import { SwaggerModule } from '@nestjs/swagger';
import { AppModule } from './app.module';
import { HttpExceptionFilter } from './common/filters/http-exception.filter';
import { corsConfig } from './config/cors.config';
import { swaggerSetupOptions } from './config/swagger.config';
import { createSwaggerDocument } from './config/swagger-document';
import { validateDeployEnv } from './config/validate-env';

async function bootstrap() {
  validateDeployEnv();

  const app = await NestFactory.create(AppModule);

  app.useGlobalFilters(new HttpExceptionFilter());
  app.useGlobalPipes(
    new ValidationPipe({
      whitelist: true,
      transform: true,
      transformOptions: { enableImplicitConversion: true },
    }),
  );

  app.enableCors(corsConfig());

  const document = createSwaggerDocument(app);
  SwaggerModule.setup('api', app, document, swaggerSetupOptions());

  await app.listen(process.env.PORT ?? 3000);
}

bootstrap().catch((error: unknown) => {
  const message = error instanceof Error ? error.message : String(error);
  console.error('[bootstrap] failed:', message);
  process.exit(1);
});
