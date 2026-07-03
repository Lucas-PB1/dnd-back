# Restrições serverless

## Stateless

- Cada request pode ir para instância diferente
- Sem cache in-memory confiável
- Sem sessão in-memory — usar Redis/Supabase se necessário

## Limites Vercel Functions

- Bundle max **250 MB**
- Timeout configurável (default 10s hobby, mais em Pro)
- Cold start na primeira request após idle

## Mitigações

- Lazy import de módulos pesados
- Queries leves via views (`v_phb_*`)
- Evitar dependências enormes no bundle

## Não usar in-process

- `@nestjs/schedule` — usar Vercel Cron
- Bull/Redis queues — serviço externo
- WebSocket persistente — requer abordagem específica
