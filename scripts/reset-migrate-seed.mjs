#!/usr/bin/env node
/**
 * Combined reset + migrate + seed in a single connection/transaction to avoid Supabase caching issues.
 * Seeds are run with autocommit after migrations are committed.
 */
import fs from 'fs';
import path from 'path';
import { loadEnv, rootDir } from './lib/load-env.mjs';
import { createPgClient, maskDatabaseUrl } from './lib/pg-client.mjs';
import { listSqlFiles, migrationVersion } from './lib/sql-files.mjs';

loadEnv();

const url = process.env.SUPABASE_DATABASE_URL;
if (!url) {
  console.error('SUPABASE_DATABASE_URL não definida.');
  process.exit(1);
}

const migrationsDir = path.join(rootDir, 'database/migrations');
const seedsDir = path.join(rootDir, 'database/seeds');

const SEED_PACKS = [
  'phb',
  'subclass',
  'valdas',
  'valdas-gunslinger',
  'valdas-player-pack-2',
  'combat',
];

function listSeedFilesInOrder() {
  const files = [];
  const truncate = path.join(seedsDir, '000_truncate.sql');
  if (fs.existsSync(truncate)) files.push(truncate);

  for (const pack of SEED_PACKS) {
    const packDir = path.join(seedsDir, pack);
    if (!fs.existsSync(packDir)) continue;
    files.push(...listSqlFiles(packDir));
  }

  return files;
}

console.log(`Reset + Migrate + Seed — ${maskDatabaseUrl(url)}`);
const client = createPgClient(url);
await client.connect();

try {
  // Step 1: Drop and recreate schema
  console.log('Dropping schema rpg...');
  await client.query('DROP SCHEMA IF EXISTS rpg CASCADE');
  console.log('Creating schema rpg...');
  await client.query('CREATE SCHEMA rpg');
  await client.query('CREATE EXTENSION IF NOT EXISTS pg_trgm');
  
  // Step 2: Bootstrap schema_migration table
  console.log('Bootstrapping migration tracking...');
  await client.query(`
    CREATE TABLE IF NOT EXISTS rpg.schema_migration (
      version TEXT PRIMARY KEY,
      applied_at TIMESTAMPTZ NOT NULL DEFAULT now()
    );
  `);

  // Step 3: Apply all migrations and seeds in a SINGLE transaction
  const migrationFiles = listSqlFiles(migrationsDir);
  const seedFiles = listSeedFilesInOrder();
  let migrationCount = 0;
  let seedCount = 0;
  
  console.log('Starting single transaction for ALL operations...');
  await client.query('BEGIN');
  
  try {
    // Migrations
    for (const filePath of migrationFiles) {
      const version = migrationVersion(filePath, migrationsDir);
      const sql = fs.readFileSync(filePath, 'utf8');
      const relativeFromRoot = path.relative(rootDir, filePath).replace(/\\/g, '/');
      
      process.stdout.write(`  applying ${relativeFromRoot}... `);
      try {
        await client.query(sql);
        await client.query(
          'INSERT INTO rpg.schema_migration (version) VALUES ($1)',
          [version],
        );
        console.log('ok');
        migrationCount++;
      } catch (err) {
        console.log('failed');
        throw err;
      }
    }
    console.log(`${migrationCount} migrations applied.`);
    
    // Seeds
    console.log('\nSeeding...');
    for (const filePath of seedFiles) {
      const relative = path.relative(rootDir, filePath).replace(/\\/g, '/');
      const sql = fs.readFileSync(filePath, 'utf8');
      
      process.stdout.write(`  seeding ${relative}... `);
      try {
        await client.query(sql);
        console.log('ok');
        seedCount++;
      } catch (err) {
        console.log('failed');
        throw err;
      }
    }
    console.log(`${seedCount} seeds applied.`);
    
    console.log('\nCommitting all operations...');
    await client.query('COMMIT');
  } catch (err) {
    console.log('Rolling back all operations...');
    await client.query('ROLLBACK');
    throw err;
  }
  
  console.log('\nDone!');
} finally {
  await client.end();
}
