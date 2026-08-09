# Dívidas — classe mesa

Itens para **avaliar depois** (sem decisão padrão-alvo vs legado nesta rodada).  
Canônico: skills `rpg-class-mesa-api` · `rpg-class-mesa-front`.

**Status:** a avaliar · **Última atualização:** 2026-08-09

| ID | Dívida | Notas |
|----|--------|-------|
| D1 | Sets hardcoded `SORCERER_*` / `WARLOCK_*` em `use-economy-table-action` vs SSOT do catálogo | Front |
| D2 | Handler do Mago monólito (sem pasta `actions/wizard/`) | API |
| D3 | Seeds C014–C018 patchando C009/C010 (risco de drift) | Seeds |
| D4 | Guerreiro fora do painel genérico C010 (BM/psi por UI própria) | Front/API |
| D5 | Invocações do Bruxo: catálogo/UI ok; cast mecânico ainda follow-up | API/front |
| D6 | Comentário C010 “generated from front arrays” desatualizado | Seeds |
| D7 | Guerreiro: endpoints dedicados → migrar para `table-action` (padrão canônico) | API/front |

## Como usar

1. Ao priorizar, marcar destino: padrão alvo / legado ok / ignorar.
2. Não expandir endpoints dedicados estilo fighter em classe nova (ver skill API).
