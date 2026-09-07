# Combate real — feature futura (fora do backlog mesa)

**Não é polish adiado.** É uma **feature posterior**: rolagem personagem × personagem / personagem × criatura, dano no alvo, saves de combate, posição, iniciativa de encontro, etc.

Enquanto isso **não** existir, a mesa só movimenta o que a **ficha / estado do PC** já carrega (recursos, PV, PV temp., CA tipada, slots, toggles).

SSOT mesa ativo: [`backlog.md`](backlog.md) · [`effect-mesa-checklist.md`](effect-mesa-checklist.md)  
Skill: `rpg-class-mesa-api` (critério mesa ≠ VTT / combate simulado).

---

## Fronteira

| Mesa **agora** (apply / toggle ok) | Combate real (**esta lista**) |
|------------------------------------|-------------------------------|
| Gastar recurso / uso | Dano no alvo (PC ou monstro) |
| Cura / PV temp. na ficha | Ataque vs CA / acerto / crítico |
| CA tipada (toggle sticky) | Saves de combate (derrubar, amedrontar…) |
| Slots, concentração, inspiração | Empurrão / grapple / alcance no tabuleiro |
| Nota + declare para o resto | Iniciativa de todos, turnos automatizados |
| | Bloodied gate, 1×/turno no servidor, etc. |

Economy/painel podem **listar** o botão e devolver **nota**; falta de apply de combate **não** reabre “classe done” nem entra no backlog mesa.

---

## Parqueado (quando existir combate)

### Manobras / estilo (dano, save, ataque)

- [ ] Battle Master: trip, menacing, pushing, precision-attack (no ataque), etc. — além de Rally/`tempHp` e notas
- [ ] Parry / redução de dano no momento do acerto
- [ ] Estilos condicionais no roll (GWF piso, TWF gate, Charger, PAM, …)
- [ ] Gunslinger: manobras `descriptive` que só fazem sentido no ataque/alvo (blindfire, ricochet, fan-the-hammer, …)
- [ ] Atacante Selvagem: enforcement 1×/turno no servidor
- [ ] Front: escolher entre 2 rolagens de dano (`alternateRolls`)

### Metamagia / invocações / cast em combate

- [ ] Metamagia: efeito no cast (não só gastar SP + descrição)
- [ ] Eldritch Smite e invocações cujo efeito é dano/condição no alvo
- [ ] Bloodied gate / craft spawn no fluxo de combate

### Condições / duração / alvo

- [ ] Condições e duração tipadas no alvo (Véu Psíquico, Rasgar Mente, Teia, Veneno, …) além de declare
- [ ] Empurrão / grappled / improvisado (Briguento de Taverna e similares)
- [ ] Attitude NPC tipado (Influenciar) se depender de combate social tipado fino
- [ ] Proteção Arcana: pool própria (≠ PV temp.), recarga por espaço, Proteção Projetada no aliado
- [ ] Centelha Divina / Auxílio da Terra: dano no alvo + save tipados (cura na ficha já é mesa)

### Encontro / atores

- [ ] §M / §P: monstro catálogo · spawn · combate no encontro
- [ ] Tracker fino de companheiro / summon em combate (além de nota/uso)

---

## Como usar

1. Achou gap que **exige alvo/dano/save de combate** → **só aqui**, não em [`backlog.md`](backlog.md).
2. Achou gap de **ficha** (cura, temp HP, CA, pool) → checklist mesa / backlog ativo.
3. Não misturar com “Adiado — polish” (UI, modal, editorial).
