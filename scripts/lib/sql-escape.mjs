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

export function sqlIntArray(values) {
  if (!values?.length) return "NULL";
  return `ARRAY[${values.map((v) => sqlInt(v)).join(", ")}]::integer[]`;
}

export function sqlTimestamp(value) {
  if (value === null || value === undefined) return "NULL";
  return `${sqlStr(value)}::timestamptz`;
}

/** Subquery: id interno a partir do slug canônico (JSON/API). */
export function sqlRef(table, slug) {
  if (slug === null || slug === undefined || slug === "") return "NULL";
  return `(SELECT id FROM rpg.${table} WHERE slug = ${sqlStr(slug)})`;
}

/** Pacote de equipamento inicial da classe. */
export function sqlClassPackageRef(classSlug, packageSlug) {
  return `(SELECT p.id FROM rpg.phb_class_starting_package p
    JOIN rpg.phb_class c ON c.id = p.class_id
    WHERE c.slug = ${sqlStr(classSlug)} AND p.slug = ${sqlStr(packageSlug)})`;
}

/** Pacote de equipamento inicial do antecedente. */
export function sqlBackgroundPackageRef(backgroundSlug, packageSlug) {
  return `(SELECT p.id FROM rpg.phb_background_starting_package p
    JOIN rpg.phb_background b ON b.id = p.background_id
    WHERE b.slug = ${sqlStr(backgroundSlug)} AND p.slug = ${sqlStr(packageSlug)})`;
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
