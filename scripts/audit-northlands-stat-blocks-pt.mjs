/**
 * Audita inglês residual nos stat blocks traduzidos.
 * Uso: node scripts/audit-northlands-stat-blocks-pt.mjs [--kind=creature|vehicle]
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const JSON_IN = path.join(__dirname, '../docs/source/northlands-stat-blocks.json');

/** Marcadores D&D / regras ainda em EN. */
const EN_MARKERS =
  /\b(the|and|with|when|each|until|within|against|while|creatures?|targets?|attacks?|damage|saving throws?|failed|successful|failure|success|advantage|disadvantage|conditions?|understands|cannot speak|can't speak|can choose|can make|can expend|immediately|legendary|recharge|grappled|restrained|poisoned|stunned|frightened|half damage|long rest|critical hit|escape dc|straight toward|plus \d|subjected to|following effect|completes a|end this|regains all|expended uses|another creature|in lair|foot line|d20 tests|northern tongue|perception|stealth|deception|intimidation|survival|persuasion| makes | in any combination| or smaller| or larger| can see| can only| at a time| with this ability| if the target| has the | has advantage| has disadvantage| feel deeply|rolling saves|burrows \d|poison damage|necrotic damage|psychic damage|fire damage|cold damage|lightning damage|acid damage|force damage|thunder damage|radiant damage|bludgeoning damage|slashing damage|piercing damage|melee attack|ranged attack|attack roll|saving throw:|constitution saving|strength saving|dexterity saving|wisdom saving|charisma saving|intelligence saving|reach \d|range \d|\d ft\.|\d-foot|adjacent to|straight line|moving war|fewer than|next turn|next round|end of the|start of the|by 5 or more|speed reduced|current speed|armor class|dexterity saving throws|grants creatures|listed speed|sailing speed|against the wind|when rowing|raise their shields|in defense|this grants|halved until|release a volley|arrows at|that point|fail the saving|rowers raise|archers release|driver of|worgs pulling|trampled by|control the sled|in battle|random direction|weapon damage|melee weapon|ranged attacks|riding on|not also on|mount or vehicle|take actions|same action|multiple times|can't move|dash action|fire ballista|shield wall|volley|hoof attack|divine strike|sled trample|worg attack|bulky construction|mounted vantage|skull shield|sails and rowing|deep keel|immune|poison, psychic|skills|senses|languages|blinded|deafened|exhaustion|incapacitated|paralyzed|petrified|prone|unconscious)\b/gi;

/** Vocabulário EN comum que não deveria aparecer em texto PT final. */
const EN_QUALITY =
  /\b(deals|objects|structures|curls|begins|lasts|wide|None|Multiattack|Bludgeoning|Piercing|Slashing|Rend|Burning|Spiked|Armored|Crushing|form|roll up|or more|it fica|it can|it is|it has|its turn|its Armored|this effect|double dano|doesn't|isn't|aren't|into its|held in|considered|repeats|immunity a this|half dano|single source|Resistance to|shape-shifts|returns to|reverts|unless it|constantly oozes|starts its|hold its breath|doesn't function|dies only|wearing or carrying|isn't transformed|is subjected|hollow body|gains a new body|becoming active|where it fell|put to rest|knew in life|whenever it|triggering|substitute|For 1 minute|away from|swims up|deals Bludgeoning|choice based|Effect:|Trigger:|Response:|takes Acid|from o |com o |of where|random espaço|one do |do following|condição envenenados|it realiza|it sofre|it moves|it chooses|it dies|it deixa|it deve|or it |If it |with it |com it )\b/gi;

/** Nomes de traits/ações ainda em inglês (padrões EN explícitos). */
const EN_ABILITY_NAME =
  /\b(of the|of Greed|of Avarice|of Evil|of Speed|of Luck|Action Uses|Shape-Shift|Change Shape|Retributive|Fate's|for Aid|to Arms|the North|Form Only|Wild Shape|Misty Step|Spellcasting|Multiattack|Legendary Resistance|Ever Vigilant|Too Big to Notice|Material Bound|Ancient Imprisonment|Grasping Thorns|Grasping Vines|Illusory Appearance|Bewildering Harmonics|Ventriloquistic Step|Cacophonous Note|Earth Rending|Rotten Shake|Fleshwebs|Icy Sweep|Hoary Breath|Absorb Lightning|Electrifying Flesh|Mystical Chain|Frigid Aura|Icy Carapace|Corpse Breath|Torrential Tune|Burst of Speed|Shot of Luck|Earth Wyrm|Rock Catching|Static Discharge|Storm Absorption|Minor Elemental|Faces of Evil|Reeking Mist|Call for Aid|Call to Arms|Divine Aid|Divine Flame|Divine Orders|Eldritch Burst|Swift Hunter|Lightning Staff|Static Fling|Fast Talk)\b/i;

function isEnglishAbilityName(name) {
  return EN_ABILITY_NAME.test(name);
}

function collectText(block) {
  const chunks = [block.name, block.subtitle, block.creatureType];
  for (const trait of block.traits ?? []) {
    chunks.push(trait.name, trait.description);
  }
  for (const action of block.actions ?? []) {
    chunks.push(action.name, action.description, action.damageExpression);
  }
  return chunks.filter(Boolean).join('\n');
}

function collectAbilityNames(block) {
  const names = [];
  for (const trait of block.traits ?? []) {
    if (trait.name && !/^(Perícias|Sentidos|Idiomas|Imunidades|Regras de turno)$/i.test(trait.name)) {
      names.push(trait.name);
    }
  }
  for (const action of block.actions ?? []) {
    if (action.name) names.push(action.name);
  }
  return names;
}

function findMatches(text, pattern) {
  return [...text.matchAll(pattern)].map((m) => (m[1] ?? m[0]).toLowerCase());
}

function main() {
  const kindFilter = process.argv.find((arg) => arg.startsWith('--kind='))?.split('=')[1];
  const data = JSON.parse(fs.readFileSync(JSON_IN, 'utf8'));
  const blocks = [...data.creatures, ...data.vehicles].filter(
    (block) => !kindFilter || block.kind === kindFilter,
  );
  const hits = [];

  for (const block of blocks) {
    const text = collectText(block);
    const markerMatches = findMatches(text, EN_MARKERS);
    const qualityMatches = findMatches(text, EN_QUALITY);
    const englishNames = collectAbilityNames(block).filter((name) => isEnglishAbilityName(name));
    const matches = [...markerMatches, ...qualityMatches, ...englishNames.map((n) => `name:${n}`)];
    if (matches.length) {
      hits.push({
        slug: block.slug,
        count: matches.length,
        samples: [...new Set(matches)].slice(0, 8),
      });
    }
  }

  hits.sort((a, b) => b.count - a.count);
  const scopeLabel = kindFilter ? `${kindFilter}s` : 'blocos';
  console.log(`Blocos com inglês residual: ${hits.length}/${blocks.length} (${scopeLabel})`);
  for (const hit of hits.slice(0, 25)) {
    console.log(`  ${hit.count.toString().padStart(3)}  ${hit.slug}  →  ${hit.samples.join(', ')}`);
  }

  const totalMarkers = hits.reduce((sum, h) => sum + h.count, 0);
  console.log(`\nTotal marcadores: ${totalMarkers}`);
  process.exit(hits.length ? 1 : 0);
}

main();
