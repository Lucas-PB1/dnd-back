import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import "dotenv/config";
import pg from "pg";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const sql = fs.readFileSync(
  path.join(__dirname, "../database/seeds/combat/C010_phb_class_panel_action.sql"),
  "utf8",
);
const client = new pg.Client({ connectionString: process.env.DATABASE_URL });
await client.connect();
await client.query(sql);
const { rows } = await client.query(
  `SELECT panel_key FROM rpg.phb_class_panel_action
   WHERE panel_key LIKE 'wizard%' ORDER BY 1`,
);
console.log(rows);
await client.end();
