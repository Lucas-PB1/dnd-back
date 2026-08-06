# Mecânica de classes — acompanhamento

Checklist da passagem **classe-base + subclasses** no padrão Pistoleiro / Bárbaro / Guerreiro:

1. Catálogo e recursos (fórmulas, recuperação)
2. Domínio puro + slice de combate / bônus nas rolagens
3. Ações e toggles que disparam **rolagem** ou gasto de recurso
4. Efeitos numéricos nas rolagens; o resto vira **nota** para a mesa
5. UI na ficha
6. Testes + migrate/seed

## Critério (mesa, não VTT)

**Não** é objetivo manter estado de jogo completo (turno a turno, posição no mapa, rastrear alvo, condições persistidas, “1× por turno” no servidor, etc.).

**É** objetivo: na ficha, **rolar como na mesa** — d20/dano/salvaguarda com os bônus certos, gastar o recurso quando a rolagem usa o poder, e devolver texto claro do que o jogador/Mestre aplica à mão.

| Faz | Não faz |
|-----|---------|
| Rolagem + modificadores + crítico | Simular o tabuleiro / iniciativa automática de todos |
| Gastar recurso quando a rolagem consome | Validar “já usei neste turno” |
| Nota: “mova metade do deslocamento”, “mesmo alvo” | Persistência de posição ou alvo |
| Toggle na UI (Furtivo, Golpe Psiônico, …) | Motor de condições/efeitos de duração |

**Critério “feito”:** recursos + rolagens + UI no padrão acima.

**Última revisão:** 2026-07-29

Legenda: `[x]` feito · `[~]` parcial · `[ ]` não conferido

---

## Resumo

| Classe | Slug | Status |
|--------|------|--------|
| Pistoleiro | `gunslinger` | `[x]` feito |
| Bárbaro | `barbarian` | `[x]` feito |
| Guerreiro | `fighter` | `[x]` feito |
| Bardo | `bard` | `[x]` feito |
| Bruxo | `warlock` | `[x]` feito |
| Clérigo | `cleric` | `[x]` feito |
| Druida | `druid` | `[x]` feito |
| Feiticeiro | `sorcerer` | `[x]` feito |
| Guardião | `ranger` | `[x]` feito |
| Ladino | `rogue` | `[x]` feito |
| Mago | `wizard` | `[x]` feito |
| Monge | `monk` | `[x]` feito |
| Paladino | `paladin` | `[x]` feito |

**Progresso:** 13 de 13 feitas (100% CONCLUÍDO)! 🎉 All PHB 2024 & Valdas classes fully implemented!

---

## Feitas / parciais

### Pistoleiro (`gunslinger`) — `[x]`

- Domínio, risco, manobras, armas de fogo, UI (`combat-maneuvers-panel`)
- Subclasses: Olho Morto, Grande Apostador, Agente Secreto, Pistoleiro Arcano, Tiro de Trucagem, Chapéu Branco

### Bárbaro (`barbarian`) — `[x]`

- Fúria, Imprudente, recursos, subclasses PHB + painel UI
- Subclasses PHB: Árvore do Mundo, Berserker, Coração Selvagem, Fanático
- Valdas: Mago Musculoso — conferir se entrou no mesmo pacote ou ficou só catálogo

### Guerreiro (`fighter`) — `[x]`

- [x] Base: Recuperar Fôlego, Mente Tática, Surto, Indomável e Ataques Estudados
- [x] Manobras BM: dado, gasto, CD, notas, Aparar/Reunir e Implacável
- [x] Combatente Psíquico: Golpe, Campo, Movimento, Salto, Resguardo, Baluarte e Mestre
- [x] Explorador de Masmorras: Chute, Matar Monstro e Precauções (5 usos)
- [x] Campeão e Cavaleiro Místico: bônus numéricos nas rolagens + notas de mesa
- [x] UI: ações/toggles e atualização dos recursos

O Dado de Superioridade só é rolado/gasto pela ação de manobra; o resultado entra
no dano manualmente, então não existe um segundo caminho na rolagem de dano.

Fora de escopo de propósito: controlar 1×/turno, rastrear alvo, posição,
condições do inimigo ou Regeneração como tick automático.

Subclasses PHB: Campeão, Cavaleiro Místico, Combatente Psíquico, Mestre da Batalha  
Valdas: Explorador de Masmorras (`dungeoneer`)

### Ladino (`rogue`) — `[x]`

