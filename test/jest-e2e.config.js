/** @type {import('jest').Config} */
module.exports = {
  moduleFileExtensions: ['js', 'json', 'ts'],
  rootDir: '.',
  testEnvironment: 'node',
  testRegex: '.e2e-spec.ts$',
  testTimeout: 60000,
  transform: {
    '^.+\\.(t|j)s$': 'ts-jest',
  },
  moduleNameMapper: {
    '^@/(.*)$': '<rootDir>/../src/$1',
    '^@entities/(.*)$': '<rootDir>/../src/entities/$1',
    '^@common/(.*)$': '<rootDir>/../src/common/$1',
    '^@catalog/(.*)$': '<rootDir>/../src/catalog/$1',
    '^@game/(.*)$': '<rootDir>/../src/game/$1',
    '^@identity/(.*)$': '<rootDir>/../src/identity/$1',
    '^@config/(.*)$': '<rootDir>/../src/config/$1',
  },
};
