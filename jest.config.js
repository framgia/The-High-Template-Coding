module.exports = {
  verbose: true,
  moduleFileExtensions: ['js', 'ts', 'tsx'],
  preset: 'react-native',
  moduleNameMapper: {
    '\\.(css|less)$': 'identity-obj-proxy',
    '^.+\\.(jpg|jpeg|gif|png|mp4|mkv|avi|webm|swf|wav|mid)$':
      'jest-static-stubs/$1',
  },
  globals: {
    __DEV__: true,
  },
  collectCoverageFrom: [
    '**/src/**/*.{ts,tsx,jsx}',
    '!**/src/**/style.js',
    '!**/src/**/index.js',
    '!**/src/theme/**',
    '!**/android/**',
    '!**/ios/**',
    '!**/node_modules/**',
    '!**/scripts/**',
    '!**/__test__/**',
  ],
  testPathIgnorePatterns: ['/node_modules/'],
};
