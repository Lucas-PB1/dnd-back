# ADR: Heritage vs Species (Grim Hollow)

## Status

Aceito — 2026-08-31

## Contexto

Grim Hollow Cap. 1 trata **herança** como identidade racial com **8 traços modulares** do pool global (~107), não como lista fechada de traços de espécie PHB. A implementação inicial sobrecarregava `phb_species` (`gh-*`, `gh-heritage-traits`, `gh_heritage_trait_*`).

## Decisão

- **PHB/SRD** permanecem em `phb_species` + `v_phb_species_trait_choices`.
- **Grim Hollow** usa tabelas dedicadas `phb_heritage*` e views `v_phb_heritage_*`.
- Personagem: `heritage_slug` XOR `species_slug` (constraint `player_character_origin_xor`).
- Escolhas modulares: kinds `heritage_trait_1..9`, `heritage_speed_trade`, `heritage_size` (não enum `gh_heritage_*` em species).
- Build tradicional = rows em `phb_heritage_traditional` + flag `is_traditional` na view de choices; não é mecânica separada.
- Repetição / tier: agregação por `trait_slug` + `take_count`; benefício ativo via `benefit_base` (1×) e `benefit_improved` (2×+).
- Mecânica de mesa: seeds tipados em `phb_combat_modifier` / `phb_class_economy_action` com `heritage_trait_id`, **sem** JSONB genérico de efeitos.

## Consequências

- API: `GET /heritages`, `/heritages/:slug/trait-choices`, `/traditional-build`.
- Front: `entities/heritage`, `heritage-catalog`; wizard envia `heritageSlug` + `heritageChoices`.
- Legado `J010`/`J011`/`J021` e `gh-*` em `phb_species` removidos via `J039`.
- `V076` retira blocos GH de `v_phb_species_trait_choices`.
