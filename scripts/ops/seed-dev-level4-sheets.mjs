import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

const here = path.dirname(fileURLToPath(import.meta.url));

function loadEnvFile(filePath) {
  if (!fs.existsSync(filePath)) return;
  for (const line of fs.readFileSync(filePath, "utf8").split(/\r?\n/)) {
    const trimmed = line.trim();
    if (!trimmed || trimmed.startsWith("#")) continue;
    const eq = trimmed.indexOf("=");
    if (eq <= 0) continue;
    const key = trimmed.slice(0, eq).trim();
    let value = trimmed.slice(eq + 1).trim();
    if (
      (value.startsWith('"') && value.endsWith('"')) ||
      (value.startsWith("'") && value.endsWith("'"))
    ) {
      value = value.slice(1, -1);
    }
    if (process.env[key] === undefined) process.env[key] = value;
  }
}

loadEnvFile(path.resolve(here, "../../.env"));
loadEnvFile(path.resolve(here, "../../../dnd-front/.env.local"));
loadEnvFile(path.resolve(here, "../../../dnd-front/.env"));

const CLASSES = [
  { name: "Bárbaro", slug: "barbarian", subclass: "berserker", primary: "forca" },
  { name: "Bardo", slug: "bard", subclass: "valor", primary: "carisma" },
  { name: "Bruxo", slug: "warlock", subclass: "archfey", primary: "carisma" },
  { name: "Clérigo", slug: "cleric", subclass: "life", primary: "sabedoria" },
  { name: "Druida", slug: "druid", subclass: "moon", primary: "sabedoria" },
  { name: "Feiticeiro", slug: "sorcerer", subclass: "aberrant", primary: "carisma" },
  { name: "Guerreiro", slug: "fighter", subclass: "psi-warrior", primary: "forca" },
  { name: "Ladino", slug: "rogue", subclass: "thief", primary: "destreza" },
  { name: "Mago", slug: "wizard", subclass: "evoker", primary: "inteligencia" },
  { name: "Monge", slug: "monk", subclass: "open-hand", primary: "destreza" },
  { name: "Paladino", slug: "paladin", subclass: "devotion", primary: "forca" },
  { name: "Patrulheiro", slug: "ranger", subclass: "hunter", primary: "destreza" },
];

const FARMER_SKILLS = new Set(["animal-handling", "nature"]);

function apiBase() {
  return (process.env.NEXT_PUBLIC_API_URL ?? "http://localhost:3000").replace(
    /\/$/,
    "",
  );
}

function scoresFor(primary) {
  const remaining = [15, 14, 13, 12, 10, 8];
  const result = {
    forca: 8,
    destreza: 8,
    constituicao: 8,
    inteligencia: 8,
    sabedoria: 8,
    carisma: 8,
  };
  result[primary] = remaining.shift();
  const rest = [
    "constituicao",
    "destreza",
    "forca",
    "sabedoria",
    "inteligencia",
    "carisma",
  ].filter((key) => key !== primary);
  for (const key of rest) result[key] = remaining.shift();
  return result;
}

async function json(res) {
  const text = await res.text();
  try {
    return text ? JSON.parse(text) : null;
  } catch {
    return text;
  }
}

async function request(method, url, token, body) {
  const headers = { Accept: "application/json" };
  if (token) headers.Authorization = `Bearer ${token}`;
  if (body !== undefined) headers["Content-Type"] = "application/json";
  const res = await fetch(url, {
    method,
    headers,
    body: body !== undefined ? JSON.stringify(body) : undefined,
  });
  const payload = await json(res);
  if (!res.ok) {
    throw new Error(
      `${method} ${url} → ${res.status} ${JSON.stringify(payload)}`,
    );
  }
  return payload;
}