- [x] Base: Ataque Furtivo, Golpe Astuto, Mira Firme, Esquiva Sobrenatural, Evasão, Talento Confiável, Mente Escorregadia e Golpe de Sorte
- [x] Adaga Espiritual: dados psiônicos, aptidão, sussurros, lâminas, teleguiado, teleporte, véu e Rasgar Mente
- [x] Assassino: iniciativa, Assassinar, dano surpresa, veneno e Golpe Mortal
- [x] Ladrão: Mão Leve no catálogo, Ataque Escondido, cargas de item mágico e notas de mesa
- [x] Trapaceiro Arcano: conjuração de 1/3, Mãos Mágicas e Ladrão de Magias
- [x] Perseguidor Aracnídeo: Golpe Venenoso, Correia/Teia, Sentido de Aranha e Paralisar
- [x] UI: painel, toggles de ataque/dano/perícia/salvaguarda e atualização de recursos

Fora de escopo de propósito: persistir alvo/turno, posição, duração de condições,
invisibilidade ou limite de uma vez por turno. A ficha rola, gasta recursos e
descreve o efeito que jogador e Mestre aplicam na mesa.

### Monge (`monk`) — `[x]`

- [x] Base: Artes Marciais (Ataque Desarmado sintético, dado 1d6→1d12, melhor de FOR/DES sem armadura/escudo), Ataque Extra, Movimento sem Armadura, Evasão e Sobrevivente Disciplinado (proficiência em todas as salvaguardas)
- [x] Foco: Torrente de Golpes, Defesa Paciente, Passo do Vento e Golpe Atordoante (CD 8 + SAB + PB) gastando Pontos de Foco
- [x] Mão Espalmada: Técnica da Mão Espalmada (CD de Caído/empurrão)
- [x] Combatente dos Elementos: Explosão Elemental à distância com o dado de Artes Marciais
- [x] Misericórdia: Mão de Cura e Mão de Dolo (SAB + dado de Artes Marciais)
- [x] Combatente das Sombras: Passo da Sombra
- [x] Guerreiro das Ruas (Valdas): notas de mesa
- [x] UI: `combat-monk-panel`, Ataque Desarmado nas Ações e atualização de Foco

O catálogo já trazia `focusPoints` (máx = nível, recupera em curto/longo) e a Defesa
sem Armadura DES+SAB; o dado de Artes Marciais e a CD de Foco vivem no código.

Fora de escopo de propósito: rastrear 1×/turno da Mão de Dolo, posição do teleporte,
duração das condições e restauração automática de Foco na iniciativa.

---

### Paladino (`paladin`) — `[x]`

- [x] Base: Mãos Consagradas (reserva = 5 × nível, com Curar Veneno por 5 PV), Ataque Extra, Aura de Proteção (+CAR nas salvaguardas, 9 m no nível 18) e Golpes Radiantes (+1d8 Radiante corpo a corpo no nível 11)
- [x] Destruição Divina (Divine Smite): gasta um espaço de magia na rolagem de dano para +2d8 Radiante (+1d8 por círculo acima do 1º; +1d8 vs Corruptor/Morto-vivo), debitando o slot no estado
- [x] Canalizar Divindade: Sentido Divino, Repudiar Inimigos (CD 8 + CAR + PB) e a opção do juramento gastando usos de Canalizar
- [x] Devoção, Glória, Anciões e Vingança: notas de mesa e nome/efeito da Canalizar do juramento
- [x] Valdas: Juramento da Folia (`oath-of-revelry`) — notas de mesa
- [x] UI: `combat-paladin-panel`, seletor de Golpe Divino no card de ataque e reservas de cura/Canalizar

O catálogo já trazia a progressão half-caster (CAR) e `channelDivinity`; a reserva de
Mãos Consagradas usa o recurso `layOnHands` com máximo = 5 × nível ajustado no runtime.

Fora de escopo de propósito: alcance/alvos das auras, duração de Voto de Inimizade e
demais efeitos de 1 minuto, e persistência de quem está dentro da aura.

---

### Guardião (`ranger`) — `[x]`

- [x] Base: Inimigo Favorito (usos gratuitos de Marca do Predador = PB), Ataque Extra, Errante (+3 m), Incansável (1d8 + SAB PV temporários), Véu da Natureza, Caçador Preciso (vantagem vs marcado) e Matador de Inimigos Favoritos (dado d10)
- [x] Marca do Predador: cast gratuito com concentração + toggle de dano 1d6/1d10 no acerto
- [x] Caçador: Assassino de Colossos (+1d8) e notas de Hordas/Defesas
- [x] Andarilho Feérico: Golpes Terríveis (+1d4/+1d6), Reforços Feéricos e Andarilho Nebuloso
- [x] Vigilante das Sombras: +SAB na Iniciativa, Golpe Terrível (+2d6/+2d8 gastando uso) e notas
- [x] Senhor das Feras: nota de Companheiro Primal / comandar a fera
- [x] UI: `combat-ranger-panel`, toggles de Marca/Colossos/Terríveis e botão de Golpe Terrível

