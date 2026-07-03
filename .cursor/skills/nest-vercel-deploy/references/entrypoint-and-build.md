# Entrypoint e build

## Arquivos reconhecidos

- `src/main.ts` (preferido)
- `src/app.ts`, `src/index.ts`, `src/server.ts`

## main.ts padrão

```typescript
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.enableCors();
  await app.listen(process.env.PORT ?? 3000);
}
bootstrap();
```

**Não alterar** o padrão `bootstrap()` + `app.listen()` — Vercel usa isso para build.

## Build

- Vercel detecta NestJS e builda automaticamente
- `vercel.json` opcional para zero-config
- CLI mínima: **48.4.0**

## Scripts package.json

```json
{
  "scripts": {
    "build": "nest build",
    "start:dev": "nest start --watch",
    "vercel:dev": "vercel dev"
  }
}
```
