# Quality gate — verificar tudo gerado

**Status:** aberto · **Posição:** **último** na fila (depois de DB / PVE / LEG / RES / LEGAC)  
**Índice:** [`pve-skirmish-index.md`](pve-skirmish-index.md)

Não implementa feature. Audita a **qualidade** dos planos gerados e, no fim da execução das trilhas, o **estado do repo**.

## Skills / rules

`testing` · `okf` · `dry` · `nestjs` · `typescript` · `postgresql-sql` · `catalog-sql-first` (smoke)  
Rules: `file-size.mdc` · `game-folder-conventions.mdc` · `catalog-sql-first.mdc` · `typescript-docs.mdc` · `nestjs-project.mdc`  
Docs: [`code-standards.md`](../architecture/code-standards.md) · [`docs/README.md`](../README.md) (plano concluído = apagar) · [`style-guide.md`](../style-guide.md)

## Fases

| # | Pacote | Doc | Quando | Tam. |
|---|--------|-----|--------|------|
| QA-1 | Auditoria dos `.md` de plano | [`quality-1-plans-audit.md`](quality-1-plans-audit.md) | **Agora** (antes/durante execução) | S |
| QA-2 | Gate pós-execução das trilhas | [`quality-2-post-execution.md`](quality-2-post-execution.md) | **Depois** DB+PVE+LEG+RES+LEGAC | M |

## Critérios gerais

### Planos (QA-1)

- [ ] Todo link relativo no índice resolve (arquivo existe)
- [ ] Cada pacote filho tem: Status · Dep · Skills/rules · Escopo · DoD · Fora (se útil)
- [ ] Sem overlap contraditório (ex.: RES-3 = PVE-0 documentado; LEGAC ≠ renomear `infernal_legacy`)
- [ ] Pais (DB-0, LEG, RES, LEGAC) apontam filhos; filhos apontam pai/índice
- [ ] `backlog.md` / `docs/README.md` listam todas as trilhas
- [ ] Nenhum plano “feito” ainda listado (política apagar)

### Repo pós-trilhas (QA-2)

- [ ] `npm test` / specs do escopo tocado verdes (ou CI)
- [ ] `npm run db:setup` (ou migrate+seed local) verde pós DB-0
- [ ] Critério PVE 100% do índice
- [ ] Critério LEG / RES / LEGAC DoD
- [ ] `combat-real-deferred` só VTT/XP (ou vazio)
- [ ] `database/migrations/` sem SQL de schema
- [ ] Pacotes `.md` concluídos **apagados**; índice atualizado
- [ ] Sem docs stale dual-read / mapa legado como código vivo

## Anti-padrões

- “QA” que reabre feature scope
- Marcar 100% sem evidência (teste / auditoria seed)
- Deixar planos fantasma no índice

## DoD desta trilha

- [ ] QA-1 e QA-2 fechados (`.md` apagados)
- [ ] Este pai apagado ou reduzido a uma linha no `backlog.md` “trilhas fechadas”
