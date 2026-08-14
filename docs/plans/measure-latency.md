# Medir latência (hot paths)

## Catálogo

```powershell
npm run measure:latency
npm run measure:latency -- --rounds=10 --warm=1
```

Paginação: `?limit=` + `?cursor=` (`meta.nextCursor` / `hasMore`).

## Ficha (sem JWT + breakdown)

```powershell
npm run measure:character
npm run measure:character -- --rounds=5 --warm=1
```

`SHEET_PROFILE=1` fica ligado no script e imprime spans do último round.

### Leitura do breakdown (Supabase remoto)

Cada round-trip “solto” ~130–140ms (piso RTT). Sequência típica após cortes:

`access → sheet.P030/P032 → combat.P031` (+ `campaigns` em paralelo com o mapper)

Referência (fighter L1 sem magias/equipado): ~**1085ms → ~406ms** wall avg (P030/P032 + P031 + cortes de I/O).

Ganhos reais = **menos hops sequenciais**. Piso atual ≈ 3 hops: `access + P030 + P031`.

## Alternativa com Bearer

```powershell
npm run measure:latency -- --token=$env:MEASURE_TOKEN --character=$env:MEASURE_CHARACTER_ID
```

## Bundles

| RPC | Papel |
|-----|--------|
| `get_character_sheet_bundle` | Filhos da sheet + PB + boosts de classe + size da espécie |
| `get_character_combat_bundle` | Inventário + itens + armadura + unarmored + active slugs |

Log server: requests **≥ 500ms** → warn no interceptor.
