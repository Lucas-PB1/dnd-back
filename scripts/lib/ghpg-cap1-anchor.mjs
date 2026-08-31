/** Normaliza anchorIds quebrados do HTML Beyond (tags de acessibilidade). */
export function canonicalAnchorId(anchorId) {
  let s = String(anchorId ?? '');
  s = s.replace(/sense/gi, '').replace(/skill/gi, '');
  s = s.replace(/^Embracethe/i, 'EmbraceThe');
  s = s.replace(/^Inuredtothe/i, 'InuredToThe');
  s = s.replace(/^ShroudOfTheWild/i, 'ShroudoftheWild');
  s = s.replace(/^ShroudoftheWild/i, 'ShroudoftheWild');
  s = s.replace(/^CraftersEye/i, 'CraftersEye');
  s = s.replace(/^CrafterEye/i, 'CraftersEye');
  s = s.replace(/^InbornskillPerception/i, 'InbornPerception');
  s = s.replace(/^InbornPerception/i, 'InbornPerception');
  s = s.replace(/^MovedByFaith/i, 'MovedByFaith');
  s = s.replace(/^MagicalSavant/i, 'MagicalSavvy');
  s = s.replace(/^MagicalSavvy/i, 'MagicalSavvy');
  s = s.replace(/^NaturalAttackFangs/i, 'NaturalAttack');
  s = s.replace(/^NaturalAttackClaws/i, 'NaturalAttack');
  s = s.replace(/^EnemyInMotion/i, 'EnemyInMotion');
  s = s.replace(/^MasterOfDistraction/i, 'MasterOfDistraction');
  s = s.replace(/^TouchOfLife/i, 'TouchOfLife');
  s = s.replace(/^BurstOfSpeed/i, 'BurstOfSpeed');
  s = s.replace(/^CommandingInsight/i, 'CommandingInsight');
  s = s.replace(/^OutOfPhase/i, 'OutofPhase');
  return s;
}

/** @param {readonly { anchorId: string }[]} traits @param {string} anchorId */
export function findTraitByAnchor(traits, anchorId) {
  const canon = canonicalAnchorId(anchorId);
  return traits.find((t) => canonicalAnchorId(t.anchorId) === canon);
}
