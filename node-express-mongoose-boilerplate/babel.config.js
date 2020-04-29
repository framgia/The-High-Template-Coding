module.exports = {
  env: {
    production: { only: ['src'], plugins: ['lodash'] },
  },
  ignore: ['node_modules'],
  plugins: [
    '@babel/proposal-class-properties',
    '@babel/proposal-private-methods',
    '@babel/syntax-bigint',
    '@babel/syntax-dynamic-import',
    '@babel/syntax-import-meta',
    'dynamic-import-node',
    ['module-resolver', { root: './src' }],
    'source-map-support',
  ],
  presets: [['@babel/env', { targets: { node: 10 } }]],
  sourceMaps: 'inline',
};
