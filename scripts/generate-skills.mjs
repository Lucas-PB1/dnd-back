/**
 * Gera arquivos individuais de perícias e regras em data/phb/skills/.
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { SKILL_ABILITIES, SKILL_RULES, SKILLS } from "./skill-data.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const skillsDir = path.join(__dirname, "../data/phb/skills");
const rulesDir = path.join(skillsDir, "rules");

const sourceBase = {
  book: "Livro do Jogador 2024",
  language: "pt-BR",
  chapter: 1,
  chapterTitle: "Jogando o Jogo",
  pdfPath: "doc/livro-jogador.pdf",
};

function writeJson(filePath, doc) {
  fs.writeFileSync(filePath, `${JSON.stringify(doc, null, 2)}\n`, "utf8");
}

for (const skill of SKILLS) {
  const doc = {
    $schema: "../../schema/skill.schema.json",
    id: skill.id,
    name: skill.name,
    abilityId: skill.abilityId,
    exampleUses: skill.exampleUses,
    source: {
      ...sourceBase,
      pdfPages: [skill.pdfPages[0], skill.pdfPages[skill.pdfPages.length - 1]],
    },
  };
  if (skill.actionIds) doc.actionIds = skill.actionIds;
  if (skill.knowledgeAreas) doc.knowledgeAreas = skill.knowledgeAreas;
  if (skill.influenceUse) doc.influenceUse = skill.influenceUse;
  if (skill.searchUse) doc.searchUse = skill.searchUse;
  writeJson(path.join(skillsDir, `${skill.id}.json`), doc);
}

const ruleDocs = {
  "proficiency.json": {
    $schema: "../../../schema/skill-rules.schema.json",
    id: "proficiency",
    title: "Proficiências em Perícias",
    source: {
      book: "Livro do Jogador 2024",
      language: "pt-BR",
      chapter: 1,
      chapterTitle: "Jogando o Jogo",
      pdfPath: "doc/livro-jogador.pdf",
      pdfPages: [13, 14],
    },
    summary:
      "A maioria dos testes de atributo envolve o uso de uma perícia. O Mestre tem a palavra final sobre a relevância de uma perícia em uma situação.",
    rules: [
      {
        id: "with-proficiency",
        text: "Se uma criatura for proficiente em uma perícia, aplica seu Bônus de Proficiência a testes de atributo relacionados a essa perícia.",
      },
      {
        id: "without-proficiency",
        text: "Sem proficiência, a criatura ainda pode realizar testes de atributo envolvendo essa perícia, mas não adiciona seu Bônus de Proficiência.",
      },
      {
        id: "example",
        text: "Escalar um penhasco pode exigir um teste de Força (Atletismo). Com proficiência em Atletismo, soma-se o Bônus de Proficiência ao teste de Força.",
      },
      {
        id: "determining",
        text: "Proficiências iniciais de personagens são definidas na criação; proficiências de monstros aparecem no bloco de estatísticas.",
      },
    ],
  },
  "alternate-ability.json": {
    $schema: "../../../schema/skill-rules.schema.json",
    id: "alternate-ability",
    title: "Perícias com Atributos Diferentes",
    source: {
      book: "Livro do Jogador 2024",
      language: "pt-BR",
      chapter: 1,
      chapterTitle: "Jogando o Jogo",
      pdfPath: "doc/livro-jogador.pdf",
      pdfPages: [14, 14],
    },
    summary:
      "Cada proficiência com perícia está vinculada a um teste de atributo. O Mestre pode permitir proficiência em um teste de atributo diferente.",
    alternateAbilityExample: {
      skillId: "intimidation",
      defaultAbilityId: "carisma",
      alternateAbilityId: "forca",
      situation:
        "Intimidar alguém por meio de uma demonstração de força física — teste de Força (Intimidação) em vez de Carisma (Intimidação).",
    },
  },
  "knowledge-areas.json": {
    $schema: "../../../schema/skill-rules.schema.json",
    id: "knowledge-areas",
    title: "Áreas de Conhecimento",
    actionId: "analyze",
    source: {
      book: "Livro do Jogador 2024",
      language: "pt-BR",
      chapter: 1,
      chapterTitle: "Glossário de Regras",
      pdfPath: "doc/livro-jogador.pdf",
      pdfPages: [361, 361],
    },
    intro:
      "Com a ação Analisar, você realiza um teste de Inteligência para examinar memória, livro, pista ou outra fonte e recordar informação importante.",
    bySkill: SKILLS.filter((s) => s.knowledgeAreas).map((s) => ({
      skillId: s.id,
      topics: s.knowledgeAreas.topics,
      creatureTypes: s.knowledgeAreas.creatureTypes ?? [],
    })),
  },
  "search.json": {
    $schema: "../../../schema/skill-rules.schema.json",
    id: "search",
    title: "Procurar",
    actionId: "search",
    source: {
      book: "Livro do Jogador 2024",
      language: "pt-BR",
      chapter: 1,
      chapterTitle: "Glossário de Regras",
      pdfPath: "doc/livro-jogador.pdf",
      pdfPages: [373, 373],
    },
    intro:
      "Com a ação Procurar, você realiza um teste de Sabedoria para perceber algo que não é evidente.",
    bySkill: SKILLS.filter((s) => s.searchUse).map((s) => ({
      skillId: s.id,
      detects: s.searchUse,
    })),
  },
  "influence.json": {
    $schema: "../../../schema/skill-rules.schema.json",
    id: "influence",
    title: "Testes de Influência",
    actionId: "influence",
    source: {
      book: "Livro do Jogador 2024",
      language: "pt-BR",
      chapter: 1,
      chapterTitle: "Glossário de Regras",
      pdfPath: "doc/livro-jogador.pdf",
      pdfPages: [370, 370],
    },
    intro:
      "Com a ação Influenciar, você tenta fazer um monstro realizar algo. Se hesitante, realiza um teste de atributo (CD 15 ou Inteligência do monstro, o que for maior).",
    bySkill: SKILLS.filter((s) => s.influenceUse).map((s) => ({
      skillId: s.id,
      abilityId: s.abilityId,
      interaction: s.influenceUse,
    })),
  },
  "passive-perception.json": {
    $schema: "../../../schema/skill-rules.schema.json",
    id: "passive-perception",
    title: "Percepção Passiva",
    skillId: "perception",
    source: {
      book: "Livro do Jogador 2024",
      language: "pt-BR",
      chapter: 1,
      chapterTitle: "Glossário de Regras",
      pdfPath: "doc/livro-jogador.pdf",
      pdfPages: [372, 372],
    },
    formula: "10 + bônus do teste de Sabedoria (Percepção)",
    advantageModifier: 5,
    disadvantageModifier: -5,
    workedExample:
      "Personagem nível 1, Sabedoria 15 (+2), proficiência em Percepção (+2): Percepção Passiva 14. Com Vantagem nos testes de Percepção, o valor sobe para 19.",
  },
  "expertise.json": {
    $schema: "../../../schema/skill-rules.schema.json",
    id: "expertise",
    title: "Especialização",
    source: {
      book: "Livro do Jogador 2024",
      language: "pt-BR",
      chapter: 1,
      chapterTitle: "Glossário de Regras",
      pdfPath: "doc/livro-jogador.pdf",
      pdfPages: [368, 368],
    },
    rules: [
      "Quando proficiente e com Especialização, dobra o Bônus de Proficiência no teste (salvo se já duplicado por outra característica).",
      "Ao adquirir Especialização, escolha uma perícia na qual já seja proficiente.",
      "Não é possível ter Especialização na mesma perícia mais de uma vez.",
    ],
  },
};

fs.mkdirSync(rulesDir, { recursive: true });
for (const [file, doc] of Object.entries(ruleDocs)) {
  writeJson(path.join(rulesDir, file), doc);
}

const index = {
  $schema: "../../../schema/skills-index.schema.json",
  source: {
    book: "Livro do Jogador 2024",
    language: "pt-BR",
    chapter: 1,
    chapterTitle: "Jogando o Jogo",
    pdfPath: "doc/livro-jogador.pdf",
    pdfPages: [14, 14],
  },
  abilities: SKILL_ABILITIES,
  skillCount: SKILLS.length,
  skills: SKILLS.map((s) => ({
    id: s.id,
    name: s.name,
    ability: s.abilityId,
    file: `${s.id}.json`,
  })),
  rules: SKILL_RULES,
};

writeJson(path.join(skillsDir, "index.json"), index);
console.log(`✓ ${SKILLS.length} perícias + ${Object.keys(ruleDocs).length} regras em data/phb/skills/`);
