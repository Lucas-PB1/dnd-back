/** @type {import('jest').Config} */
module.exports = {
  moduleFileExtensions: ['js', 'json', 'ts'],
  rootDir: 'src',
  testRegex: '.*\\.spec\\.ts$',
  transform: {
    '^.+\\.(t|j)s$': 'ts-jest',
  },
  /**
   * Cobertura do código de aplicação/domínio.
   * DTOs (class-validator) e controllers (wiring HTTP) ficam de fora do unit gate —
   * contrato HTTP → e2e. Gate global 80%.
   */
  collectCoverageFrom: [
    '**/*.(t|j)s',
    '!**/*.module.ts',
    '!**/main.ts',
    '!**/*.spec.ts',
    '!**/index.ts',
    '!**/*.dto.ts',
    '!**/dto/**',
    '!**/*.controller.ts',
  ],
  coverageDirectory: '../coverage',
  coverageReporters: ['text', 'text-summary', 'lcov', 'json-summary'],
  coverageThreshold: {
    global: {
      statements: 80,
      lines: 80,
      functions: 80,
      branches: 80,
    },
  },
  testEnvironment: 'node',
};
