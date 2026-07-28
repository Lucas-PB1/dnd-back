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
};
