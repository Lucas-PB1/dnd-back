# Duelo 1v1 (PvP) — duas contas

**Status:** F0–**F4** jogável (armas + magias tipadas + escuridão mágica + condições + retrato + PV temp.).  
**Não é polish adiado** e **não** entra no backlog mesa.

SSOT combate amplo: [`combat-real-deferred.md`](combat-real-deferred.md)

---

## Escopo de produto (acordado)

| Incluir | Descartar |
|---------|-----------|
| Armas | **Mapa / VTT / posição** |
| Retrato | Distância, cobertura, voo |
| PV temporários no dano | Ranked / fila / realtime |
| Condições no turno | |
| Magias tipadas (subset) + cast genérico (nota) | |
| Escuridão mágica como efeito de arena | Tratar darkvision como se atravessasse |
| **Espectador** via link `/duels/:id` (conta logada, só leitura) | Assistir sem login |

Regra de arena: sempre no alcance útil. Escuridão mágica **não** é resolvida por Visão no Escuro — só exceções tipadas (Visão do Diabo).

---

## Feito

| Fase | Conteúdo |
|------|----------|
| F0–F3 | Lobby, ready, iniciativa, armas, PV, retrato, temp HP |
| **F4** | `POST .../cast`, `POST .../conditions`, `arena_effects`, gates de ação/visão |
| **Espectador** | `GET /duels/:id` para qualquer conta autenticada → `viewerRole: spectator` |

### Magias tipadas (F4)

| Slug | Efeito |
|------|--------|
| `escuridao` | Arena `magical_darkness` + concentração |
| `misseis-magicos` | Acerto automático, dano por dardos |
| `raio-de-fogo` | Ataque mágico vs CA + 1d10 (escala de truque) |
| demais | Gasta slot via cast da ficha + nota no log |

### Visão / gates

- Incapacitado / atordoado / paralisado / inconsciente / petrificado → não age
- Escuridão mágica: vantagem/desvantagem conforme quem tem Visão do Diabo
- Concentração deixa de ser Escuridão → limpa efeito de arena

---

## API

| Método | Path |
|--------|------|
| `GET/POST` | `/duels` |
| `POST` | `/duels/join` |
| `GET` | `/duels/:id` |
| `POST` | `/duels/:id/ready` |
| `POST` | `/duels/:id/attack` |
| `POST` | `/duels/:id/cast` |
| `POST` | `/duels/:id/conditions` |
| `POST` | `/duels/:id/forfeit` |

Schema: `arena_effects TEXT[]`, `arena_effect_source_character_id`

---

## Próximos (pós-F4)

- Mais magias tipadas / saves / cura no alvo
- Gates finos por condição (ex.: vantagem vs cego)
- Quebra de concentração por dano

Convergir com [`combat-real-deferred.md`](combat-real-deferred.md).