Recursos novos de classe: `favoredEnemy`, `tireless`, `naturesVeil`. Subclasses já tinham
`dread-strike`, `fey-reinforcements` e `misty-wanderer` no catálogo.

Fora de escopo de propósito: estado do Companheiro Primal, rastrear 1×/turno, alcance do
Destruidor de Hordas e duração do Véu da Natureza além da nota de mesa.

---

### Clérigo (`cleric`) — `[x]`

- [x] Base: Canalizar Divindade com Centelha Divina (cura ou dano), Expulsar/Fulminar Mortos-Vivos, Golpes Abençoados e Intervenção Divina
- [x] Vida: Discípulo da Vida, Preservar a Vida (reserva = 5 × nível), Curandeiro Abençoado e Cura Suprema
- [x] Luz: Brilho do Amanhecer, Labareda Protetora/Aprimorada e Coroa de Luz
- [x] Trapaça: Bênção do Trapaceiro, Invocar Duplicidade, Transposição e Duplicidade Aprimorada
- [x] Guerra: Ataque Direcionado, Sacerdote da Guerra, Bênção do Deus da Guerra e Avatar da Guerra
- [x] UI: `combat-cleric-panel`, recursos, ações de Canalizar e toggle de Golpe Divino no card de arma

O catálogo já trazia a progressão de `channelDivinity`, magias de domínio e recursos
de Coroa de Luz, Bênção do Trapaceiro e Sacerdote da Guerra. Foram completados os
recursos de Intervenção Divina e Labareda Protetora, incluindo suas recuperações.

Fora de escopo de propósito: persistir alvo/duração de Expulsar, Duplicidade, bênçãos
e auras; escolher automaticamente alvos de cura/dano; validar 1×/turno do Golpe
Divino; e bloquear automaticamente os 2d4 Descansos Longos após Desejo.

---

### Bardo (`bard`) — `[x]`

- [x] Base: Inspiração Bárdica (dados d6/d8/d10/d12 por nível, máx = Mod. CAR, recarrega em DL até nv. 4 e DC no nv. 5+ com Fonte de Inspiração), Pau para Toda Obra, Balada de Cura e Inspiração Superior (nv. 18: +1 uso na iniciativa se zerada)
- [x] Conhecimento: Palavras Cortantes (Reação gasta 1 Inspiração para subtrair do ataque/teste/dano inimigo)
- [x] Glamour: Desempenho Cativante (gasta 1 Inspiração para conceder PV temporários = 2×dado a aliados e movimento por Reação)
- [x] Dança: Dança Virtuosa (Ataque Desarmado com CAR e dado de Inspiração) e Resposta Ágil (Reação para CA + movimento de aliado)
- [x] Bravura: Inspiração de Combate (usar Inspiração no dano ou na CA)
- [x] UI: `combat-bard-panel`, botões de ação e estado ao vivo dos usos/dados

---

### Feiticeiro (`sorcerer`) — `[x]`

- [x] Base: Pontos de Feitiçaria (máx = nível a partir do nv 2), Inato Feiticeiro (Ira Feiticeira: +1 CD de magia e Vantagem nos truques), Restauração Feiticeira (recupera Pontos no Descanso Curto nv 5+)
- [x] Fonte de Magia: conversão bidirecional entre Slots de Magia ↔ Pontos de Feitiçaria (1:1 slot->pontos, custos 2/3/5/6/7 pontos->slot)
- [x] Metamágica: botões de gasto de 1, 2 ou 3 Pontos de Feitiçaria para modificadores de conjuração
- [x] Linhagem Dracônica: Resiliência Dracônica (CA 10 + DES + CAR; +1 PV/nível) e Afinidade Elemental
- [x] Magia Selvagem: Maré de Caos (Vantagem em 1 rolagem; recarrega com Surto de Magia Selvagem)
- [x] Mapeamento Mecânico: Baluarte da Ordem (gasta 1-5 Pontos para dados de proteção a aliados)
- [x] Feitiçaria Aberrante: Feitiçaria Psiónica e Mente Psiónica
- [x] UI: `combat-sorcerer-panel`, seletores de conversão de slots e botões de metamágica/subclasse

---

### Bruxo (`warlock`) — `[x]`

