# QA-2 — Gate pós-execução

**Status:** aberto · **Pai:** [`quality-gate-backlog.md`](quality-gate-backlog.md) · **Dep:** DB-0c + PVE-10b + LEG-4 + RES-5 + LEGAC-4 (ou residual justificado) · **Tam:** M

## Skills / rules

`testing` · `nestjs` · `postgresql-sql` · `catalog-sql-first` · `okf` · `/legado` pontual se achar morto  
`code-standards.md` · `sql-layout.md`

## Escopo

Smoke e critérios finais:

| Check | Comando / evidência |
|-------|---------------------|
| Testes | `npm test` (ou CI) no escopo tocado |
| DB greenfield | `npm run db:setup` local; migrations vazias |
| PVE 100% | auditoria magia ofensiva; deferred limpo |
| LEG / RES / LEGAC | DoDs dos pais; `rg` spot-check |
| Docs | planos concluídos apagados; índice só residual |
| Swagger | contrato cast/react/attack coerente se PVE-8 feito |

Registrar resultado em `docs/okf/log.md` (1 bloco “QA-2 gate”).

## Fora

- Novas features
- Polish mesa UI

## DoD

- [ ] Checklist do pai QA preenchido
- [ ] Log OKF
- [ ] Apagar este `.md` + pai `quality-gate-backlog.md`
- [ ] `backlog.md` Feature futura sem trilhas fantasma
