import { formatSkirmishAttackLogLine } from './format-skirmish-attack-log';

describe('formatSkirmishAttackLogLine', () => {
  it('details attack and damage dice faces', () => {
    expect(
      formatSkirmishAttackLogLine('Aldric', 'Goblin', {
        critical: true,
        hit: true,
        attackExpression: '1d20+5',
        attackRolls: [20],
        attackTotal: 25,
        targetAc: 12,
        damageTotal: 14,
        damageExpression: '2d8+3',
        damageRolls: [7, 4],
      }),
    ).toBe(
      'Aldric → Goblin: crítico (1d20+5 [20] = 25 vs CA 12) · dano 2d8+3 [7, 4] = 14',
    );
  });

  it('omits damage on a miss', () => {
    expect(
      formatSkirmishAttackLogLine('Aldric', 'Goblin', {
        critical: false,
        hit: false,
        attackExpression: '1d20+5',
        attackRolls: [2],
        attackTotal: 7,
        targetAc: 15,
        damageTotal: null,
        damageExpression: null,
        damageRolls: [],
      }),
    ).toBe('Aldric → Goblin: erro (1d20+5 [2] = 7 vs CA 15)');
  });
});
