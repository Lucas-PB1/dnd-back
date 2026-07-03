# Nest tradicional vs Vercel

| Aspecto | Nest tradicional | Nest na Vercel |
|---------|------------------|----------------|
| Runtime | Processo Node long-running | Serverless function (Fluid compute) |
| Porta | `listen(3000)` fixo | `process.env.PORT` injetado |
| Estado | Memória OK (cache, sessão) | **Stateless** — instância por request |
| WebSockets / filas | Gateway, Bull, cron in-process | Limitado; cron via Vercel Cron |
| DB pool | Grande, persistente | Mínimo + singleton; Supabase pooler |
| Deploy | Docker, PM2 | Git push ou `vercel --prod` |
| Dev local | `nest start --watch` | `vercel dev` simula prod |
| Bundle | Sem limite prático | **250 MB** max |
| Cold start | Não existe | Existe; lazy imports mitigam |

## Zero-config (out/2025+)

Vercel detecta NestJS automaticamente. Entrypoint: `src/main.ts`. App inteiro vira **uma Vercel Function**.

Docs: https://vercel.com/docs/frameworks/backend/nestjs

## Implicações RPG + Supabase

- Catálogo PHB read-only: **ideal** para Vercel
- Sem `@nestjs/schedule` in-process — usar Vercel Cron para refresh de MV
- CORS explícito para frontend futuro
