/**
 * Valida regras de jogo em todas as fichas geradas (sem PostgreSQL).
 */
import {
  buildAllBlueprints,
  buildCharacter,
  TARGET_CHARACTER_COUNT,
} from "./lib/character-generator.mjs";
import { validateCharacterRules } from "./character-rules.mjs";

const blueprints = buildAllBlueprints();
if (blueprints.length !== TARGET_CHARACTER_COUNT) {
  console.error(
    `✗ ${blueprints.length} blueprints — esperado ${TARGET_CHARACTER_COUNT}`
  );
  process.exit(1);
}

const failures = [];
const coverage = {
  classLevel: new Map(),
  subclassLevel: new Map(),
};

for (let i = 0; i < blueprints.length; i++) {
  const bp = blueprints[i];
  const id = `pc-${String(i + 1).padStart(3, "0")}`;
  const char = buildCharacter({ ...bp, id, name: `Personagem ${String(i + 1).padStart(3, "0")}` });

  const result = validateCharacterRules(char);
  if (!result.ok) {
    failures.push({ id, classId: char.classId, level: char.level, subclassId: char.subclassId, ...result });
  }

  const classKey = `${char.classId}:${char.level}`;
  coverage.classLevel.set(classKey, (coverage.classLevel.get(classKey) ?? 0) + 1);

  if (char.subclassId) {
    const subKey = `${char.classId}:${char.subclassId}:${char.level}`;
    coverage.subclassLevel.set(subKey, (coverage.subclassLevel.get(subKey) ?? 0) + 1);
  }
}

if (failures.length) {
  console.error(`✗ ${failures.length} ficha(s) com inconsistências:\n`);
  for (const f of failures.slice(0, 40)) {
    console.error(
      `  ${f.id} ${f.classId}${f.subclassId ? `/${f.subclassId}` : ""} L${f.level} — [${f.validator}] ${f.reason}`
    );
  }
  if (failures.length > 40) {
    console.error(`  … e mais ${failures.length - 40}`);
  }
  process.exit(1);
}

console.log(`✓ ${blueprints.length} fichas validadas (regras PHB)`);
console.log(`  cobertura classe×nível: ${coverage.classLevel.size} combinações`);
console.log(`  cobertura subclasse×nível: ${coverage.subclassLevel.size} combinações`);
process.exit(0);
