export function isDruidClass(classSlug: string | null | undefined): boolean {
  return classSlug === 'druid';
}

export function wildShapeMaxUses(level: number): number {
  if (level < 2) return 0;
  if (level >= 17) return 4;
  if (level >= 6) return 3;
  return 2;
}

export function moonWildShapeTempHp(level: number): number {
  return 3 * level;
}

export function landAidDice(level: number): number {
  if (level >= 14) return 4;
  if (level >= 10) return 3;
  return 2;
}

export function starryFormDice(level: number): string {
  return level >= 10 ? '2d8' : '1d8';
}

export function wrathOfTheSeaRadiusMeters(level: number): number {
  return level >= 6 ? 3 : 1.5;
}

export function wickerboneBehemothNote(level: number): string {
  const shard = level >= 10 ? '2d4' : '1d4';
  const parts = [
    'Beemote de Osso-Vime (10 min ou até Forma Selvagem de novo)',
    'braços = Porrete com Bordão Místico (maestria); Desvantagem em Prestidigitação',
    'Pele-Casca (sem Concentração)',
    `retaliação ${shard} Perfurante a 1,5 m ao ser atingido`,
    'início do turno: regenera metade do dano sofrido desde o turno anterior (máx. 5×PB; não se Inconsciente)',
  ];
  if (level >= 10) {
    parts.push(
      'Ira da Natureza: tamanho Grande; ao Atacar, Resistência Contundente/Perfurante/Cortante até o fim do próximo turno (acaba cedo com Fogo)',
    );
  }
  if (level >= 14) {
    parts.push('braços: maestria Nick além de Slow');
  }
  return `${parts.join(' · ')}. Sem armadura/escudo.`;
}