async function login() {
  const email =
    process.env.CYPRESS_LOGIN_EMAIL ?? process.env.NEXT_PUBLIC_DEV_LOGIN_EMAIL;
  const password =
    process.env.CYPRESS_LOGIN_PASSWORD ??
    process.env.NEXT_PUBLIC_DEV_LOGIN_PASSWORD;
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY;
  if (!email || !password || !supabaseUrl || !supabaseKey) {
    throw new Error("Credenciais de login/Supabase ausentes no .env");
  }
  const payload = await request(
    "POST",
    `${supabaseUrl}/auth/v1/token?grant_type=password`,
    null,
    { email, password },
  );
  const token = payload?.access_token;
  if (!token) throw new Error("Login sem access_token");
  return token;
}

function authJson(token, method, path, body) {
  return request(method, `${apiBase()}${path}`, token, body);
}

async function paged(token, path) {
  const payload = await authJson(token, "GET", path);
  return payload?.data ?? payload ?? [];
}

function pickSkills(pool, count) {
  return pool
    .map((row) => row.slug)
    .filter((slug) => slug && !FARMER_SKILLS.has(slug))
    .slice(0, count);
}

function pickFeatureOptions(groups) {
  return (groups ?? [])
    .map((group) => {
      const pick = (group.values ?? []).find((value) => value.valueId);
      if (!pick) return null;
      return { optionKey: group.optionKey, valueId: pick.valueId };
    })
    .filter(Boolean);
}

function equipmentPayload(source, rows) {
  const byPackage = new Map();
  for (const row of rows) {
    const slug = row.packageSlug;
    if (!slug) continue;
    if (!byPackage.has(slug)) byPackage.set(slug, []);
    byPackage.get(slug).push(row);
  }
  const ranked = [...byPackage.entries()].sort((a, b) => {
    const score = (pack) =>
      pack.filter((row) => row.itemSlug).length -
      (pack.every((row) => row.goldAmount && !row.itemSlug) ? 100 : 0);
    return score(b[1]) - score(a[1]);
  });
  const [packageSlug, pack] = ranked[0] ?? [];
  if (!packageSlug) return [];
  const items = [{ source, packageSlug, sortOrder: 0 }];
  pack
    .filter((row) => row.itemSlug)
    .forEach((row, index) => {
      items.push({
        source,
        packageSlug,
        itemSlug: row.itemSlug,
        quantity: row.quantity ?? 1,
        sortOrder: index + 1,
      });
    });
  return items;
}

function matchesMastery(propertySlugs, eligibility) {
  if (eligibility === "melee") {
    return !(
      propertySlugs.includes("ammunition") && !propertySlugs.includes("thrown")
    );
  }
  if (eligibility === "ranged") return propertySlugs.includes("ammunition");
  return true;
}

function isProficient(weapon, proficiencySlugs) {
  if (
    proficiencySlugs.includes("armas-marciais") &&
    weapon.category === "martial"
  ) {
    return true;
  }
  if (
    proficiencySlugs.includes("armas-simples") &&
    weapon.category === "simple"
  ) {
    return true;
  }
  const props = (weapon.propertyDetails ?? []).map((item) => item.slug);
  if (
    proficiencySlugs.includes("armas-marciais-acuidade-ou-leves") &&
    weapon.category === "martial" &&
    (props.includes("finesse") || props.includes("light"))
  ) {
    return true;
  }
  return false;
}

async function masteryWeapons(token, classSlug, eligibility, proficiencySlugs) {
  const weapons = await paged(token, "/weapons?limit=100");
  return weapons
    .filter((weapon) => weapon.mastery)
    .filter((weapon) =>
      matchesMastery(
        (weapon.propertyDetails ?? []).map((item) => item.slug),
        eligibility,
      ),
    )
    .filter((weapon) => isProficient(weapon, proficiencySlugs ?? []))
    .map((weapon) => ({ slug: weapon.slug, name: weapon.name }));
}

function pickMastery(weapons, character, slots) {
  const taken = new Set(
    (character.classOptions ?? [])
      .filter((option) => option.optionKey.startsWith("masteryWeapon"))
      .map((option) => option.valueId),
  );
  const available = weapons.filter((weapon) => !taken.has(weapon.slug));
  return slots.map((slot, index) => {
    const weapon = available[index];
    if (!weapon) {
      throw new Error(`Sem arma de maestria para ${slot.optionKey}`);
    }
    taken.add(weapon.slug);
    return { optionKey: slot.optionKey, valueId: weapon.slug };
  });
}

