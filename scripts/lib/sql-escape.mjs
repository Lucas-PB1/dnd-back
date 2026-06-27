/** Utilitários para gerar literais SQL PostgreSQL. */

export function sqlStr(value) {
  if (value === null || value === undefined) return "NULL";
  return `'${String(value).replace(/'/g, "''")}'`;
}

export function sqlBool(value) {
  if (value === null || value === undefined) return "NULL";
  return value ? "TRUE" : "FALSE";
}

export function sqlInt(value) {
  if (value === null || value === undefined || value === "") return "NULL";
  const n = Number(value);
  if (Number.isNaN(n)) return "NULL";
  return String(n);
}

export function sqlJson(value) {
  if (value === null || value === undefined) return "NULL";
  return `${sqlStr(JSON.stringify(value))}::jsonb`;
}

export function sqlTextArray(values) {
  if (!values?.length) return "NULL";
  return `ARRAY[${values.map(sqlStr).join(", ")}]::text[]`;
}

export function sqlAbilityArray(values) {
  if (!values?.length) return "NULL";
  return `ARRAY[${values.map((v) => `${sqlStr(v)}::rpg.ability_id`).join(", ")}]`;
}

/** Gera INSERT em lote com ON CONFLICT opcional. */
export function batchInsert(table, columns, rows, { conflict, updates } = {}) {
  if (!rows.length) return "";
  const cols = columns.join(", ");
  const values = rows
    .map((row) => {
      const vals = columns.map((col) => row[col]);
      return `(${vals.join(", ")})`;
    })
    .join(",\n  ");

  let sql = `INSERT INTO ${table} (${cols})\nVALUES\n  ${values}`;
  if (conflict) {
    sql += `\nON CONFLICT ${conflict}`;
    if (updates?.length) {
      sql += ` DO UPDATE SET ${updates.map((c) => `${c} = EXCLUDED.${c}`).join(", ")}`;
    } else {
      sql += " DO NOTHING";
    }
  }
  return `${sql};\n`;
}
