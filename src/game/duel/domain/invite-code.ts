import { randomBytes } from 'crypto';

/** Código curto para entrar no duelo (ex.: A3K9MQ2P). */
export function generateDuelInviteCode(length = 8): string {
  const alphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
  const bytes = randomBytes(length);
  let code = '';
  for (let i = 0; i < length; i += 1) {
    code += alphabet[bytes[i]! % alphabet.length];
  }
  return code;
}