function proficientSkills(character) {
  const slugs = [
    ...(character.classSkillSlugs ?? []),
    ...(character.backgroundSkillSlugs ?? []),
  ];
  return [...new Set(slugs)];
}

function pickExpertise(character, slots) {
  const pool = proficientSkills(character);
  const taken = new Set(
    (character.classOptions ?? [])
      .filter((option) => /^expertiseSkill\d+$/.test(option.optionKey))
      .map((option) => option.valueId),
  );
  return slots.map((slot) => {
    const valueId = pool.find((slug) => !taken.has(slug));
    if (!valueId) throw new Error(`Sem perícia para ${slot.optionKey}`);
    taken.add(valueId);
    return { optionKey: slot.optionKey, valueId };
  });
}

async function pickSubclassOptions(token, character, groups, slots) {
  const takenKeys = new Set(
    (character.subclassOptions ?? []).map((option) => option.optionKey),
  );
  const pending = slots.filter((slot) => !takenKeys.has(slot.optionKey));
  const used = new Set(
    (character.subclassOptions ?? []).map((option) => option.valueId),
  );
  const additions = [];
  for (const slot of pending) {
    const group = groups.find((item) => item.optionKey === slot.optionKey);
    const staticPick = (group?.values ?? []).find(
      (value) => value.valueId && !used.has(value.valueId),
    );
    if (staticPick) {
      used.add(staticPick.valueId);
      additions.push({ optionKey: slot.optionKey, valueId: staticPick.valueId });
      continue;
    }
    const maxLevel = group?.spellMaxLevel ?? 9;
    const schools = new Set(group?.spellSchoolSlugs ?? []);
    const spells = await paged(
      token,
      `/classes/${character.classSlug}/spells?maxLevel=${maxLevel}&limit=100`,
    );
    const minLevel = maxLevel === 0 ? 0 : 1;
    const spell = spells.find(
      (row) =>
        row.slug &&
        row.level >= minLevel &&
        row.level <= maxLevel &&
        !used.has(row.slug) &&
        (schools.size === 0 ||
          (row.schoolSlug != null && schools.has(row.schoolSlug))),
    );
    if (!spell) {
      throw new Error(`Sem magia para ${slot.optionKey}`);
    }
    used.add(spell.slug);
    additions.push({ optionKey: slot.optionKey, valueId: spell.slug });
  }
  return additions;
}

