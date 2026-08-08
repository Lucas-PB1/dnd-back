# Economia de combate de talentos

**Status:** implementado (auditoria 89/89 slugs no catálogo).

Espelha espécie/classe: usável na Economia + recursos; passivo nas Passivas; magias/ASI já cobertos ficam de fora.

## Auditoria (catálogo completo)

- **PHB:** 75 · **Valdas:** 4 · **Pack2:** 8 · **Gunslinger:** 2 → **89**
- **`akimbo`:** referenciado só em opção órfã (`G028`); **não existe** em `phb_feat` — fora do escopo.
- Seeds: [`S071_phb_feat_resource_grant.sql`](../seeds/phb/S071_phb_feat_resource_grant.sql) + [`C012_phb_feat_economy_action.sql`](../seeds/combat/C012_phb_feat_economy_action.sql)
- Script: `npm run` via `node scripts/seed-feat-economy.mjs` (após migrate)

### Economia (~42 linhas)

Lucky, Healer, Observant, Keen Mind, War Caster, Defensive Duelist, Polearm Master (×2), GWM Cortar, Dual Wielder, Shield Master (×2), Sentinel, Durable, Interception, Protection, Telekinetic, Mage Slayer, Ritual Caster, Charger, Chef, Poisoner, boons de combate (Combat Prowess, Recovery ×2, Energy Redirect, Speed, Dimensional, Fate, Night Spirit), Field Commander, Iron Hero, Familiar Distraction, Showman, Spellblade Channel, Shock Trooper, Magitech, Metabolistic (×2).

### Passivas (`featCombatNotes`)

Alert, Savage Attacker, Tavern Brawler, GWM +PB, Sharpshooter, Crossbow Expert, Mobile, Crusher/Piercer/Slasher, estilos de luta passivos, Heavy/Medium Armor Master, Mounted, Grappler, Stealthy, Durable (morte), Athlete/Charger dash, Elemental Adept, Spell Sniper, Poisoner ignore res., Mage Slayer concentração, Sentinel halt, boons passivos, Valdas/Pack2/Gun passivos relevantes.

### Skip (já cobertos / sem bucket)

ASI, Skilled, Skill Expert, Resilient, armaduras/treino, Magic Initiate / Fey / Shadow / Telepathic / Pyromaniac / Gun Mage Adept / Familiar (magias), Musician / Inspiring Leader (descanso), Tough (HP), Weapon Master, Martial Weapon Training, Artisan, Actor (RP), Showman Atuação (prof), Flex Caster (nota passiva + Magias).

## Critério

Lucky: free + tracker PB; Usar gasta ponto. Polearm/GWM/Interceptação na Economia se o feat estiver na ficha. Passivas com lembretes.
