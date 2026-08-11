# Auditoria de preços — PHB Equipment (Beyond) vs S031

Fonte: PHB 2024 Cap. 6 Equipment (Beyond) — scrape local removido do repo; audit histórico.
Seed: `database/seeds/phb/S031_phb_item.sql`

## Coin Values (PHB)

| Moeda EN | Abrev PT | Valor em PO |
|----------|----------|-------------|
| Copper (CP) | PC | 1/100 |
| Silver (SP) | PP | 1/10 |
| Electrum (EP) | PE | 1/2 |
| Gold (GP) | PO | 1 |
| Platinum (PP) | PL | 10 |

## Resumo

- Comparados (únicos com slug no seed): **50**
- Match cobre: **50**
- Mismatch: **0**
- Beyond sem slug no S031: **2**

## Mismatches

_Nenhum mismatch de valor (cobre) nos itens mapeados._

## Beyond sem entrada S031 (amostra)

- (50 GP) → `` (0 GP)
- (Cantrip, 30 GP → `cantrip-30-gp` (0 GP)