async function createLevel1(token, cls) {
  const detail = await authJson(token, "GET", `/classes/${cls.slug}`);
  const skills = await paged(token, `/classes/${cls.slug}/skills?limit=50`);
  let featureGroups = [];
  try {
    featureGroups = await paged(
      token,
      `/classes/${cls.slug}/options?level=1&limit=50`,
    );
  } catch {
    featureGroups = [];
  }
  const progression = await paged(
    token,
    `/classes/${cls.slug}/progression?limit=20`,
  );
  const masteryCount =
    progression.find((row) => row.level === 1)?.weaponMastery ?? 0;
  const classSkillSlugs = pickSkills(skills, detail.skillChoiceCount ?? 0);
  const featureOptions = pickFeatureOptions(featureGroups);
  const expertiseSlots =
    cls.slug === "rogue"
      ? [{ optionKey: "expertiseSkill1" }, { optionKey: "expertiseSkill2" }]
      : [];
  const masterySlots = Array.from({ length: masteryCount }, (_, index) => ({
    optionKey: `masteryWeapon${index + 1}`,
  }));
  const weapons = masterySlots.length
    ? await masteryWeapons(
        token,
        cls.slug,
        detail.weaponMasteryEligibility,
        detail.weaponProficiencySlugs,
      )
    : [];
  const stub = {
    classSlug: cls.slug,
    classSkillSlugs,
    backgroundSkillSlugs: [...FARMER_SKILLS],
    classOptions: [],
  };
  const classOptions = [
    ...featureOptions,
    ...pickExpertise(stub, expertiseSlots),
    ...pickMastery(weapons, stub, masterySlots),
  ];
  const classEq = await paged(token, `/classes/${cls.slug}/equipment?limit=100`);
  const bgEq = await paged(token, `/backgrounds/farmer/equipment?limit=100`);
  const languageSlugs = [
    "common",
    "dwarvish",
    "elvish",
    ...(cls.slug === "druid" ? ["druidic"] : []),
    ...(cls.slug === "rogue" ? ["thieves-cant", "giant"] : []),
  ];
  const body = {
    name: `${cls.name} Nv4`,
    classSlug: cls.slug,
    speciesSlug: "dwarf",
    backgroundSlug: "farmer",
    level: 1,
    abilityGenerationMethodSlug: "standard-array",
    abilityScores: scoresFor(cls.primary),
    classSkillSlugs,
    languageSlugs,
    backgroundAbilityBoostMode: "plus2plus1",
    backgroundAbilityBoostPlus2Slug: "constituicao",
    backgroundAbilityBoostPlus1Slug: "forca",
    speciesChoices: [{ choiceKind: "dwarf_culture", choiceSlug: "phb" }],
    classOptions,
    equipment: [
      ...equipmentPayload("class", classEq),
      ...equipmentPayload("background", bgEq),
    ],
  };
  if (cls.slug === "fighter") {
    const style =
      (detail.fightingStyleSlugs ?? []).find((slug) => slug === "defense") ??
      detail.fightingStyleSlugs?.[0];
    if (!style) throw new Error("Guerreiro sem estilo de luta");
    body.characterFeats = [{ featSlug: style, instanceIndex: 0 }];
  }
  return authJson(token, "POST", "/characters", body);
}

const PREFERRED_MAIN = {
  barbarian: ["greataxe", "battleaxe", "handaxe"],
  bard: ["rapier", "longsword", "shortsword", "dagger"],
  warlock: ["light-crossbow", "shortsword", "dagger", "sickle"],
  cleric: ["mace", "warhammer", "light-crossbow"],
  druid: ["scimitar", "sickle", "quarterstaff"],
  sorcerer: ["light-crossbow", "dagger"],
  fighter: ["longsword", "battleaxe", "greatsword", "greataxe"],
  rogue: ["rapier", "shortsword", "dagger"],
  wizard: ["quarterstaff", "dagger"],
  monk: ["shortsword", "dagger"],
  paladin: ["longsword", "warhammer", "battleaxe"],
  ranger: ["longbow", "shortsword", "dagger"],
};

const TWO_HANDED = new Set([
  "greataxe",
  "greatsword",
  "maul",
  "longbow",
  "heavy-crossbow",
  "pike",
]);

async function refineLoadout(token, characterId, classSlug) {
  const inventory = await authJson(
    token,
    "GET",
    `/characters/${characterId}/inventory`,
  );
  const list = inventory?.items ?? [];
  const slugs = new Set(list.map((row) => row.itemSlug));
  const hasShield = list.some(
    (row) => row.location === "equipped" && row.equipmentSlot === "shield",
  );

  const unequip = async (slug) => {
    if (!slugs.has(slug)) return;
    await authJson(token, "PATCH", `/characters/${characterId}/inventory/${slug}`, {
      location: "backpack",
    });
  };

  const equip = async (slug, equipmentSlot) => {
    if (!slugs.has(slug)) return false;
    await authJson(token, "PATCH", `/characters/${characterId}/inventory/${slug}`, {
      location: "equipped",
      equipmentSlot,
    });
    return true;
  };

  for (const row of list) {
    if (
      row.location === "equipped" &&
      (row.equipmentSlot === "main_hand" || row.equipmentSlot === "off_hand")
    ) {
      await unequip(row.itemSlug);
    }
  }

  let mainSlug = null;
  for (const slug of PREFERRED_MAIN[classSlug] ?? []) {
    if (await equip(slug, "main_hand")) {
      mainSlug = slug;
      break;
    }
  }

  if (!hasShield && mainSlug && !TWO_HANDED.has(mainSlug)) {
    const lightOff = ["dagger", "handaxe"].find(
      (slug) => slugs.has(slug) && slug !== mainSlug,
    );
    if (lightOff) await equip(lightOff, "off_hand");
  }
}

