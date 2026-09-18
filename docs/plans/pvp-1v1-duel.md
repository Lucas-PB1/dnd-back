# Duelo 1v1 (PvP) — duas contas

**Status:** F0–**F4** jogável + espectador + **Sabujo de Sangue** no ataque.  
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
| Magias tipadas (`phb_spell_combat` / `resolveCombatSpell`) + cast genérico (nota) | |
| Escuridão mágica como efeito de arena | Tratar darkvision como se atravessasse |
| **Espectador** via link `/duels/:id` (conta logada, só leitura) | Assistir sem login |
| **Sabujo de Sangue** (Golpe / Armamento / Explosão / refund L15) | Wiring tipado completo na mesa |

Regra de arena: sempre no alcance útil. Escuridão mágica **não** é resolvida por Visão no Escuro — só exceções tipadas (Visão do Diabo).

---

## Feito

| Fase | Conteúdo |
|------|----------|
| F0–F3 | Lobby, ready, iniciativa, armas, PV, retrato, temp HP |
| **F4** | `POST .../cast`, `POST .../conditions`, `arena_effects`, gates de ação/visão |
| **Espectador** | `GET /duels/:id` para qualquer conta autenticada → `viewerRole: spectator` |
| **Sabujo** | `POST .../attack` com `bloodStrike` / `damageTypeOverride` / `bloodExplosionOnMiss`; panel no detail |

### Magias tipadas (F4 + PVE)

Motor compartilhado `resolveCombatSpell` + tabela `phb_spell_combat` (cantrips…Nv9, condições, arena). Ausência de row → gasta slot + nota (`slot_only`).

| Exemplo | Efeito |
|---------|--------|
| `escuridao` | Arena `magical_darkness` + concentração |
| `misseis-magicos` | `auto_damage` |
| `raio-de-fogo` / `bola-de-fogo` | `spell_attack` / `save_damage` |
| demais tipadas | ver [`spell-combat.md`](../architecture/spell-combat.md) |
| sem row | Slot + nota no log |

Paridade superfícies: [`surface-combat-parity.md`](../architecture/surface-combat-parity.md).

### Sabujo de Sangue (duelo)

| Mecânica | Comportamento |
|----------|----------------|
| Golpe | Gasta pool + custo necrótico (+ cura L15); dano extra tipado por opção |
| Bloodshard | Save DEX vs arma + perf. (sem attack roll) |
| Hunting | CA efetiva = 10 + DEX |
| Shadowblood | Escuridão mágica na arena |
| Exílio / Trovão | `incapacitated` / `prone` no save falho |
| Constritor / Definhante | marcas em `arena_effects` (desvantagem / metade no próximo ataque) |
| Armamento L7 | `damageTypeOverride` acid/necrotic/poison |
| Explosão L7 | `bloodExplosionOnMiss` no mesmo request |
| Refund L15 | recupera 1 uso se o golpe zerou o alvo |
| Anatomia | resist. Veneno se o alvo for Sabujo |

### Visão / gates

- Incapacitado / atordoado / paralisado / inconsciente / petrificado → não age
- Escuridão mágica: vantagem/desvantagem conforme quem tem Visão do Diabo
- Concentração deixa de ser Escuridão → limpa efeito de arena
- Exílio: no início do turno do alvo, perde o turno e limpa incapacitado

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
- Mesa: UI `optionSlug` + efeitos tipados do Golpe

Convergir com [`combat-real-deferred.md`](combat-real-deferred.md).
