import { hasProperty } from './weapon-attack-predicates';
import type {
  EquippedWeaponPiece,
  WeaponAttackRole,
} from './weapon-attack.types';

export function collectAttackNoteExtras(input: {
  piece: EquippedWeaponPiece;
  role: WeaponAttackRole;
  versatile2h: boolean;
  isFirearm: boolean;
  greatWeaponFighting: boolean;
  masteryActive: boolean;
  masterySlug: string | null;
  masteryName: string | null;
  nickUsesAttackAction: boolean;
  attackDisadvantage: boolean;
  critThreshold: number;
  brutalDice: string | null;
  monkMartialArtsDie: string | null;
}): string[] {
  const noteExtras: string[] = [];
  const { piece } = input;
  if (hasProperty(piece, 'versatile')) {
    noteExtras.push(
      input.versatile2h ? 'versátil (2 mãos)' : 'versátil (1 mão)',
    );
  }
  if (input.isFirearm) noteExtras.push('arma de fogo');
  if (hasProperty(piece, 'recoil')) noteExtras.push('recuo');
  if (hasProperty(piece, 'reload')) {
    const cap = piece.reloadCapacity;
    noteExtras.push(cap != null ? `recarga (${cap})` : 'recarga');
  }
  if (input.role === 'light_bonus') {
    noteExtras.push(
      input.nickUsesAttackAction
        ? 'ataque adicional (Ágil · ação Atacar)'
        : 'ataque adicional (Leve)',
    );
  }
  if (input.role === 'dual_bonus') {
    noteExtras.push('ataque adicional (Ambidestro)');
  }
  if (input.greatWeaponFighting) noteExtras.push('Luta com Armas Grandes');
  if (input.masteryActive && input.masteryName) {
    noteExtras.push(`Maestria: ${input.masteryName}`);
  }
  if (input.masteryActive && input.masterySlug === 'scatter') {
    noteExtras.push('Dispersão: sem desv. a 1,5 m');
  }
  if (input.masteryActive && input.masterySlug === 'sighted') {
    noteExtras.push('Mira: sem desv. a longa distância');
  }
  if (input.masteryActive && input.masterySlug === 'automatic') {
    noteExtras.push('Automática: opção 2 ataques c/ desv.');
  }
  if (input.masteryActive && input.masterySlug === 'explode') {
    noteExtras.push('Explosiva: opção esfera 1,5 m');
  }
  if (input.attackDisadvantage) {
    noteExtras.push('desvantagem (Pesada / tamanho Pequeno)');
  }
  if (input.critThreshold < 20) {
    noteExtras.push(`crítico ${input.critThreshold}–20`);
  }
  if (input.brutalDice) noteExtras.push(`Golpe Brutal ${input.brutalDice}`);
  if (input.monkMartialArtsDie) {
    noteExtras.push(`Artes Marciais ${input.monkMartialArtsDie}`);
  }
  return noteExtras;
}
