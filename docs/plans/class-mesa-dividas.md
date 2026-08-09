# Dívidas — classe mesa

Itens para **avaliar depois** (sem decisão padrão-alvo vs legado nesta rodada).  
Canônico: skills `rpg-class-mesa-api` · `rpg-class-mesa-front`.

**Status:** a avaliar · **Última atualização:** 2026-08-09

| ID | Dívida | Notas | Status |
|----|--------|-------|--------|
| D1 | Sets hardcoded `SORCERER_*` / `WARLOCK_*` / `FIGHTER_*` em `use-economy-table-action` vs SSOT do catálogo | Front | a avaliar |
| D2 | Handler do Mago monólito (sem pasta `actions/wizard/`) | API | a avaliar |
| D3 | Seeds C014–C018 patchando C009/C010 (risco de drift) | Seeds | a avaliar |
| D4 | Guerreiro fora do painel genérico C010 (BM/psi por UI própria) | Front/API | **feito** (C019 + painel catalog; BM/Dungeon mantêm seletor) |
| D5 | Invocações do Bruxo: catálogo/UI ok; cast mecânico ainda follow-up | API/front | a avaliar |
| D6 | Comentário C010 “generated from front arrays” desatualizado | Seeds | a avaliar |
| D7 | Guerreiro: endpoints dedicados → `table-action` | API/front | **feito** (2026-08-09) |

## Como usar

1. Ao priorizar, marcar destino: padrão alvo / legado ok / ignorar.
2. Não expandir endpoints dedicados por poder em classe nova (ver skill API).
