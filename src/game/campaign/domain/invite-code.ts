import { randomBytes } from 'crypto';

/** Código curto para entrar na campanha (ex.: A3K9MQ). */
export function generateCampaignInviteCode(length = 8): string {
  const alphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
  const bytes = randomBytes(length);
  let code = '';
  for (let i = 0; i < length; i += 1) {
    code += alphabet[bytes[i]! % alphabet.length];
  }
  return code;
}
