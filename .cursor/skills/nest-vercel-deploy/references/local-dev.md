# Dev local

## Nest tradicional (desenvolvimento rápido)

```bash
npm run start:dev
```

Hot reload, ideal para codar endpoints.

## Vercel dev (simula produção)

```bash
npm i -g vercel   # CLI ≥ 48.4
vercel dev
```

- Simula runtime serverless
- Usa env vars do projeto Vercel
- Pull env: `vercel env pull .env.local`

## Variáveis locais (.env)

```
DATABASE_URL=postgresql://...@localhost:5432/postgres
PORT=3000
NODE_ENV=development
```

## Fluxo recomendido

1. Desenvolver com `start:dev`
2. Antes de deploy, testar com `vercel dev`
3. Deploy preview: push branch → Vercel preview URL
4. Produção: `vercel --prod` ou merge main
