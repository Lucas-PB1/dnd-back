#!/usr/bin/env node
/**
 * Sobe `vercel dev`, aguarda /health e encerra.
 * Requer: npm install, .env com DATABASE_URL (+ SUPABASE_URL se VERCEL=1 no validate).
 *
 * Uso: node scripts/vercel-local-smoke.mjs
 */
import { spawn } from 'node:child_process';
import { setTimeout as sleep } from 'node:timers/promises';

const PORT = process.env.PORT ?? '3000';
const BASE = `http://127.0.0.1:${PORT}`;
const MAX_WAIT_MS = 120_000;

function runVercelDev() {
  const bin = process.platform === 'win32' ? 'npx.cmd' : 'npx';
  return spawn(bin, ['vercel', 'dev', '--listen', PORT, '--yes'], {
    cwd: process.cwd(),
    stdio: ['ignore', 'pipe', 'pipe'],
    env: { ...process.env, FORCE_COLOR: '0' },
    shell: process.platform === 'win32',
  });
}

async function waitForHealth() {
  const started = Date.now();
  while (Date.now() - started < MAX_WAIT_MS) {
    try {
      const response = await fetch(`${BASE}/health`);
      if (response.ok) {
        const body = await response.text();
        return { status: response.status, body };
      }
    } catch {
      // server still booting
    }
    await sleep(2000);
  }
  throw new Error(`Timeout: ${BASE}/health não respondeu em ${MAX_WAIT_MS}ms`);
}

function pipeLogs(child, label) {
  child[label].on('data', (chunk) => {
    process.stdout.write(`[vercel:${label}] ${chunk}`);
  });
}

async function main() {
  console.log(`Iniciando vercel dev em ${BASE} ...`);
  const child = runVercelDev();
  pipeLogs(child, 'stdout');
  pipeLogs(child, 'stderr');

  try {
    const result = await waitForHealth();
    console.log(`\nOK ${BASE}/health → ${result.status}`);
    console.log(result.body);
  } finally {
    child.kill('SIGTERM');
    await sleep(1000);
    if (!child.killed) {
      child.kill('SIGKILL');
    }
  }
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});