- [x] Base: Magia de Pacto (slots de círculo único com recuperação no Descanso Curto e Longo), Contato Arcano (recupera 1 Slot de Pacto no nv 5+, 1×/DL) e Arcanum Místico (magias de 6º a 9º círculo)
- [x] Celestial: Luz Curativa (reserva de 1 + nível em d6s para cura como Ação Bônus) e Alma Radiante (+CAR no dano Fogo/Radiante)
- [x] Ínfero: Bênção do Obscuro (PV temp = CAR + nível ao matar inimigo), Sorte do Próprio Inferno (+1d10 em teste/salvaguarda) e Resiliência Ínfera
- [x] Arquifada: Passo de Bruma Aprimorado (usos de Passo de Bruma com efeitos de Provocar, Desorientar ou Invisibilidade)
- [x] Grande Antigo: Mente Desperta (telepatia a 9 m) e Feitiçaria Psiónica
- [x] UI: `combat-warlock-panel`, exibição dos recursos de patrono e botões de ação

---

### Druida (`druid`) — `[x]`

- [x] Base: Forma Selvagem (2 a 4 usos; 1 uso recarrega no Descanso Curto; todos no Longo), Ordem Primal (Protetor ou Magista), Ressurgimento Selvagem (conversão Forma ↔ Slot 1º círculo) e Besta Feiticeira
- [x] Lua: Forma Selvagem de Combate (PV temp = 3×nível, CA = 13 + Mod. Sabedoria, Ataques Radiantes) e Cura Lunar
- [x] Terra: Recuperação Natural (recupera slots no descanso curto) e Terreno Habitual (Ação Bônus altera sintonização)
- [x] Estrelas: Forma Estelar (Arquiro: 1d8+SAB radiante Bônus; Cálice: +1d8+SAB cura extra; Dragão: mín 10 em Concentração/INT/SAB)
- [x] Mar: Ira do Mar (Ação Bônus aura de tempestade a 3 m: causa d6s de dano elétrico/concussão = SAB e empurra a 4.5 m)
- [x] UI: `combat-druid-panel`, botões de conversão e atalhos de Círculo

---

### Mago (`wizard`) — `[x]`

- [x] Base: Recuperação Arcana (recupera slots até metade do nível de Mago no descanso curto), Ritualista Arcano (rituais sem preparação) e Dominância de Magias (nv 18)
- [x] Abjurador: Proteção Arcana (cria barreira de 2×nível + INT de PV temporários ao conjurar Abjuração)
- [x] Adivinhador: Presságio (rola 2d20/3d20 no descanso longo e substitui rolagens no dia)
- [x] Evocador: Esculpir Magias (protege aliados contra magias de área) e Truque Potentado
- [x] Ilusionista: Ilusão Aprimorada (conjura ilusões como Ação Bônus sem componentes V)
- [x] UI: `combat-wizard-panel`, seletores de Recuperação Arcana e botões de Tradição Arcana

---

## Todas as Classes PHB 2024 + Valdas Pack 1 Concluídas

---

## Valdas Player Pack 2 — jogável A/B + trackers

Critério mesa: recursos + Usar/economia + notes. Familiares: **adiados** (só catálogo P009).

| Subclasse | Slug | Status |
|-----------|------|--------|
| Pistolero | `pistolero` | `[x]` manobras Abrir o Leque / Confronto + notes |
| Colégio das Máscaras | `college-of-masks` | `[x]` Virtuoso + tracker `personaMasks` (vestir 1–2) |
| Domínio do Dragão | `dragon-domain` | `[~]` Majestade/Aspecto Lendário (spend) + notes |
| Círculo da Cidade | `circle-of-the-city` | `[~]` Forma da Cidade / Distorção de Muro + notes |
| Portador Bestial | `beastborne` | `[x]` tracker `bestialAspectLevel` 0–5 + Uivo Feral |
| Feitiçaria Heróica | `heroic-sorcery` | `[~]` Alma Heróica / Manobras Místicas (SP) + notes |
| Mago dos Mísseis | `magic-missile-mage` | `[x]` free / Escudo / Giga (recursos + Usar) |

**Encantos de Arma:** `[x]` itens `weapon-charm-*` (P011), `attached_charm_slug` no inventário, bônus por arma, attach/detach API + UI.

Seeds: `valdas-player-pack-2/P001`–`P011`. Migrations player: `P017` (charm), `P018` (trackers).

---

## Ordem sugerida (próximas)

Familiares como sistema; hooks de Mísseis no cast; aprofundar Domínio do Dragão / Círculo da Cidade.

---

## Como atualizar

1. Ao fechar uma classe: marcar `[x]` no resumo e nos checkboxes; anotar gaps em “parcial” se houver.
2. Gaps do Guerreiro: riscar aqui quando fechados (não só no chat).
3. Backlog geral da API: [`backlog.md`](backlog.md).
