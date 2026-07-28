import type { OpenAPIObject } from '@nestjs/swagger';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';
import type { INestApplication } from '@nestjs/common';

export function buildSwaggerConfig() {
  return new DocumentBuilder()
    .setTitle('RPG PHB API')
    .setDescription('Catálogo D&D 2024 (PHB) + fichas de jogador')
    .setVersion('1.0')
    .addBearerAuth()
    .build();
}

export function createSwaggerDocument(app: INestApplication): OpenAPIObject {
  return SwaggerModule.createDocument(app, buildSwaggerConfig());
}