async function levelUpTo(token, characterId, cls, target) {
  let character = await authJson(token, "GET", `/characters/${characterId}`);
  while (character.level < target) {
    const preview = await authJson(
      token,
      "GET",
      `/characters/${characterId}/level-up/preview`,
    );
    const body = {};
    if (preview.subclassRequired) body.subclassSlug = cls.subclass;
    if (character.speciesChoices?.length) {
      body.speciesChoices = character.speciesChoices;
    }
    if (character.classSkillSlugs?.length) {
      body.classSkillSlugs = character.classSkillSlugs;
    }
    const nextSubclass =
      body.subclassSlug ?? character.subclassSlug ?? cls.subclass;
    const needsClassOptions =
      (preview.newClassExpertiseSlots?.length ?? 0) > 0 ||
      (preview.newWeaponMasterySlots?.length ?? 0) > 0;
    if (needsClassOptions) {
      const detail = await authJson(token, "GET", `/classes/${cls.slug}`);
      const weapons =
        (preview.newWeaponMasterySlots?.length ?? 0) > 0
          ? await masteryWeapons(
              token,
              cls.slug,
              detail.weaponMasteryEligibility,
              detail.weaponProficiencySlugs,
            )
          : [];
      body.classOptions = [
        ...(character.classOptions ?? []),
        ...pickExpertise(character, preview.newClassExpertiseSlots ?? []),
        ...pickMastery(weapons, character, preview.newWeaponMasterySlots ?? []),
      ];
    }
    let slots = (preview.newSubclassOptionSlots ?? []).map((slot) => ({
      optionKey: slot.optionKey,
      unlockLevel: slot.unlockLevel,
    }));
    if (slots.length === 0 && preview.subclassRequired && nextSubclass) {
      const groups = await paged(
        token,
        `/subclasses/${nextSubclass}/options?level=${preview.nextLevel}&limit=100`,
      ).catch(() => []);
      slots = groups
        .filter((group) => group.unlockLevel === preview.nextLevel)
        .map((group) => ({
          optionKey: group.optionKey,
          unlockLevel: group.unlockLevel,
        }));
    }
    if (slots.length > 0) {
      const groups = await paged(
        token,
        `/subclasses/${nextSubclass}/options?level=${preview.nextLevel}&limit=100`,
      ).catch(() => []);
      const additions = await pickSubclassOptions(
        token,
        character,
        groups,
        slots,
      );
      body.subclassOptions = [
        ...(character.subclassOptions ?? []),
        ...additions,
      ];
    }
    character = await authJson(
      token,
      "POST",
      `/characters/${characterId}/level-up`,
      body,
    );
  }
  return character;
}

async function main() {
  const token = await login();
  const existing = await authJson(token, "GET", "/characters");
  const rows = Array.isArray(existing) ? existing : [];
  for (const row of rows) {
    await request("DELETE", `${apiBase()}/characters/${row.id}`, token);
  }
  const created = [];
  for (const cls of CLASSES) {
    process.stdout.write(`${cls.name}… `);
    const row = await createLevel1(token, cls);
    const leveled = await levelUpTo(token, row.id, cls, 4);
    await refineLoadout(token, row.id, cls.slug);
    created.push({
      name: leveled.name,
      classSlug: leveled.classSlug,
      subclassSlug: leveled.subclassSlug,
      level: leveled.level,
    });
    console.log(`ok (${leveled.level} ${leveled.subclassSlug ?? "—"})`);
  }
  console.log(JSON.stringify(created, null, 2));
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});
