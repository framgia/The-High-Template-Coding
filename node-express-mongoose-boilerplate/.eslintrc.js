module.exports = {
  env: {
    es6: true,
    node: true,
  },
  extends: ['airbnb-base', 'plugin:prettier/recommended', 'prettier'],
  parser: 'babel-eslint',
  parserOptions: {
    ecmaFeatures: { impliedStrict: true },
    ecmaVersion: 2018,
    sourceType: 'module',
  },
  rules: {
    'no-underscore-dangle': [
      'error',
      {
        allow: [
          '_find',
          '_get',
          '_create',
          '_patch',
          '_update',
          '_remove',
          '_id',
          '__t',
          '__v',
        ],
      },
    ],
    'jsdoc/require-jsdoc': 'off',
  },
  settings: {
    'import/resolver': {
      node: { moduleDirectory: ['src', 'node_modules'] },
    },
  },
};
