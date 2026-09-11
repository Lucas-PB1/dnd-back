/** Notas dinâmicas de patrono. Estáticas → catálogo. */
import { healingLightDiceMax } from './rules';

export function addWarlockSubclassNotes(
  notes: string[],
  subclassSlug: string | null | undefined,
  level: number,
): void {
  if (level < 3) return;

  if (subclassSlug === 'celestial') {
    notes.push(
      `Patrono Celestial: Luz Medicinal (reserva de ${healingLightDiceMax(level)}d6; Ação Bônus gasta 1–CAR d6s para curar).`,
    );
  }
  if (subclassSlug === 'archfey') {
    notes.push(
      level >= 6
        ? 'Patrono Arquifada: Passos Feéricos (usos = CAR) — Passo Nebuloso + efeito (Provocante, Revigorante, Desvanecedor ou Terrível).'
        : 'Patrono Arquifada: Passos Feéricos (usos = CAR) — Passo Nebuloso + efeito (Provocante ou Revigorante).',
    );
  }
}
