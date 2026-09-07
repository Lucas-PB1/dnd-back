# Efeitos + mesa — por fonte (pack)

**Eixo = livro/pack.** Use para “fechar Northlands / GH / DMG”. O trabalho em si está nas **categorias** — este doc só cruza.

Índice por categoria: [`effect-mesa-checklist.md`](effect-mesa-checklist.md) · DROP legado: [`adr-effect-engine.md`](../architecture/adr-effect-engine.md)

Como usar: escolha a **fonte** → percorra as células → marque gaps no § da categoria (não invente lista paralela de tarefas).

---

## Matriz fonte × categoria

| Fonte | Seeds / área | Categorias a varrer | Audit / detalhe já existente |
|-------|--------------|---------------------|------------------------------|
| **PHB** | `phb/` · `effects/E001` · `E007` · `E009` · combat `C00*` core | B C D G H I N O | — |
| **DMG / Treasure** | `dmg/` · item economy `C013`–`C045` | **H** (mágico, prop., maestria, cast) | [`dmg-item-mesa.md`](../architecture/dmg-item-mesa.md) · [`treasure-rules-vs-sistema.md`](../architecture/treasure-rules-vs-sistema.md) · [`dmg-wiring-status.md`](../source/dmg-wiring-status.md) |
| **Grim Hollow** | `grim-hollow/` · `transformation/` · `economy/grim-hollow/` · Cap.1–6 | A B C E H I · K (Primordial) | residual fino → [`backlog.md`](backlog.md) Adiado |
| **Northlands** | `northlands-heroes/` · `E004` · `C052`–`C056` · threads | B C D F I · L (veículos NL) | [`northlands-character-threads.md`](northlands-character-threads.md) · residual → [`backlog.md`](backlog.md) Adiado |
| **Steinhardt (SEH)** | `steinhardt-eldritch-hunt/` · `E002` · `C046`–`C050` | B C D I | — |
| **Valda / Gunslinger** | `valdas*` · `E005` · `G021` | B C H I | — |
| **Griffon’s Saddlebag** | seeds Griffon · `C058`–`C061` | B C H | — |
| **Creatures / vehicles** | `creatures/` · templates | **J K L M** · P | [`creature-template-field-map.md`](../architecture/creature-template-field-map.md) |

Packs extras no mesmo espírito: entrar na linha da fonte (ou nova linha curta) e apontar §§.

---

## Ordem sugerida ao auditar uma fonte

1. Grants/efeitos da fonte (categoria do dono)  
2. Economies `C0*` da fonte  
3. Apply + front  
4. Actors da fonte (se houver — montaria, navio, companion)  
5. Anotar residual fino no audit da fonte ou no [`backlog.md`](backlog.md) Adiado  

Não reabrir inventário docs-first por fase antiga do motor — seeds `E00*` + esta matriz bastam.
